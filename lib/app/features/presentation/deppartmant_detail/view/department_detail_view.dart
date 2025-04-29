// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:metropolitan_museum/app/common/constants/app_strings.dart';
import 'package:metropolitan_museum/app/common/widgets/page_transactions_text_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:metropolitan_museum/app/common/constants/app_colors.dart';
import 'package:metropolitan_museum/app/common/constants/app_image.dart';
import 'package:metropolitan_museum/app/common/constants/text_style_helper.dart';
import 'package:metropolitan_museum/app/common/get_it/get_it.dart';
import 'package:metropolitan_museum/app/common/router/app_router.dart';
import 'package:metropolitan_museum/app/common/widgets/collection_text_field.dart';
import 'package:metropolitan_museum/app/common/widgets/home_card_widget.dart';
import 'package:metropolitan_museum/app/common/widgets/lottie_circular_progress.dart';
import 'package:metropolitan_museum/app/features/data/models/object_model.dart';
import 'package:metropolitan_museum/app/features/presentation/deppartmant_detail/cubit/departmant_detail_cubit.dart';
import 'package:metropolitan_museum/app/features/presentation/deppartmant_detail/cubit/departmant_detail_state.dart';

@RoutePage()
class DepartmentDetailView extends StatelessWidget {
  final int departmentId;
  final String departmentName;

  const DepartmentDetailView({
    super.key,
    required this.departmentId,
    required this.departmentName,
  });

  @override
  Widget build(BuildContext context) {
    // İlk veri çekmeyi tetikle
    context.read<DepartmentDetailCubit>().init(departmentId: departmentId);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(departmentName),
        ),
        body: BlocBuilder<DepartmentDetailCubit, DepartmentDetailState>(
          builder: (context, state) {
            final objects = state.filteredObjectList;
            final totalPages = (state.totalItems / state.itemsPerPage).ceil();
            final hasInternet = context.read<DepartmentDetailCubit>().checkInternetControl();

            if (state.isLoading) {
              return const LottieCircularProgress();
            }

            if (state.error.isNotEmpty || objects.isEmpty) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: CollectionTextField(
                      controller: context.read<DepartmentDetailCubit>().searchController,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 80.w,
                            child: Image.asset(
                              Theme.of(context).brightness == Brightness.dark
                                  ? AppImage.nodata_white.path
                                  : AppImage.nodata_black.path,
                            ),
                          ),
                          const Gap(10),
                          Text(state.error.isNotEmpty ? state.error : AppStrings.noData),
                          const Gap(10),
                          ElevatedButton(
                            onPressed: () {
                              context.read<DepartmentDetailCubit>().loadListCollection(
                                    departmentId: departmentId,
                                    page: state.currentPage,
                                  );
                            },
                            child: const Text(AppStrings.tryAgain),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }

            return Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  CollectionTextField(
                    controller: context.read<DepartmentDetailCubit>().searchController,
                  ),
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
                          title: model.title ?? "",
                          subtitle: model.objectName ?? "",
                          imageWidth: 200,
                          imageHeight: 200,
                        );
                      },
                    ),
                  ),
                  FutureBuilder<bool>(
                    future: hasInternet,
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data == true) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PageTransActionTextButton(
                                onPressed: state.currentPage > 1
                                    ? () =>
                                        context.read<DepartmentDetailCubit>().previousPage(departmentId: departmentId)
                                    : () {},
                                text: AppStrings.previous,
                                isButtonEnabled: state.currentPage > 1,
                              ),
                              Container(),
                              PageTransActionTextButton(
                                onPressed: state.currentPage < totalPages
                                    ? () => context.read<DepartmentDetailCubit>().nextPage(departmentId: departmentId)
                                    : () {},
                                text: AppStrings.next,
                                isButtonEnabled: state.currentPage < totalPages,
                              ),
                            ],
                          ),
                        );
                      }
                      return const SizedBox();
                    },
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
