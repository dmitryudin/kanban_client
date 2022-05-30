import 'package:canban/utils/Auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Network/RestController.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String status = '';
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
                                Auth().login = value;
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
                                  Auth().password = value;
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
                              Auth().register((status) {
                                this.status = status;
                                print('status = ${this.status}');
                                this.setState(() {});
                              },
                                  '{"login":"' +
                                      Auth().login +
                                      '", "password":"' +
                                      Auth().password +
                                      '"}');
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
