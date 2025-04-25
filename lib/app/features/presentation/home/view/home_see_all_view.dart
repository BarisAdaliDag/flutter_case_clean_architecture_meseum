import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:metropolitan_museum/app/common/get_it/get_it.dart';
import 'package:metropolitan_museum/app/features/presentation/home/cubit/home_cubit.dart';
import 'package:metropolitan_museum/app/features/presentation/home/cubit/home_state.dart';
import 'package:metropolitan_museum/app/common/widgets/home_card_widget.dart';

@RoutePage()
class HomeSeeAllView extends StatefulWidget {
  final bool isFamous;
  const HomeSeeAllView({super.key, required this.isFamous});

  @override
  State<HomeSeeAllView> createState() => _HomeSeeAllViewState();
}

class _HomeSeeAllViewState extends State<HomeSeeAllView> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().fetchObjectList(
          query: widget.isFamous ? "Famous%20Artworks" : "Current%20Exhibitions",
          isFamous: widget.isFamous,
          start: 0,
          end: 20,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isFamous ? "Famous Artworks" : "Current Exhibitions"),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final list = widget.isFamous ? state.famousArtworkList : state.currentList;
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.errorMessage != null || list.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.errorMessage!),
                  const Gap(10),
                  ElevatedButton(
                    onPressed: () {
                      context.read<HomeCubit>().fetchObjectList(
                            query: widget.isFamous ? "Famous%20Artworks" : "Current%20Exhibitions",
                            isFamous: widget.isFamous,
                            start: 0,
                            end: 20,
                          );
                    },
                    child: const Text('Tekrar Dene'),
                  ),
                ],
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(12),
            child: ListView.separated(
              itemCount: list.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final obj = list[index];
                return HomeCard(
                  image: obj.primaryImageSmall ?? "",
                  title: obj.title ?? "",
                  subtitle: obj.culture ?? "",
                );
              },
            ),
          );
        },
      ),
    );
  }
}
