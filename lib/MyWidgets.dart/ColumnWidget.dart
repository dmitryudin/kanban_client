import 'package:canban/MyWidgets.dart/Task.dart';
import 'package:canban/controllers/TaskObject.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Dialogs/CreateTaskDialog.dart';

class ColumnWidget extends StatefulWidget {
  String title = '';
  Color color;
  bool btn;
  List<TaskObject> taskList = [];
  ColumnWidget(
      {required this.title,
      required this.taskList,
      required this.color,
      required this.btn,
      Key? key})
      : super(key: key);

  @override
  State<ColumnWidget> createState() => _ColumnWidgetState(
      title: title, taskList: taskList, color: color, btn: btn);
}

class _ColumnWidgetState extends State<ColumnWidget> {
  String title = '';
  Color color;
  bool btn;
  List<TaskObject> taskList = [];
  _ColumnWidgetState(
      {required this.title,
      required this.taskList,
      required this.color,
      required this.btn});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Widget> myTasksWidget = [];
    for (TaskObject task in taskList) {
      myTasksWidget.add(
          TaskCard(parentList: taskList, taskObject: task, key: UniqueKey()));
    }
    return DragTarget<TaskObject>(onWillAccept: ((data) {
      return true;
    }), onAccept: ((data) {
      print('onAccepted $data');
      taskList.add(data);
      setState(() {});
    }), builder: (
      BuildContext context,
      List<dynamic> accepted,
      List<dynamic> rejected,
    ) {
      return Container(
          padding: const EdgeInsets.all(1.0),
          height: size.height / 1.2,
          width: size.width / 4.1,
          child: Card(
              child: Column(children: [
            ListTile(
              trailing: btn
                  ? IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CreateTaskDialog();
                            });
                        //setState(() {});
                      },
                      icon: const Icon(Icons.add_circle_outline),
                    )
                  : null,
              tileColor: color,
              textColor: Color.fromARGB(255, 5, 5, 5),
              title: Text(
                title + ' (' + taskList.length.toString() + ')',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
                child: ListView(
              shrinkWrap: true,
              children: myTasksWidget,
            ))
          ])));
    });
  }
}
