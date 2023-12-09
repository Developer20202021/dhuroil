
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:bijoy_helper/bijoy_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhuroil/DeveloperAccess/DeveloperAccess.dart';
import 'package:dhuroil/Screens/Students/AllStudentsHomePage.dart';
import 'package:dhuroil/Screens/Students/Attendance/AttendanceHomePage.dart';
import 'package:dhuroil/Screens/Teachers/AllTeachers.dart';
import 'package:dhuroil/Screens/Teachers/Attendance/AllTeacherAttendance.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:uuid/uuid.dart';



class AdminHomePage extends StatefulWidget {


  AdminHomePage({super.key,});

  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {

  var uuid = Uuid();


  int _selectedDestination = 0;

  bool loading = false;

  TextEditingController DebitController = TextEditingController();
  TextEditingController DebitAmountController = TextEditingController();




  
  Map<String, double> dataMap = {
    "Student P": 60,
    "Student A": 40,
    "Teacher P": 99,
    "Teacher A": 1,
  };


  
  Map<String, double> DebitCredit = {
    "Debit": 11160,
    "Credit": 11140,
  };







  List AllStudentAbsenceData = [];
  int TotalStudentAbsence = 0;
  List AllStudentPresenceData = [];
  int TotalStudentPresence = 0;


// Student Presence Data Load 
  Future<void> getStudentPresenceData() async {


    setState(() {
      loading = true;
    });

    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('StudentAttendance');

    Query query = _collectionRef
        .where("type", isEqualTo: "presence")
        .where("Date", isEqualTo: "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}");
    QuerySnapshot querySnapshot = await query.get();

    // Get data from docs and convert map to List
    AllStudentPresenceData = querySnapshot.docs.map((doc) => doc.data()).toList();

    setState(() {
      TotalStudentPresence = AllStudentPresenceData.length;
    });

    if (AllStudentPresenceData.isEmpty) {
      setState(() {
        loading = false;
      });

      getStudentAbsenceData();
    } else {
      setState(() {
        AllStudentPresenceData = querySnapshot.docs.map((doc) => doc.data()).toList();

        loading = false;
      });

        getStudentAbsenceData();
    }
  }



// Student Absence Data Load 
 Future<void> getStudentAbsenceData() async {


    setState(() {
      loading = true;
    });

    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('StudentAttendance');

    Query query = _collectionRef
        .where("type", isEqualTo: "absence")
        .where("Date", isEqualTo: "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}");
    QuerySnapshot querySnapshot = await query.get();

    // Get data from docs and convert map to List
    AllStudentAbsenceData = querySnapshot.docs.map((doc) => doc.data()).toList();

    setState(() {
      TotalStudentAbsence = AllStudentAbsenceData.length;
    });

    if (AllStudentAbsenceData.isEmpty) {
      setState(() {
        loading = false;
      });

     getTeacherPresenceData();
    } else {
      setState(() {
        AllStudentAbsenceData = querySnapshot.docs.map((doc) => doc.data()).toList();

        loading = false;
      });

      getTeacherPresenceData();
    }
  }









  List AllTeacherAbsenceData = [];
  int TotalTeacherAbsence = 0;
  List AllTeacherPresenceData = [];
  int TotalTeacherPresence = 0;


// Teacher Presence Data Load 
  Future<void> getTeacherPresenceData() async {


    setState(() {
      loading = true;
    });

    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('Attendance');

    Query query = _collectionRef
        .where("type", isEqualTo: "presence")
        .where("Date", isEqualTo: "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}");
    QuerySnapshot querySnapshot = await query.get();

    // Get data from docs and convert map to List
    AllTeacherPresenceData = querySnapshot.docs.map((doc) => doc.data()).toList();

    setState(() {
      TotalTeacherPresence = AllTeacherPresenceData.length;
    });

    if (AllTeacherPresenceData.isEmpty) {
      setState(() {
        loading = false;
      });

      getTeacherAbsenceData();
    } else {
      setState(() {
        AllTeacherPresenceData = querySnapshot.docs.map((doc) => doc.data()).toList();

        loading = false;
      });

      getTeacherAbsenceData();
    }
  }




// Teacher Absence Data Load 
  Future<void> getTeacherAbsenceData() async {


    setState(() {
      loading = true;
    });

    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('Attendance');

    Query query = _collectionRef
        .where("type", isEqualTo: "absence")
        .where("Date", isEqualTo: "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}");
    QuerySnapshot querySnapshot = await query.get();

    // Get data from docs and convert map to List
    AllTeacherAbsenceData = querySnapshot.docs.map((doc) => doc.data()).toList();

    setState(() {
      TotalTeacherAbsence= AllTeacherAbsenceData.length;
    });

    if (AllTeacherAbsenceData.isEmpty) {
      setState(() {
        loading = false;
      });

      DataSetForMap();
    } else {
      setState(() {
        AllTeacherAbsenceData = querySnapshot.docs.map((doc) => doc.data()).toList();

        loading = false;
      });

      DataSetForMap();
    }
  }




  void DataSetForMap(){


    setState(() {


     dataMap = {
    "Student P": double.parse(AllStudentPresenceData.length.toString()),
    "Student A": double.parse(AllStudentAbsenceData.length.toString()),
    "Teacher P": double.parse(AllTeacherPresenceData.length.toString()),
    "Teacher A": double.parse(AllTeacherAbsenceData.length.toString()),
  };
      

    });




  }








  List AllStudentsData =[];
  int TotalStudents = 0;

  // All Student Data Load 
 Future<void> getAllStudentsData() async {


    setState(() {
      loading = true;
    });

    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('StudentInfo');

    Query query = _collectionRef
        .where("StudentStatus", isEqualTo: "running");
       
    QuerySnapshot querySnapshot = await query.get();

    // Get data from docs and convert map to List
    AllStudentsData = querySnapshot.docs.map((doc) => doc.data()).toList();

    setState(() {
      TotalStudents = AllStudentsData.length;
    });

    if (AllStudentsData.isEmpty) {
      setState(() {
        loading = false;
      });

   
    } else {
      setState(() {
        AllStudentsData = querySnapshot.docs.map((doc) => doc.data()).toList();

        loading = false;
      });

  
    }
  }














@override
  void initState() {
    getStudentPresenceData();
    super.initState();
  }




























  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    var DebitID = uuid.v4();

    return Row(
      children: [
        Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'All Actions',
                  style: textTheme.headline6,
                ),
              ),
              Divider(
                height: 1,
                thickness: 1,
              ),
              ListTile(
                leading: Icon(Icons.favorite),
                title: Text('All Students'),
                selected: _selectedDestination == 0,
                onTap: (){

                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllStudentsHomePage()));

                  selectDestination(0);
                },
              ),
              ListTile(
                leading: Icon(Icons.favorite),
                title: Text('Student Attendance'),
                selected: _selectedDestination == 1,
                onTap: (){

                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => AttendanceHomePage()));

                  selectDestination(1);
                },
              ),
              ListTile(
                leading: Icon(Icons.favorite),
                title: Text('All Teachers'),
                selected: _selectedDestination == 2,
                onTap: (){

                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllTeachers(indexNumber: "")));

                  selectDestination(2);
                },
              ),
              Divider(
                height: 1,
                thickness: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'All Actions',
                ),
              ),
              ListTile(
                leading: Icon(Icons.favorite),
                title: Text('Teacher Attendance'),
                selected: _selectedDestination == 3,
                onTap: (){

                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllTeacherAttendance(indexNumber: "")));

                  selectDestination(3);
                },
              ),

                 ListTile(
                leading: Icon(Icons.bookmark),
                title: Text('Item B'),
                selected: _selectedDestination == 4,
                onTap: (){
                 selectDestination(4);
                },
              ),

                 ListTile(
                leading: Icon(Icons.bookmark),
                title: Text('Item C'),
                selected: _selectedDestination == 5,
                onTap: (){
                 selectDestination(5);
                },
              ),
            ],
          ),
        ),
        VerticalDivider(
          width: 1,
          thickness: 1,
        ),
        Expanded(
          child: Scaffold(
            appBar: AppBar(
              leading: 
                      PopupMenuButton(
                        onSelected: (value) {
                          // your logic
                        },
                        itemBuilder: (BuildContext bc) {
                          return  [
                            PopupMenuItem(
                                child: Text("Debit Add"),
                                            value: '/about',
                                            onTap: () async {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  String SelectedStudentStatus =
                                                      "";
                                                  String Title ="নিচে আয়ের খাত লিখবেন";

                                                  String LabelText ="আয়ের খাত লিখবেন";

                                                  return StatefulBuilder(
                                                    builder:
                                                        (context, setState) {
                                                      return AlertDialog(
                                                        title:  Text(
                                                            "${Title.toBijoy}", style: TextStyle(fontFamily: "SiyamRupali"),),
                                                        content: SingleChildScrollView(
                                                          
                                                          child:  Column(
                                                            children: [
              
              Container(
                  width: 200,
                  child: TextField(
                    onChanged: (value) {},
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '${LabelText}',

                      hintText: '${LabelText}',

                      //  enabledBorder: OutlineInputBorder(
                      //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                      //     ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3, color: Theme.of(context).primaryColor),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                      ),
                    ),
                    controller: DebitController,
                  ),
                ),


                                                              
                                                              
                                                              
                                                              
                                                              
                                                              
                                                              
                      SizedBox(
                              height: 20,
                            ),

                    

                    Container(
                  width: 200,
                  child: TextField(
                    onChanged: (value) {},
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'আয়ের পরিমান(৳)',

                      hintText: 'আয়ের পরিমান(৳)',

                      //  enabledBorder: OutlineInputBorder(
                      //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                      //     ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3, color: Theme.of(context).primaryColor),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                      ),
                    ),
                    controller: DebitAmountController,
                  ),
                ),






                                                            ],
                                                          ),
                                                        ),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context),
                                                            child:
                                                                Text("Cancel"),
                                                          ),


                                                  ElevatedButton(
                                                          onPressed:
                                                            () async {

            setState((){

              loading = true;

            });


            var updateData =
                      {
                        "DebitID": DebitID,
                        "DebitName":DebitController.text.trim().toLowerCase(),
                        "DebitAmount":DebitAmountController.text.trim().toLowerCase(),
                        "year":"${DateTime.now().year}",
                        "month":"${DateTime.now().month}/${DateTime.now().year}",
                        "Date":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                        "DateTime":DateTime.now().toIso8601String(),
                        "CollectorName":"",
                        "CollectorEmail":""
                        };

                  final StudentInfo = FirebaseFirestore.instance.collection('DebitInfo').doc(DebitID);
                  
                  StudentInfo.set(updateData).then((value) =>setState(() {
                                        

                                        Navigator.pop(context);

                                final snackBar = SnackBar(
                                        
                                        elevation: 0,
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.transparent,
                                        content: AwesomeSnackbarContent(
                                        titleFontSize: 12,
                                        title: 'successfull',
                                        message: 'Hey Thank You. Good Job',

                          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                        contentType: ContentType.success,
                                                ),
                                            );

                    ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(snackBar);

                       setState(() {
                        loading = false;
                             });
                            }))
                      .onError((error,stackTrace) =>setState(() {
                        final snackBar = SnackBar(
                  /// need to set following properties for best effect of awesome_snackbar_content
                        elevation: 0,
                        
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                        title: 'Something Wrong!!!!',
                        message: 'Try again later...',

            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                        contentType: ContentType.failure,
                            ),
                        );

                ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(snackBar);

                      setState(() {
                            loading = false;
                               });
                      }));




                                                                  },
                                                                  child: const Text(
                                                                      "Save"),
                                                                ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                          ),




                           PopupMenuItem(
                                child: Text("Credit Add"),
                                            value: '/about',
                                            onTap: () async {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  String SelectedStudentStatus =
                                                      "";
                                                  String Title ="নিচে ব্যয়ের খাত লিখবেন";

                                                  String LabelText ="আয়ের খাত লিখবেন";

                                                  return StatefulBuilder(
                                                    builder:
                                                        (context, setState) {
                                                      return AlertDialog(
                                                        title:  Text(
                                                            "${Title.toBijoy}", style: TextStyle(fontFamily: "SiyamRupali"),),
                                                        content: SingleChildScrollView(
                                                          
                                                          child:  Column(
                                                            children: [
              
              Container(
                  width: 200,
                  child: TextField(
                    onChanged: (value) {},
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'ব্যয়ের খাত লিখবেন',

                      hintText: 'ব্যয়ের খাত লিখবেন',

                      //  enabledBorder: OutlineInputBorder(
                      //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                      //     ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3, color: Theme.of(context).primaryColor),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                      ),
                    ),
                    controller: DebitController,
                  ),
                ),


                                                              
                                                              
                                                              
                                                              
                                                              
                                                              
                                                              
                      SizedBox(
                              height: 20,
                            ),

                    

                    Container(
                  width: 200,
                  child: TextField(
                    onChanged: (value) {},
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'ব্যয়ের পরিমান(৳)',

                      hintText: 'ব্যয়ের পরিমান(৳)',

                      //  enabledBorder: OutlineInputBorder(
                      //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                      //     ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3, color: Theme.of(context).primaryColor),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                      ),
                    ),
                    controller: DebitAmountController,
                  ),
                ),






                                                            ],
                                                          ),
                                                        ),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context),
                                                            child:
                                                                Text("Cancel"),
                                                          ),


                                                  ElevatedButton(
                                                          onPressed:
                                                            () async {

            setState((){

              loading = true;

            });


            var updateData =
                      {
                        "CreditID": DebitID,
                        "CreditName":DebitController.text.trim().toLowerCase(),
                        "CreditAmount":DebitAmountController.text.trim().toLowerCase(),
                        "year":"${DateTime.now().year}",
                        "month":"${DateTime.now().month}/${DateTime.now().year}",
                        "Date":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                        "DateTime":DateTime.now().toIso8601String(),
                        "CollectorName":"",
                        "CollectorEmail":""
                        };

                  final StudentInfo = FirebaseFirestore.instance.collection('CreditInfo').doc(DebitID);
                  
                  StudentInfo.set(updateData).then((value) =>setState(() {
                                        

                                        Navigator.pop(context);

                                final snackBar = SnackBar(
                                        
                                        elevation: 0,
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.transparent,
                                        content: AwesomeSnackbarContent(
                                        titleFontSize: 12,
                                        title: 'successfull',
                                        message: 'Hey Thank You. Good Job',

                          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                        contentType: ContentType.success,
                                                ),
                                            );

                    ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(snackBar);

                       setState(() {
                        loading = false;
                             });
                            }))
                      .onError((error,stackTrace) =>setState(() {
                        final snackBar = SnackBar(
                  /// need to set following properties for best effect of awesome_snackbar_content
                        elevation: 0,
                        
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                        title: 'Something Wrong!!!!',
                        message: 'Try again later...',

            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                        contentType: ContentType.failure,
                            ),
                        );

                ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(snackBar);

                      setState(() {
                            loading = false;
                               });
                      }));




                                                                  },
                                                                  child: const Text(
                                                                      "Save"),
                                                                ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                          ),
                          
                          ];
                        },
                      ),
              title: Text("Dashboard"),
            ),
            body: loading?LinearProgressIndicator(): GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              padding: EdgeInsets.all(20),
              childAspectRatio: 3 / 2,
              children: [
            
              
              // Total Student
             Container(
                    child:  Center(child: Container(
                      child: Column(
                        children: [
                          Icon(Icons.person, size: 107,color: Colors.white,),

                          SizedBox(height: 10,),
                          
                          Text("Total Active Student: 100", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 27, color: Colors.white),),
                        ],
                      ),
                    )),
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.9),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.red.shade200, Colors.pink.shade500, ],
                      ),
                    ),
                  ),
            
            
            
            
            
                // Total Teacher
                  Container(
                    child:  Center(child: Container(
                      child: Column(
                        children: [


                          Icon(Icons.school, size: 107,color: Colors.white,),

                          SizedBox(height: 10,),




                          Text("Total Teacher: 100", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27, color: Colors.white),),
                        ],
                      ),
                    )),
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.9),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [ Colors.deepPurpleAccent, Colors.deepPurple.shade300],
                      ),
                    ),
                  ),
            
            
            
            
                // Total Fee Collection this year
                  Container(
                    child:  Center(child: Container(
                      child: Column(
                        children: [
                    
                          Icon(Icons.payment, size: 107,color: Colors.white,),
                    
                            SizedBox(height: 10,),
                    
                          Text("Total Fee Collection: 100 ৳", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23, color: Colors.white),),
                        ],
                      ),
                    )),
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.9),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [ Colors.orange.shade400, Colors.green.shade300],
                      ),
                    ),
                  ),
            
            
            
            
            
            
            
                  // Today Presence Students
                  Container(
                    child:  Center(child: Container(
                      child: Column(
                        children: [

                          Icon(Icons.person_3, size: 107,color: Colors.white,),

                          SizedBox(height: 10,),
                          
                          Text("Today Present Students: 100 ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23, color: Colors.white),),
                        ],
                      ),
                    )),
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.9),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [ Colors.indigo.shade400, Colors.green.shade400],
                      ),
                    ),
                  ),
            
            
            
            
                   // Today Presence and absence Students persentage
                  Container(
                    child:  Center(child: PieChart(
                            dataMap: dataMap,
                            animationDuration: Duration(milliseconds: 800),
                            chartLegendSpacing: 32,
                            chartRadius: MediaQuery.of(context).size.width / 9.2,
                          
                            initialAngleInDegree: 0,
                            chartType: ChartType.ring,
                            ringStrokeWidth: 32,
                            centerText: "Attendance",
                            legendOptions: LegendOptions(
                              showLegendsInRow: false,
                              legendPosition: LegendPosition.right,
                              showLegends: true,
                              
                              legendTextStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            chartValuesOptions: ChartValuesOptions(
                              showChartValueBackground: true,
                              showChartValues: true,
                              showChartValuesInPercentage: false,
                              showChartValuesOutside: false,
                              decimalPlaces: 1,
                            ),
                            // gradientList: ---To add gradient colors---
                            // emptyColorGradient: ---Empty Color gradient---
                          )),
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.9),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.white70, Colors.indigo.shade100, Colors.white70],
                      ),
                    ),
                  ),
            
            
            
            
            
            
            
                  
                   // this year আয় ব্যয়
                  Container(
                    child:  Center(child: PieChart(
                            dataMap: DebitCredit,
                            animationDuration: Duration(milliseconds: 800),
                            chartLegendSpacing: 32,
                            chartRadius: MediaQuery.of(context).size.width / 9.2,
                          
                            initialAngleInDegree: 0,
                            chartType: ChartType.ring,
                            ringStrokeWidth: 32,
                            centerText: "আয় ব্যয়",
                            legendOptions: LegendOptions(
                              showLegendsInRow: false,
                              legendPosition: LegendPosition.right,
                              showLegends: true,
                              
                              legendTextStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            chartValuesOptions: ChartValuesOptions(
                              showChartValueBackground: true,
                              showChartValues: true,
                              showChartValuesInPercentage: false,
                              showChartValuesOutside: false,
                              decimalPlaces: 1,
                            ),
                            // gradientList: ---To add gradient colors---
                            // emptyColorGradient: ---Empty Color gradient---
                          )),
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.9),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.white70, Colors.indigo.shade100, Colors.white70],
                      ),
                    ),
                  ),




                   // this year আয় ব্যয়
                  Container(
                    child:  Center(child: PieChart(
                            dataMap: DebitCredit,
                            animationDuration: Duration(milliseconds: 800),
                            chartLegendSpacing: 32,
                            chartRadius: MediaQuery.of(context).size.width / 9.2,
                          
                            initialAngleInDegree: 0,
                            chartType: ChartType.ring,
                            ringStrokeWidth: 32,
                            centerText: "আয় ব্যয়",
                            legendOptions: LegendOptions(
                              showLegendsInRow: false,
                              legendPosition: LegendPosition.right,
                              showLegends: true,
                              
                              legendTextStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            chartValuesOptions: ChartValuesOptions(
                              showChartValueBackground: true,
                              showChartValues: true,
                              showChartValuesInPercentage: false,
                              showChartValuesOutside: false,
                              decimalPlaces: 1,
                            ),
                            // gradientList: ---To add gradient colors---
                            // emptyColorGradient: ---Empty Color gradient---
                          )),
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.9),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.white70, Colors.indigo.shade100, Colors.white70],
                      ),
                    ),
                  ),


            
            
            
            
                  
            
            
            
            
            
            
            
            
            
            
            
               
              ],
            ),
          ),
        ),
      ],
    );
  }

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }
}