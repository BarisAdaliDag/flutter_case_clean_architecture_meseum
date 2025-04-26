import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:metropolitan_museum/app/common/constants/app_colors.dart';
import 'package:metropolitan_museum/app/common/constants/app_constants.dart';
import 'package:metropolitan_museum/app/common/constants/text_style_helper.dart';
import 'package:metropolitan_museum/app/common/get_it/get_it.dart';
import 'package:metropolitan_museum/app/common/router/app_router.dart';
import 'package:metropolitan_museum/app/features/presentation/home/cubit/home_cubit.dart';
import 'package:metropolitan_museum/app/features/presentation/home/cubit/home_state.dart';
import 'package:metropolitan_museum/app/common/widgets/home_card_widget.dart';

@RoutePage()
class HomeSeeAllView extends StatefulWidget {
  final bool isFamous;
  const HomeSeeAllView({super.key, required this.isFamous});

  @override
  State<HomeSeeAllView> createState() => _HomeSeeAllViewState();
}

class _HomeSeeAllViewState extends State<HomeSeeAllView> {
  int currentPage = 1;
  static const int itemsPerPage = 20;

  bool hasInternet = false;

  @override
  void initState() {
    super.initState();

    _fetchData();
  }

  Future<void> _fetchData() async {
    hasInternet = await context.read<HomeCubit>().checkInternetControl();
    print('HomeSeeAllView fetching page $currentPage for isFamous: ${widget.isFamous}');

    widget.isFamous ? context.read<HomeCubit>().resetfamouslist() : context.read<HomeCubit>().resetCurrentlist();
    int start = (currentPage - 1) * itemsPerPage;
    int end = currentPage * itemsPerPage;
    await context.read<HomeCubit>().fetchObjectList(
          query: widget.isFamous ? "Famous%20Artworks" : "Current%20Exhibitions",
          isFamous: widget.isFamous,
          start: start,
          end: end,
        );
  }

  void _nextPage(int totalItems) {
    final totalPages = (totalItems / itemsPerPage).ceil();
    if (currentPage < totalPages) {
      print('Navigating to next page: ${currentPage + 1} / $totalPages');

      setState(() {
        currentPage++;
        _fetchData();
      });
    }
  }

  void _previousPage() {
    if (currentPage > 1) {
      print('Navigating to previous page: ${currentPage - 1}');
      setState(() {
        currentPage--;
        _fetchData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.ghostWhite, // SafeArea alt kısmı ve arka plan beyaz
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(widget.isFamous ? "Famous Artworks" : "Current Exhibitions"),
          ),
          body: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              final list = widget.isFamous ? state.famousArtworkList : state.currentList;
              final totalItems = widget.isFamous ? state.famousTotal : state.currentTotal;
              final totalPages = (totalItems / itemsPerPage).ceil();

              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.errorMessage != null || list.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(state.errorMessage ?? "Bu koleksiyon için veri bulunamadı."),
                      const Gap(10),
                      ElevatedButton(
                        onPressed: _fetchData,
                        child: const Text('Try Again'),
                      ),
                    ],
                  ),
                );
              }

              // Veri yüklendiğinde kaydırmayı tetikle
              if (!state.isLoading && list.isNotEmpty) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  //  _scrollToPosition();
                });
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
                  if (hasInternet)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: currentPage > 1 ? _previousPage : null,
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
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 0),
                          //   child: Text('Total ${list.length} collections ', style: TxStyleHelper.body),
                          // ),
                          hasInternet
                              ? TextButton(
                                  onPressed: () {
                                    if (currentPage < totalPages) {
                                      _nextPage(totalItems);
                                    }
                                  },
                                  child: Text(
                                    'Next',
                                    style: TxStyleHelper.body.copyWith(
                                      color: currentPage < totalPages ? AppColors.redValencia : Colors.grey,
                                      decoration: TextDecoration.underline,
                                      decorationColor: currentPage < totalPages ? Colors.red : Colors.grey,
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
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
