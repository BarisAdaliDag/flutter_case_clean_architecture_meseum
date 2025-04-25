import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
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
        title: const Text('Throne of Njoueteu: Royal Couple'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Resim Bölümü
            Center(
              child: Image.network(
                'https://picsum.photos/200/300',
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            // Başlık ve Kültür Bilgisi
            const Text(
              'Bamileke people, Chiefdom of Bansoa',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Late 19th–early 20th Century',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),

            // Açıklama Bölümü
            const Text(
              'The seat of office was created for a leader in the Grassfields region of western Cameroon. This densely populated region was a prosperous nexus of the trade that gave rise to a proliferation of principalities.',
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 24),

            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Artwork Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8),

                // Detaylar Listesi (Custom Widget Kullanımı)
                DetailItem(
                  title: 'Title: ',
                  value: 'Throne of Njoueteu: Royal Couple',
                ),
                DetailItem(
                  title: 'Date: ',
                  value: 'Late 19th–early 20th Century, Grassfields region',
                ),
                DetailItem(
                  title: 'Geography: ',
                  value: 'Cameroon, Grassfields region',
                ),
                DetailItem(
                  title: 'Culture: ',
                  value: 'Bamileke peoples, Chiefdom of Bansoa',
                ),
                DetailItem(
                  title: 'Medium: ',
                  value: 'Wood, glass beads, cloth, cowrie shells',
                ),
                DetailItem(
                  title: 'Dimensions: ',
                  value: 'H. 64 x W. 29 1/4 x D. 28 1/2 in. (162.6 x 74.3 x 67.3 cm)',
                ),
                DetailItem(
                  title: 'Classification: ',
                  value: 'Wood-Sculpture',
                ),
                DetailItem(
                  title: 'Credit Line: ',
                  value:
                      'Purchase, Rogers Fund, Andrea and Robert Bolt Jr., and Laura and James J. Ross, and Anonymous Gifts, 2014',
                ),
                DetailItem(
                  title: 'Object Number: ',
                  value: '2014.256',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
