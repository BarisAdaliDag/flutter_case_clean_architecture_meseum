import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metropolitan_museum/app/common/constants/app_image.dart';
import 'package:metropolitan_museum/app/features/presentation/home/cubit/home_cubit.dart';
import 'package:metropolitan_museum/app/features/presentation/home/cubit/home_state.dart';
import 'package:metropolitan_museum/app/common/get_it/get_it.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

@RoutePage()
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (_) => getIt<HomeCubit>()..loadDepartmentsAndObjects(),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView(
                children: [
                  SizedBox(
                      height: 70,
                      width: 70,
                      child: Image.asset(
                        AppImage.logo.path,
                      )),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.departmentList.length,
                    itemBuilder: (context, deptIndex) {
                      final department = state.departmentList[deptIndex];
                      final objects = (deptIndex < state.objectList.length) ? state.objectList[deptIndex] : [];
                      return ExpansionTile(
                        title: Text(department.displayName),
                        children: objects
                            .map((obj) => ListTile(
                                  title: Text(obj.title),
                                  subtitle: Text(obj.departmentIds.toString()),
                                  leading: obj.primaryImageSmall.isNotEmpty
                                      ? Image.network(obj.primaryImageSmall, width: 40, height: 40, fit: BoxFit.cover)
                                      : const SizedBox(width: 40, height: 40),
                                ))
                            .toList(),
                      );
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
