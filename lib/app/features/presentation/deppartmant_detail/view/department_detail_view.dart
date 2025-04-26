import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:metropolitan_museum/app/common/constants/app_image.dart';
import 'package:metropolitan_museum/app/common/get_it/get_it.dart';
import 'package:metropolitan_museum/app/common/router/app_router.dart';
import 'package:metropolitan_museum/app/common/widgets/collection_text_field.dart';
import 'package:metropolitan_museum/app/common/widgets/lottie_circular_progress.dart';
import 'package:metropolitan_museum/app/features/data/models/object_model.dart';
import 'package:metropolitan_museum/app/features/presentation/deppartmant_detail/cubit/departmant_detail_cubit.dart';
import 'package:metropolitan_museum/app/common/widgets/home_card_widget.dart';
import 'package:metropolitan_museum/app/features/presentation/deppartmant_detail/cubit/departmant_detail_state.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

@RoutePage()
class DepartmentDetailView extends StatefulWidget {
  final int departmentId;
  final String departmentName;
  const DepartmentDetailView({super.key, required this.departmentId, required this.departmentName});

  @override
  State<DepartmentDetailView> createState() => _DepartmentDetailViewState();
}

class _DepartmentDetailViewState extends State<DepartmentDetailView> with RouteAware {
  int departmantId = 0;
  @override
  void initState() {
    super.initState();
    getIt<DepartmentDetailCubit>().loadListCollection(widget.departmentId);
    departmantId = widget.departmentId;
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   AppRouter.routeObserver.subscribe(this, ModalRoute.of(context)!);
  // }

  // @override
  // void dispose() {
  //   AppRouter.routeObserver.unsubscribe(this);
  //   super.dispose();
  // }

  // @override
  // void didPopNext() {
  //   // Sayfa geri gelince tekrar yükle
  //   getIt<DepartmentDetailCubit>().loadListCollection(widget.departmentId);
  // }

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
              return const LottieCircularProgress();
            }
            if (objects.isEmpty) {
              return Center(
                  child: SizedBox(
                      width: 80.w,
                      child: Image.asset(
                        AppImage.nodata.path,
                      )));
            }
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
                        return HomeCard(
                          onTap: () {
                            context.router.push(ObjectDetailRoute(objectModel: model));
                          },
                          image: model.primaryImageSmall ?? "",
                          title: model.objectName ?? "",
                          subtitle: model.title ?? "",
                          imageWidth: 200,
                          imageHeight: 200,
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
