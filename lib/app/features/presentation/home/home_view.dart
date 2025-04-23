import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:metropolitan_museum/app/common/constants/app_image.dart';
import 'package:metropolitan_museum/main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

@RoutePage()
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     centerTitle: true,
      //     title: SizedBox(
      //         height: 70,
      //         width: 70,
      //         child: Image.asset(
      //           AppImage.logo.path,
      //         ))),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
                height: 70,
                width: 70,
                child: Image.asset(
                  AppImage.logo.path,
                )),
            Container(
              height: 15.h,
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
