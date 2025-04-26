import 'package:flutter/material.dart';
import 'package:metropolitan_museum/app/features/presentation/settings/mixin/settings_mixin.dart';
import 'package:metropolitan_museum/app/features/presentation/settings/widget/settings_button.dart';
import 'package:metropolitan_museum/app/features/presentation/settings/widget/theme_toggle_button.dart';

class SettingsBody extends StatelessWidget with SettingsMixin {
  SettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ThemeToggleButton(),
      ],
    );
  }
}
