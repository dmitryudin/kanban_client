import 'package:canban/Dialogs/EditTaskDialog.dart';
import 'package:canban/LoginPage.dart';
import 'package:canban/MyWidgets.dart/ColumnWidget.dart';
import 'package:canban/SplashScreen.dart';
import 'package:canban/configuration/NetworkConfiguration.dart';
import 'package:canban/controllers/TaskObject.dart';
import 'package:canban/utils/Security/Auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Dialogs/CreateTaskDialog.dart';
import 'HomePage.dart';
import 'controllers/TaskColumnObject.dart';

import 'package:url_strategy/url_strategy.dart';

void main() async {
  setPathUrlStrategy();
  runApp(MyApp());
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

  _MyAppState() {
    Auth().init(
        callback: ({required bool isAuthFlag}) {
          if (isAuthFlag)
            page = MyHomePage(
              title: '',
            );
          else
            page = LoginPage();
          setState(() {});
        },
        authUrl: NetworkConfiguration().address + '/auth',
        refreshTokenUrl: NetworkConfiguration().address + '/refresh');
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
