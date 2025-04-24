import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:metropolitan_museum/app/common/constants/app_image.dart';
import 'package:metropolitan_museum/app/common/constants/text_style_helper.dart';
import 'package:metropolitan_museum/app/features/presentation/info/widget.dart/info_header.dart';
import 'package:metropolitan_museum/app/features/presentation/info/widget.dart/museum_info_widget.dart';

@RoutePage()
final class InfoView extends StatelessWidget {
  const InfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Info'),
      ),
      body: ListView(
        children: [
          const InfoHeader(),
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16.0),
            child: Row(
              children: [
                Text(
                  'Locations and Hours',
                  style: TxStyleHelper.subheading,
                ),
              ],
            ),
          ),
          const Gap(5),
          MuseumInfoWidget(
            title: "The Met Fifth Avenue",
            hours: "Sunday–Tuesday, Thursday: 10 am–5 pm; Friday–Saturday: 10 am–9 pm",
            closedDay: "Wednesday",
            address: "1000 Fifth Avenue, New York, NY, 10028",
            phone: "212-535-7710",
            imageUrl: AppImage.img_info_02.path,
          ),
          MuseumInfoWidget(
            title: "The Met Cloisters",
            hours: "Thursday–Tuesday: 10 am–5 pm",
            closedDay: "Wednesday",
            address: "99 Margaret Corbin Drive, Fort Tryon Park, New York, NY, 10040",
            phone: "212-923-3700",
            imageUrl: AppImage.img_info_03.path, // Gerçek bir URL ile değiştirin
          ),
        ],
      ),
    );
  }
}
