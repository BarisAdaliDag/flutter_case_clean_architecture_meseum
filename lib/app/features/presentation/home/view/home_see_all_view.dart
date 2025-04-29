import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:metropolitan_museum/app/common/constants/app_constants.dart';
import 'package:metropolitan_museum/app/common/constants/app_strings.dart';
import 'package:metropolitan_museum/app/common/router/app_router.dart';
import 'package:metropolitan_museum/app/common/widgets/home_header_button.dart';
import 'package:metropolitan_museum/app/common/widgets/lottie_circular_progress.dart';
import 'package:metropolitan_museum/app/common/widgets/page_transactions_text_button.dart';
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
            title: Text(isFamous ? AppStrings.famaousArtworks : AppStrings.currentExhibitions),
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
                      Text(state.errorMessage ?? AppStrings.noData),
                      const Gap(10),
                      HomeHeaderButton(
                          ontap: () {
                            context.read<HomeCubit>().fetchObjectList(
                                  query: isFamous ? "Famous%20Artworks" : "Current%20Exhibitions",
                                  isFamous: isFamous,
                                  page: currentPage,
                                );
                          },
                          title: AppStrings.tryAgain)
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
                              PageTransActionTextButton(
                                onPressed: currentPage > 1
                                    ? () => context.read<HomeCubit>().previousPage(isFamous: isFamous)
                                    : () {},
                                text: AppStrings.previous,
                                isButtonEnabled: currentPage > 1,
                              ),
                              Container(),
                              PageTransActionTextButton(
                                onPressed: currentPage > 1
                                    ? () => context.read<HomeCubit>().nextPage(isFamous: isFamous)
                                    : () {},
                                text: AppStrings.next,
                                isButtonEnabled: currentPage > 1,
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
