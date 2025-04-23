import 'package:metropolitan_museum/app/features/data/models/test_model.dart';
import 'package:metropolitan_museum/app/features/data/repositories/test_repository.dart';
import 'package:metropolitan_museum/core/widgets/snackbar/app_snackbar.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'test_state.dart';

final class TestCubit extends Cubit<TestState> {
  TestCubit({
    required TestRepository testRepository,
  })  : _testRepository = testRepository,
        super(const TestState(
          isLoading: false,
          testList: [],
        ));

  final TestRepository _testRepository;

  Future<void> getAllTests() async {
    emit(state.copyWith(isLoading: true, testList: []));
    await Future.delayed(Durations.extralong4 * 4);
    var dataResult = await _testRepository.getAll();
    if (!dataResult.success) {
      AppSnackBar.show(dataResult.message ?? "Unknown error");
      emit(state.copyWith(isLoading: false));
      return;
    }
    emit(state.copyWith(isLoading: false, testList: dataResult.data));
  }
}
