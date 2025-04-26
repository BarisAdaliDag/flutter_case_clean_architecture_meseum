// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TxStyleHelper {
  const TxStyleHelper._();
  static final TextStyle heading1 = TextStyle(
    fontSize: 34.sp,
    fontWeight: FontWeight.w400,
    
  );

  static final TextStyle heading2 = TextStyle(
    fontSize: 28.sp,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle heading3 = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle headline = TextStyle(
    fontSize: 30.sp,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle body = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle bodyBold = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle subheading = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle subheadingBold = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle caption = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle captionBold = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w700,
  );
}
