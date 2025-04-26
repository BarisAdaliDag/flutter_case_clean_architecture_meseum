import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:metropolitan_museum/app/common/constants/app_image.dart';
import 'package:metropolitan_museum/app/features/presentation/settings/widget/setttings_body.dart';

@RoutePage()
class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image(image: AssetImage(AppImage.logo.path)),
            SettingsBody(),
          ],
        ),
      ),
    );
  }
}
