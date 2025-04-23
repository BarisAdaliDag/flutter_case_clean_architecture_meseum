import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../core/network_control/network_control.dart';

part 'main_state.dart';

/// Main Cubt
class MainCubit extends Cubit<MainState> {
  /// Main Cubit constructor
  MainCubit()
      : super(
          const MainState(
            selectedIndex: 0,
            networkResult: NetworkResult.on,
          ),
        ) {
    _checkInitialConnection();
    _listenToNetworkChanges();
  }
  final INetworkControl _networkControl = NetworkControl();

  /// Main View Selected [BottomNavigationBar] index
  void setSelectedIndex(int index) => emit(state.copyWith(selectedIndex: index));

  void _checkInitialConnection() async {
    NetworkResult result = await _networkControl.checkNetworkFirstTime();
    emit(state.copyWith(networkResult: result));
  }

  void _listenToNetworkChanges() {
    _networkControl.handleNetworkChange((NetworkResult result) {
      emit(state.copyWith(networkResult: result));
    });
  }

  @override
  Future<void> close() {
    _networkControl.dispose();
    return super.close();
  }
}
