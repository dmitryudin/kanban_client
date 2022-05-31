import 'package:canban/utils/Security/Auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'utils/Network/RestController.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String status = '';
  String login = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(title: Text('Регистрация')),
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
                          'Введите учетные данные',
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
                        Text(this.status),
                        Padding(padding: EdgeInsets.only(top: height * 0.03)),
                        ElevatedButton(
                            onPressed: () {
                              RestController().sendPostRequest(
                                  onComplete: (
                                      {required String data,
                                      required int statusCode}) {
                                    if (statusCode == 201)
                                      Navigator.pop(context);
                                  },
                                  onError: ({required int statusCode}) {
                                    if (statusCode == 409) {
                                      status = 'Пользователь существует';
                                    } else {
                                      status = 'Ошибка $statusCode';
                                    }
                                    setState(() {});
                                  },
                                  controller: 'register',
                                  data:
                                      '{"login":"$login", "password":"$password", "role":"client"}');
                            },
                            child: Text('Зарегистрироваться')),
                        Padding(padding: EdgeInsets.only(top: height * 0.03)),
                        Padding(padding: EdgeInsets.only(top: height * 0.05)),
                      ],
                    )))
          ])
        ]));
  }
}
