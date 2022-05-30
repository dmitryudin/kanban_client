import 'dart:convert';

import 'package:hive/hive.dart';

import '../Network/RestController.dart';

class Auth {
  static final Auth _auth = Auth._instance();

  factory Auth() {
    return _auth;
  }
  Auth._instance();

  int id = -1;
  String status = '';
  String login = '';
  String password = '';
  String accessToken = '';
  String refreshToken = '';
  bool isAuthFlag = false;
  late var box;
  late void Function({required bool isAuth}) callback;
  late void Function() reloadFunction;
  bool isAuth() {
    return isAuthFlag;
  }

  void save(void Function() callback) async {
    box = await Hive.openBox('Security');
    box.put('id', id);
    box.put('login', login);
    box.put('password', password);
    box.put('accessToken', accessToken);
    box.put('refreshToken', refreshToken);
    callback();
  }

  void init(
      {required Function callback,
      required void Function() reloadFunction}) async {
    box = await Hive.openBox('Security');
    this.reloadFunction = reloadFunction;
    try {
      id = box.get('id');
      login = box.get('login');
      password = box.get('password');

      if (login.isEmpty || password.isEmpty) {
        isAuthFlag = false;
        callback();
        return;
      } else
        isAuthFlag = true;

      callback();
      // accessToken = box.get('secToken');
      // refreshToken = box.get('refreshToken');
    } catch (e) {
      print('Exeption in Auth.init() $e');
      isAuthFlag = false;
      callback();
    }
    //Тут мы проверяем запрос есть ли авторизация
    //если авторизации нету, но есть логин и пароль, то стучимся к jwt
  }

  void register(Function(String status) onComplete, String data) {
    RestController().sendPostRequest(
        onComplete: ({required String data}) {
          Map<String, dynamic> jsonString = jsonDecode(data);
          print(data);
          if (jsonString['status'] == 'phone exist' ||
              jsonString['status'] == 'email exist') {
            onComplete('Логин существует!');
          } else {
            save(() {
              onComplete('Успех!');
            });
          }
        },
        onError: ({required String data}) {},
        controller: 'register',
        data: data);
  }

  void auth(Function(String status) onComplete, String data) {
    RestController().sendPostRequest(
        onComplete: ({required String data}) {
          Map<String, dynamic> jsonString = jsonDecode(data);
          accessToken = jsonString["access_token"];
          refreshToken = jsonString["refresh_token"];
          save(() {
            onComplete('Успех!');
          });
          isAuthFlag = true;
          reload();
        },
        onError: ({required String data}) {},
        controller: 'auth',
        data: data);
  }

  void reload() {
    reloadFunction();
  }

  void logOut(void Function() callback) async {
    print('Access token $accessToken');
    print('login $login');
    Box box = await Hive.openBox('Security');

    box.delete('id');
    box.delete('login');
    box.delete('password');
    box.delete('accessToken');
    box.delete('refreshToken');
    id = -1;
    status = '';
    login = '';
    password = '';
    accessToken = '';
    refreshToken = '';
    print('Access token $accessToken');
    print('login $login');
    isAuthFlag = false;
    //callback();
    reload();
  }

  void updateToken(void Function() callback) async {
    RestController().sendPostRequest(
        onComplete: ({required String data}) {
          Map<String, dynamic> jsonString = jsonDecode(data);
          accessToken = jsonString["access_token"];
          refreshToken = jsonString["refresh_token"];
          save(() {
            callback();
          });
        },
        onError: ({required String data}) {},
        controller: 'auth',
        data: '{"login":"' +
            Auth().login +
            '", "password":"' +
            Auth().password +
            '"}');

    reload();
  }
}
