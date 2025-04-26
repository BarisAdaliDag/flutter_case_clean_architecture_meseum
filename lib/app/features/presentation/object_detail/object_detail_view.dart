import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:metropolitan_museum/app/common/constants/app_colors.dart';
import 'package:metropolitan_museum/app/common/constants/app_constants.dart';
import 'package:metropolitan_museum/app/common/widgets/cahche_network_image_widget.dart';
import 'package:metropolitan_museum/app/features/data/models/object_model.dart';
import 'package:metropolitan_museum/app/features/presentation/object_detail/widget/detail_item.dart';

@RoutePage()
class ObjectDetailView extends StatelessWidget {
  final ObjectModel objectModel;

  const ObjectDetailView({super.key, required this.objectModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(objectModel.title ?? 'Object Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(AppConstants.radiusMedium), // Adjust the radius for desired roundness
                      child: CacheNetworkImageWidget(
                        image: objectModel.primaryImageSmall ?? "",
                        imageHeight: 300,
                        imageWidth: double.infinity,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Text(
                    objectModel.title ?? 'Unknown Title',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).brightness != Brightness.dark ? AppColors.lavender : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    objectModel.objectDate ?? 'Unknown Date',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Açıklama Bölümü
                  Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley",
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).brightness != Brightness.dark ? AppColors.lavender : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            Container(
              color: AppColors.greyHomeBackground,
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Artwork Details',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Detaylar Listesi (Custom Widget Kullanımı)
                  DetailItem(
                    title: 'Title: ',
                    value: objectModel.title ?? 'Unknown Title',
                  ),
                  DetailItem(
                    title: 'Date: ',
                    value: objectModel.objectDate ?? 'Unknown Date',
                  ),
                  DetailItem(
                    title: 'Geography: ',
                    value: objectModel.geographyType ?? 'Unknown Geography',
                  ),
                  DetailItem(
                    title: 'Culture: ',
                    value: objectModel.culture ?? 'Unknown Culture',
                  ),
                  DetailItem(
                    title: 'Medium: ',
                    value: objectModel.medium ?? 'Unknown Medium',
                  ),
                  DetailItem(
                    title: 'Dimensions: ',
                    value: objectModel.dimensions ?? 'Unknown Dimensions',
                  ),
                  DetailItem(
                    title: 'Classification: ',
                    value: objectModel.classification ?? 'Unknown Classification',
                  ),
                  DetailItem(
                    title: 'Credit Line: ',
                    value: objectModel.creditLine ?? 'Unknown Credit Line',
                  ),
                  DetailItem(
                    title: 'Object Number: ',
                    value: objectModel.accessionNumber ?? 'Unknown Object Number',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
