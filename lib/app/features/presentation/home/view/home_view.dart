import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:metropolitan_museum/app/common/constants/app_colors.dart';
import 'package:metropolitan_museum/app/common/constants/app_constants.dart';
import 'package:metropolitan_museum/app/common/constants/app_image.dart';
import 'package:metropolitan_museum/app/common/constants/text_style_helper.dart';
import 'package:metropolitan_museum/app/common/router/app_router.dart';
import 'package:metropolitan_museum/app/features/presentation/collection/cubit/collection_cubit.dart';
import 'package:metropolitan_museum/app/features/presentation/collection/cubit/collection_state.dart';
import 'package:metropolitan_museum/app/common/get_it/get_it.dart';
import 'package:metropolitan_museum/app/features/presentation/home/widgets/home_listview_title.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../data/models/object_model.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../../../../common/widgets/home_card_widget.dart';
import '../widgets/the_meat_header.dart';

@RoutePage()
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    getIt<HomeCubit>().fetchHomeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView(
              children: [
                const Gap(20),
                SizedBox(
                    height: 70,
                    width: 70,
                    child: Image.asset(
                      AppImage.logo.path,
                    )),
                const Gap(20),
                const TheMetHeader(),
                const Gap(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingMedium),
                  child: Column(
                    children: [
                      if (state.currentList.isNotEmpty)
                        Column(
                          children: [
                            HomeListViewHeader(
                              onTap: () {
                                context.router.push(HomeSeeAllRoute(isFamous: false));
                              },
                              title: "Current Exhibitions",
                            ),
                            const Gap(10),
                            SizedBox(
                              height: 300,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.currentList.length,
                                itemBuilder: (context, index) {
                                  final ObjectModel obj = state.currentList[index];
                                  return SizedBox(
                                    width: 195,
                                    child: HomeCard(
                                      image: obj.primaryImageSmall ?? "",
                                      title: obj.title ?? "",
                                      subtitle: obj.objectName ?? "",
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      if (state.famousArtworkList.isNotEmpty)
                        Column(
                          children: [
                            HomeListViewHeader(
                              onTap: () {
                                context.router.push(HomeSeeAllRoute(isFamous: true));
                              },
                              title: "Famous Artworks",
                            ),
                            const Gap(10),
                            SizedBox(
                              height: 300,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.famousArtworkList.length,
                                itemBuilder: (context, index) {
                                  final ObjectModel obj = state.famousArtworkList[index];
                                  return SizedBox(
                                    width: 195,
                                    child: HomeCard(
                                      image: obj.primaryImageSmall ?? "",
                                      title: obj.title ?? "",
                                      subtitle: obj.objectName ?? "",
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      if (state.currentList.isEmpty && state.famousArtworkList.isEmpty && state.errorMessage != null)
                        //todo: solve try again button
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(state.errorMessage!),
                              const Gap(10),
                              TextButton(
                                onPressed: () {
                                  getIt<HomeCubit>().fetchHomeData();
                                },
                                child: Text(
                                  'Try Again',
                                  style: TxStyleHelper.body.copyWith(
                                    color: AppColors.redValencia,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
