import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:metropolitan_museum/app/common/constants/app_colors.dart';
import 'package:metropolitan_museum/app/common/constants/text_style_helper.dart';
import 'package:metropolitan_museum/app/common/get_it/get_it.dart';
import 'package:metropolitan_museum/app/features/presentation/home/cubit/home_cubit.dart';
import 'package:metropolitan_museum/app/features/presentation/home/cubit/home_state.dart';

class TryAgainButtonContainer extends StatelessWidget {
  final HomeState state;

  const TryAgainButtonContainer({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(state.errorMessage!),
          const Gap(10),
          TextButton(
            onPressed: () {
              getIt<HomeCubit>().fetchHomeData();
            },
            child: Text(
              'Try Again',
              style: TxStyleHelper.body.copyWith(
                color: AppColors.redValencia,
                decoration: TextDecoration.underline,
                decorationColor: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
