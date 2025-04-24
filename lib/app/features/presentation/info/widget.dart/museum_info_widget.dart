import 'package:flutter/material.dart';
import 'package:metropolitan_museum/app/common/constants/text_style_helper.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MuseumInfoWidget extends StatelessWidget {
  final String title;
  final String hours;
  final String closedDay;
  final String address;
  final String phone;
  final String imageUrl;

  const MuseumInfoWidget({
    super.key,
    required this.title,
    required this.hours,
    required this.closedDay,
    required this.address,
    required this.phone,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Resim
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.asset(
              imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 200,
                  color: Colors.grey[300],
                  child: const Center(child: Text("Image not available")),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          // Başlık
          Text(
            title,
            style: TextStyle(
              fontSize: (18.0).sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          // Saatler
          Text(
            "Hours: $hours",
            style: TxStyleHelper.body,
          ),
          const SizedBox(height: 8),
          // Kapalı Gün
          Text(
            "Closed: $closedDay",
            style: TxStyleHelper.body,
          ),
          const SizedBox(height: 8),
          // Adres
          Text(
            "Address: $address",
            style: TxStyleHelper.body,
          ),
          const SizedBox(height: 8),
          // Telefon
          Text(
            "Phone: $phone",
            style: TxStyleHelper.body,
          ),
        ],
      ),
    );
  }
}

// Örnek kullanım için ana sayfa
class MuseumInfoScreen extends StatelessWidget {
  const MuseumInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Museum Information"),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            // İlk MuseumInfoWidget (The Met Cloisters)
            MuseumInfoWidget(
              title: "The Met Cloisters",
              hours: "Thursday–Tuesday: 10 am–5 pm",
              closedDay: "Wednesday",
              address: "99 Margaret Corbin Drive, Fort Tryon Park, New York, NY, 10040",
              phone: "212-923-3700",
              imageUrl: "https://example.com/met_cloisters.jpg", // Gerçek bir URL ile değiştirin
            ),
            // İkinci MuseumInfoWidget (Farklı parametrelerle)
            MuseumInfoWidget(
              title: "The Met Fifth Avenue",
              hours: "Sunday–Tuesday, Thursday: 10 am–5 pm; Friday–Saturday: 10 am–9 pm",
              closedDay: "Wednesday",
              address: "1000 Fifth Avenue, New York, NY, 10028",
              phone: "212-535-7710",
              imageUrl: "https://example.com/met_fifth_avenue.jpg", // Gerçek bir URL ile değiştirin
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(home: MuseumInfoScreen()));
}
