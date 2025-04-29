import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:metropolitan_museum/app/common/constants/app_colors.dart';
import 'package:metropolitan_museum/app/common/constants/app_constants.dart';
import 'package:metropolitan_museum/app/common/constants/text_style_helper.dart';
import 'package:metropolitan_museum/app/common/router/app_router.dart';
import 'package:metropolitan_museum/app/common/widgets/lottie_circular_progress.dart';
import 'package:metropolitan_museum/app/features/presentation/home/cubit/home_cubit.dart';
import 'package:metropolitan_museum/app/features/presentation/home/cubit/home_state.dart';
import 'package:metropolitan_museum/app/common/widgets/home_card_widget.dart';

@RoutePage()
class HomeSeeAllView extends StatelessWidget {
  final bool isFamous;

  const HomeSeeAllView({super.key, required this.isFamous});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(isFamous ? "Famous Artworks" : "Current Exhibitions"),
          ),
          body: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              final list = isFamous ? state.famousArtworkList : state.currentList;
              final totalItems = isFamous ? state.famousTotal : state.currentTotal;
              final currentPage = isFamous ? state.famousCurrentPage : state.currentExhibitionsCurrentPage;
              final totalPages = (totalItems / state.itemsPerPage).ceil();
              final hasInternet = context.read<HomeCubit>().checkInternetControl();

              if (state.isLoading) {
                return const LottieCircularProgress();
              }

              if (state.errorMessage != null || list.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(state.errorMessage ?? "Bu koleksiyon için veri bulunamadı."),
                      const Gap(10),
                      ElevatedButton(
                        onPressed: () {
                          context.read<HomeCubit>().fetchObjectList(
                                query: isFamous ? "Famous%20Artworks" : "Current%20Exhibitions",
                                isFamous: isFamous,
                                page: currentPage,
                              );
                        },
                        child: const Text('Try Again'),
                      ),
                    ],
                  ),
                );
              }

              return Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: ListView.separated(
                        itemCount: list.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final obj = list[index];
                          return SizedBox(
                            height: 300,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
                              child: HomeCard(
                                onTap: () {
                                  context.router.push(ObjectDetailRoute(objectModel: obj));
                                },
                                image: obj.primaryImageSmall ?? "",
                                title: obj.title ?? "",
                                subtitle: obj.culture ?? "",
                                imageWidth: double.infinity,
                                imageHeight: 200,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  FutureBuilder<bool>(
                    future: hasInternet,
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data == true) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: currentPage > 1
                                    ? () => context.read<HomeCubit>().previousPage(isFamous: isFamous)
                                    : null,
                                child: Text(
                                  'Previous',
                                  style: TxStyleHelper.body.copyWith(
                                    color: currentPage > 1 ? AppColors.redValencia : Colors.grey,
                                    decoration: TextDecoration.underline,
                                    decorationColor: currentPage > 1 ? Colors.red : Colors.grey,
                                  ),
                                ),
                              ),
                              Container(),
                              TextButton(
                                onPressed: currentPage < totalPages
                                    ? () => context.read<HomeCubit>().nextPage(isFamous: isFamous)
                                    : null,
                                child: Text(
                                  'Next',
                                  style: TxStyleHelper.body.copyWith(
                                    color: currentPage < totalPages ? AppColors.redValencia : Colors.grey,
                                    decoration: TextDecoration.underline,
                                    decorationColor: currentPage < totalPages ? Colors.red : Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
