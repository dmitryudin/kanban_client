import 'dart:convert';

class TaskObject {
  String name = '';
  String description = '';
  late DateTime dateTimeOfCreate;
  late DateTime requiredDateTime;

  TaskObject({required this.name, required this.description});

  String toJson() {
    Map<String, dynamic> data = {};
    data['name'] = name;
    data['description'] = description;
    data['date'] = requiredDateTime.toString();
    String json = jsonEncode(data);
    return json;
  }

  TaskObject.fromJsonString({jsonString}) {
    name = jsonString['name'];

    description = jsonString['description'];

    requiredDateTime = DateTime.parse(jsonString['date'].toString());
  }
}
