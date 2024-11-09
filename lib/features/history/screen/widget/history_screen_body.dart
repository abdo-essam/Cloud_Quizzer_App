import 'package:cloudquizzer/core/models/score.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HistoryScreenBody extends StatefulWidget {
  const HistoryScreenBody({super.key, required this.scores});

  final List<Score> scores;

  @override
  State<HistoryScreenBody> createState() => _HistoryScreenBodyState();
}

class _HistoryScreenBodyState extends State<HistoryScreenBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Text(
              "History Point",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            Expanded(
                child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: widget.scores.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [],
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.scores[index].certificationName,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "Question: ${widget.scores[index].score}/${widget.scores[index].numOfQuestions}",
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "Date: ${DateFormat('yyyy-MM-dd h:mm:ss a').format(widget.scores[index].date)}",
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "Your Score: ${widget.scores[index].score}",
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    InkWell(
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.red,
                                        ),
                                        onTap: () async {
                                          deleteScore(index);
                                        }),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    CircularPercentIndicator(
                                      radius: 60.0,
                                      lineWidth: 13.0,
                                      percent:
                                          (widget.scores[index].score * 1.0) /
                                              100,
                                      animationDuration: 1200,
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                      center: Text(
                                          "${widget.scores[index].score}%"),
                                      progressColor: conditionalColor(
                                          widget.scores[index].score),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ));
                  }),
            ))
          ],
        ),
      ),
    );
  }

  void deleteScore(int index) async {
    final scoreToDelete = widget.scores[index];
    await scoreToDelete.delete();

    setState(() {
      widget.scores.removeAt(index);
    });
  }

  Color conditionalColor(int value) {
    if (value >= 70) {
      return Colors.green;
    }
    return Colors.red;
  }
}
