import 'package:flutter/material.dart';

WidgetStateProperty<Color> getColor(Color color, Color colorPressed) {
  getColor(Set<WidgetState> states) {
    if (states.contains(WidgetState.pressed)) {
      return colorPressed;
    } else {
      return color;
    }
  }

  return WidgetStateProperty.resolveWith(getColor);
}