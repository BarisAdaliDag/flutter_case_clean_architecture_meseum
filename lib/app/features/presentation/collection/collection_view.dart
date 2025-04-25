import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:metropolitan_museum/app/common/constants/app_image.dart';
import 'package:metropolitan_museum/app/common/router/app_router.dart';
import 'package:metropolitan_museum/app/features/presentation/collection/cubit/collection_cubit.dart';
import 'package:metropolitan_museum/app/features/presentation/collection/cubit/collection_state.dart';
import 'package:metropolitan_museum/app/common/get_it/get_it.dart';
import 'package:metropolitan_museum/app/features/presentation/collection/widget/collection_card.dart';
import 'package:metropolitan_museum/app/features/presentation/collection/widget/collection_header.dart';
import 'package:metropolitan_museum/app/common/widgets/collection_text_field.dart';
import 'package:metropolitan_museum/app/features/presentation/deppartmant_detail/view/department_detail_view.dart';
import 'package:metropolitan_museum/app/features/presentation/home/widgets/home_listview_title.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

@RoutePage()
final class CollectionView extends StatefulWidget {
  const CollectionView({super.key});

  @override
  State<CollectionView> createState() => _CollectionViewState();
}

class _CollectionViewState extends State<CollectionView> {
  @override
  void initState() {
    getIt<CollectionCubit>().loadDepartmentsAndObjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          title: const Text("The Met Collection"),
        ),
        body: SafeArea(
          child: BlocBuilder<CollectionCubit, CollectionState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return ListView(
                children: [
                  const CollectionHeader(),
                  const Gap(20),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CollectionTextField(
                      controller: context.read<CollectionCubit>().searchController,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.filteredDepartmentList.length,
                    itemBuilder: (context, deptIndex) {
                      final department = state.filteredDepartmentList[deptIndex];
                      final originalIndex = state.departmentList.indexOf(department);
                      final objects = (originalIndex < state.objectList.length) ? state.objectList[originalIndex] : [];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: GestureDetector(
                          onTap: () {
                            context.router.push(DepartmentDetailRoute(
                              departmentId: department.departmentId,
                              departmentName: department.displayName,
                            ));
                          },
                          child: CollectionCard(
                            image: objects.isNotEmpty ? objects.first.primaryImageSmall : "",
                            title: department.displayName,
                            id: department.departmentId.toString(),
                          ),
                        ),
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
