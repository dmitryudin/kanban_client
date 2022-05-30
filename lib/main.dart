import 'package:canban/Dialogs/EditTaskDialog.dart';
import 'package:canban/LoginPage.dart';
import 'package:canban/MyWidgets.dart/ColumnWidget.dart';
import 'package:canban/SplashScreen.dart';
import 'package:canban/controllers/TaskObject.dart';
import 'package:canban/utils/Auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Dialogs/CreateTaskDialog.dart';
import 'HomePage.dart';
import 'controllers/TaskColumnObject.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  runApp(MyApp());
  await Hive.initFlutter();
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  Widget page = SplashScreen();
  void reload() {
    if (Auth().isAuth())
      page = MyHomePage(title: 'kanban');
    else
      page = LoginPage();
    setState(() {});
  }

  _MyAppState() {
    Auth().init(
        callback: () {
          print('App reloaded');
          if (Auth().isAuth())
            page = MyHomePage(title: 'kanban');
          else
            page = LoginPage();
          setState(() {});
        },
        reloadFunction: reload);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => TaskColumnObject()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: page,
        ));
  }
}
