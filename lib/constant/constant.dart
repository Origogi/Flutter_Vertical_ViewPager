import 'dart:ui';

import 'package:flutter/material.dart';

const maxCardWidthPadding = 50;
const cardHeightPadding = 15;

enum Role { TANKER, FIGHTER, MARKSMAN, MAGE, ASSASIN }

enum Difficulty { LOW, MODERATE, HIGH }
final backgoundColor = Color(0xff000913);

final difficultyEnableColor = Color(0xff08d6f6);
final difficultyDisableColor = Color(0xff023240);


const textTheme = TextTheme(
  headline1: TextStyle(
      fontSize: 60.0, fontWeight: FontWeight.bold, color: Colors.white),
  headline2: TextStyle(
      fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.white),
);
