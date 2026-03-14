import 'package:flutter/material.dart';

class CharacterAnalysisNotifier with ChangeNotifier {
  String _character = '';
  List<MapEntry<String, int>> _characterCount = [];

  String get character => _character;
  List<MapEntry<String, int>> get characterCount => _characterCount;

  void updateCharacter(String newCharacter) {
    _character = newCharacter;
    _characterCount = getCharacterDistribution(newCharacter);
    notifyListeners();
  }

  int getCharacterLength() {
    return character.length;
  }

  List<MapEntry<String, int>> getCharacterDistribution(String text) {
    Map<String, int> counts = {};

    for (var char in text.split('')) {
      counts[char] = (counts[char] ?? 0) + 1;
    }

    return counts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value))
      ..take(15);
  }

  double getReadingTime(String text) {
    int wordCount = text.split(' ').length;
    return wordCount / 200;
  }
}
