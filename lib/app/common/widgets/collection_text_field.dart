import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metropolitan_museum/app/features/presentation/collection/cubit/collection_cubit.dart';

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
        hintText: "Search",
        hintStyle: TextStyle(
          color: _isFocused ? Colors.black : Colors.grey,
        ),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 1,
              height: 52,
              color: _isFocused ? Colors.black : Colors.grey,
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
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
        ),
      ),
    );
  }
}
