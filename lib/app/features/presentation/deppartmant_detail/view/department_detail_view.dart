import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:metropolitan_museum/app/common/get_it/get_it.dart';
import 'package:metropolitan_museum/app/common/router/app_router.dart';
import 'package:metropolitan_museum/app/common/widgets/collection_text_field.dart';
import 'package:metropolitan_museum/app/features/data/models/object_model.dart';
import 'package:metropolitan_museum/app/features/presentation/collection/cubit/collection_cubit.dart';
import 'package:metropolitan_museum/app/features/presentation/collection/cubit/collection_state.dart';
import 'package:metropolitan_museum/app/features/presentation/deppartmant_detail/cubit/departmant_detail_cubit.dart';
import 'package:metropolitan_museum/app/common/widgets/home_card_widget.dart';

@RoutePage()
class DepartmentDetailView extends StatefulWidget {
  final int departmentId;
  final String departmentName;
  const DepartmentDetailView({super.key, required this.departmentId, required this.departmentName});

  @override
  State<DepartmentDetailView> createState() => _DepartmentDetailViewState();
}

class _DepartmentDetailViewState extends State<DepartmentDetailView> {
  @override
  void initState() {
    super.initState();
    // İlgili departmanın objelerini yükle
    getIt<DepartmentDetailCubit>().loadObjects();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.departmentName),
        ),
        body: BlocBuilder<CollectionCubit, CollectionState>(
          builder: (context, state) {
            final deptIndex = state.departmentList.indexWhere((d) => d.departmentId == widget.departmentId);
            final objects = (deptIndex >= 0 && deptIndex < state.objectList.length) ? state.objectList[deptIndex] : [];
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            // if (objects.isEmpty) {
            //   return const Center(child: Text("No objects found in this department."));
            // }
            return Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  CollectionTextField(controller: context.read<CollectionCubit>().searchController),
                  const Gap(20),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.6,
                      ),
                      itemCount: 5, //objects.length

                      itemBuilder: (context, index) {
                        // final obj = objects[index];
                        return GestureDetector(
                          onTap: () => context.router.push(ObjectDetailRoute(
                              objectModel: ObjectModel(
                                  departmentIds: 1,
                                  primaryImageSmall: "primaryImageSmall",
                                  culture: "culture",
                                  department: "department",
                                  title: "title",
                                  objectName: "objectName"))),
                          child: const HomeCard(
                            image: "https://picsum.photos/200/300", //obj.primaryImageSmall
                            title: "obj.title", //obj.title,
                            subtitle: "obj.objectName",
                            imageWidth: 200,
                            imageHeight: 200,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
