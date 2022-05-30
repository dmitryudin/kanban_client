import 'dart:typed_data';

import 'package:canban/controllers/TaskColumnObject.dart';
import 'package:canban/controllers/TaskObject.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditTaskDialog extends StatefulWidget {
  TaskObject task;
  EditTaskDialog({required this.task, Key? key}) : super(key: key);

  @override
  State<EditTaskDialog> createState() => _EditTaskDialogState(task: task);
}

class _EditTaskDialogState extends State<EditTaskDialog> {
  late TaskObject task;
  _EditTaskDialogState({required this.task}) {}
  String dateTime = '';

  selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != DateTime.now())
      dateTime = picked.toString().split(' ')[0].toString();
    task.requiredDateTime = DateTime.parse(dateTime);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return AlertDialog(
        title: Text('Создание задачи'),
        content: Container(
            width: MediaQuery.of(context).size.width / 3,
            child: Column(
              children: [
                TextFormField(
                  controller: TextEditingController()..text = task.name,
                  validator: (value) {},
                  onChanged: (String value) {
                    task.name = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Заголовок задачи',
                  ),
                ),
                Expanded(
                    child: TextField(
                  maxLines: null,
                  controller: TextEditingController()..text = task.description,
                  onChanged: (String value) {
                    task.description = value;
                  },
                  //maxLines: 10,
                  decoration: InputDecoration(
                    labelText: 'Описание задачи',
                  ),
                )),
                TextFormField(
                  controller: TextEditingController()
                    ..text = task.requiredDateTime.toString(),
                  readOnly: true,
                  validator: (value) {},
                  onChanged: (String value) {
                    task.requiredDateTime = DateTime.parse(value);
                  },
                  decoration: InputDecoration(
                    labelText: 'Дата исполнения задачи',
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      selectDate(context);
                    },
                    child: Text('Задать сроки исполнения')),
                Padding(padding: EdgeInsets.only(top: height * 0.05)),
                ElevatedButton(
                    onPressed: () {
                      Provider.of<TaskColumnObject>(context, listen: false)
                          .notifyListeners();
                      Navigator.pop(context);
                    },
                    child: Text('Save'))
              ],
            )));
  }
}
