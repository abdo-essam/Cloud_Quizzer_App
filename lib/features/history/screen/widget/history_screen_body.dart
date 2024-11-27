import 'package:cloudquizzer/core/models/score.dart';
import 'package:cloudquizzer/features/history/manager/history_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../../core/theme/color_manager.dart';

class HistoryScreenBody extends StatelessWidget {
  const HistoryScreenBody({super.key, required this.scores});

  final List<Score> scores;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            const SizedBox(height: 50),
            _buildHeader(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView.separated(
                  itemCount: scores.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 15),
                  itemBuilder: (context, index) {
                    final score = scores[index];
                    return _buildScoreCard(context, score);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Text(
      "History Points",
      style: TextStyle(
        color: ColorManager.white,
        fontWeight: FontWeight.bold,
        fontSize: 30,
      ),
    );
  }

  Widget _buildScoreCard(BuildContext context, Score score) {
    final percentage = score.score / score.numOfQuestions;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ColorManager.cultured,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: _buildScoreDetails(score),
          ),
          Expanded(
            child: _buildScoreActions(context, score, percentage),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreDetails(Score score) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          score.certificationName,
          style: TextStyle(
            color: ColorManager.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 8),
        Text("Questions: ${score.score}/${score.numOfQuestions}"),
        const SizedBox(height: 8),
        Text("Date: ${DateFormat('yyyy-MM-dd h:mm:ss a').format(score.date)}"),
        const SizedBox(height: 8),
        Text("Your Score: ${score.score}"),
      ],
    );
  }

  Widget _buildScoreActions(BuildContext context, Score score, double percentage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InkWell(
          onTap: () => context.read<HistoryCubit>().deleteScore(score),
          child: const Icon(Icons.close, color: ColorManager.red),
        ),
        const SizedBox(height: 10),
        CircularPercentIndicator(
          radius: 60.0,
          lineWidth: 13.0,
          percent: percentage,
          animationDuration: 1200,
          circularStrokeCap: CircularStrokeCap.round,
          center: Text("${(percentage * 100).toInt()}%"),
          progressColor: _getConditionalColor(percentage * 100),
        ),
      ],
    );
  }

  Color _getConditionalColor(double value) {
    return value >= 70 ? ColorManager.green : ColorManager.red;
  }
}
