import 'package:flutter/material.dart';

class Data {
  static List<String> taskList = [];
  static const TextStyle textStyle = TextStyle(fontSize: 25);

  static addTaskToList(value) {
    taskList.add(value);
  }
}
