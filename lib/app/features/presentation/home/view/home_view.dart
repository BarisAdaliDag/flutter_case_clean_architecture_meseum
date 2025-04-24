import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:metropolitan_museum/app/common/constants/app_image.dart';
import 'package:metropolitan_museum/app/features/presentation/collection/cubit/collection_cubit.dart';
import 'package:metropolitan_museum/app/features/presentation/collection/cubit/collection_state.dart';
import 'package:metropolitan_museum/app/common/get_it/get_it.dart';
import 'package:metropolitan_museum/app/features/presentation/home/widgets/home_listview_title.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../widgets/the_meat_header.dart';

@RoutePage()
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CollectionCubit>(
      create: (_) => getIt<CollectionCubit>()..loadDepartmentsAndObjects(),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<CollectionCubit, CollectionState>(
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
                  HomeListViewHeader(
                    onTap: () {},
                    title: "Current Exhibitions",
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
