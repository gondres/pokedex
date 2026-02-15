import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  // Type colors for badges and glow
  static const Map<String, Color> typeColors = {
    'normal': Colors.grey,
    'fire': Colors.orange,
    'water': Colors.blue,
    'electric': Colors.yellow,
    'grass': Color(0xFFF49D0B1),
    'ice': Colors.cyan,
    'fighting': Colors.red,
    'poison': Colors.purple,
    'ground': Colors.brown,
    'flying': Colors.indigo,
    'psychic': Colors.pink,
    'bug': Colors.lime,
    'rock': Colors.brown,
    'ghost': Colors.deepPurple,
    'dragon': Colors.indigo,
    'dark': Colors.grey,
    'steel': Colors.blueGrey,
    'fairy': Colors.pinkAccent,
  };

  // Type gradients for background
  static Map<String, List<Color>> typeGradients = {
    'normal': [Colors.grey, Colors.grey.shade300],
    'fire': [Colors.orange, Colors.redAccent],
    'water': [Colors.blue, Colors.cyan],
    'electric': [Colors.yellow, Colors.yellowAccent],
    'grass': [Colors.green, Colors.lightGreen],
    'ice': [Colors.cyan, Colors.blueAccent],
    'fighting': [Colors.red, Colors.orange],
    'poison': [Colors.purple, Colors.deepPurple],
    'ground': [Colors.brown, Colors.amber],
    'flying': [Colors.indigo, Colors.lightBlue],
    'psychic': [Colors.pink, Colors.purple],
    'bug': [Colors.lime, Colors.green],
    'rock': [Colors.brown, Colors.grey],
    'ghost': [Colors.deepPurple, Colors.indigo],
    'dragon': [Colors.indigo, Colors.purple],
    'dark': [Colors.grey, Colors.black87],
    'steel': [Colors.blueGrey, Colors.grey],
    'fairy': [Colors.pinkAccent, Colors.pink],
  };
}
