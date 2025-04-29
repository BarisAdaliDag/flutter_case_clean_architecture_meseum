import 'package:flutter/material.dart';

import 'package:metropolitan_museum/app/common/constants/app_colors.dart';
import 'package:metropolitan_museum/app/common/constants/app_strings.dart';

class CollectionTextField extends StatefulWidget {
  const CollectionTextField({
    super.key,
    required this.controller,
  });
  final TextEditingController controller;
  @override
  State<CollectionTextField> createState() => _CollectionTextFieldState();
}

class _CollectionTextFieldState extends State<CollectionTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    // FocusNode'a bir dinleyici ekliyoruz
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: _focusNode, // FocusNode'u TextField'a bağlıyoruz
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: AppStrings.search,
        hintStyle: TextStyle(
          color: _isFocused
              ? Theme.of(context).brightness == Brightness.dark
                  ? AppColors.grey
                  : AppColors.black
              : Colors.grey,
        ),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 1,
              height: 52,
              color: _isFocused
                  ? Theme.of(context).brightness == Brightness.dark
                      ? AppColors.grey
                      : AppColors.black
                  : Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(
                Icons.search,
                color: _isFocused ? Colors.red : Colors.grey,
              ),
            ),
          ],
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
            width: 1.0,
          ),
        ),
      ),
    );
  }
}
