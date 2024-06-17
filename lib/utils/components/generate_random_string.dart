import 'dart:math';
import 'package:flutter/material.dart';



String generateRandomString() {
  final Random random = Random();

  // List of uppercase and lowercase letters
  List<String> uppercaseLetters = List.generate(26, (index) => String.fromCharCode('A'.codeUnitAt(0) + index));
  List<String> lowercaseLetters = List.generate(26, (index) => String.fromCharCode('a'.codeUnitAt(0) + index));

  // Combine both lists into one
  List<String> allLetters = [...uppercaseLetters, ...lowercaseLetters];

  // Generate a random 9-character string
  String randomString = List.generate(9, (_) => allLetters[random.nextInt(allLetters.length)]).join('');
  debugPrint(randomString);
  return randomString;
}