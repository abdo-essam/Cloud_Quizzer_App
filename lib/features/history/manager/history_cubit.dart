import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/models/score.dart';
import 'history_state.dart';


class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInitial());

  Future<List<Score>> getScores() async {
    try {
      emit(HistoryLoading());
      final box = Hive.box('scoresBox');
      emit(HistoryLoaded(scores: box.values.cast<Score>().toList().reversed.toList()));
      return box.values.cast<Score>().toList();
    } catch (e) {
      emit(HistoryError(message: e.toString()));
      return [];
    }
  }

  Future<void> deleteScore(Score score) async {
    try {
      final box = Hive.box('scoresBox');
      await box.delete(score);
      emit(HistoryDeleteScore(score: score));
    } catch (e) {
      emit(HistoryError(message: e.toString()));
    }
  }






}
