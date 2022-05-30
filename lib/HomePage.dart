import 'package:canban/utils/Auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Dialogs/CreateTaskDialog.dart';
import 'MyWidgets.dart/ColumnWidget.dart';
import 'controllers/TaskColumnObject.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState() {}
  void _incrementCounter() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double index = 0.01;
    print('rebuild');
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.update),
              onPressed: () {
                Provider.of<TaskColumnObject>(context, listen: false).getData();
              },
            ),
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                Provider.of<TaskColumnObject>(context, listen: false)
                    .saveState();
              },
            ),
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                Auth().logOut(() {});
              },
            )
          ],
          title: Text('KanbanBoard'),
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: index,
              ),
              Column(
                children: [
                  ColumnWidget(
                    taskList:
                        Provider.of<TaskColumnObject>(context, listen: true)
                            .idea,
                    title: 'Idea',
                    color: Color.fromARGB(255, 243, 177, 34),
                    btn: true,
                  ),
                ],
              ),
              SizedBox(
                width: index,
              ),
              Column(
                children: [
                  ColumnWidget(
                    taskList:
                        Provider.of<TaskColumnObject>(context, listen: true)
                            .todo,
                    title: 'To do',
                    color: Color.fromARGB(255, 236, 51, 18),
                    btn: false,
                  )
                ],
              ),
              SizedBox(
                width: index,
              ),
              Column(
                children: [
                  ColumnWidget(
                    taskList:
                        Provider.of<TaskColumnObject>(context, listen: true)
                            .inProgress,
                    title: 'In process',
                    color: Color.fromARGB(255, 121, 119, 255),
                    btn: false,
                  )
                ],
              ),
              SizedBox(
                width: index,
              ),
              Column(
                children: [
                  ColumnWidget(
                    taskList:
                        Provider.of<TaskColumnObject>(context, listen: true)
                            .done,
                    title: 'Done',
                    color: Color.fromARGB(255, 20, 253, 32),
                    btn: false,
                  )
                ],
              )
            ],
          ),
        ]));
  }
}
