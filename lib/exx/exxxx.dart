import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Testing(),
  ));
}

class Testing extends StatelessWidget {
  var sex = [
    "Protected Sex",
    "Unprotected Sex",
    "No Sex",
    "Strong desire",
    "Masturbation",
  ];
  var mood = [
    "Cheerful",
    "Calm",
    "Energetic",
    "Playful",
    "Mood swings",
    "Sad",
    "Indifferent",
    "Angry",
    "Aroused",
    "Inspired",
    "Mopey",
    "Anxious",
    "Confused",
    "Depressed",
  ];
  var symptoms = [
    "Everything's Fine",
    "Abdominal cramps",
    "Headache",
    "Fatigue",
    "Acne (pimples)",
    "Back pain",
    "Insomnia",
    "Sensitive breasts",
    "Bloating",
    "Nausea",
    "Constipation",
    "Diarrhea",
    "Chills",
    "Sore throat",
    "Fever",
  ];
  var discharge = [
    "No discharge",
    "Spotting",
    "Sticky",
    "Creamy",
    "Mucousy",
    "Watery",
    "Abnormal",
  ];
  var flow = [
    "Light",
    "Medium",
    "Heavy",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.purple,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.elliptical(50, 40))),
            ),
            Positioned(
              top: 230,
              left: 150,
              child: MaterialButton(
                shape: CircleBorder(),
                color: Colors.grey,
                onPressed: () {
                  showModalBottomSheet<void>(
                    backgroundColor: Colors.white,
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: MediaQuery.of(context).size.height / 2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50))),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'Add Symptoms',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    width: 100,
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.heart_broken_outlined,
                                          color: Colors.red,
                                        ),
                                        Text('Sex'),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Icon(
                                          Icons.child_care_outlined,
                                          color: Colors.red,
                                        ),
                                        Text('Mood'),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Icon(
                                          Icons.man,
                                          color: Colors.red,
                                        ),
                                        Text('Symptoms'),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Icon(
                                          Icons.water_drop_outlined,
                                          color: Colors.red,
                                        ),
                                        Text('Discharge'),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Icon(
                                          Icons.water_drop_outlined,
                                          color: Colors.red,
                                        ),
                                        Text('Heaviness'),
                                        Text('of flow'),
                                        // SizedBox(
                                        //   height: 10,
                                        // ),
                                        // Icon(Icons.note_alt_outlined,color: Colors.red,),
                                        // Text('Notes')
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 50,
                                          width: MediaQuery.of(context).size.width,
                                          child: ListView(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            children: List.generate(
                                                sex.length,
                                                (index) => Card(
                                                      child: Center(
                                                          child: Padding(
                                                            padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                                            child: Text(sex[index]),
                                                          )),
                                                    )),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          height: 50,
                                          width: MediaQuery.of(context).size.width,
                                          child: ListView(
                                            scrollDirection: Axis.horizontal,
                                            children: List.generate(
                                                mood.length,
                                                    (index) => Card(
                                                  child: Center(
                                                      child: Padding(
                                                        padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                                        child: Text(mood[index]),
                                                      )),
                                                )),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          height: 50,
                                          width: MediaQuery.of(context).size.width,
                                          child: ListView(
                                            scrollDirection: Axis.horizontal,
                                            children: List.generate(
                                                symptoms.length,
                                                    (index) => Card(
                                                  child: Center(
                                                      child: Padding(
                                                        padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                                        child: Text(symptoms[index]),
                                                      )),
                                                )),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          height: 50,
                                          width: MediaQuery.of(context).size.width,
                                          child: ListView(
                                            scrollDirection: Axis.horizontal,
                                            children: List.generate(
                                                discharge.length,
                                                    (index) => Card(
                                                  child: Center(
                                                      child: Padding(
                                                        padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                                        child: Text(discharge[index]),
                                                      )),
                                                )),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          height: 50,
                                          width: MediaQuery.of(context).size.width,
                                          child: ListView(
                                            scrollDirection: Axis.horizontal,
                                            children: List.generate(
                                                flow.length,
                                                    (index) => Card(
                                                  child: Center(
                                                      child: Padding(
                                                        padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                                        child: Text(flow[index]),
                                                      )),
                                                )),
                                          ),
                                        ),
                                        // SizedBox(
                                        //   height: 10,
                                        // ),
                                        // Padding(
                                        //   padding: const EdgeInsets.symmetric(horizontal: 10),
                                        //   child: TextField(
                                        //     decoration: InputDecoration(
                                        //       enabledBorder: OutlineInputBorder(
                                        //         borderRadius: BorderRadius.all(Radius.circular(10)),
                                        //         borderSide: BorderSide(color: Colors.green,width: 1)
                                        //       )
                                        //     ),
                                        //   ),
                                        // ),
                                        // SizedBox(height: 10,)
                                      ],
                                    ),
                                  ),

                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
