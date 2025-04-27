// ignore_for_file: library_private_types_in_public_api, document_ignores

import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metropolitan_museum/app/common/constants/app_colors.dart';
import 'package:metropolitan_museum/app/common/constants/app_constants.dart';
import 'package:metropolitan_museum/app/common/constants/app_icons.dart';
import 'package:metropolitan_museum/app/common/constants/text_style_helper.dart';
import 'package:metropolitan_museum/app/features/presentation/main/cubit/main_cubit.dart';
import 'package:metropolitan_museum/core/network_control/network_control.dart';

@RoutePage()

/// Main View Page
final class MainView extends StatefulWidget {
  ///
  const MainView({super.key});

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      builder: (context, child) {
        return Container(
          color: Theme.of(context).colorScheme.surface,
          child: SafeArea(
            bottom: false,
            child: Scaffold(
              body: BlocBuilder<MainCubit, MainState>(
                builder: (context, state) {
                  // var cubit = context.read<MainCubit>();

                  // if (state.networkResult == NetworkResult.off) {
                  //   return Container();
                  // }
                  return Column(
                    children: [
                      if (state.networkResult == NetworkResult.off)
                        Container(
                          height: 50,
                          color: AppColors.redValencia,
                          child: const Center(
                            child: Text(
                              "No Internet Connection",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      Expanded(
                        child: IndexedStack(
                          key: const ValueKey('main'),
                          index: state.selectedIndex,
                          children: [
                            child,
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
              floatingActionButton: Transform.translate(
                offset: const Offset(10, 0), // Sağa 20 piksel kaydırır
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: FloatingActionButton(
                    backgroundColor: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.smokyBlack
                        : AppColors.whiteBottomAppbar,
                    onPressed: () {
                      context.tabsRouter.setActiveIndex(1);
                    },
                    shape: const CircleBorder(), // Yuvarlak şekil
                    child: Image.asset(
                      context.tabsRouter.activeIndex == 1
                          ? AppIcons.tabbarCollectionSelected.assetPath
                          : AppIcons.tabbarCollectionUnselected.assetPath,
                      width: 40,
                      height: 40,
                    ),
                  ),
                ),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: BlocBuilder<MainCubit, MainState>(
                builder: (context, state) {
                  return SafeArea(
                    child: buildBottomNavBar(context, context.tabsRouter),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildBottomNavBar(BuildContext context, TabsRouter tabsRouter) {
    final hideNavBar = tabsRouter.topMatch.meta['hideNavBar'] == true;
    double iconSize = 24;
    final activeIndex = tabsRouter.activeIndex;
    return hideNavBar
        ? const SizedBox.shrink()
        : Container(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppConstants.radiusMedium), // Kenarları yuvarlat
              child: BottomAppBar(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.smokyBlack
                    : AppColors.whiteBottomAppbar,
                shape: const CircularNotchedRectangle(),
                notchMargin: 15.0,
                child: SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () => tabsRouter.setActiveIndex(0),
                        child: Column(
                          children: [
                            Image.asset(
                              tabsRouter.activeIndex == 0
                                  ? AppIcons.tabbarHomeSelected.assetPath
                                  : AppIcons.tabbarHomeUnselected.assetPath,
                              width: iconSize,
                              height: iconSize,
                            ),
                            Text(
                              "Home",
                              style: TxStyleHelper.body.copyWith(
                                color: activeIndex == 0 ? AppColors.redValencia : Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 32), // Ortadaki boşluk (FAB için)
                      GestureDetector(
                        onTap: () => tabsRouter.setActiveIndex(2),
                        child: Column(
                          children: [
                            Image.asset(
                              tabsRouter.activeIndex == 2
                                  ? AppIcons.tabbarInfoSelected.assetPath
                                  : AppIcons.tabbarInfoUnselected.assetPath,
                              width: iconSize,
                              height: iconSize,
                            ),

                            //
                            //   onPressed: () => tabsRouter.setActiveIndex(0),
                            Text(
                              "Info",
                              style: TxStyleHelper.body.copyWith(
                                color: activeIndex == 2 ? AppColors.redValencia : Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
//