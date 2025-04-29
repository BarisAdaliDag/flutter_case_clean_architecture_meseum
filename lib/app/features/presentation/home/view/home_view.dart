import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:metropolitan_museum/app/common/constants/app_constants.dart';
import 'package:metropolitan_museum/app/common/widgets/logo_image.dart';
import 'package:metropolitan_museum/app/common/widgets/lottie_circular_progress.dart';
import 'package:metropolitan_museum/app/common/get_it/get_it.dart';
import 'package:metropolitan_museum/app/features/presentation/home/widgets/current_exhibitions_list_view.dart';
import 'package:metropolitan_museum/app/features/presentation/home/widgets/famous_artwork_list_view.dart';
import 'package:metropolitan_museum/app/features/presentation/home/widgets/try_again_bottom_container.dart';

import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
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
              return const LottieCircularProgress();
            }
            return ListView(
              children: [
                const Gap(20),
                const LogoImage(),
                const Gap(20),
                const TheMetHeader(),
                const Gap(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingMedium),
                  child: Column(
                    children: [
                      if (state.currentList.isNotEmpty)
                        CurrentExxhibitionsListView(
                          state: state,
                        ),
                      if (state.famousArtworkList.isNotEmpty)
                        FamouArtWorkListView(
                          state: state,
                        ),
                      if (state.currentList.isEmpty && state.famousArtworkList.isEmpty && state.errorMessage != null)
                        TryAgainButtonContainer(
                          state: state,
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
