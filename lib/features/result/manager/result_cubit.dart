
import 'package:cloudquizzer/features/result/manager/result_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/models/score.dart';

class ResultCubit extends Cubit<ResultState> {
  ResultCubit() : super(ResultInitial());

  Future<void> saveScore(int scoreValue, String certificationName, int numOfQuestions) async {
    final box = Hive.box('scoresBox');
    final now = DateTime.now();
    final score = Score(score: scoreValue, date: now, certificationName:certificationName,numOfQuestions: numOfQuestions);
    await box.add(score);
    emit(ResultSaveScore());
  }
}
