import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metropolitan_museum/app/features/presentation/settings/cubit/theme_cubit.dart';

import '../../../../common/constants/app_colors.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        debugPrint('ToggleButton ThemeMode: $themeMode');
        final isDark = themeMode == ThemeMode.dark ||
            (themeMode == ThemeMode.system && MediaQuery.of(context).platformBrightness == Brightness.dark);

        return GestureDetector(
          onTap: () {
            context.read<ThemeCubit>().toggleTheme(!isDark);
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              color: Theme.of(context).brightness == Brightness.dark ? AppColors.smokyBlack : AppColors.whiteGost,
              child: ListTile(
                title: const Text('Dark Mode'),
                leading: const Icon(Icons.brightness_6),
                trailing: Switch(
                  inactiveTrackColor: AppColors.whiteGost,
                  value: isDark,
                  onChanged: (value) {
                    context.read<ThemeCubit>().toggleTheme(value);
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
