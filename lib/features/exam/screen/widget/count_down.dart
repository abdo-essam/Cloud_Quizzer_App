import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

import '../../../../core/theme/color_manager.dart';

class CountDown extends StatefulWidget {
  final int quizTime; // Quiz time in minutes
  final VoidCallback timeOut; // Callback when the timer ends

  const CountDown({
    super.key,
    required this.quizTime,
    required this.timeOut,
  });

  @override
  CountDownState createState() => CountDownState();
}

class CountDownState extends State<CountDown> {
  late DateTime _endTime;

  @override
  void initState() {
    super.initState();
    _setEndTime();
  }

  /// Initializes or resets the end time for the countdown timer
  void _setEndTime() {
    _endTime = DateTime.now().add(Duration(minutes: widget.quizTime));
  }

  /// Restarts the countdown timer
  void restartTimer() {
    setState(_setEndTime);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: _buildDecoration(),
      child: Row(
        children: [
          // Timer Icon
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Icon(
              Icons.timer_outlined,
              color: ColorManager.white,
              size: 18.w,
            ),
          ),
          // Countdown Timer
          TimerCountdown(
            format: CountDownTimerFormat.hoursMinutesSeconds,
            enableDescriptions: false,
            colonsTextStyle: _buildTextStyle(),
            timeTextStyle: _buildTextStyle(),
            endTime: _endTime,
            onEnd: widget.timeOut,
          ),
        ],
      ),
    );
  }

  // Builds the BoxDecoration for the container
  BoxDecoration _buildDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(
        color: ColorManager.white,
        width: 1.5,
      ),
    );
  }

  // Returns a consistent TextStyle for the countdown text
  TextStyle _buildTextStyle() {
    return const TextStyle(color: ColorManager.white, fontSize: 14);
  }
}
