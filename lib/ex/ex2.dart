import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ValueNotifier<ThemeMode> _notifier = ValueNotifier(ThemeMode.light);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: _notifier,
      builder: (_, mode, __) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: mode,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Toggle Tick Icon'),
        ),
        body: MyWidget(notifier: _notifier, mode: mode,),
      ),
    );
  },
  );
  }
}

class MyWidget extends StatefulWidget {
  ValueNotifier notifier;
  ThemeMode mode;
  MyWidget({required this.notifier,required this.mode});
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  bool isTickVisible = false;
  @override
  Widget build(BuildContext context) {
    Brightness platformBrightness = MediaQuery.of(context).platformBrightness;
    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              // Toggle the visibility of the tick icon
              setState(() {
                isTickVisible = !isTickVisible;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                ),
                if (isTickVisible)
                  Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 60,
                  ),
              ],
            ),
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(onTap: () => widget.notifier.value = widget.mode == ThemeMode.light ? ThemeMode.light : ThemeMode.light, child: Container(height: 100,width: 100,color: Colors.white,)),
              SizedBox(width: 20,),
              InkWell(onTap: () => widget.notifier.value = widget.mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.dark, child: Container(height: 100,width: 100,color: Colors.black,)),
              SizedBox(width: 20,),
              InkWell(onTap: () =>  widget.notifier.value = widget.mode == ThemeMode.system , child: Container(height: 100,width: 100,color: Colors.red,)),
            ],
          ),
          SizedBox(height: 30,),
          Text('Hello',style: TextStyle(color: Colors.yellow,fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}
