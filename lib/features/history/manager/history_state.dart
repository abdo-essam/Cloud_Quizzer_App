import '../../../core/models/score.dart';

abstract class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<Score> scores;

  HistoryLoaded({required this.scores});
}

class HistoryError extends HistoryState {
  final String message;

  HistoryError({required this.message});
}

class HistoryDeleteScore extends HistoryState {
  final Score score;

  HistoryDeleteScore({required this.score});
}
