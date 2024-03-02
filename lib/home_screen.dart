import 'package:flutter/material.dart';
import 'package:luna_loom/settings.dart';
import 'package:luna_loom/utils/lu_colors.dart';
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
   int avgcyc = 28;
   int avgprd = 8;
   int? cycleday=0;
  String? lastmensis;
  static DateTime? cycleStartDate;
  static DateTime? cycleendDate;
  static DateTime? periodadder;
  static DateTime? PCycleAdder;
  static DateTime? ovulationadder;
  static DateTime? mainovule;
  static DateTime? highovule;
  static DateTime? NxtcycleStartDate;
  static DateTime? NxtcycleendDate;
  late SharedPreferences preferences;
  var bgcolor = LuColors.bgColor;
  var rangeicon = Icon(Icons.signal_cellular_alt_1_bar_outlined,color: LuColors.textWhiteColor,);
  String rangetxt ='Low';
  String daystoperiod ='Period';

  String _currentDate = DateFormat.yMMMd().format(DateTime.now());
  final String _today = DateFormat.yMMMd().format(DateTime.now());
  final String _today1 = DateFormat.MMMd().format(DateTime.now());
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = DateFormat.MMMM().format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();

  static Widget _periodIcon(String day) => Container(
      decoration: BoxDecoration(
        color: LuColors.periodColor,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
      ),
      child: Center(
        child: Text(
          day,
          style: TextStyle(color: LuColors.textWhiteColor),
        ),
      ));

  static Widget _ovulationIcon(String day) => Container(
      decoration: BoxDecoration(
        color: LuColors.ovulationColor,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
      ),
      child: Center(
        child: Text(
          day,
          style: TextStyle(color: LuColors.textWhiteColor),
        ),
      ));

  static Widget _mainovulationIcon(String day) => Container(
      decoration: BoxDecoration(
          color: LuColors.ovulationColor,
          borderRadius: BorderRadius.all(Radius.circular(1000)),
          border: Border.all(color: LuColors.periodColor, width: 4.0)),
      child: Center(
        child: Text(
          day,
          style: TextStyle(color: LuColors.textWhiteColor),
        ),
      ));

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {},
  );

  List<DateTime> PeriodDates = [];
  List<DateTime> mainOvulationDates = [];
  List<DateTime> highOvulationDates = [];
  List<DateTime> OvulationDates = [];
  List<DateTime> PCycle = [];

  @override
  void initState() {
    fetchData();
    addCycleloop();
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
      PeriodDates.add(DateTime(
          cycleStartDate!.year, cycleStartDate!.month, cycleStartDate!.day));
      periodadder = cycleStartDate;
      for (int i = 1; i < avgprd; i++) {
        periodadder = periodadder?.add(Duration(days: 1));
        PeriodDates.add(
            DateTime(periodadder!.year, periodadder!.month, periodadder!.day));
      }
      ovulationadder = cycleendDate?.subtract(Duration(days: 12));
      for (int i = 1; i < 8; i++) {
        OvulationDates.add(DateTime(
            ovulationadder!.year, ovulationadder!.month, ovulationadder!.day));
        ovulationadder = ovulationadder?.subtract(Duration(days: 1));
      }
      mainovule = cycleendDate?.subtract(Duration(days: 14));
      mainOvulationDates.add(DateTime(mainovule!.year, mainovule!.month, mainovule!.day));
      for (int i = 0; i < OvulationDates.length; i++) {
        if (OvulationDates[i] == mainOvulationDates[0]) {
          OvulationDates.remove(
              DateTime(mainovule!.year, mainovule!.month, mainovule!.day));
        }
      }
      highovule = cycleendDate?.subtract(Duration(days: 13));
      for(int i=1;i<=2;i++) {
        highOvulationDates.add(DateTime(highovule!.year, highovule!.month, highovule!.day));
        highovule=cycleendDate?.subtract(Duration(days: 15));
      }
      for (int i = 0; i < OvulationDates.length; i++) {
        for(int j=0;j<highOvulationDates.length;j++){
          if (OvulationDates[i] == highOvulationDates[j]) {
            highovule=highOvulationDates[j];
            OvulationDates.remove(DateTime(highovule!.year, highovule!.month, highovule!.day));
          }
        }
      }
      PCycleAdder = cycleStartDate;
      for(int i = 0;i< avgcyc;i++){
        PCycle.add(DateTime(PCycleAdder!.year,PCycleAdder!.month,PCycleAdder!.day,));
        PCycleAdder = PCycleAdder?.add(Duration(days: 1));
      }
    });
  }

  void addCycleloop() async{
    preferences = await SharedPreferences.getInstance();
    setState(() {
      avgcyc = preferences.getInt("AvgCycle")!;
      avgprd = preferences.getInt("AvgPeriod")!;
      lastmensis = preferences.getString("LastMensis")!;
      cycleStartDate = DateTime.parse(lastmensis!);
      cycleendDate = cycleStartDate?.add(Duration(days: avgcyc - 1));
      NxtcycleStartDate = cycleStartDate?.add(Duration(days: avgcyc));
      NxtcycleendDate = NxtcycleStartDate?.add(Duration(days: avgcyc - 1));
      for(int i=1;i<12;i++) {
        PeriodDates.add(DateTime(
            NxtcycleStartDate!.year, NxtcycleStartDate!.month, NxtcycleStartDate!.day));
        periodadder = NxtcycleStartDate;
        for (int i = 1; i < avgprd; i++) {
          periodadder = periodadder?.add(Duration(days: 1));
          PeriodDates.add(
              DateTime(periodadder!.year, periodadder!.month, periodadder!.day));
        }
        ovulationadder = NxtcycleendDate?.subtract(Duration(days: 12));
        for (int i = 1; i < 8; i++) {
          OvulationDates.add(DateTime(
              ovulationadder!.year, ovulationadder!.month, ovulationadder!.day));
          ovulationadder = ovulationadder?.subtract(Duration(days: 1));
        }
        mainovule = NxtcycleendDate?.subtract(Duration(days: 14));
        mainOvulationDates.add(DateTime(mainovule!.year, mainovule!.month, mainovule!.day));
        for (int i = 0; i < OvulationDates.length; i++) {
          for(int j=0;j<mainOvulationDates.length;j++){
            if (OvulationDates[i] == mainOvulationDates[j]) {
              OvulationDates.remove(
                  DateTime(mainovule!.year, mainovule!.month, mainovule!.day));
            }
          }
        }
        highovule = NxtcycleendDate?.subtract(Duration(days: 13));
        for(int i=1;i<=2;i++) {
          highOvulationDates.add(DateTime(highovule!.year, highovule!.month, highovule!.day));
          highovule=NxtcycleendDate?.subtract(Duration(days: 15));
        }
        for (int i = 0; i < OvulationDates.length; i++) {
          for(int j=0;j<highOvulationDates.length;j++){
            if (OvulationDates[i] == highOvulationDates[j]) {
              highovule=highOvulationDates[j];
              OvulationDates.remove(DateTime(highovule!.year, highovule!.month, highovule!.day));
            }
          }
        }
        PCycleAdder = NxtcycleStartDate;
        for(int i = 0;i< avgcyc;i++){
          PCycle.add(DateTime(PCycleAdder!.year,PCycleAdder!.month,PCycleAdder!.day,));
          PCycleAdder = PCycleAdder?.add(Duration(days: 1));
        }
        NxtcycleStartDate = NxtcycleStartDate?.add(Duration(days: avgcyc));
        NxtcycleendDate = NxtcycleStartDate?.add(Duration(days: avgcyc - 1));
      }});
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
    for (int i = 0; i < mainOvulationDates.length; i++) {
      _markedDateMap.add(
          mainOvulationDates[i],
          new Event(
              date: mainOvulationDates[i],
              title: 'Event 5',
              icon: _mainovulationIcon(
                mainOvulationDates[i].day.toString(),
              )));
    }
    for (int i = 0; i < highOvulationDates.length; i++) {
      _markedDateMap.add(
          highOvulationDates[i],
          new Event(
              date: highOvulationDates[i],
              title: 'Event 5',
              icon: _ovulationIcon(
                highOvulationDates[i].day.toString(),
              )));
    }

    final _calendarCarouselNoHeader = CalendarCarousel<Event>(
      firstDayOfWeek: DateTime.monday,
      viewportFraction: .7,
      selectedDayButtonColor: LuColors.textGreyColor,
      weekdayTextStyle: TextStyle(color: Colors.grey),
      weekendTextStyle: TextStyle(
        color: Colors.black,
      ),
      dayPadding: 1,
      isScrollable: true,
      scrollDirection: Axis.vertical,
      onDayPressed: (date, events) {
        setState(() {
          _currentDate2 = date;
          _currentDate = DateFormat.yMMMd().format(date);
          for (int i = 0; i < PCycle.length; i++) {
            if (date == PCycle[i]) {
              if(i<avgcyc){
              cycleday = i + 1;
            }else if(avgcyc<=i && i<avgcyc*2){
                int j=i-avgcyc;
                cycleday=j+1;
              }else if(avgcyc*2<=i && i<avgcyc*3) {
                int j = i - (avgcyc*2);
                cycleday = j + 1;
              }else if(avgcyc*3<=i && i<avgcyc*4) {
                int j = i - (avgcyc*3);
                cycleday = j + 1;
              }else if(avgcyc*4<=i && i<avgcyc*5) {
                int j = i - (avgcyc*4);
                cycleday = j + 1;
              }else if(avgcyc*5<=i && i<avgcyc*6) {
                int j = i - (avgcyc*5);
                cycleday = j + 1;
              }else if(avgcyc*6<=i && i<avgcyc*7) {
                int j = i - (avgcyc*6);
                cycleday = j + 1;
              }else if(avgcyc*7<=i && i<avgcyc*8) {
                int j = i - (avgcyc*7);
                cycleday = j + 1;
              }else if(avgcyc*8<=i && i<avgcyc*9) {
                int j = i - (avgcyc*8);
                cycleday = j + 1;
              }else if(avgcyc*9<=i && i<avgcyc*10) {
                int j = i - (avgcyc*9);
                cycleday = j + 1;
              }else if(avgcyc*10<=i && i<avgcyc*11) {
                int j = i - (avgcyc*10);
                cycleday = j + 1;
              }else if(avgcyc*11<=i && i<avgcyc*12) {
                int j = i - (avgcyc*11);
                cycleday = j + 1;
              }
            }
          }
          for (int i = 0; i < PeriodDates.length; i++) {
            for (int j = 0; j < OvulationDates.length; j++) {
              if (date != mainOvulationDates[0]) {
                if (date != PeriodDates[i]) {
                  if (date != OvulationDates[j]) {
                    bgcolor = Colors.grey;
                    daystoperiod ='Prediction';
                    rangeicon = Icon(Icons.signal_cellular_alt_1_bar,
                               color: LuColors.textWhiteColor,);
                           rangetxt='Low';
                  }
                }
              }
            }
          }
          for (int i = 0; i < PeriodDates.length; i++) {
            if (date == PeriodDates[i]) {
              bgcolor = LuColors.periodColor;
              daystoperiod ='Period';
              rangeicon = Icon(Icons.signal_cellular_alt_1_bar,
                color: LuColors.textWhiteColor,);
              rangetxt='Low';
            }
          }
          for (int i = 0; i < OvulationDates.length; i++) {
            if (date == OvulationDates[i]) {
              bgcolor = LuColors.ovulationColor;
              daystoperiod ='Ovulation';
              rangeicon = Icon(Icons.signal_cellular_alt_2_bar,
                        color: LuColors.textWhiteColor,);
                       rangetxt='Medium';
            }
          }
          for (int i = 0; i < highOvulationDates.length; i++) {
            if (date == highOvulationDates[i]) {
              bgcolor = LuColors.ovulationColor;
              daystoperiod ='Ovulation';
              rangeicon = Icon(Icons.signal_cellular_alt, color: LuColors.textWhiteColor,);
              rangetxt='High';
            }
          }
          for (int i = 0; i < mainOvulationDates.length; i++) {
            if (date == mainOvulationDates[i]) {
              bgcolor = LuColors.ovulationColor;
              daystoperiod ='Ovulation';
              rangeicon = Icon(Icons.signal_cellular_alt, color: LuColors.textWhiteColor,);
              rangetxt='High';
            }
          }
        });
        events.forEach((event) => print(event.title));
      },
      showOnlyCurrentMonthDate: true,

      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
      markedDatesMap: _markedDateMap,

      height: 500,
      selectedDateTime: _currentDate2,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: ScrollPhysics(),
      showHeader: false,
      todayTextStyle: TextStyle(
        color: LuColors.textPurpleColor,
      ),
      markedDateShowIcon: true,
      markedDateIconMaxShown: 1,
      markedDateIconBuilder: (event) {
        return event.icon;
      },
      markedDateMoreShowTotal: null,
      todayButtonColor: LuColors.textGreyColor,
      minSelectedDate: DateTime(2023, 10),
      maxSelectedDate: DateTime(2024, 12, 31),
      prevDaysTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
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
        automaticallyImplyLeading: false,
        backgroundColor: bgcolor,
        centerTitle: true,
        title: Text(
          (_currentDate == _today) ? 'Today, $_today1' : '$_currentDate',
          style: TextStyle(color: LuColors.textWhiteColor, fontSize: 25),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.menu,
              color: LuColors.textWhiteColor,
            ),
            onPressed: () {
              Navigator.of(context)
                  .pushAndRemoveUntil(PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => Lu_Settings(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.ease;

                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  }),(route)=>false);
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
                      SizedBox(
                        height: 80,
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
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: bgcolor,
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.elliptical(50, 40.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 60,
                        width: 85,
                        child: Center(
                          child: Text(
                            daystoperiod,
                            style: TextStyle(color: LuColors.textWhiteColor),
                          ),
                        ),
                      ),
                      VerticalDivider(
                        color: Colors.grey.shade400,
                        thickness: 2,
                        width: 20,
                      ),
                      Container(
                        height: 60,
                        width: 85,
                        child: Center(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  rangeicon,
                                  SizedBox(width: 5,),
                                  Text(
                                    rangetxt,
                                    style: TextStyle(color: LuColors.textWhiteColor),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Text(
                                'chances of',
                                style: TextStyle(color: LuColors.textWhiteColor, fontSize: 10),
                              ),
                              Text(
                                'getting pregnant',
                                style: TextStyle(color: LuColors.textWhiteColor, fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      ),
                      VerticalDivider(
                        color: Colors.grey.shade400,
                        thickness: 2,
                        width: 20,
                      ),
                     Container(
                       height: 60,
                       width: 85,
                       child: Center(
                         child: Column(
                           children: [
                             Text(
                               '$cycleday',
                               style: TextStyle(color: LuColors.textWhiteColor),
                             ),
                             SizedBox(height: 5,),
                             Text(
                               'day of cycle',
                               style: TextStyle(color: LuColors.textWhiteColor),
                             ),
                           ],
                         ),
                       ),
                     ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Text(
                    _currentMonth,
                    style: TextStyle(
                      color: LuColors.textWhiteColor,
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
                  style: ElevatedButton.styleFrom(
                      backgroundColor: LuColors.textWhiteColor, elevation: 3),
                  onPressed: () {
                    setState(() {
                      _targetDateTime = DateTime.now();
                    });
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.keyboard_return,
                        color: LuColors.textlightPurpleColor,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Today',
                        style: TextStyle(color: LuColors.textlightPurpleColor),
                      )
                    ],
                  )))
        ],
      ),
    );
  }
}
