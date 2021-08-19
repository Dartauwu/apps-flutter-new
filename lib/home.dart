import 'dart:ffi';
import 'dart:html';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:calendar_strip/calendar_strip.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static String tag = 'myapp';
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

static List allDates = [
  {
  "date": DateTime.now(),
  "startTime": "09:00",
  "endTime": "11:00",
  "subject": "Sciace",
  "teacher": "Peter",
  "imageUrl": "https://www.freepik.com/free-photo/covid-19-preventing-virus-social-distancing-university-concept-cheerful-asian-male-teacher-tutor-medical-mask-carry-notebooks-study-materials-showing-thumbs-up-white-background_16786891.htm#page=1&query=teacher&position=11",
  },
{ 
  "date": DateTime.now().subtract(Duration(days:2)),
  "startTime": "09:30",
  "endTime": "11:30",
  "subject": "English",
  "teacher":"Jhon",
  "imageUrl":"https://www.freepik.com/free-photo/young-asia-businessman-using-computer-laptop-talk-colleagues-about-plan-video-call-meeting-while-working-from-home_14323589.htm?query=teacher",
},

{ 
  "date": DateTime.now().add(Duration(days:4)),
  "startTime": "12:00",
  "endTime": "14:30",
  "subject": "Mathematics",
  "teacher":"Bob",
  "imageUrl":"https://www.freepik.com/free-photo/clueless-male-asian-student-cannot-understand-what-teacher-wants-shrugging-standing-with-hands-spread-sideways-lifted-eyebrows_10177970.htm?query=teacher",
}
  

];


  DateTime startDate = DateTime.now().subtract(Duration(days: 5));
  DateTime endDate = DateTime.now().add(Duration(days: 5));
  DateTime selectedDate = DateTime.now().subtract(Duration(days: 2));
  List<DateTime> markedDates = [];
  List datasData = [];

  onSelect(data) {
    State(data){
      setState(() {
        datesData.clear();
      });
    }
    print("Selected Date -> $data");
    for(int i = 0; i <allDates.length; i++){
      if(DateTime.parse(DateFormat('yyy-mm-dd').format(data))== DateTime.parse(DateFormat('yyy-mm-dd').format(allDates[i]['date']))){
        setState(() {
          datesData.add(allDates[i]);
        });
      }
      
    }
  }
  

  
  _monthNameWidget(monthName) {
    return Container(
      child: Text(monthName,
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
              fontStyle: FontStyle.italic)),
      padding: EdgeInsets.only(top: 8, bottom: 4),
    );
  }

  getMarkedIndicatorWidget() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        margin: EdgeInsets.only(left: 1, right: 1),
        width: 7,
        height: 7,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
      ),
      Container(
        width: 7,
        height: 7,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
      )
    ]);
  }

  dateTileBuilder(
      date, selectedDate, rowIndex, dayName, isDateMarked, isDateOutOfRange) {
    bool isSelectedDate = date.compareTo(selectedDate) == 0;
    Color fontColor = isDateOutOfRange ? Colors.black26 : Colors.black87;
    TextStyle normalStyle =
        TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: fontColor);
    TextStyle selectedStyle = TextStyle(
        fontSize: 17, fontWeight: FontWeight.w800, color: Colors.black87);
    TextStyle dayNameStyle = TextStyle(fontSize: 14.5, color: fontColor);
    List<Widget> _children = [
      Text(dayName, style: dayNameStyle),
      Text(date.day.toString(),
          style: !isSelectedDate ? normalStyle : selectedStyle),
    ];

    if (isDateMarked == true) {
      _children.add(getMarkedIndicatorWidget());
    }

    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 8, left: 5, right: 5, bottom: 5),
      decoration: BoxDecoration(
        color: !isSelectedDate ? Colors.transparent : Colors.blue,
        borderRadius: BorderRadius.all(Radius.circular(60)),
      ),
      child: Column(
        children: _children,
      ),
    );
  }

  @override
  void initState(){
    super.initState();

    for(int 1 = 0; 1 <allDates.length; i++>){
      setState(() {
        markedDates.add(allDates[i])['date']

        if(DateTime.parse(DateFormat('yyy-mm-dd').format(DateTime.now()))== DateTime.parse(DateFormat('yyy-mm-dd').format(allDates[i]['date']))){
          datesData.add(allDates[i]);
        }
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: <Widget>[
          Container(
              child: CalendarStrip(
            startDate: startDate,
            endDate: endDate,
            onDateSelected: onSelect,
            onWeekSelected: onWeekSelect,
            dateTileBuilder: dateTileBuilder,
            iconColor: Colors.black87,
            monthNameWidget: _monthNameWidget,
            markedDates: markedDates,
            containerDecoration: BoxDecoration(color: Colors.black12),
          )),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: datesData.length,
            itemBuilder: (BuildContext context, i){
            return new ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: <Widget> [
                Row(
                  children: [
                    SizedBox(
                      height: 15,
                      width: 30,
                      child: Container(
                        child: Material(
                          color: Colors.orange,
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.zero,
                            right: Radius.circular(60)
                          ),
                        ),),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(datesData[i]['startTime'],style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 150),
                      child: Text(datesData[i]['endTime'],style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey
                      ),),
                    ),
                    
                  ],
                ),
                Container(
                      height: 200,
                      padding: EdgeInsets.only(left: 30, right: 10),
                      child: Card(
                        color: Color.fromRGBO(255, 190, 140, 1),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget> [
                            ListTile(
                              title: Text("object: ${datesData[i]['subject']}",style: TextStyle(fontWeight: FontWeight.bold
                              ),
                              ),
                              trailing: Container(
                                width: 100,
                                child: Row(
                                  children: <Widget> [
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {},
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () {},
                                    )
                                  ],
                                ),
                              ),
                            ),
                            ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(datesData[i]['imageUrl']),
                              ),
                              title: Text("Teacher ${datesData[i]["teacher"]}"),
                            )
                          ],
                        ),
                      ),
                    ),

              ],
            );
            
          })
        ],
      ),
    );
  }
}
