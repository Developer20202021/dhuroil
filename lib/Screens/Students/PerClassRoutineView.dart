import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhuroil/DeveloperAccess/DeveloperAccess.dart';
import 'package:dhuroil/Screens/Students/ShowAttendance.dart';
import 'package:dhuroil/Screens/Teachers/Attendance/AllTeacherAttendance.dart';
import 'package:dhuroil/Screens/Teachers/EditTeacher.dart';
import 'package:dhuroil/Screens/Teachers/ShowAttendance.dart';
import 'package:dhuroil/Screens/Teachers/TeacherProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';
import 'package:weekday_selector/weekday_selector.dart';



class PerClassRoutine extends StatefulWidget {

  final indexNumber ;
  final ClassName;







  const PerClassRoutine({super.key, required this.indexNumber,required this.ClassName});

  @override
  State<PerClassRoutine> createState() => _PerClassRoutineState();
}

class _PerClassRoutineState extends State<PerClassRoutine> {




TextEditingController TeacherSubjectNameController = TextEditingController();

TextEditingController TeacherSMSController = TextEditingController();




bool loading = false;

var DataLoad = "";


 final values = List.filled(7, false);




 



// Firebase All Customer Data Load

List  AllData = [];













Future<void> getData() async {
    // Get docs from collection reference
      CollectionReference _CustomerOrderHistoryCollectionRef =
    FirebaseFirestore.instance.collection('TeacherRoutine');

  // // all Due Query Count
     Query _CustomerOrderHistoryCollectionRefDueQueryCount = _CustomerOrderHistoryCollectionRef.where("ClassName", isEqualTo: widget.ClassName);

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


      
  // getData();

    });




  }









  @override
  Widget build(BuildContext context) {

 FocusNode myFocusNode = new FocusNode();






    double width = MediaQuery.of(context).size.width;

    double height = MediaQuery.of(context).size.height;
   




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
      appBar: AppBar(

    
    
      systemOverlayStyle: SystemUiOverlayStyle(
            // Navigation bar
            statusBarColor: ColorName().appColor, // Status bar
          ),
       
        iconTheme: IconThemeData(color: Color.fromRGBO(92, 107, 192, 1)),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),
        title: Text("Routine",  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),
      body:loading?Center(child: CircularProgressIndicator()): DataLoad == "0"? Center(child: Text("No Data Available")): RefreshIndicator(
        onRefresh: refresh,
        child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) => SizedBox(height: 20,),
          itemBuilder: (BuildContext context, int index) {
            return Padding(

                  padding:  EdgeInsets.only(left:308.0, right: 308, bottom: 10),
                  child: Container(
                  
                 decoration: BoxDecoration(
                  color: Colors.grey.shade300,
     

                  border: Border.all(
                            width: 2,
                            color: Colors.grey.shade300
                          ),
                  borderRadius: BorderRadius.circular(10)      
                 ),
      
                    
                    child: Column(
                      children: [



                        ListTile(

                          trailing: 
                              PopupMenuButton(
                                onSelected: (value) {
                                  // your logic
                                },
                                itemBuilder: (BuildContext bc) {
                                  return [
                            

              //                       PopupMenuItem(
              //                         child: Text("Edit Routine"),
              //                         value: '/hello',
              //                         onTap: () async{





              //   showDialog(
              //       context: context,
              //       builder: (context) {
              //       String SelectedClassName ="";

              //       String SelectDay ="";

              //       String SelectClassStartTime ="Select Start Time";

              //       String SelectClassEndTime ="Select End Time";

              //       double ClassStartTimeSeconds =0.0;

              //       double ClassEndTimeSeconds =0.0;


                    



              //         return StatefulBuilder(
              //         builder: (context, setState) {
              //           return AlertDialog(
              //           title: Text("Edit Routine"),
              //           content:  Container(
              //                                 width: 400,
              //                                 height: 330,
              //                                 child: Column(
              //                                   children: [


              //                         DropdownButton(
                                                  
                                                                    
                                                  
              //                                       hint:  SelectedClassName == ""
              //                                           ? Text('Select Class')
              //                                           : Text(
              //                                             "Class: ${SelectedClassName}",
              //                                               style: TextStyle(color: ColorName().appColor, fontWeight: FontWeight.bold, fontSize: 16),
              //                                             ),
              //                                       isExpanded: true,
              //                                       iconSize: 30.0,
              //                                       style: TextStyle(color: ColorName().appColor, fontWeight: FontWeight.bold, fontSize: 16),
              //                                       items: ["0",'1', '2', '3', "4","5","6","7","8", "9","10", "ssc"].map(
              //                                         (val) {
              //                                           return DropdownMenuItem<String>(
              //                                             value: val,
              //                                             child: Text(val),
              //                                           );
              //                                         },
              //                                       ).toList(),
              //                                       onChanged: (val) {
              //                                         setState(
              //                                           () {
              //                                             SelectedClassName = val!;

              //                                             print(val);
              //                                           },
              //                                         );
              //                                       },
              //                                     ),


              //        SizedBox(
              //         height: 20,
              //       ),



              //      TextField(

              //         decoration: InputDecoration(
              //             border: OutlineInputBorder(),
              //             labelText: 'Enter Subject Name',
              //              labelStyle: TextStyle(
              // color: myFocusNode.hasFocus ? Theme.of(context).primaryColor: Colors.black
              //     ),
              //             hintText: 'Enter Subject Name',
              //             //  enabledBorder: OutlineInputBorder(
              //             //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
              //             //   ),
              //               focusedBorder: OutlineInputBorder(
              //                 borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
              //               ),
              //               errorBorder: OutlineInputBorder(
              //                 borderSide: BorderSide(
              //                     width: 3, color: Color.fromARGB(255, 66, 125, 145)),
              //               ),
                          
                          
              //             ),
              //         controller: TeacherSubjectNameController,
              //       ),
            
              //       SizedBox(
              //         height: 20,
              //       ),




              //     Text("যে Day গুলোতে ক্লাস থাকবে তা Select করুন"),
                  

              //       WeekdaySelector(
              //           selectedSplashColor: Colors.green,
              //           onChanged: (int day) {
              //             setState(() {
              //               // Use module % 7 as Sunday's index in the array is 0 and
              //               // DateTime.sunday constant integer value is 7.
              //               final index = day % 7;
                    
              //               print(day);
              //               // We "flip" the value in this example, but you may also
              //               // perform validation, a DB write, an HTTP call or anything
              //               // else before you actually flip the value,
              //               // it's up to your app's needs.
              //               values[index] = !values[index];
              //             });
              //           },
              //           values: values,
              //         ),



              //   SizedBox(
              //         height: 30,
              //       ),



              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [


              //           Container(width: 150, child:TextButton(onPressed: () async{


              //             showTimePicker(
              //                           context: context,
              //                           initialTime: TimeOfDay(hour: 7, minute: 15),

              //                         ).then((value) => setState((){
                                        
              //                           print("${value?.hour}:${value?.minute} ${value?.period.toString().split('.')[1]}");




              //                            DateTime tempDate = DateFormat("hh:mm").parse(
              //                                 value!.hour.toString() +
              //                                     ":" + value!.minute.toString());
              //                             var dateFormat = DateFormat("h:mm a"); // you can change the format here
              //                             print(dateFormat.format(tempDate));


              //                             String FormateTime = dateFormat.format(tempDate);

              //                             String SplitTime = FormateTime.split(" ")[0];

                                          
              //                             double SplitTimehour = double.parse(SplitTime.split(":")[0]);

              //                             double SplitTimeMinute = double.parse(SplitTime.split(":")[1]);


              //                             double SplitTimeSeconds = (SplitTimehour*60 + SplitTimeMinute)*60;

                                          
                                          



              //                             setState((){

              //                               SelectClassStartTime = dateFormat.format(tempDate);

              //                               ClassStartTimeSeconds = SplitTimeSeconds;

              //                             });

    
              //                         }));




              //           }, child: Text("${SelectClassStartTime}", style: TextStyle(color: Colors.white),), style: ButtonStyle(
                         
              //   backgroundColor: MaterialStatePropertyAll<Color>(Theme.of(context).primaryColor),
              // ),),),




              //  Container(width: 150, child:TextButton(onPressed: () async{



              //                 showTimePicker(
              //                           context: context,
              //                           initialTime: TimeOfDay(hour: 7, minute: 15),

              //                         ).then((value) => setState((){
                                        
              //                           print("${value?.hour}:${value?.minute} ${value?.period.toString().split('.')[1]}");




              //                            DateTime tempDate = DateFormat("hh:mm").parse(
              //                                 value!.hour.toString() +
              //                                     ":" + value!.minute.toString());
              //                             var dateFormat = DateFormat("h:mm a"); // you can change the format here
              //                             print(dateFormat.format(tempDate));


                                          
              //                             String FormateTime = dateFormat.format(tempDate);

              //                             String SplitTime = FormateTime.split(" ")[0];

                                          
              //                             double SplitTimehour = double.parse(SplitTime.split(":")[0]);

              //                             double SplitTimeMinute = double.parse(SplitTime.split(":")[1]);


              //                             double SplitTimeSeconds = (SplitTimehour*60 + SplitTimeMinute)*60;



              //                             setState((){

              //                               SelectClassEndTime = dateFormat.format(tempDate);


              //                               ClassEndTimeSeconds = SplitTimeSeconds;
              //                             });

    
              //                         }));




              //           }, child: Text("${SelectClassEndTime}", style: TextStyle(color: Colors.white),), style: ButtonStyle(
                         
              //   backgroundColor: MaterialStatePropertyAll<Color>(Theme.of(context).primaryColor),
              // ),),),



              //         ],
              //       ),









            
              //       SizedBox(
              //         height: 10,
              //       ),




            
              //                                   ],
              //                                 ),
              //                               ),


              //           actions: <Widget>[

              //             TextButton(
              //               onPressed: (){


              //                 double DurationTime = (ClassStartTimeSeconds - ClassEndTimeSeconds)/60;

              //                 print("${DurationTime} min");



              //               },
              //               child: Text("Create"),
              //             ),
                          



              //             TextButton(
              //               onPressed: () => Navigator.pop(context),
              //               child: Text("Cancel"),
              //             ),


                          



              //             ],
              //           );
              //         },
              //       );
              //       },
              //     );


              //                         },
              //                       ),

                             
                                    PopupMenuItem(
                                      child: Text("Send SMS"),
                                      value: '/contact',
                                      onTap: () {

                                        showDialog(
                    context: context,
                    builder: (context) {
                    String SelectedClassName ="";
                    

                    TeacherSMSController.text ="Dear Sir,আপনার Class ${AllData[index]["ClassName"]} এ ${AllData[index]["ClassStartTime"]} Time এ একটা ক্লাস আছে। Thank You";

                      return StatefulBuilder(
                      builder: (context, setState) {
                        return AlertDialog(
                        title: Text("Send SMS"),
                        content:  Container(
                                              height: 200,
                                              child: Column(
                                                children: [



                   TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter Message',
                           labelStyle: TextStyle(
              color: myFocusNode.hasFocus ? Theme.of(context).primaryColor: Colors.black
                  ),
                          hintText: 'Enter Your Message',
                          //  enabledBorder: OutlineInputBorder(
                          //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                          //   ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                            ),
                          
                          
                          ),
                      controller: TeacherSMSController,
                    ),
            
                    SizedBox(
                      height: 10,
                    ),
            
            
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(width: 150, child:TextButton(onPressed: () async{


                            setState(() {
                              loading = true;
                            });


                            String StudentPhoneNumber="";




                          Future SendSMSToCustomer(context, msg) async {


                            final response = await http
                                .get(Uri.parse('https://api.greenweb.com.bd/api.php?token=1024519252916991043295858a1b3ac3cb09ae52385b1489dff95&to=${StudentPhoneNumber}&message=${msg}'));

                                    Navigator.pop(context);

                            if (response.statusCode == 200) {
                              // If the server did return a 200 OK response,
                              // then parse the JSON.

                              final snackBar = SnackBar(
                                        elevation: 0,
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.transparent,
                                        content: AwesomeSnackbarContent(
                                        title: 'Teacher message send Successfull',
                                        message: 'Hey Thank You. Good Job',

                          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                        contentType: ContentType.success,
                                                ),
                                            );

                    ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(snackBar);
                             
                              setState(() {
                                // msgSend = "success";
                                loading = false;
                              });
                            
                            } else {

                               setState(() {
                                // msgSend = "fail";
                                loading = false;
                              });
                              // If the server did not return a 200 OK response,
                              // then throw an exception.
                              throw Exception('Failed to load album');
                            }
                          }


                          SendSMSToCustomer(context,TeacherSubjectNameController.text);



                        }, child: Text("Send", style: TextStyle(color: Colors.white),), style: ButtonStyle(
                         
                backgroundColor: MaterialStatePropertyAll<Color>(Theme.of(context).primaryColor),
              ),),),



                    




                      ],
                    )
            
            
                                                ],
                                              ),
                                            ),


                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("Cancel"),
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

                            
                          
                   
                            
                                  title: Text("S No:- ${index+1}", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),

                                
      
      
                                  subtitle: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                     
                                      Text("Name:${AllData[index]["TeacherName"].toString().toUpperCase()}"),
                                      Text("Phone Number:${AllData[index]["TeacherPhoneNo"]}"),

                                      Text("Email: ${AllData[index]["TeacherEmail"]}"),
                                      Text("Class: ${AllData[index]["ClassName"]}"),

                                     Text("Subject: ${AllData[index]["SubjectName"]}"),

                                     Text("Start: ${AllData[index]["ClassStartTime"]}"),

                                     Text("End: ${AllData[index]["ClassEndTime"]}"),

                                     Text("Duration:${AllData[index]["duration"]} min"),

                                    
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                    
                                    Text("ক্লাস নিবেন: "),

                                    AllData[index]["days"][0]?const Text("রবিবার,"):const Text(""),


                                    AllData[index]["days"][1]?const Text("সোমবার,"):const Text(""),


                                    AllData[index]["days"][2]?const Text("মংগলবার,"):const Text(""),

                                    AllData[index]["days"][3]?const Text("বুধবার,"):const Text(""),


                                    AllData[index]["days"][4]?const Text("বৃহস্পতিবার,"):const Text(""),


                                    AllData[index]["days"][5]?const Text("শুক্রবার,"):const Text(""),

                                    AllData[index]["days"][6]?const Text("শনিবার,"):const Text("")


                                      ],
                                    )


                                    ],
                                  ),
                            
                            
                            
                                ),





                                 Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                             








                SizedBox(height: 2,),



                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(onPressed: ()async{
                
                
                
                
                
                
                     AwesomeDialog(
                              showCloseIcon: true,
                             width: MediaQuery.of(context).size.width*0.4,
                            context: context,
                            dialogType: DialogType.question,
                            animType: AnimType.rightSlide,
                            title: 'Are You Sure?',
                            desc: 'আপনি কি এই Teacher এর Routine Delete করতে চান?যদি হ্যা হয় তবে Ok button press করুন। না হলে Cancel button press করুন।',
                          
                            btnOkOnPress: () async{
                
                
                
                setState(() {
                
                            loading = true;
                            
                          },);
                                                
                          CollectionReference collectionRef =
                          FirebaseFirestore.instance.collection('TeacherRoutine');
                              collectionRef.doc(AllData[index]["RoutineID"]).delete().then(
                                      (doc) => setState((){
                
                
                                            getData();
                
                
                                          Navigator.pop(context);
                
                
                
                
                
                                      final snackBar = SnackBar(
                                    
                                        elevation: 0,
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.transparent,
                                        content: AwesomeSnackbarContent(
                                          title: 'Delete Successfull',
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
                
                
                
                
                                      }),
                                      onError: (e) => setState((){
                
                
                                      
                
                
                                          Navigator.pop(context);
                
                
                
                
                
                                                  final snackBar = SnackBar(
                                    
                                        elevation: 0,
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.transparent,
                                        content: AwesomeSnackbarContent(
                                          title: 'Something Wrong!!!',
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
                
                
                
                
                
                                      }),
                                    );
                      
                      
                      
                      
                      
                
                
                          
                            },
                
                            btnCancelOnPress: () {
                
                
                          
                            },
                          ).show();
                
                
                                        }, child: Text("Delete", style: TextStyle(color: Colors.white, fontSize: 12),), style: ButtonStyle(
                                         
                    backgroundColor: MaterialStatePropertyAll<Color>(Colors.red.shade400),
                  ),),
                ),


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