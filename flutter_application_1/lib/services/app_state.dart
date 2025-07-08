import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';


class MyAppState extends ChangeNotifier {
  // Holds the current random word pair
  var current = WordPair.random();

  // Updates 'current' with a new random word pair and notifies listeners
  void getNext() {
    current = WordPair.random();
    notifyListeners(); // Triggers UI update
  }

  // A list to store favorite word pairs
  var favorites = <WordPair>[];

  // Adds or removes the current word pair from the favorites list
  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current); // Remove if already a favorite
    } else {
      favorites.add(current); // Add if not already a favorite
    }
    notifyListeners(); // Triggers UI update
  }
}