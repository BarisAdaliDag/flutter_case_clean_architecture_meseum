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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _fetchData() {
    print('HomeSeeAllView fetching page $currentPage for isFamous: ${widget.isFamous}');
    context.read<HomeCubit>().fetchObjectList(
          query: widget.isFamous ? "Famous%20Artworks" : "Current%20Exhibitions",
          isFamous: widget.isFamous,
          start: (currentPage - 1) * itemsPerPage,
          end: currentPage * itemsPerPage,
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

  void _scrollToPosition() {
    if (_scrollController.hasClients) {
      final targetIndex = (currentPage - 1) * itemsPerPage - 1;
      if (targetIndex >= 0) {
        print('Scrolling to index: $targetIndex');
        _scrollController.animateTo(
          targetIndex * 310.0, // Her item yaklaşık 200 (imageHeight) + 16 (separator) yüksekliğinde
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    child: const Text('Tekrar Dene'),
                  ),
                ],
              ),
            );
          }

          // Veri yüklendiğinde kaydırmayı tetikle
          if (!state.isLoading && list.isNotEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _scrollToPosition();
            });
          }

          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: ListView.separated(
                    controller: _scrollController,
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // TextButton(
                    //   onPressed: currentPage > 1 ? _previousPage : null,
                    //   child: Text(
                    //     'Previous',
                    //     style: TxStyleHelper.body.copyWith(
                    //       color: currentPage > 1 ? AppColors.redValencia : Colors.grey,
                    //       decoration: TextDecoration.underline,
                    //       decorationColor: currentPage > 1 ? Colors.red : Colors.grey,
                    //     ),
                    //   ),
                    // ),
                    Container(),
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child:
                          Text('Total ${list.length} collections $currentPage/$totalPages', style: TxStyleHelper.body),
                    ),
                    TextButton(
                      onPressed: currentPage < totalPages ? () => _nextPage(totalItems) : null,
                      child: Text(
                        'More',
                        style: TxStyleHelper.body.copyWith(
                          color: currentPage < totalPages ? AppColors.redValencia : Colors.grey,
                          decoration: TextDecoration.underline,
                          decorationColor: currentPage < totalPages ? Colors.red : Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
