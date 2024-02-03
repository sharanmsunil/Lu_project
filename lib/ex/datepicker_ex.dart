import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/date_picker_theme.dart';
import 'package:flutter_holo_date_picker/widget/date_picker_widget.dart';
import 'package:luna_loom/ex/exhome.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){
  runApp(MaterialApp(debugShowCheckedModeBanner: false,home: DatePick_Ex(),));
}
class DatePick_Ex extends StatefulWidget {
  const DatePick_Ex({super.key});

  @override
  State<DatePick_Ex> createState() => _DatePick_ExState();
}

class _DatePick_ExState extends State<DatePick_Ex> {
  late DateTime selectedDate;
  var dob;
  var formate1;
  late SharedPreferences preferences;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffbc84e9),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: DatePickerWidget(
                looping: false,
                firstDate: DateTime(2020,01,01),
                lastDate: DateTime.now(),
                initialDate: DateTime(2024,01,01),
                dateFormat: "dd-MMMM-yyyy",
                locale: DatePicker.localeFromString('en'),
                onChange: (DateTime newDate,_) {
                  setState(() {
                    selectedDate = newDate;
                    dob = newDate;
                     formate1 = "${dob.year}-${dob.month}-${dob.day}";
                  });
                } ,
                pickerTheme: DateTimePickerTheme(
                  backgroundColor: Color(0xffbc84e9),
                  itemTextStyle: TextStyle(color: Colors.white,fontSize: 19),
                  dividerColor: Color(0xff812ac7),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Text('$formate1',style: TextStyle(color: Colors.white),),
            SizedBox(height: 20,),
            Text('$dob',style: TextStyle(color: Colors.white),),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: ()async{
              preferences = await SharedPreferences.getInstance();
              preferences.setString("LastMensis1", formate1);
              preferences.setString("LastMensis2", dob.toString());
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Home_Ex()));
            }, child: Text('Continue'))
          ],
        ),
      ),
    );
  }
}
