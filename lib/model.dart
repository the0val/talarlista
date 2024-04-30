import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:collection';
import 'speaker.dart';

class SpeakersQueue extends ChangeNotifier {
  final Queue<Speaker> _items = Queue<Speaker>();
  List<Speaker> speakerData = <Speaker>[];
  UnmodifiableListView get items => UnmodifiableListView<Speaker>(_items);

  void queue(Speaker speaker) {
    _items.addLast(_findNrInData(speaker.nr));
    notifyListeners();
  }

  void dequeue() {
    _items.removeFirst();
    notifyListeners();
  }

  void remove(Speaker speaker) {
    _items.remove(speaker);
    notifyListeners();
  }

  Speaker _findNrInData(String nr) {
    return speakerData.firstWhere((s) => s.nr == nr, orElse: () => Speaker(nr));
  }
}
