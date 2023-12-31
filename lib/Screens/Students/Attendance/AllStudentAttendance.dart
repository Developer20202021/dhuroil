
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhuroil/DeveloperAccess/DeveloperAccess.dart';
import 'package:dhuroil/Screens/Students/Attendance/ChangeAttendance.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:path/path.dart';

import 'package:uuid/uuid.dart';








class AllStudentAttendance extends StatefulWidget {

  final indexNumber ;

  final ClassName;





  const AllStudentAttendance({super.key, required this.indexNumber, required this.ClassName});

  @override
  State<AllStudentAttendance> createState() => _AllStudentAttendanceState();
}

class _AllStudentAttendanceState extends State<AllStudentAttendance> {

   var uuid = Uuid();

TextEditingController StudentRollNumberController = TextEditingController();

var searchField ="";

bool loading = false;

var DataLoad = "";

 



// Firebase All Customer Data Load

List  AllData = [{},{}];













Future<void> getData() async {
    // Get docs from collection reference
      CollectionReference _CustomerOrderHistoryCollectionRef =
    FirebaseFirestore.instance.collection('StudentInfo');

  // all Due Query Count
     Query _CustomerOrderHistoryCollectionRefDueQueryCount = _CustomerOrderHistoryCollectionRef.where("ClassName", isEqualTo: widget.ClassName).where("StudentStatus", isEqualTo: "running");

     QuerySnapshot queryDueSnapshot = await _CustomerOrderHistoryCollectionRefDueQueryCount.get();

    var AllDueData = queryDueSnapshot.docs.map((doc) => doc.data()).toList();





     if (AllDueData.length == 0) {
      setState(() {
        DataLoad = "0";
        loading = false;
      });
       
     } else {

      setState(() {
     
      AllData = queryDueSnapshot.docs.map((doc) => doc.data()).toList();
      loading = false;
     });
       
     }
     

    print(AllData);
}








List todayAttendanceData =[];


Future<void> getTodayAttendanceData(String StudentEmail,String FineAmount, BuildContext context) async {
    // Get docs from collection reference
      CollectionReference _CustomerOrderHistoryCollectionRef =
    FirebaseFirestore.instance.collection('StudentAttendance');

  // all Due Query Count
     Query _CustomerOrderHistoryCollectionRefDueQueryCount = _CustomerOrderHistoryCollectionRef.where("StudentEmail", isEqualTo: StudentEmail).where("Date", isEqualTo: "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}");

     QuerySnapshot queryDueSnapshot = await _CustomerOrderHistoryCollectionRefDueQueryCount.get();

    var AllDueData = queryDueSnapshot.docs.map((doc) => doc.data()).toList();





     if (AllDueData.length == 0) {
      setState(() {
        DataLoad = "0";
        loading = false;
      });
       
     } else {

      setState(() {
     
      todayAttendanceData = queryDueSnapshot.docs.map((doc) => doc.data()).toList();
      loading = false;


       Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChangeAttendance(StudentEmail: StudentEmail, AttendanceType: todayAttendanceData[0]["type"] , AttendanceID: todayAttendanceData[0]["AttendanceID"], FineAmount: FineAmount, ClassName: todayAttendanceData[0]["ClassName"], RollNo: todayAttendanceData[0]["StudentRollNo"], StudentName: todayAttendanceData[0]["StudentName"],)));
     });
       
     }
     

    print(AllData);
}










List  AllSearchData = [];


Future<void> getSearchData(String StudentRollNo) async {

      setState(() {
        loading = true;
        DataLoad ="";
      });
    // Get docs from collection reference
     CollectionReference _SearchCollectionRef =
    FirebaseFirestore.instance.collection('StudentInfo');

     Query _SearchCollectionRefQuery = _SearchCollectionRef.where("RollNo", isEqualTo: StudentRollNo);


    QuerySnapshot SearchCollectionQuerySnapshot = await _SearchCollectionRefQuery.get();

    // Get data from docs and convert map to List
    setState(() {
       AllSearchData = SearchCollectionQuerySnapshot.docs.map((doc) => doc.data()).toList();
    });
     if (AllSearchData.length == 0) {
      setState(() {
        DataLoad = "0";
        loading = false;
      });
       
     } else {

      setState(() {
     
       AllData = SearchCollectionQuerySnapshot.docs.map((doc) => doc.data()).toList();
      loading = false;
     });
       
     }
     

    print(AllSearchData);
}











// Firebase All Customer Data Load








@override
  void initState() {
    // TODO: implement initState
    setState(() {
      loading = true;
    });
   
    getData();
    super.initState();
  }



  
  Future refresh() async{


    setState(() {


      
  getData();

    });




  }









  @override
  Widget build(BuildContext context) {


        var AttendanceID = uuid.v4();

 FocusNode myFocusNode = new FocusNode();


   




    return Scaffold(

        bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 200, right: 200, bottom: 9),
        child: Container(
          
          height: 60,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
           
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
       
       
           IconButton(
                enableFeedback: false,
                onPressed: () {
       
                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) =>AdminDashboard(indexNumber: "1")));
                },
                icon: const Icon(
                  Icons.home_sharp,
                  color: Colors.white,
                  size: 25,
                ),
              ),
       
       
       
             IconButton(
                enableFeedback: false,
                onPressed: () {
       
       
                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllNotice(indexNumber: "2")));
       
       
                },
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.white,
                  size: 25,
                ),
              ),
       
       
       
       
              IconButton(
                enableFeedback: false,
                onPressed: () {
       
       
                  //  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>MonthlyCourseFeeCollection()));
       
       
       
                },
                icon: const Icon(
                  Icons.account_balance,
                  color: Colors.white,
                  size: 25,
                ),
              ),
       
       
       
              IconButton(
                enableFeedback: false,
                onPressed: () {
       
                  //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllDepartment()));
       
       
       
       
                },
                icon: const Icon(
                  Icons.person_outline,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ],
          ),),
           ),







      backgroundColor: Colors.white,
        appBar:  AppBar(

      
      systemOverlayStyle: SystemUiOverlayStyle(
          // Navigation bar
          statusBarColor: ColorName().appColor, // Status bar
        ),

        toolbarHeight: searchField=="search"?100:56,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        automaticallyImplyLeading: false,
        title:  Padding(
          padding: const EdgeInsets.only(left: 300, right: 300),
          child: searchField=="search"?ListTile(
        
            leading: IconButton(onPressed: (){
        
        
              setState(() {
                loading = true;
                searchField = "";
              });
        
        
        
              getSearchData(StudentRollNumberController.text.trim());
        
        
              print("___________________________________________________________________________________________${StudentRollNumberController.text}_____________________");
        
        
              // comming soon 
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
            }, icon: Icon(Icons.search, color: Theme.of(context).primaryColor,)),
            title: TextField(
        
                        keyboardType: TextInputType.phone,
                        
                        decoration: InputDecoration(
                          
                            border: OutlineInputBorder(),
                            labelText: 'Enter Roll No',
                             labelStyle: TextStyle(
                color: myFocusNode.hasFocus ? Theme.of(context).primaryColor: Colors.black
                    ),
                            hintText: 'Enter Roll No',
              
                             enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                                ),
                            
                            
                            ),
        
                          controller: StudentRollNumberController,
                    
                      ),
              
              
        
        
        
          ):Text("All Students Class:${widget.ClassName}", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),),
        ),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        actions: [


          searchField == "search"?IconButton(onPressed: (){


            // showSearch(context: context, delegate: MySearchDelegate());

            


                      setState(() {
                              
                              searchField = "";
                              StudentRollNumberController.text ="";
                            });





            










          }, icon: Icon(Icons.close)):IconButton(onPressed: (){


            setState(() {
              
              searchField = "search";
            });


          

            








          

          }, icon: Icon(Icons.search))







        ],
        
      ),
      body:loading?Center(child: CircularProgressIndicator()): DataLoad == "0"? Center(child: Text("No Data Available")): RefreshIndicator(
        onRefresh: refresh,
        child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) => const Divider(),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                  padding:  EdgeInsets.only(left: 300, right: 300),
                  child: Container(
                       
                 decoration: BoxDecoration(
                  color:AllData[index]["LastAttendance"] =="${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"? Colors.green.shade100 : ColorName().AppBoxBackgroundColor,
     

                  border: Border.all(
                            width: 2,
                            color:AllData[index]["LastAttendance"] =="${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"? Colors.green.shade100 :  ColorName().AppBoxBackgroundColor
                          ),
                  borderRadius: BorderRadius.circular(10)      
                 ),
      
                    
                    child: Column(
                      children: [



                        ListTile(
                          
                   
                            
                                  title: Text("Roll No:- ${AllData[index]["RollNo"]}", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),

                                  trailing: 
                             Column(
                               children: [






                    

      AllData[index]["LastAttendance"] =="${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"? TextButton(onPressed: () async{


        getTodayAttendanceData(AllData[index]["StudentEmail"],AllData[index]["FineAmount"], context);





      
      
      
      
      
         }, child: Text("Change", style: TextStyle(color: Colors.white, fontSize: 12),), style: ButtonStyle(
                                           
                  backgroundColor: MaterialStatePropertyAll<Color>(ColorName().appColor),
                ),):Text(""),



                               ],
                             ),
                                  
      
      
                                  subtitle: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                     
                                      Text("Name:${AllData[index]["StudentName"].toString().toUpperCase()}"),
                                      Text("Phone Number:${AllData[index]["StudentPhoneNumber"]}"),



                                      Text("Father Phone No: ${AllData[index]["FatherPhoneNo"]}"),


                                      Text("Class: ${AllData[index]["ClassName"]}"),

                                      Text("Department: ${AllData[index]["Department"]}"),

                                      Text("Fine: ${AllData[index]["FineAmount"]} ৳"),

                                     Text("Fine Type: ${AllData[index]["StudentFineType"]}"),

                                      Text("Exam Fee Type: ${AllData[index]["ExamFeeType"]} "),

                                     Text("Exam Fee: ${AllData[index]["ExamFeeAmount"]} ৳"),

    

                                    ],
                                  ),
                            
                            
                            
                                ),





                                 Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                
                   AllData[index]["LastAttendance"] =="${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"?Text(""):TextButton(onPressed: () async{


                    setState(() {
                      loading = true;
                    });




                              
               var updateData ={

                                "LastAttendance":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                                "FineAmount":(double.parse(AllData[index]["FineAmount"]) + 5.0).toString(),
                                "StudentFineType":"Due",

                              };


   final StudentInfo =
    FirebaseFirestore.instance.collection('StudentInfo').doc(AllData[index]["StudentEmail"]);

                              
                          StudentInfo.update(updateData).then((value) => setState(() async{








            final docUser =  FirebaseFirestore.instance.collection("StudentAttendance");

                      final jsonData ={

                        "AttendanceID":AttendanceID,
                        "StudentName":AllData[index]["StudentName"],
                        "StudentEmail":AllData[index]["StudentEmail"],
                        "StudentPhoneNumber":AllData[index]["StudentPhoneNumber"],
                        "StudentRollNo":AllData[index]["RollNo"],
                        "ClassName":AllData[index]["ClassName"],
                        "Date":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                        "month":"${DateTime.now().month}/${DateTime.now().year}",
                        "year":"${DateTime.now().year}",
                        "DateTime":"${DateTime.now().toIso8601String()}",
                        "type":"absence"


                     
                      };




         await docUser.doc(AttendanceID).set(jsonData).then((value) =>  setState(() async{



               getData();



         

              setState(() {
                      loading = false;
                    });


                    })).onError((error, stackTrace) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.green,
                              content: const Text('Success'),
                              action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            )));





                              final snackBar = SnackBar(
                 
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Successfull',
                      message:
                          'Hey Thank You. Good Job',
        
                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                      contentType: ContentType.success,
                    ),
                  );
        
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);



                         setState(() {
                            loading = false;
                          });





                          })).onError((error, stackTrace) => setState((){




                              final snackBar = SnackBar(
                    /// need to set following properties for best effect of awesome_snackbar_content
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Something Wrong!!!!',
                      message:
                          'Try again later...',
        
                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                      contentType: ContentType.failure,
                    ),
                  );
        
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);






                   setState(() {
                            loading = false;
                          });


                          }));

      
      
                                      }, child: Text("Absence", style: TextStyle(color: Colors.white, fontSize: 12),), style: ButtonStyle(
                                       
                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.red.shade400),
                ),),













                SizedBox(height: 2,),



















                   AllData[index]["LastAttendance"] =="${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"?Icon(Icons.check, color: Colors.green,):TextButton(onPressed: () async{



              setState(() {
                      loading = true;
                    });


                              
               var updateData ={

                                "LastAttendance":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"

                              };


   final StudentInfo =
    FirebaseFirestore.instance.collection('StudentInfo').doc(AllData[index]["StudentEmail"]);

                              
                          StudentInfo.update(updateData).then((value) => setState(() async{








            final docUser =  FirebaseFirestore.instance.collection("StudentAttendance");

                      final jsonData ={

                        "AttendanceID":AttendanceID,
                        "StudentName":AllData[index]["StudentName"],
                        "StudentEmail":AllData[index]["StudentEmail"],
                        "StudentPhoneNumber":AllData[index]["StudentPhoneNumber"],
                        "StudentRollNo":AllData[index]["RollNo"],
                        "ClassName":AllData[index]["ClassName"],
                        "Date":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                        "month":"${DateTime.now().month}/${DateTime.now().year}",
                        "year":"${DateTime.now().year}",
                        "DateTime":"${DateTime.now().toIso8601String()}",
                        "type":"presence"


                     
                      };




         await docUser.doc(AttendanceID).set(jsonData).then((value) =>  setState(() async{



               getData();



         
            setState(() {
                      loading = false;
                    });



                    })).onError((error, stackTrace) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.green,
                              content: const Text('Success'),
                              action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            )));





                              final snackBar = SnackBar(
                 
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Successfull',
                      message:
                          'Hey Thank You. Good Job',
        
                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                      contentType: ContentType.success,
                    ),
                  );
        
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);



                         setState(() {
                            loading = false;
                          });





                          })).onError((error, stackTrace) => setState((){




                              final snackBar = SnackBar(
                    /// need to set following properties for best effect of awesome_snackbar_content
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Something Wrong!!!!',
                      message:
                          'Try again later...',
        
                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                      contentType: ContentType.failure,
                    ),
                  );
        
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);






                   setState(() {
                            loading = false;
                          });


                          }));

      
      
                                      }, child: Text("Presence", style: TextStyle(color: Colors.white, fontSize: 12),), style: ButtonStyle(
                                       
                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.green.shade400),
                ),),


                SizedBox(height: 2,),
















                         


             





                                           

                                    ],
                                  ),



                          

                          SizedBox(height: 9,),




              












                      ],
                    ),
                  ),
                );
          },
          itemCount: AllData.length,
        ),
      ),
    );
  }
}







