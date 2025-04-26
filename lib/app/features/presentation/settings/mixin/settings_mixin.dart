import 'package:flutter/material.dart';
import 'package:metropolitan_museum/app/features/presentation/settings/model/settings_button_model.dart';

mixin SettingsMixin {
  List<SettignsButtonModel> settingsButtonList = [
    SettignsButtonModel(
      title: 'Rate Us',
      icon: Icons.star,
      onTap: () {
        // Rate Us işlevselliği
      },
    ),
    SettignsButtonModel(
      title: 'Share App',
      icon: Icons.share,
      onTap: () {
        // Share App işlevselliği
      },
    ),
    SettignsButtonModel(
      title: 'Privacy Policy',
      icon: Icons.privacy_tip,
      onTap: () {
        // Privacy Policy işlevselliği
      },
    ),
    SettignsButtonModel(
      title: 'About Us',
      icon: Icons.info,
      onTap: () {
        // About Us işlevselliği
      },
    ),
  ];
}
