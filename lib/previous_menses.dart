import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:luna_loom/home_screen.dart';
import 'package:luna_loom/utils/dimensions.dart';
import 'package:luna_loom/utils/lu_colors.dart';
import 'package:luna_loom/widgets/logo_widget.dart';
import 'package:luna_loom/widgets/lu_font_txt.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';

class PreviousMns extends StatefulWidget {
  const PreviousMns({super.key});


  @override
  State<PreviousMns> createState() => _PreviousMnsState();
}

class _PreviousMnsState extends State<PreviousMns> {
  late DateTime selectedDate;
  late SharedPreferences preferences;
  dynamic previousMenses;
  dynamic forMate;
  late bool isANewUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LuColors.bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LogoWidget(),
            Container(
              margin: EdgeInsets.only(top: Dimensions.height30),
              child: const Column(
                children: [
                  LuFontText(text: 'When did your previous'),
                  LuFontText(text: 'menses begin?')
                ],
              ),
            ),
            SizedBox(height: Dimensions.height20,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.width25),
              child: DatePickerWidget(
                looping: false,
                firstDate: DateTime(2023, 10),
                lastDate: DateTime.now(),
                initialDate: DateTime(2024,01,01),
                dateFormat: "dd-MMMM-yyyy",
                locale: DatePicker.localeFromString('en'),
                onChange: (DateTime newDate,_) {
                  setState(() {
                    selectedDate = newDate;
                    previousMenses = newDate;
                    forMate = "${previousMenses.day}-${previousMenses.month}-${previousMenses.year}";
                    Vibration.vibrate(duration: 10,);
                  });
                } ,
                pickerTheme: DateTimePickerTheme(
                  backgroundColor: LuColors.bgColor,
                    itemTextStyle: TextStyle(color: LuColors.textWhiteColor,fontSize: Dimensions.font20),
                    dividerColor: LuColors.logoColor,
                ),
              ),
            ),
        SizedBox(height: Dimensions.height30,),
            ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: LuColors.textWhiteColor,
                      elevation: 3, minimumSize: Size(Dimensions.width220, Dimensions.height50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Dimensions.radius25)
                    ),),
                  onPressed: () async{
                    preferences = await SharedPreferences.getInstance();
                    preferences.setBool('newUser', true);
                    if(previousMenses==null){
                      String backupDate ='2024-01-01 00:00:00.000';
                      previousMenses=DateTime.parse(backupDate);
                      preferences.setString("LastMenses", previousMenses.toString());
                    }else {
                      preferences.setString("LastMenses", previousMenses.toString());
                    }
                    if (context.mounted)Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Home_Screen()),(route)=>false);
                  },
                  child: const LuFontText(text: 'Continue',color: LuColors.textPurpleColor,)),
          ],
        ),
      ),
    );
  }
}
