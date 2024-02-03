import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:scrollable_clean_calendar/utils/extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'dooboolab flutter calendar',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Calendar Carousel Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _currentDate = DateFormat.yMMMd().format(DateTime.now());
  final String _today = DateFormat.yMMMd().format(DateTime.now());
  final String _today1 = DateFormat.MMMd().format(DateTime.now());
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();
  DateTime _checker = DateTime.now();
  late SharedPreferences preferences;
   int avgcyc = 28;
   int avgprd =5 ;
  String lastmensis ='2024-02-01 00:00:00.000';
  static DateTime? cycleStartDate;
  static DateTime? periodadder;
  static DateTime? ovulationadder;
  static DateTime? cycleendDate;
  static DateTime? mainovule;

  //List<DateTime> _markedDate = [DateTime(2024, 2, 20), DateTime(2024, 2, 11)];
  static Widget _periodIcon(String day) => Container(
    decoration:  BoxDecoration(
        color: Color(0xFFEA779C),
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        //border: Border.all(color: Colors.blue, width: 2.0)
      ),
    child:  Center(
      child: Text(
        day,style: TextStyle(color: Colors.white),
      ),
    )
  );
  static Widget _ovulationIcon(String day) => Container(
    decoration:  BoxDecoration(
        color: Color(0xffbc84e9),
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        //border: Border.all(color: Colors.blue, width: 2.0)
      ),
    child:  Center(
      child: Text(
        day,style: TextStyle(color: Colors.white),
      ),
    )
  );
  static Widget _mainovulationIcon(String day) => Container(
    decoration:  BoxDecoration(
        color: Color(0xffbc84e9),
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Color(0xff590f9b), width: 2.0)
      ),
    child:  Center(
      child: Text(
        day,style: TextStyle(color: Colors.white),
      ),
    )
  );

  EventList<Event> _markedDateMap = new EventList<Event>(events: {},);


  @override
  void initState() {
    fetchData();
    addPeriod();
    addOvulation();
    addmainOvulation();
    super.initState();
  }

  void fetchData() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      cycleStartDate = DateTime.parse(lastmensis);
      cycleendDate = cycleStartDate?.add(Duration(days: avgcyc - 1));
    });
  }

  void addPeriod(){
    PeriodDates.add(DateTime(cycleStartDate!.year,cycleStartDate!.month,cycleStartDate!.day));
    periodadder = cycleStartDate;
     for(int i=1;i<avgprd;i++){
      periodadder = periodadder?.add(Duration(days: 1));
      PeriodDates.add(DateTime(periodadder!.year,periodadder!.month,periodadder!.day));
    }
  }

  void addOvulation(){
    ovulationadder = cycleendDate?.subtract(Duration(days: 12));
     for(int i=1;i<7;i++){
       OvulationDates.add(DateTime(ovulationadder!.year,ovulationadder!.month,ovulationadder!.day));
       ovulationadder = ovulationadder?.subtract(Duration(days: 1));
    }
  }

  void addmainOvulation(){
    mainovule = cycleendDate?.subtract(Duration(days: 14));
    mainOvulationDates.add(DateTime(mainovule!.year,mainovule!.month,mainovule!.day));
    for(int i=0;i<OvulationDates.length;i++){
      if(OvulationDates[i]==mainOvulationDates[0]){
        OvulationDates.remove(DateTime(mainovule!.year,mainovule!.month,mainovule!.day));
      }
    }
  }

  List<DateTime> PeriodDates =[];
  List<DateTime> mainOvulationDates =[];
  List<DateTime> OvulationDates =[];


  // List<DateTime> PeriodDates =[
  //   DateTime(2024,02,1),
  //   DateTime(2024,02,2),
  //   DateTime(2024,02,3),
  //   DateTime(2024,02,4),
  //   DateTime(2024,02,5),
  // ];

  // List<DateTime> OvulationDates =[
  //   DateTime(2024,02,21),
  //   DateTime(2024,02,22),
  //   DateTime(2024,02,23),
  //   DateTime(2024,02,24),
  //   DateTime(2024,02,25),
  //   DateTime(2024,02,26),
  //   DateTime(2024,02,27),
  //   DateTime(2024,02,14),
  // ];


  @override
  Widget build(BuildContext context) {
    //cHeight = MediaQuery.of(context).size.height;
    for(int i=0;i<PeriodDates.length;i++){
      _markedDateMap.add(PeriodDates[i], new Event(date: PeriodDates[i],title: 'Event 5',icon: _periodIcon(PeriodDates[i].day.toString(),)));
    }
    for(int i=0;i<OvulationDates.length;i++){
      _markedDateMap.add(OvulationDates[i], new Event(date: OvulationDates[i],title: 'Event 5',icon: _ovulationIcon(OvulationDates[i].day.toString(),)));
    }
    for(int i=0;i<mainOvulationDates.length;i++){
      _markedDateMap.add(mainOvulationDates[i], new Event(date: mainOvulationDates[i],title: 'Event 5',icon: _mainovulationIcon(mainOvulationDates[i].day.toString(),)));
    }
    /// Example Calendar Carousel without header and custom prev & next button
    final _calendarCarouselNoHeader = CalendarCarousel<Event>(
      viewportFraction: .7,
      selectedDayButtonColor: Colors.grey.shade300,
      weekdayTextStyle: TextStyle(color: Colors.grey),
      weekendTextStyle: TextStyle(
        color: Colors.black,
      ),
      dayPadding: 1,
      isScrollable: true,
      scrollDirection: Axis.vertical,
      //todayBorderColor: Colors.green,
      onDayPressed: (date, events) {
        this.setState(() {
          _currentDate2 = date;
          _currentDate = DateFormat.yMMMd().format(date);
        });
        events.forEach((event) => print(event.title));
      },
      //daysHaveCircularBorder: true,
      showOnlyCurrentMonthDate: true,

      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
//      firstDayOfWeek: 4,
      markedDatesMap: _markedDateMap,


      height: 500,
      selectedDateTime: _currentDate2,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: ScrollPhysics(),
      // markedDateCustomShapeBorder:
      //     CircleBorder(side: BorderSide(color: Colors.purple)),
      // markedDateCustomTextStyle: TextStyle(
      //   fontSize: 15,
      //   color: Colors.purple,
      // ),
      showHeader: false,
      todayTextStyle: TextStyle(
        color: Colors.pink,
      ),
      markedDateShowIcon: true,
      markedDateIconMaxShown: 1,
      markedDateIconBuilder: (event) {
        return event.icon;
      },
       markedDateMoreShowTotal: null,
      todayButtonColor: Colors.grey.shade300,
      // selectedDayTextStyle: TextStyle(
      //   color: Colors.yellow,
      // ),
     // minSelectedDate: DateTime(2023, 10),
      minSelectedDate: DateTime(2023, 10),
      maxSelectedDate: DateTime(2024, 12, 31),
      prevDaysTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
      // inactiveDaysTextStyle: TextStyle(
      //   color: Colors.tealAccent,
      //   fontSize: 16,
      // ),
      onCalendarChanged: (DateTime date) {
        this.setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
        });
      },
      onDayLongPressed: (DateTime date) {
        print('long pressed date $date');
      },
    );

    return Scaffold(
        appBar:  AppBar(
          title:  Text(widget.title),
        ),
        drawer: Drawer(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  top: 30.0,
                  bottom: 16.0,
                  left: 16.0,
                  right: 16.0,
                ),
                child: Column(
                  children: [
                    Text(
                      (_currentDate == _today)
                          ? 'Today, $_today1'
                          : '$_currentDate',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      _currentMonth,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        TextButton(
                          child: Text(
                            'PREV',
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            setState(() {
                              _targetDateTime = DateTime(_targetDateTime.year,
                                  _targetDateTime.month - 1);
                              _currentMonth =
                                  DateFormat.yMMM().format(_targetDateTime);
                            });
                          },
                        ),
                        Spacer(),
                        TextButton(
                          child: Text(
                            'NEXT',
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            setState(() {
                              _targetDateTime = DateTime(_targetDateTime.year,
                                  _targetDateTime.month + 1);
                              _currentMonth =
                                  DateFormat.yMMM().format(_targetDateTime);
                              print(lastmensis);
                              print(cycleStartDate);
                              print(cycleendDate.toString());
                            });
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: _calendarCarouselNoHeader,
              ),
              //
            ],
          ),
        ));
  }
}
