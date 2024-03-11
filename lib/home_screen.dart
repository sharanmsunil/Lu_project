import 'package:flutter/material.dart';
import 'package:luna_loom/settings.dart';
import 'package:luna_loom/utils/dimensions.dart';
import 'package:luna_loom/utils/lu_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   int avgCyc = 28;
   int avgPrd = 8;
   int? cycleDay=0;
  String? lastMenses;
  static DateTime? cycleStartDate;
  static DateTime? cycleEndDate;
  static DateTime? periodAdder;
  static DateTime? pCycleAdder;
  static DateTime? ovulationAdder;
  static DateTime? mainOvule;
  static DateTime? highOvule;
  static DateTime? nxtCycleStartDate;
  static DateTime? nxtCycleEndDate;
  late SharedPreferences preferences;
  var bgColor = LuColors.bgColor;
  var rangeIcon =  Icon(Icons.signal_cellular_alt_1_bar_outlined,color: LuColors.textWhiteColor,size: Dimensions.iconSize20,);
  String rangeTxt ='Low';
  String daysToPeriod ='Period';

  String _currentDate = DateFormat.yMMMd().format(DateTime.now());
  final String _today = DateFormat.yMMMd().format(DateTime.now());
  final String _today1 = DateFormat.MMMd().format(DateTime.now());
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = DateFormat.MMMM().format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();

  static Widget _periodIcon(String day) => Container(
      decoration:  BoxDecoration(
        color: LuColors.periodColor,
        borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius50)),
      ),
      child: Center(
        child: Text(
          day,
          style:  TextStyle(color: LuColors.textWhiteColor,fontSize: Dimensions.font15),
        ),
      ));

  static Widget _ovulationIcon(String day) => Container(
      decoration:  BoxDecoration(
        color: LuColors.ovulationColor,
        borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius50)),
      ),
      child: Center(
        child: Text(
          day,
          style:  TextStyle(color: LuColors.textWhiteColor,fontSize: Dimensions.font15),
        ),
      ));

  static Widget _mainOvulationIcon(String day) => Container(
      decoration: BoxDecoration(
          color: LuColors.ovulationColor,
          borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius50)),
          border: Border.all(color: LuColors.periodColor, width: Dimensions.width5)),
      child: Center(
        child: Text(
          day,
          style:  TextStyle(color: LuColors.textWhiteColor,fontSize: Dimensions.font15),
        ),
      ));

  final EventList<Event> _markedDateMap = EventList<Event>(
    events: {},
  );

  List<DateTime> periodDates = [];
  List<DateTime> mainOvulationDates = [];
  List<DateTime> highOvulationDates = [];
  List<DateTime> ovulationDates = [];
  List<DateTime> pCycle = [];

  @override
  void initState() {
    fetchData();
    addCycleLoop();
    super.initState();
  }

  void fetchData() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      avgCyc = preferences.getInt("AvgCycle")!;
      avgPrd = preferences.getInt("AvgPeriod")!;
      lastMenses = preferences.getString("LastMenses")!;
      cycleStartDate = DateTime.parse(lastMenses!);
      cycleEndDate = cycleStartDate?.add(Duration(days: avgCyc - 1));
      periodDates.add(DateTime(
          cycleStartDate!.year, cycleStartDate!.month, cycleStartDate!.day));
      periodAdder = cycleStartDate;
      for (int i = 1; i < avgPrd; i++) {
        periodAdder = periodAdder?.add(const Duration(days: 1));
        periodDates.add(
            DateTime(periodAdder!.year, periodAdder!.month, periodAdder!.day));
      }
      ovulationAdder = cycleEndDate?.subtract(const Duration(days: 12));
      for (int i = 1; i < 8; i++) {
        ovulationDates.add(DateTime(
            ovulationAdder!.year, ovulationAdder!.month, ovulationAdder!.day));
        ovulationAdder = ovulationAdder?.subtract(const Duration(days: 1));
      }
      mainOvule = cycleEndDate?.subtract(const Duration(days: 14));
      mainOvulationDates.add(DateTime(mainOvule!.year, mainOvule!.month, mainOvule!.day));
      for (int i = 0; i < ovulationDates.length; i++) {
        if (ovulationDates[i] == mainOvulationDates[0]) {
          ovulationDates.remove(
              DateTime(mainOvule!.year, mainOvule!.month, mainOvule!.day));
        }
      }
      highOvule = cycleEndDate?.subtract(const Duration(days: 13));
      for(int i=1;i<=2;i++) {
        highOvulationDates.add(DateTime(highOvule!.year, highOvule!.month, highOvule!.day));
        highOvule=cycleEndDate?.subtract(const Duration(days: 15));
      }
      for (int i = 0; i < ovulationDates.length; i++) {
        for(int j=0;j<highOvulationDates.length;j++){
          if (ovulationDates[i] == highOvulationDates[j]) {
            highOvule=highOvulationDates[j];
            ovulationDates.remove(DateTime(highOvule!.year, highOvule!.month, highOvule!.day));
          }
        }
      }
      pCycleAdder = cycleStartDate;
      for(int i = 0;i< avgCyc;i++){
        pCycle.add(DateTime(pCycleAdder!.year,pCycleAdder!.month,pCycleAdder!.day,));
        pCycleAdder = pCycleAdder?.add(const Duration(days: 1));
      }
    });
  }

  void addCycleLoop() async{
    preferences = await SharedPreferences.getInstance();
    setState(() {
      avgCyc = preferences.getInt("AvgCycle")!;
      avgPrd = preferences.getInt("AvgPeriod")!;
      lastMenses = preferences.getString("LastMenses")!;
      cycleStartDate = DateTime.parse(lastMenses!);
      cycleEndDate = cycleStartDate?.add(Duration(days: avgCyc - 1));
      nxtCycleStartDate = cycleStartDate?.add(Duration(days: avgCyc));
      nxtCycleEndDate = nxtCycleStartDate?.add(Duration(days: avgCyc - 1));
      for(int i=1;i<12;i++) {
        periodDates.add(DateTime(
            nxtCycleStartDate!.year, nxtCycleStartDate!.month, nxtCycleStartDate!.day));
        periodAdder = nxtCycleStartDate;
        for (int i = 1; i < avgPrd; i++) {
          periodAdder = periodAdder?.add(const Duration(days: 1));
          periodDates.add(
              DateTime(periodAdder!.year, periodAdder!.month, periodAdder!.day));
        }
        ovulationAdder = nxtCycleEndDate?.subtract(const Duration(days: 12));
        for (int i = 1; i < 8; i++) {
          ovulationDates.add(DateTime(
              ovulationAdder!.year, ovulationAdder!.month, ovulationAdder!.day));
          ovulationAdder = ovulationAdder?.subtract(const Duration(days: 1));
        }
        mainOvule = nxtCycleEndDate?.subtract(const Duration(days: 14));
        mainOvulationDates.add(DateTime(mainOvule!.year, mainOvule!.month, mainOvule!.day));
        for (int i = 0; i < ovulationDates.length; i++) {
          for(int j=0;j<mainOvulationDates.length;j++){
            if (ovulationDates[i] == mainOvulationDates[j]) {
              ovulationDates.remove(
                  DateTime(mainOvule!.year, mainOvule!.month, mainOvule!.day));
            }
          }
        }
        highOvule = nxtCycleEndDate?.subtract(const Duration(days: 13));
        for(int i=1;i<=2;i++) {
          highOvulationDates.add(DateTime(highOvule!.year, highOvule!.month, highOvule!.day));
          highOvule=nxtCycleEndDate?.subtract(const Duration(days: 15));
        }
        for (int i = 0; i < ovulationDates.length; i++) {
          for(int j=0;j<highOvulationDates.length;j++){
            if (ovulationDates[i] == highOvulationDates[j]) {
              highOvule=highOvulationDates[j];
              ovulationDates.remove(DateTime(highOvule!.year, highOvule!.month, highOvule!.day));
            }
          }
        }
        pCycleAdder = nxtCycleStartDate;
        for(int i = 0;i< avgCyc;i++){
          pCycle.add(DateTime(pCycleAdder!.year,pCycleAdder!.month,pCycleAdder!.day,));
          pCycleAdder = pCycleAdder?.add(const Duration(days: 1));
        }
        nxtCycleStartDate = nxtCycleStartDate?.add(Duration(days: avgCyc));
        nxtCycleEndDate = nxtCycleStartDate?.add(Duration(days: avgCyc - 1));
      }});
  }


  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < periodDates.length; i++) {
      _markedDateMap.add(
          periodDates[i],
          Event(
              date: periodDates[i],
              title: 'Event 5',
              icon: _periodIcon(
                periodDates[i].day.toString(),
              )));
    }
    for (int i = 0; i < ovulationDates.length; i++) {
      _markedDateMap.add(
          ovulationDates[i],
          Event(
              date: ovulationDates[i],
              title: 'Event 5',
              icon: _ovulationIcon(
                ovulationDates[i].day.toString(),
              )));
    }
    for (int i = 0; i < mainOvulationDates.length; i++) {
      _markedDateMap.add(
          mainOvulationDates[i],
          Event(
              date: mainOvulationDates[i],
              title: 'Event 5',
              icon: _mainOvulationIcon(
                mainOvulationDates[i].day.toString(),
              )));
    }
    for (int i = 0; i < highOvulationDates.length; i++) {
      _markedDateMap.add(
          highOvulationDates[i],
          Event(
              date: highOvulationDates[i],
              title: 'Event 5',
              icon: _ovulationIcon(
                highOvulationDates[i].day.toString(),
              )));
    }

    final calendarCarouselNoHeader = CalendarCarousel<Event>(
      firstDayOfWeek: DateTime.monday,
      viewportFraction: .7,
      selectedDayButtonColor: LuColors.textGreyColor,
      weekdayTextStyle:  TextStyle(color: Colors.grey,fontSize: Dimensions.font15),
      weekendTextStyle:  TextStyle(
        color: Colors.black,fontSize: Dimensions.font15
      ),
      dayPadding: 1,
      isScrollable: true,
      scrollDirection: Axis.vertical,
      onDayPressed: (date, events) {
        setState(() {
          _currentDate2 = date;
          _currentDate = DateFormat.yMMMd().format(date);
          for (int i = 0; i < pCycle.length; i++) {
            if (date == pCycle[i]) {
              if(i<avgCyc){
                cycleDay = i + 1;
            }else if(avgCyc<=i && i<avgCyc*2){
                int j=i-avgCyc;
                cycleDay=j+1;
              }else if(avgCyc*2<=i && i<avgCyc*3) {
                int j = i - (avgCyc*2);
                cycleDay = j + 1;
              }else if(avgCyc*3<=i && i<avgCyc*4) {
                int j = i - (avgCyc*3);
                cycleDay = j + 1;
              }else if(avgCyc*4<=i && i<avgCyc*5) {
                int j = i - (avgCyc*4);
                cycleDay = j + 1;
              }else if(avgCyc*5<=i && i<avgCyc*6) {
                int j = i - (avgCyc*5);
                cycleDay = j + 1;
              }else if(avgCyc*6<=i && i<avgCyc*7) {
                int j = i - (avgCyc*6);
                cycleDay = j + 1;
              }else if(avgCyc*7<=i && i<avgCyc*8) {
                int j = i - (avgCyc*7);
                cycleDay = j + 1;
              }else if(avgCyc*8<=i && i<avgCyc*9) {
                int j = i - (avgCyc*8);
                cycleDay = j + 1;
              }else if(avgCyc*9<=i && i<avgCyc*10) {
                int j = i - (avgCyc*9);
                cycleDay = j + 1;
              }else if(avgCyc*10<=i && i<avgCyc*11) {
                int j = i - (avgCyc*10);
                cycleDay = j + 1;
              }else if(avgCyc*11<=i && i<avgCyc*12) {
                int j = i - (avgCyc*11);
                cycleDay = j + 1;
              }
            }
          }
          for (int i = 0; i < periodDates.length; i++) {
            for (int j = 0; j < ovulationDates.length; j++) {
              if (date != mainOvulationDates[0]) {
                if (date != periodDates[i]) {
                  if (date != ovulationDates[j]) {
                    bgColor = Colors.grey;
                    daysToPeriod ='Prediction';
                    rangeIcon =  Icon(Icons.signal_cellular_alt_1_bar,
                               color: LuColors.textWhiteColor,size: Dimensions.iconSize20,);
                    rangeTxt='Low';
                  }
                }
              }
            }
          }
          for (int i = 0; i < periodDates.length; i++) {
            if (date == periodDates[i]) {
              bgColor = LuColors.periodColor;
              daysToPeriod ='Period';
              rangeIcon =  Icon(Icons.signal_cellular_alt_1_bar,
                color: LuColors.textWhiteColor,size: Dimensions.iconSize20,);
              rangeTxt='Low';
            }
          }
          for (int i = 0; i < ovulationDates.length; i++) {
            if (date == ovulationDates[i]) {
              bgColor = LuColors.ovulationColor;
              daysToPeriod ='Ovulation';
              rangeIcon =  Icon(Icons.signal_cellular_alt_2_bar,
                        color: LuColors.textWhiteColor,size: Dimensions.iconSize20,);
              rangeTxt='Medium';
            }
          }
          for (int i = 0; i < highOvulationDates.length; i++) {
            if (date == highOvulationDates[i]) {
              bgColor = LuColors.ovulationColor;
              daysToPeriod ='Ovulation';
              rangeIcon =  Icon(Icons.signal_cellular_alt, color: LuColors.textWhiteColor,size: Dimensions.iconSize20,);
              rangeTxt='High';
            }
          }
          for (int i = 0; i < mainOvulationDates.length; i++) {
            if (date == mainOvulationDates[i]) {
              bgColor = LuColors.ovulationColor;
              daysToPeriod ='Ovulation';
              rangeIcon =  Icon(Icons.signal_cellular_alt, color: LuColors.textWhiteColor,size: Dimensions.iconSize20,);
              rangeTxt='High';
            }
          }
        });
        // events.forEach((event) => print(event.title));
      },
      showOnlyCurrentMonthDate: true,

      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
      markedDatesMap: _markedDateMap,

      height: Dimensions.height500,
      selectedDateTime: _currentDate2,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: const ScrollPhysics(),
      showHeader: false,
      todayTextStyle:  TextStyle(
        color: LuColors.textPurpleColor,fontSize: Dimensions.font15
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
      prevDaysTextStyle:  TextStyle(
        fontSize: Dimensions.font15,
        color: Colors.black,
      ),
      onCalendarChanged: (DateTime date) {
        setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.MMMM().format(_targetDateTime);
        });
      },
      onDayLongPressed: (DateTime date) {
        // print('long pressed date $date');
      },
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: bgColor,
        centerTitle: true,
        title: Text(
          (_currentDate == _today) ? 'Today, $_today1' : _currentDate,
          style:  TextStyle(color: LuColors.textWhiteColor, fontSize: Dimensions.font25),
        ),
        actions: [
          IconButton(
            icon:  Icon(
              Icons.menu,
              color: LuColors.textWhiteColor,
              size: Dimensions.iconSize20,
            ),
            onPressed: () {
              Navigator.of(context)
                  .pushAndRemoveUntil(PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => const LuSettings(),
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
                  margin:  EdgeInsets.only(
                    top: Dimensions.height30,
                    bottom: Dimensions.height16,
                    left: Dimensions.width16,
                    right: Dimensions.width16,
                  ),
                  child: Column(
                    children: [
                       SizedBox(
                        height: Dimensions.height80,
                      ),
                      Row(
                        children: <Widget>[
                          TextButton(
                            child:  Text(
                              'PREV',
                              style: TextStyle(color: Colors.black,fontSize: Dimensions.font15),
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
                          const Spacer(),
                          TextButton(
                            child:  Text(
                              'NEXT',
                              style: TextStyle(color: Colors.black,fontSize: Dimensions.font15),
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
                  margin:  EdgeInsets.symmetric(horizontal: Dimensions.width16),
                  child: calendarCarouselNoHeader,
                ),
                //
              ],
            ),
          ),
          Container(
            height: Dimensions.height100,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius:
                   BorderRadius.vertical(bottom: Radius.elliptical(Dimensions.width50, Dimensions.height40)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: Dimensions.height60,
                        width: Dimensions.width85,
                        child: Center(
                          child: Text(
                            daysToPeriod,
                            style:  TextStyle(color: LuColors.textWhiteColor,fontSize: Dimensions.font15),
                          ),
                        ),
                      ),
                      VerticalDivider(
                        color: Colors.grey.shade400,
                        thickness: Dimensions.divider2,
                        width: Dimensions.width20,
                      ),
                      SizedBox(
                        height: Dimensions.height60,
                        width: Dimensions.width85,
                        child: Center(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  rangeIcon,
                                   SizedBox(width: Dimensions.width5,),
                                  Text(
                                    rangeTxt,
                                    style:  TextStyle(color: LuColors.textWhiteColor,fontSize: Dimensions.font15),
                                  ),
                                ],
                              ),
                               SizedBox(height: Dimensions.height5,),
                               Text(
                                'chances of',
                                style: TextStyle(color: LuColors.textWhiteColor, fontSize: Dimensions.font10),
                              ),
                               Text(
                                'getting pregnant',
                                style: TextStyle(color: LuColors.textWhiteColor, fontSize: Dimensions.font10),
                              ),
                            ],
                          ),
                        ),
                      ),
                      VerticalDivider(
                        color: Colors.grey.shade400,
                        thickness: Dimensions.divider2,
                        width: Dimensions.width20,
                      ),
                     SizedBox(
                       height: Dimensions.height60,
                       width: Dimensions.width85,
                       child: Center(
                         child: Column(
                           children: [
                             Text(
                               '$cycleDay',
                               style:  TextStyle(color: LuColors.textWhiteColor,fontSize: Dimensions.font15),
                             ),
                              SizedBox(height: Dimensions.height5,),
                              Text(
                               'day of cycle',
                               style: TextStyle(color: LuColors.textWhiteColor,fontSize: Dimensions.font15),
                             ),
                           ],
                         ),
                       ),
                     ),
                    ],
                  ),
                ),
                 SizedBox(
                  height: Dimensions.height5,
                ),
                Center(
                  child: Text(
                    _currentMonth,
                    style:  TextStyle(
                      color: LuColors.textWhiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: Dimensions.font24,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              bottom: Dimensions.height20,
              left: Dimensions.width150,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: LuColors.textWhiteColor, elevation: 3),
                  onPressed: () {
                    setState(() {
                      _targetDateTime = DateTime.now();
                    });
                  },
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Icon(
                        Icons.keyboard_return,
                        color: LuColors.textLightPurpleColor,
                         size: Dimensions.iconSize20,
                      ),
                      SizedBox(
                        width: Dimensions.width5,
                      ),
                       Text(
                        'Today',
                        style: TextStyle(color: LuColors.textLightPurpleColor,fontSize: Dimensions.font15),
                      )
                    ],
                  )))
        ],
      ),
    );
  }
}
