import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
final class InfoView extends StatelessWidget {
  const InfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InfoView'),
      ),
      body: const Center(
        child: Text('Hello, InfoView!'),
      ),
    );
  }
}
