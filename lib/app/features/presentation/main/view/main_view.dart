// ignore_for_file: library_private_types_in_public_api, document_ignores

import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metropolitan_museum/app/common/constants/app_icons.dart';
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
        return Scaffold(
          body: BlocBuilder<MainCubit, MainState>(
            builder: (context, state) {
              // var cubit = context.read<MainCubit>();

              if (state.networkResult == NetworkResult.off) {
                return Container();
              }
              return IndexedStack(
                key: const ValueKey('main'),
                index: state.selectedIndex,
                children: [
                  child,
                ],
              );
            },
          ),
          bottomNavigationBar: BlocBuilder<MainCubit, MainState>(
            builder: (context, state) {
              return SafeArea(
                child: buildBottomNavBar(context, context.tabsRouter),
              );
            },
          ),
        );
      },
    );
  }

  Widget buildBottomNavBar(BuildContext context, TabsRouter tabsRouter) {
    final hideNavBar = tabsRouter.topMatch.meta['hideNavBar'] == true;
    double iconSize = 24;
    return hideNavBar
        ? const SizedBox.shrink()
        : Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
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
              borderRadius: BorderRadius.circular(58),
              child: BottomNavigationBar(
                currentIndex: tabsRouter.activeIndex,
                //    unselectedItemColor: AppColors.unSelectedTabColor,
                type: BottomNavigationBarType.fixed,
                //    fixedColor: AppColors.ultramarineBlue,
                //    backgroundColor: AppColors.backgroundColor,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Image.asset(AppIcons.tabbarHomeUnselected.assetPath, width: iconSize, height: iconSize),
                    activeIcon: Image.asset(AppIcons.tabbarHomeSelected.assetPath, width: iconSize, height: iconSize),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(AppIcons.tabbarCollectionUnselected.assetPath, width: iconSize, height: iconSize),
                    activeIcon:
                        Image.asset(AppIcons.tabbarCollectionSelected.assetPath, width: iconSize, height: iconSize),
                    label: 'Collection',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(AppIcons.tabbarInfoUnselected.assetPath, width: iconSize, height: iconSize),
                    activeIcon: Image.asset(AppIcons.tabbarInfoSelected.assetPath, width: iconSize, height: iconSize),
                    label: 'Info',
                  ),
                ],
                onTap: (index) {
                  tabsRouter.setActiveIndex(index);
                  if (index == 0) {}
                  if (index == 1) {
                    //    Dependency.profileCubit.fetchStreak();
                  }
                  if (index == 2) {
                    //  Dependency.profileCubit.getUserById();
                  }
                },
              ),
            ),
          );
  }
}
