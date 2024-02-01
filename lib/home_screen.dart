import 'package:flutter/material.dart';
import 'package:luna_loom/settings.dart';
import 'package:scrollable_clean_calendar/controllers/clean_calendar_controller.dart';
import 'package:scrollable_clean_calendar/scrollable_clean_calendar.dart';
import 'package:scrollable_clean_calendar/utils/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home_Screen extends StatefulWidget {

  Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
 // DateTime selectedDate;
  final calendarController = CleanCalendarController(
    minDate: DateTime(2023,10),
    maxDate: DateTime(2024,12,31),
    //onRangeSelected: (firstDate, secondDate) {},
    onRangeSelected: (firstDate, secondDate) {},
    onDayTapped: (date) {},
    //readOnly: true,
    onPreviousMinDateTapped: (date) {},
    onAfterMaxDateTapped: (date) {},
    weekdayStart: DateTime.sunday,
    initialFocusDate: DateTime.now(),
    initialDateSelected: DateTime(2024,3,15),
    endDateSelected: DateTime(2024,3,20)
  );
  late int avgcyc;
  late int avgprd;
  late SharedPreferences preferences;
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData()async{
    preferences = await SharedPreferences.getInstance();
    setState(() {
      avgcyc = preferences.getInt("AvgCycle")!;
      avgprd = preferences.getInt("AvgPeriod")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          actions: [
            IconButton(icon: Icon(Icons.menu,color: Colors.white,),onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Lu_Settings()));
            },)
          ],
        ),
        body:  Stack(
              children: [
                ScrollableCleanCalendar(
                  calendarController: calendarController,
                  layout: Layout.BEAUTY,
                  calendarCrossAxisSpacing: 15,
                ),


                // Container(
                //   height: 200,
                //   width: double.infinity,
                //   decoration: BoxDecoration(color: Color(0xff812ac7),
                //     borderRadius: BorderRadius.vertical(
                //         bottom: Radius.elliptical(50, 50.0)),),
                // )
              ],
            ),
      );
  }
}
