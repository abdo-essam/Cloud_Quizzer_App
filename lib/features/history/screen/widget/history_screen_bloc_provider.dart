import 'package:cloudquizzer/core/models/score.dart';
import 'package:cloudquizzer/features/history/manager/history_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/no_data_founded_screen.dart';
import '../../manager/history_state.dart';
import 'history_screen_body.dart';

class HistoryScreenBlocProvider extends StatelessWidget {
  const HistoryScreenBlocProvider({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<HistoryCubit>().getScores();
    return BlocBuilder<HistoryCubit, HistoryState>(
      builder: (context, state) {
        if (state is HistoryLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.deepOrange,
            ),
          );
        }
        if (state is HistoryLoaded) {
          return getHistoryScreen(state.scores);
        }
        if (state is HistoryError) {
          return Center(
            child: Text(state.message),
          );
        }
        return const Center(
          child: Text('Something went wrong! , try again later'),
        );
      },
    );
  }

  Widget getHistoryScreen(List<Score> scores) {
    if (scores.isEmpty) {
      return const NoDataFoundedScreen();
    }
    return HistoryScreenBody(scores: scores);
  }
}
