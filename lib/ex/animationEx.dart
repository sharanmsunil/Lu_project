import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashPage(),
    );
  }
}

enum SplashHeroes { icon }

class SplashPage extends StatefulWidget {
  @override
  SplashPageState createState() {
    return new SplashPageState();
  }
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), _toNext);
  }

  _toNext() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, _, __) => LoginPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(
          opacity: animation,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Hero(
            tag: SplashHeroes.icon,
            createRectTween: (rect1, rect2) => RectTween(begin: rect1, end: rect2),
            child: Icon(
              Icons.airport_shuttle,
              size: 100.0,
              color: Colors.white,
            ),
          ),
          TextButton(
            child: Text("Next"),
            onPressed: _toNext,
          ),
        ],
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Hero(
            createRectTween: (rect1, rect2) => RectTween(begin: rect1, end: rect2),
            tag: SplashHeroes.icon,
            child: Icon(
              Icons.airport_shuttle,
              color: Colors.white,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Column(
          children: <Widget>[
            Text("Username"),
            TextField(),
            Text("Password"),
            TextField(),
          ],
        ),
      ),
    );
  }
}