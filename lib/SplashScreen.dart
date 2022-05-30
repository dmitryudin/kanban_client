import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      CachedNetworkImage(
          imageUrl:
              'https://www.culturaagil.com.br/wp-content/uploads/2014/12/kanban-do-inicio-ao-fim.jpg')
    ]);
  }
}
