import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metropolitan_museum/app/features/presentation/home/cubit/home_cubit.dart';
import 'package:metropolitan_museum/app/features/presentation/home/cubit/home_state.dart';

mixin SeeAllMixin<T extends StatefulWidget> on State<T> {
  int currentPage = 1;
  static const int itemsPerPage = 20;
  bool hasInternet = false;

  bool get isFamous;

  Future<void> fetchData(BuildContext context) async {
    hasInternet = await context.read<HomeCubit>().checkInternetControl();
    print('SeeAllMixin fetching page $currentPage for isFamous: $isFamous');

    isFamous ? context.read<HomeCubit>().resetfamouslist() : context.read<HomeCubit>().resetCurrentlist();
    int start = (currentPage - 1) * itemsPerPage;
    int end = currentPage * itemsPerPage;
    await context.read<HomeCubit>().fetchObjectList(
          query: isFamous ? "Famous%20Artworks" : "Current%20Exhibitions",
          isFamous: isFamous,
          start: start,
          end: end,
        );
  }

  void nextPage(int totalItems) {
    final totalPages = (totalItems / itemsPerPage).ceil();
    if (currentPage < totalPages) {
      print('Navigating to next page: ${currentPage + 1} / $totalPages');
      setState(() {
        currentPage++;
        fetchData(context);
      });
    }
  }

  void previousPage() {
    if (currentPage > 1) {
      print('Navigating to previous page: ${currentPage - 1}');
      setState(() {
        currentPage--;
        fetchData(context);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData(context);
  }
}
