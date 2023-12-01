
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



class AllTeachers extends StatefulWidget {

  final indexNumber ;






  const AllTeachers({super.key, required this.indexNumber,});

  @override
  State<AllTeachers> createState() => _AllTeachersState();
}

class _AllTeachersState extends State<AllTeachers> {




TextEditingController StudentSendController = TextEditingController();


bool loading = false;

var DataLoad = "";

 



// Firebase All Customer Data Load

List  AllData = [
  
  {
  "TeacherName":"Mahadi Hasan"
},


  {
  "TeacherName":"Mahadi Hasan"
},

  {
  "TeacherName":"Mahadi Hasan"
},


];













Future<void> getData() async {
    // Get docs from collection reference
      CollectionReference _CustomerOrderHistoryCollectionRef =
    FirebaseFirestore.instance.collection('TeacherInfo');

  // // all Due Query Count
  //    Query _CustomerOrderHistoryCollectionRefDueQueryCount = _CustomerOrderHistoryCollectionRef.where("Department", isEqualTo: widget.DepartmentName).where("Semister", isEqualTo: widget.SemisterName).where("StudentStatus", isEqualTo: "new");

     QuerySnapshot queryDueSnapshot = await _CustomerOrderHistoryCollectionRef.get();

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
    // setState(() {
    //   loading = true;
    // });
   
    // getData();
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
        title: const Text("All Teachers",  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),),
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

                  padding:  EdgeInsets.only(left:208.0, right: 208, bottom: 10),
                  child: Container(
                  
                 decoration: BoxDecoration(
                  color: ColorName().AppBoxBackgroundColor,
     

                  border: Border.all(
                            width: 2,
                            color: ColorName().AppBoxBackgroundColor
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
                                    PopupMenuItem(
                                      child: Text("Give Attendance"),
                                      value: '/hello',
                                      onTap: () {

                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllTeacherAttendance(indexNumber: "", DepartmentName: "", SemisterName: "",)));
                                        
                                      },
                                    ),

                                    PopupMenuItem(
                                      child: Text("Show Attendance"),
                                      value: '/hello',
                                      onTap: () {

                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>ShowTeacherAttendance(StudentEmail: "")));
                                        
                                      },
                                    ),

                                    PopupMenuItem(
                                      child: Text("Set Routine"),
                                      value: '/hello',
                                      onTap: () {
                                        showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay(hour: 7, minute: 15),

                                      ).then((value) => setState((){
                                        
                                        print("${value?.hour}:${value?.minute} ${value?.period.toString().split('.')[1]}");




                                         DateTime tempDate = DateFormat("hh:mm").parse(
                                              value!.hour.toString() +
                                                  ":" + value!.minute.toString());
                                          var dateFormat = DateFormat("h:mm a"); // you can change the format here
                                          print(dateFormat.format(tempDate));

    
                                      }));
                                      },
                                    ),

                                    PopupMenuItem(
                                      child: Text("View Routine"),
                                      value: '/about',
                                    ),
                                    PopupMenuItem(
                                      child: Text("Send SMS"),
                                      value: '/contact',
                                      onTap: () {

                                        showDialog(
                    context: context,
                    builder: (context) {
                    String SelectedStudentStatus ="";
                    



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
                      controller: StudentSendController,
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
                              print(jsonDecode(response.body));
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


                          SendSMSToCustomer(context,StudentSendController.text);



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

                                    PopupMenuItem(
                                      child: Text("Set Work"),
                                      value: '/contact',
                                    ),

                                    PopupMenuItem(
                                      child: Text("Set Guide Teacher"),
                                      value: '/contact',
                                    ),

                                    PopupMenuItem(
                                      child: Text("Total Payment Receive"),
                                      value: '/contact',
                                    ),

                                    PopupMenuItem(
                                      child: Text("Edit"),
                                      value: '/contact',
                                      onTap: () {

                                         Navigator.of(context).push(MaterialPageRoute(builder: (context) =>EditTeacher(TeacherEmail: "", DepartmentName: "", SubjectName: "", TeacherAddress: "", TeacherName: "", TeacherPhoneNumber: "")));
                                        
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
                                      Text("Phone Number:${AllData[index]["TeacherPhoneNumber"]}"),

                                      Text("Email: ${AllData[index]["TeacherEmail"]}"),
                                      Text("Address: ${AllData[index]["TeacherAddress"]}"),

                                      Text("Department: ${AllData[index]["Department"]}"),

                                     Text("Subject: ${AllData[index]["SubjectName"]}"),


                                    ],
                                  ),
                            
                            
                            
                                ),





                                 Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      TextButton(onPressed: (){
      
      
                                              
      
      
                                       
                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllPay(StudentDueAmount: AllData[index]["DueAmount"], StudentEmail: AllData[index]["StudentEmail"], StudentName: AllData[index]["StudentName"], StudentPhoneNumber: AllData[index]["StudentPhoneNumber"], FatherPhoneNo: AllData[index]["FatherPhoneNo"])));
      
      
      
      
      
                                      }, child: Text("Pay", style: TextStyle(color: Colors.white, fontSize: 12),), style: ButtonStyle(
                                       
                  backgroundColor: MaterialStatePropertyAll<Color>(ColorName().appColor),
                ),),


                SizedBox(height: 2,),




                             TextButton(onPressed: (){




                               Navigator.of(context).push(MaterialPageRoute(builder: (context) => TeacherProfile(TeacherEmail:  AllData[index]["TeacherEmail"])));

      
      
      
      
      
                                      }, child: Text("Profile", style: TextStyle(color: Colors.white, fontSize: 12),), style: ButtonStyle(
                                       
                  backgroundColor: MaterialStatePropertyAll<Color>(ColorName().appColor),
                ),),


                SizedBox(height: 2,),



                    TextButton(onPressed: (){




                              //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ShowTeacherAttendance(TeacherEmail: AllData[index]["TeacherEmail"])));

      
      
      
      
      
                                      }, child: Text("Show A/p", style: TextStyle(color: Colors.white, fontSize: 12),), style: ButtonStyle(
                                       
                  backgroundColor: MaterialStatePropertyAll<Color>(ColorName().appColor),
                ),),


                SizedBox(height: 2,),












                            TextButton(onPressed: () async{





                        


      AwesomeDialog(
        width: MediaQuery.of(context).size.width*0.4,
          showCloseIcon: true,
            context: context,
            dialogType: DialogType.question,
            animType: AnimType.rightSlide,
            title: 'Are You Sure?',
            desc: 'আপনি কি এই Teacher কে পুরাতন Teacher এর তালিকায় দিতে চান?যদি হ্যা হয় তবে Ok button press করুন। না হলে Cancel button press করুন।',
          
            btnOkOnPress: () async{




               var updateData ={

                                "TeacherStatus":"old"

                              };


   final StudentInfo =
    FirebaseFirestore.instance.collection('TeacherInfo').doc(AllData[index]["TeacherEmail"]);

                              
                          StudentInfo.update(updateData).then((value) => setState((){




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
      
      
      
      
      


          
            },

            btnCancelOnPress: () {


          
            },
          ).show();




                             
      
                                      }, child: Text("old", style: TextStyle(color: Colors.white, fontSize: 12),), style: ButtonStyle(
                                       
                  backgroundColor: MaterialStatePropertyAll<Color>(ColorName().appColor),
                ),),


                SizedBox(height: 2,),



                             AllData[index]["AdminApprove"]=="false"?            TextButton(onPressed: ()async{









                              
      AwesomeDialog(
         width: MediaQuery.of(context).size.width*0.4,
            context: context,
            dialogType: DialogType.question,
            animType: AnimType.rightSlide,
            title: 'Are You Sure?',
            desc: 'আপনি কি এই Teacher কে Approve করতে চান?যদি হ্যা হয় তবে Ok button press করুন। না হলে Cancel button press করুন।',
          
            btnOkOnPress: () async{




               var updateData ={

                                "AdminApprove":"true"

                              };


   final StudentInfo =
    FirebaseFirestore.instance.collection('TeacherInfo').doc(AllData[index]["TeacherEmail"]);

                              
                          StudentInfo.update(updateData).then((value) => setState((){




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
                          getData();
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
      
      
      
      
      


          
            },

            btnCancelOnPress: () {


          
            },
          ).show();










      
     
      
      
                                      }, child: Text("Enable", style: TextStyle(color: Colors.white, fontSize: 12),), style: ButtonStyle(
                                       
                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.green.shade400),
                ),):TextButton(onPressed: ()async{






                   AwesomeDialog(
              showCloseIcon: true,
             width: MediaQuery.of(context).size.width*0.4,
            context: context,
            dialogType: DialogType.question,
            animType: AnimType.rightSlide,
            title: 'Are You Sure?',
            desc: 'আপনি কি এই Teacher কে  Disable করতে চান?যদি হ্যা হয় তবে Ok button press করুন। না হলে Cancel button press করুন।',
          
            btnOkOnPress: () async{




               var updateData ={

                                "AdminApprove":"false"

                              };


   final StudentInfo =
    FirebaseFirestore.instance.collection('TeacherInfo').doc(AllData[index]["TeacherEmail"]);

                              
                          StudentInfo.update(updateData).then((value) => setState((){




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
                          getData();
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
      
      
      
      
      


          
            },

            btnCancelOnPress: () {


          
            },
          ).show();










      



















      
     
      
      
                                      }, child: Text("Disable", style: TextStyle(color: Colors.white, fontSize: 12),), style: ButtonStyle(
                                       
                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.red.shade400),
                ),),


                SizedBox(height: 2,),





                                           

                                    ],
                                  ),



                          

                          SizedBox(height: 9,),




                //           Row(

                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             children: [
                //                 TextButton(onPressed: (){
      
      
                                              
      
      
                                       
                //   // Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaymentAdd(SalePrice: AllData[index]["TotalFoodPrice"], CustomerPhoneNumber: AllData[index]["CustomerPhoneNumber"], OrderID: AllData[index]["OrderID"], CustomerID: getCustomerID[0]["CustomerID"])));
      
      
      
      
      
                //                       }, child: Text("Attandance", style: TextStyle(color: Colors.white, fontSize: 12),), style: ButtonStyle(
                                       
                //   backgroundColor: MaterialStatePropertyAll<Color>(ColorName().appColor),
                // ),),


                // SizedBox(height: 2,),





                //                              TextButton(onPressed: (){
      
      
                                              
      
      
                                       
                //   // Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaymentAdd(SalePrice: AllData[index]["TotalFoodPrice"], CustomerPhoneNumber: AllData[index]["CustomerPhoneNumber"], OrderID: AllData[index]["OrderID"], CustomerID: getCustomerID[0]["CustomerID"])));
      
      
      
      
      
                //                       }, child: Text("Old", style: TextStyle(color: Colors.white, fontSize: 12),), style: ButtonStyle(
                                       
                //   backgroundColor: MaterialStatePropertyAll<Color>(ColorName().appColor),
                // ),),


                // SizedBox(height: 2,),





                
                //                  AllData[index]["AdminApprove"]=="false"?            TextButton(onPressed: (){
      
     
      
      
                //                       }, child: Text("Enable", style: TextStyle(color: Colors.white, fontSize: 12),), style: ButtonStyle(
                                       
                //   backgroundColor: MaterialStatePropertyAll<Color>(ColorName().appColor),
                // ),):TextButton(onPressed: (){
      
     
      
      
                //                       }, child: Text("Disable", style: TextStyle(color: Colors.white, fontSize: 12),), style: ButtonStyle(
                                       
                //   backgroundColor: MaterialStatePropertyAll<Color>(ColorName().appColor),
                // ),),


                // SizedBox(height: 2,),






                //             ],
                //           )












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