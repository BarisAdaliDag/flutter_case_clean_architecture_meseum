import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metropolitan_museum/app/features/presentation/settings/cubit/theme_cubit.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        print('ToggleButton ThemeMode: $themeMode');
        final isDark = themeMode == ThemeMode.dark ||
            (themeMode == ThemeMode.system && MediaQuery.of(context).platformBrightness == Brightness.dark);

        return GestureDetector(
          onTap: () {
            context.read<ThemeCubit>().toggleTheme(!isDark);
          },
          child: Card(
            child: ListTile(
              title: const Text('Dark Mode'),
              leading: const Icon(Icons.brightness_6),
              trailing: Switch(
                value: isDark,
                onChanged: (value) {
                  context.read<ThemeCubit>().toggleTheme(value);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
