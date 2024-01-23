import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Elevated Button Demo'),
        ),
        body: Center(
          child: MyButton(),
        ),
      ),
    );
  }
}

class MyButton extends StatefulWidget {
  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  var avgcyc = 28;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              margin: EdgeInsets.only(top: 50),
              child: Text(
                'Duration of cycle',
                style:
                    GoogleFonts.kameron(color: Colors.grey[600], fontSize: 15),
              )),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 1, minimumSize: Size(300, 40)),
                onPressed: () {
                  // When the button is pressed, show a new container
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Container(
                              height: 200,
                              child:
                                  StatefulBuilder(builder: (context, setState) {
                                return Column(
                                  children: <Widget>[
                                    Text(
                                      'Duration of cycle',
                                      style:
                                      GoogleFonts.kameron(color: Colors.grey[600], fontSize: 15),
                                    ),
                                    Text(
                                      'Choose the number of days',
                                      style:
                                      GoogleFonts.kameron(color: Colors.grey[600], fontSize: 15),
                                    ),
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 15),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          alignment: Alignment.center,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[100],
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                color: Colors.grey.shade200),
                                          ),
                                        ),
                                        NumberPicker(
                                            minValue: 20,
                                            maxValue: 50,
                                            value: avgcyc,
                                            itemHeight: 30,
                                            itemWidth: 30,
                                            itemCount: 5,
                                            axis: Axis.vertical,
                                            selectedTextStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25,
                                            ),
                                            textStyle: TextStyle(
                                                color: Colors.grey[400],
                                                fontSize: 15),
                                            onChanged: (value) => setState(
                                                  () => avgcyc = value,
                                                )),
                                      ],
                                    ),
                                  ],
                                );
                              }),
                            )),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Center(
                                child: Text(
                              'Select',
                              style: GoogleFonts.kameron(
                                  fontSize: 15, color: Color(0xff812ac7)),
                            )),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text(
                  "${avgcyc} days",
                  style: GoogleFonts.kameron(
                      fontSize: 15, color: Color(0xffbc84e9)),
                )),
          ),
          SizedBox(height: 20,),
          Text('$avgcyc'),

        ],
      ),
    );
  }
}
