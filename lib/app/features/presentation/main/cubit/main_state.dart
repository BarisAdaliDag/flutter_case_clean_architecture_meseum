part of 'main_cubit.dart';

/// Main State
final class MainState extends Equatable {
  /// Main State Constructor
  const MainState({
    required this.selectedIndex,
    required this.networkResult,
  });

  /// Selected Index Value [BottomNavigationBar]
  final int selectedIndex;

  final NetworkResult networkResult;

  /// Copy With Method
  MainState copyWith({
    int? selectedIndex,
    NetworkResult? networkResult,
  }) {
    return MainState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      networkResult: networkResult ?? this.networkResult,
    );
  }

  @override
  List<Object> get props => [
        selectedIndex,
        networkResult,
      ];
}
