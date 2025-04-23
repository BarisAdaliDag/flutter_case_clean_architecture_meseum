import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
final class CollectionView extends StatelessWidget {
  const CollectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CollectionView'),
      ),
      body: const Center(
        child: Text('Hello, CollectionView!'),
      ),
    );
  }
}
