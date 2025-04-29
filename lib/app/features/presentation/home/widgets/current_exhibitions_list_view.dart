import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:metropolitan_museum/app/common/constants/app_strings.dart';
import 'package:metropolitan_museum/app/common/router/app_router.dart';
import 'package:metropolitan_museum/app/common/widgets/home_card_widget.dart';
import 'package:metropolitan_museum/app/features/data/models/object_model.dart';
import 'package:metropolitan_museum/app/features/presentation/home/cubit/home_state.dart';
import 'package:metropolitan_museum/app/features/presentation/home/widgets/home_listview_title.dart';

class CurrentExxhibitionsListView extends StatelessWidget {
  final HomeState state;

  const CurrentExxhibitionsListView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeListViewHeader(
          onTap: () {
            context.router.push(HomeSeeAllRoute(isFamous: false));
          },
          title: AppStrings.currentExhibitions,
        ),
        const Gap(10),
        SizedBox(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.currentList.length,
            itemBuilder: (context, index) {
              final ObjectModel obj = state.currentList[index];
              return SizedBox(
                width: 195,
                child: HomeCard(
                  onTap: () {
                    context.router.push(ObjectDetailRoute(objectModel: obj));
                  },
                  image: obj.primaryImageSmall ?? "",
                  title: obj.title ?? "",
                  subtitle: obj.objectName ?? "",
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
