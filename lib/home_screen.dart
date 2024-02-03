import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luna_loom/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;

class Home_Screen extends StatefulWidget {
  Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
   late int avgcyc;
   late int avgprd;
  String? lastmensis;
  static DateTime? cycleStartDate;
  static DateTime? cycleendDate;
  static DateTime? periodadder;
  static DateTime? ovulationadder;
  static DateTime? mainovule;
  late SharedPreferences preferences;

  String _currentDate = DateFormat.yMMMd().format(DateTime.now());
  final String _today = DateFormat.yMMMd().format(DateTime.now());
  final String _today1 = DateFormat.MMMd().format(DateTime.now());
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = DateFormat.MMMM().format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();

  static Widget _periodIcon(String day) => Container(
      decoration: BoxDecoration(
        color: Color(0xFFEA779C),
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        //border: Border.all(color: Colors.blue, width: 2.0)
      ),
      child: Center(
        child: Text(
          day,
          style: TextStyle(color: Colors.white),
        ),
      ));

  static Widget _ovulationIcon(String day) => Container(
      decoration: BoxDecoration(
        color: Color(0xffbc84e9),
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        //border: Border.all(color: Colors.blue, width: 2.0)
      ),
      child: Center(
        child: Text(
          day,
          style: TextStyle(color: Colors.white),
        ),
      ));

  static Widget _mainovulationIcon(String day) => Container(
      decoration:  BoxDecoration(
          color: Color(0xffbc84e9),
          borderRadius: BorderRadius.all(Radius.circular(1000)),
          border: Border.all(color: Color(0xffea779c), width: 4.0)
      ),
      child:  Center(
        child: Text(
          day,style: TextStyle(color: Colors.white),
        ),
      )
  );

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {},
  );

  List<DateTime> PeriodDates =[];
  List<DateTime> mainOvulationDates =[];
  List<DateTime> OvulationDates =[];


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
      avgcyc = preferences.getInt("AvgCycle")!;
      avgprd = preferences.getInt("AvgPeriod")!;
      lastmensis = preferences.getString("LastMensis")!;
      cycleStartDate = DateTime.parse(lastmensis!);
      cycleendDate = cycleStartDate?.add(Duration(days: avgcyc - 1));
    });
  }

  void addPeriod()async{
    preferences =await SharedPreferences.getInstance();
    setState(() {
      avgprd = preferences.getInt("AvgPeriod")!;
      PeriodDates.add(DateTime(cycleStartDate!.year,cycleStartDate!.month,cycleStartDate!.day));
      periodadder = cycleStartDate;
      for(int i=1;i<avgprd;i++){
        periodadder = periodadder?.add(Duration(days: 1));
        PeriodDates.add(DateTime(periodadder!.year,periodadder!.month,periodadder!.day));
      }
    });

  }

  void addOvulation(){
    ovulationadder = cycleendDate?.subtract(Duration(days: 12));
    for(int i=1;i<8;i++){
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

  @override
  Widget build(BuildContext context) {


    for (int i = 0; i < PeriodDates.length; i++) {
      _markedDateMap.add(
          PeriodDates[i],
          new Event(
              date: PeriodDates[i],
              title: 'Event 5',
              icon: _periodIcon(
                PeriodDates[i].day.toString(),
              )));
    }
    for (int i = 0; i < OvulationDates.length; i++) {
      _markedDateMap.add(
          OvulationDates[i],
          new Event(
              date: OvulationDates[i],
              title: 'Event 5',
              icon: _ovulationIcon(
                OvulationDates[i].day.toString(),
              )));
    }
    for(int i=0;i<mainOvulationDates.length;i++){
      _markedDateMap.add(mainOvulationDates[i], new Event(date: mainOvulationDates[i],title: 'Event 5',icon: _mainovulationIcon(mainOvulationDates[i].day.toString(),)));
    }

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
        color: Color(0xff812ac7),
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
          _currentMonth = DateFormat.MMMM().format(_targetDateTime);
        });
      },
      onDayLongPressed: (DateTime date) {
        print('long pressed date $date');
      },
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffbc84e9),
        centerTitle: true,
        title:  Text(
            (_currentDate == _today)
                ? 'Today, $_today1'
                : '$_currentDate',
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Lu_Settings()));
            },
          )
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
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
                      SizedBox(height: 80,),
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
                                    DateFormat.MMMM().format(_targetDateTime);
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
                                    DateFormat.MMMM().format(_targetDateTime);
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
          ),
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(color: Color(0xffbc84e9),
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(50, 40.0)),),
            child:  Column(
              children: [
                Center(
                  child: Text(
                    _currentMonth,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
              left: 150,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white,elevation: 3),
                  onPressed: (){
                    setState(() {
                      _targetDateTime=DateTime.now();
                    });
                  }, child: Row(
                children: [
                  Icon(Icons.keyboard_return,color: Color(0xffbc84e9),),
                  SizedBox(width: 5,),
                  Text('Today',style: TextStyle(color: Color(0xffbc84e9)),)
                ],
              )))
        ],
      ),
    );
  }
}
