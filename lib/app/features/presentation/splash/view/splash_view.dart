import 'package:auto_route/auto_route.dart';
import 'package:metropolitan_museum/app/common/get_it/get_it.dart';
import 'package:metropolitan_museum/app/common/router/app_router.dart';
import 'package:metropolitan_museum/app/features/presentation/test/cubit/test_cubit.dart';
import 'package:metropolitan_museum/app/features/presentation/test/view/test_view.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // getIt.get<TestCubit>().getAllTests();
      context.replaceRoute(const MainRoute());
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Placeholder(),
    );
  }
}
