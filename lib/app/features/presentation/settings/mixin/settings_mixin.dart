import 'package:flutter/material.dart';
import 'package:metropolitan_museum/app/features/presentation/settings/model/settings_button_model.dart';

/// Settings view mixin
mixin SettingsMixin {
  /// Settings button list datas
  List<SettignsButtonModel> settingsButtonList = [
    SettignsButtonModel(title: 'Rate Us', icon: Icons.add, onTap: () {}),
    SettignsButtonModel(title: 'Rate Us', icon: Icons.add, onTap: () {}),
    SettignsButtonModel(title: 'Rate Us', icon: Icons.add, onTap: () {}),
    SettignsButtonModel(title: 'Rate Us', icon: Icons.add, onTap: () {}),
    SettignsButtonModel(title: 'Rate Us', icon: Icons.add, onTap: () {}),
  ];
}
