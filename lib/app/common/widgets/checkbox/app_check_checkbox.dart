import 'package:metropolitan_museum/app/common/constants/app_colors.dart';
import 'package:flutter/material.dart';

final class AppCheckCheckbox extends StatelessWidget {
  final bool isSelected;
  final bool isIndeterminate;
  final ValueChanged<bool> onChanged;

  const AppCheckCheckbox({
    super.key,
    required this.isSelected,
    this.isIndeterminate = false,
    required this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!isSelected);
      },
      child: Container(
        width: 20,
        height: 20,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(6),
          color: Colors.transparent,
          border: Border.all(
            color: isSelected || isIndeterminate ? AppColors.purpleHan : AppColors.platinum,
            width: 1.5,
          ),
        ),
        child: isSelected
            ? const Center(
                child: SizedBox(
                height: 16,
                width: 16,
                child: Icon(
                  Icons.check,
                  color: AppColors.purpleHan,
                  size: 16,
                ),
              ))
            : isIndeterminate
                ? const Center(
                    child: SizedBox(
                    height: 16,
                    width: 16,
                    child: Icon(
                      Icons.remove,
                      color: AppColors.purpleHan,
                      size: 16,
                    ),
                  ))
                : null,
      ),
    );
  }
}
