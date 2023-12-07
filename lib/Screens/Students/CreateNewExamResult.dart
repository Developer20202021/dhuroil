import 'dart:convert';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhuroil/DeveloperAccess/DeveloperAccess.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';












class CreateNewExamResult extends StatefulWidget {



  final StudentClassName;






  const CreateNewExamResult({super.key,required this.StudentClassName });

  @override
  State<CreateNewExamResult> createState() => _CreateNewExamResultState();
}

class _CreateNewExamResultState extends State<CreateNewExamResult> {
  TextEditingController StudentPhoneNumberController = TextEditingController();
  TextEditingController ExamTotalMarksController = TextEditingController();
  TextEditingController FeeNameController = TextEditingController();
  TextEditingController OtherExamNameController = TextEditingController();
  TextEditingController ExamFeeController = TextEditingController();




  var uuid = Uuid();


  bool loading = false;

  String SelectedExamName ="";

  String SelectedYear ="${DateTime.now().year}";
  String SelectedDate ="Select Exam Year and Month";










  Future CreateExam(ExamID, CreatorEmail, CreatorName) async{

    setState(() {
      loading = true;
    });




          final docUser =  FirebaseFirestore.instance.collection("ExamResult");

                      final jsonData ={

                        "ExamResultID":ExamID,
                        "Date":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                        "month":"${DateTime.now().month}/${DateTime.now().year}",
                        "year":"${DateTime.now().year}",
                        "ExamYear":SelectedYear,
                        "ExamDate":SelectedDate,
                        "DateTime":"${DateTime.now().toIso8601String()}",
                        "CreatorEmail":CreatorEmail,
                        "CreatorName":CreatorName,
                        "ExamName":SelectedExamName.toLowerCase(),
                        "ExamTotalMarks":ExamTotalMarksController.text.trim(),
                        "OtherExamName": SelectedExamName=="Other"?OtherExamNameController.text.trim().toLowerCase():"",
                        "ClassName":widget.StudentClassName,
                        "status":"private",
                        "ExamFeeCollectionMode":"open",
                        "ExamFee":ExamFeeController.text.trim().toString(),
                        "ExamStartingDate":SelectedDate

                      };




         await docUser.doc(ExamID).set(jsonData).then((value) =>  setState(() {


                     setState(() {
                        loading = false;
                 
                      });

                        final snackBar = SnackBar(

                                      duration: Duration(seconds: 7),
                                  
                                      elevation: 0,
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.transparent,
                                      content: AwesomeSnackbarContent(
                                        title: 'Exam Create Successfull',
                                        message:
                                            'Exam Create Successfull',
                          // Presence & Absence History
                                        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                        contentType: ContentType.success,
                                      ),
                                    );
                          
                                    ScaffoldMessenger.of(context)
                                      ..hideCurrentSnackBar()
                                      ..showSnackBar(snackBar);







                    })).onError((error, stackTrace) => setState(() {

                      setState(() {
                        loading = false;
                      });


                      print(error);



                      final snackBar = SnackBar(

                                      duration: Duration(seconds: 7),
                                  
                                      elevation: 0,
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.transparent,
                                      content: AwesomeSnackbarContent(
                                        title: 'Something Wrong!!',
                                        message:
                                            'Try again later',
                          // Presence & Absence History
                                        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                        contentType: ContentType.failure,
                                      ),
                                    );
                          
                                    ScaffoldMessenger.of(context)
                                      ..hideCurrentSnackBar()
                                      ..showSnackBar(snackBar);








                    }));





  }













  @override
  Widget build(BuildContext context) {



    var ExamID = uuid.v4();

    FocusNode myFocusNode = new FocusNode();

    // StudentPhoneNumberController.text = widget.StudentPhoneNumber;
  
 

    return Scaffold(
      backgroundColor: Colors.white,

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



      
      appBar: AppBar(
    
    
      systemOverlayStyle: SystemUiOverlayStyle(
            // Navigation bar
            statusBarColor: ColorName().appColor, // Status bar
          ),
       
        iconTheme: IconThemeData(color: Color.fromRGBO(92, 107, 192, 1)),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),
        title:  Text("Class: ${widget.StudentClassName} Create Exam For Result",  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),
      body: SingleChildScrollView(

        child: loading?const Padding(
                padding: EdgeInsets.only(top: 40),
                child: Center(
                      child: CircularProgressIndicator(),
                    ),
              ): Padding(
          padding: const EdgeInsets.only(left: 400, right: 400, top: 60),
          child: 
          
          
          Center(
            child: Container(

                decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                    // width: MediaQuery.of(context).size.width*0.75,
                    


              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                  
                          
                          
                          
                          
                     SizedBox(
                      height: 10,
                    ),
                          
                          
                          
                          
                    
                          
                          
                          
                          
                          
                    
                          
                    Padding(
                       padding: const EdgeInsets.only(left: 18, right: 18, top: 6),
                      child: TextField(
                       enabled: false,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Class: ${widget.StudentClassName}',
                             labelStyle: TextStyle(
                        color: myFocusNode.hasFocus ? Color.fromRGBO(92, 107, 192, 1): Colors.black
                                      ),
                            hintText: 'Class',
                                      
                            //  enabledBorder: OutlineInputBorder(
                            //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                            //     ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                                ),
                            
                            
                            ),
                        controller: FeeNameController,
                      ),
                    ),
                          
                          
                          
                 
                          
                          
                          
                          
                    
                  
                          
                          
                          
                 
                          
                
                  
                  
                  
                




                    Padding(
                      padding: const EdgeInsets.only(left: 18, right: 18, top: 6),
                      child: Container(
                                height: 70,
                                width: 150,
                                child: DropdownButton(
                                 
                                                   
                                 
                                  hint:  SelectedExamName == ""
                                      ? Text('Exam Name')
                                      : Text(
                                         SelectedExamName,
                                          style: TextStyle(color: ColorName().appColor, fontWeight: FontWeight.bold, fontSize: 16),
                                        ),
                                  isExpanded: true,
                                  iconSize: 30.0,
                                  style: TextStyle(color: ColorName().appColor, fontWeight: FontWeight.bold, fontSize: 16),
                                  items: ['১ম সাময়িক', '২য় সাময়িক', '৩য় সাময়িক', "অর্ধ-বার্ষিক","বার্ষিক","ক্লাস টেস্ট","সাপ্তাহিক টেস্ট","নির্বাচনী","প্রাক-নির্বাচনী","মাসিক","দৈনিক টেস্ট"].map(
                                    (val) {
                                      return DropdownMenuItem<String>(
                                        value: val,
                                        child: Text(val),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (val) {
                                    setState(
                                      () {
                                         SelectedExamName = val!;
                                      },
                                    );
                                  },
                                ),
                              ),
                    ),
                          
                          
                          
                          

                     SizedBox(
                      height: 10,
                    ),




                  SelectedExamName=="Other"?  Padding(
                    padding: const EdgeInsets.only(left: 18, right: 18, top: 6),
                    child: TextField(
                       keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Other Exam Name',
                             labelStyle: TextStyle(
                        color: myFocusNode.hasFocus ? Color.fromRGBO(92, 107, 192, 1): Colors.black
                    ),
                            hintText: 'Other Exam Name',
                    
                            //  enabledBorder: OutlineInputBorder(
                            //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                            //     ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                                ),
                            
                            
                            ),
                        controller: OtherExamNameController,
                      ),
                  ):Text(""),
                  
                  
                  
                  
                SizedBox(height: 6,),



                    Padding(
                      padding: const EdgeInsets.only(left: 18, right: 18),
                      child: TextButton(onPressed: (){
                    
                                showDatePicker(
                                  context: context,
                                  
                                  initialDatePickerMode: DatePickerMode.year,
                                  initialDate: DateTime(2000,1,1),
                                  firstDate: DateTime(2000,1,1),
                                  lastDate: DateTime(2090,1,1),
                                ).then((pickedDate) {
                                  print(pickedDate);
                    
                                
                    
                                  setState(() {
                    
                                    SelectedYear = "${pickedDate?.year}";
                                    SelectedDate = "${pickedDate}";
                                    SelectedDate = SelectedDate.split(" ")[0];
                    
                                    print(SelectedYear);
                                    print(SelectedDate.split(" ")[0]);
                    
                                  });
                    
                    
                    
                                  });
                          
                                        }, child: Text("${SelectedDate}", style: TextStyle(color: Colors.white, fontSize: 15),), style: ButtonStyle(
                                         
                                      backgroundColor: MaterialStatePropertyAll<Color>(ColorName().appColor),
                                    ),),
                    ),


 
                          
                          
                 
                          
                          
                          
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: TextField(
                       keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Exam Total Marks',
                             labelStyle: TextStyle(
                        color: myFocusNode.hasFocus ? Color.fromRGBO(92, 107, 192, 1): Colors.black
                                      ),
                            hintText: 'Exam Total Marks',
                                      
                            //  enabledBorder: OutlineInputBorder(
                            //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                            //     ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                                ),
                            
                            
                            ),
                        controller: ExamTotalMarksController,
                      ),
                    ),




                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: TextField(
                       keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Exam Fee',
                             labelStyle: TextStyle(
                        color: myFocusNode.hasFocus ? Color.fromRGBO(92, 107, 192, 1): Colors.black
                                      ),
                            hintText: 'Exam Fee',
                                      
                            //  enabledBorder: OutlineInputBorder(
                            //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                            //     ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                                ),
                            
                            
                            ),
                        controller: ExamFeeController,
                      ),
                    ),
                  
                  
                  
          
                  
                  
                  
                  
                  
                  
                  
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(width: 250, child:TextButton(onPressed: () async{
                            
                            setState(() {
                              loading = true;
                            });
                            
                            
                        // FirebaseAuth.instance
                        //   .authStateChanges()
                        //   .listen((User? user) async{
                        //     if (user == null) {
                            
                        //       print('User is currently signed out!');
                        //     } else {
                            
                            
                            
                        //   CreateExam(ExamID, user.email, user.displayName);
                            
                        //     }
                            
                        //   });



                        CreateExam(ExamID, "mahadi", "mahadi Hasan");
                            
                            
                            
                            
                            
                            
                          }, child: Text("Create Exam For Result", style: TextStyle(color: Colors.white),), style: ButtonStyle(
                           
                                    backgroundColor: MaterialStatePropertyAll<Color>(Color.fromRGBO(92, 107, 192, 1)),
                        ),),),
                            
                            
                            
                      
                            
                            
                            
                            
                        ],
                      ),
                    )
                  
                  
                  
                  ],
                ),
              ),
            ),
          ),
        ),
        ),
      
      
    );
  }
}