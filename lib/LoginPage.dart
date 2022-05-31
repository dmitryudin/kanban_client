import 'package:canban/RegisterPage.dart';
import 'package:canban/utils/Security/Auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String login = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(title: Text('Вход')),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                width: width / 3.5,
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 15,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(padding: EdgeInsets.only(top: height * 0.03)),
                        Text(
                          'Пожалуйста, авторизуйтесь',
                          style: TextStyle(fontSize: 24),
                        ),
                        Padding(padding: EdgeInsets.only(top: height * 0.03)),
                        Container(
                            width: width / 5,
                            child: TextFormField(
                              //controller: TextEditingController()..text = dateTime,
                              //readOnly: true,
                              //initialValue: dateTime,
                              validator: (value) {},
                              onChanged: (String value) {
                                login = value;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.person),
                                labelText: 'Логин',
                              ),
                            )),
                        Padding(padding: EdgeInsets.only(top: height * 0.03)),
                        Container(
                            width: width / 5,
                            child: TextFormField(
                                //controller: TextEditingController()..text = dateTime,

                                //initialValue: dateTime,
                                validator: (value) {},
                                onChanged: (String value) {
                                  password = value;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.key),
                                  labelText: 'Пароль',
                                ))),
                        Padding(padding: EdgeInsets.only(top: height * 0.03)),
                        ElevatedButton(
                            onPressed: () {
                              Auth().logIn(login: login, password: password);
                            },
                            child: Text('Войти')),
                        Padding(padding: EdgeInsets.only(top: height * 0.03)),
                        TextButton(
                          child: Text('Зарегестрироваться'),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return RegisterPage();
                              },
                            );
                          },
                        ),
                        Padding(padding: EdgeInsets.only(top: height * 0.05)),
                      ],
                    )))
          ])
        ]));
  }
}
