import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:metropolitan_museum/app/common/get_it/get_it.dart';
import 'package:metropolitan_museum/app/common/router/app_router.dart';
import 'package:metropolitan_museum/app/common/widgets/collection_text_field.dart';
import 'package:metropolitan_museum/app/features/data/models/object_model.dart';
import 'package:metropolitan_museum/app/features/presentation/deppartmant_detail/cubit/departmant_detail_cubit.dart';
import 'package:metropolitan_museum/app/common/widgets/home_card_widget.dart';
import 'package:metropolitan_museum/app/features/presentation/deppartmant_detail/cubit/departmant_detail_state.dart';

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
    getIt<DepartmentDetailCubit>().loadListCollection(widget.departmentId);
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
        body: BlocBuilder<DepartmentDetailCubit, DepartmentDetailState>(
          builder: (context, state) {
            final objects = state.filteredObjectList;
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
                  CollectionTextField(controller: context.read<DepartmentDetailCubit>().searchController),
                  const Gap(20),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.58,
                      ),
                      itemCount: objects.length,
                      itemBuilder: (context, index) {
                        final model = objects[index];
                        return GestureDetector(
                          onTap: () {
                            context.router.push(ObjectDetailRoute(objectModel: model));
                          },
                          child: HomeCard(
                            image: model.primaryImageSmall ?? "",
                            title: model.objectName ?? "",
                            subtitle: model.title ?? "",
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
