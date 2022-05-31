import 'dart:typed_data';

import 'package:canban/controllers/TaskColumnObject.dart';
import 'package:canban/controllers/TaskObject.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../utils/Security/validator.dart';

class CreateTaskDialog extends StatefulWidget {
  CreateTaskDialog({Key? key}) : super(key: key);

  @override
  State<CreateTaskDialog> createState() => _CreateTaskDialogState();
}

class _CreateTaskDialogState extends State<CreateTaskDialog> {
  final _formKey = GlobalKey<FormState>();
  late TaskObject newTask;
  _CreateTaskDialogState() {
    newTask = TaskObject(name: '', description: '');
  }
  String dateTime = '';

  selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != DateTime.now())
      dateTime = picked.toString().split(' ')[0].toString();
    newTask.requiredDateTime = DateTime.parse(dateTime);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return AlertDialog(
        title: Text('Создание задачи'),
        content: Container(
            width: MediaQuery.of(context).size.width / 3,
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {},
                      onChanged: (String value) {
                        newTask.name = value;
                      },
                      decoration: InputDecoration(
                        labelText: 'Заголовок задачи',
                      ),
                    ),
                    Expanded(
                        child: TextField(
                      maxLines: null,
                      onChanged: (String value) {
                        newTask.description = value;
                      },
                      scrollPadding: EdgeInsets.only(bottom: 40),
                      inputFormatters: [
                        //LengthLimitingTextInputFormatter(10),
                      ],
                      decoration: InputDecoration(
                        labelText: 'Описание задачи',
                      ),
                    )),
                    TextFormField(
                      controller: TextEditingController()..text = dateTime,
                      readOnly: true,
                      validator: (value) {
                        return Validator.isEmptyValid(value!);
                      },
                      onChanged: (String value) {
                        newTask.requiredDateTime = DateTime.parse(value);
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
                          if (_formKey.currentState!.validate()) {
                            Provider.of<TaskColumnObject>(context,
                                    listen: false)
                                .idea
                                .add(newTask);
                            Provider.of<TaskColumnObject>(context,
                                    listen: false)
                                .notifyListeners();
                            Navigator.pop(context);
                          }
                        },
                        child: Text('Save'))
                  ],
                ))));
  }
}
