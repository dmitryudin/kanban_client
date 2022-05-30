import 'package:canban/controllers/TaskColumnObject.dart';
import 'package:canban/controllers/TaskObject.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Dialogs/EditTaskDialog.dart';

class TaskCard extends StatefulWidget {
  TaskCard({required this.taskObject, required this.parentList, Key? key})
      : super(key: key);
  TaskObject taskObject;
  List<TaskObject> parentList = [];

  @override
  State<TaskCard> createState() => _TaskCardState(taskObject, parentList);
}

class _TaskCardState extends State<TaskCard> {
  TaskObject taskObject;
  List<TaskObject> parentList = [];
  _TaskCardState(
    this.taskObject,
    this.parentList,
  );
  @override
  Widget build(BuildContext context) {
    Color color;
    if (!DateTime.now().isBefore(taskObject.requiredDateTime)) {
      color = Colors.red;
    } else
      color = Colors.black;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return LongPressDraggable<TaskObject>(
        onDragCompleted: () {
          parentList.remove(taskObject);
          Provider.of<TaskColumnObject>(context, listen: false)
              .notifyListeners();
        },
        data: taskObject,
        dragAnchorStrategy: pointerDragAnchorStrategy,
        feedback: Container(
          width: width / 5,
          height: height / 5,
          decoration:
              BoxDecoration(border: Border.all(color: Colors.blueAccent)),
        ),
        childWhenDragging: Container(),
        child: Card(
          child: Column(children: [
            ListTile(
                title: Text(taskObject.name),
                tileColor: Color.fromARGB(255, 187, 187, 187),
                trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                  IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return EditTaskDialog(task: taskObject);
                          });
                    },
                    icon: const Icon(Icons.create),
                  ),
                  IconButton(
                      onPressed: () {
                        parentList.remove(taskObject);
                        Provider.of<TaskColumnObject>(context, listen: false)
                            .notifyListeners();
                      },
                      icon: const Icon(Icons.delete)),
                ])),
            Row(children: [
              Container(
                width: width / 6,
                child: Column(children: [
                  Text(
                      'Срок исполнения: ' +
                          taskObject.requiredDateTime.day.toString() +
                          '.' +
                          taskObject.requiredDateTime.month.toString() +
                          '.' +
                          taskObject.requiredDateTime.year.toString(),
                      style: TextStyle(color: color)),
                  Divider(color: Colors.black),
                  Text(
                    taskObject.description,
                    //softWrap: true, textAlign: TextAlign.left,
                    maxLines: 3, // new line
                    overflow: TextOverflow.ellipsis,
                  ),
                ]),
              ),
            ])
          ]),
        ));
  }
}
