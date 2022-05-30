import 'dart:convert';

import 'package:canban/controllers/TaskObject.dart';
import 'package:flutter/cupertino.dart';

import '../Network/RestController.dart';

class TaskColumnObject extends ChangeNotifier {
  List<TaskObject> idea = [];
  List<TaskObject> todo = [];
  List<TaskObject> inProgress = [];
  List<TaskObject> done = [];

  TaskColumnObject() {
    getData();
  }

  fromJson(var data) {
    idea.clear();
    todo.clear();
    inProgress.clear();
    done.clear();

    Map<String, dynamic> jsonString = jsonDecode(data);

    for (var el in jsonString['idea'])
      idea.add(TaskObject.fromJsonString(jsonString: el));

    for (var el in jsonString['todo']) {
      todo.add(TaskObject.fromJsonString(jsonString: el));
    }

    for (var el in jsonString['inprocess'])
      inProgress.add(TaskObject.fromJsonString(jsonString: el));
    for (var el in jsonString['done'])
      done.add(TaskObject.fromJsonString(jsonString: el));

    redraw();
  }

  String toJson() {
    Map<String, dynamic> data = {};
    data['idea'] = idea.map((e) => jsonDecode(e.toJson())).toList();
    data['todo'] = todo.map((e) => jsonDecode(e.toJson())).toList();
    data['inprocess'] = inProgress.map((e) => jsonDecode(e.toJson())).toList();
    data['done'] = done.map((e) => jsonDecode(e.toJson())).toList();
    String json = jsonEncode(data);
    return json;
  }

  void saveState() {
    RestController().sendPostRequest(
        onComplete: ({required String data}) {},
        onError: ({required String data}) {},
        controller: 'update',
        data: this.toJson());
  }

  void getData() {
    RestController().sendPostRequest(
        onComplete: ({required String data}) {
          fromJson(data);
        },
        onError: ({required String data}) {},
        controller: 'get',
        data: "");
  }

  void redraw() {
    print(idea.length);
    print(todo.length);
    print(inProgress.length);
    print(done.length);
    notifyListeners();
  }
}
