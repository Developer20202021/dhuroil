import 'dart:convert';

import 'package:dhuroil/DeveloperAccess/DeveloperAccess.dart';
import 'package:dhuroil/Screens/Students/Pay/ExamFeePay.dart';
import 'package:dhuroil/Screens/Students/Pay/MonthlyFee.dart';
import 'package:dhuroil/Screens/Students/Pay/OthersFeePay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';






class AllPay extends StatefulWidget {

  final StudentEmail;
  final StudentPhoneNumber;
  final StudentName;
  final ExamFee;
  final FatherPhoneNo;
  final StudentRollNo;
  final ExamName;
  final ExamDate;
  final ClassName;
  final ExamStarttingDate;
  final ExamResultID;
  final TotalExamFeeCollection;



  const AllPay({super.key, required this.ExamFee, required this.StudentEmail, required this.StudentName, required this.StudentPhoneNumber, required this.FatherPhoneNo, required this.StudentRollNo, required this.ExamName, required this.ExamDate, required this.ClassName, required this.ExamStarttingDate, required this.ExamResultID, required this.TotalExamFeeCollection});

  @override
  State<AllPay> createState() => _AllPayState();
}

class _AllPayState extends State<AllPay> {

  bool loading = false;














  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      appBar: AppBar(

      systemOverlayStyle: SystemUiOverlayStyle(
            // Navigation bar
            statusBarColor: ColorName().appColor, // Status bar
          ),
       
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),
        title: const Text("All Pay",  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),
      body: loading?Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Center(
                      child: LoadingAnimationWidget.discreteCircle(
                        color: const Color(0xFF1A1A3F),
                        secondRingColor:  Theme.of(context).primaryColor,
                        thirdRingColor: Colors.white,
                        size: 100,
                      ),
                    ),
              ):SingleChildScrollView(child: Center(
        child: Column(
      
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
      
      
          children: [



      







  SizedBox(height: 30,),




                       Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                  width: MediaQuery.of(context).size.width*0.75,
                  height: 200,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Column(
                        children: [
                          Text("Exam Fee", style: TextStyle(
                    // ${moneyAdd.toString()}
                            fontSize: 20,
                            color:Colors.white,
                            overflow: TextOverflow.clip
                           
                          ),),
                    

                             SizedBox(
                                    height: 17,
                                   ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Row(
                                              
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                
                                
                                children: [
                                              
                                              
                                          widget.ExamName!=""?  Container(width: 170, child:TextButton(onPressed: (){
                
                
                   Navigator.of(context).push(MaterialPageRoute(builder: (context) =>ExamFeePay(ExamFee: widget.ExamFee, StudentEmail: widget.StudentEmail, StudentName: widget.StudentName, StudentPhoneNumber: widget.StudentPhoneNumber, FatherPhoneNo: widget.FatherPhoneNo, StudentRollNo: widget.StudentRollNo, ExamName: widget.ExamName, ExamDate: widget.ExamDate, ClassName: widget.ClassName, ExamStarttingDate: widget.ExamStarttingDate, ExamResultID: widget.ExamResultID, TotalExamFeeCollection: widget.TotalExamFeeCollection,)));
                
                
                
                
                
                
                
                                            }, child: Text("Exam Fee", style: TextStyle(color: ColorName().appColor),), style: ButtonStyle(
                                 
                                            backgroundColor: MaterialStatePropertyAll<Color>(Colors.white),
                                          ),),):Text(""),

                                ],),
                            )
                    

                        ],
                      ),
                    ),
                
                
                  ),
                       
                 decoration: BoxDecoration(

                     boxShadow: [
                      BoxShadow(
                        color: Colors.white70,
                        blurRadius: 20.0,
                      ),
                    ],
                  color: ColorName().appColor,
                
                  border: Border.all(
                            width: 2,
                            color: ColorName().appColor
                          ),
                  borderRadius: BorderRadius.circular(10)      
                 ),)),






 SizedBox(height: 30,),




                       Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                  width: MediaQuery.of(context).size.width*0.75,
                  height: 200,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Column(
                        children: [
                          Text("Others Fee", style: TextStyle(
                    // ${moneyAdd.toString()}
                            fontSize: 20,
                            color:Colors.white,
                            overflow: TextOverflow.clip
                           
                          ),),
                    

                             SizedBox(
                                    height: 17,
                                   ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Row(
                                              
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                
                                
                                children: [
                                              
                                              
                                            Container(width: 170, child:TextButton(onPressed: (){
                
                
                   Navigator.of(context).push(MaterialPageRoute(builder: (context) =>OthersFeePay(ExamFee: widget.ExamFee, StudentEmail: widget.StudentEmail, StudentName: widget.StudentName, StudentPhoneNumber: widget.StudentPhoneNumber, FatherPhoneNo: widget.FatherPhoneNo, StudentRollNo: widget.StudentRollNo, ExamName: widget.ExamName, ExamDate: widget.ExamDate, ClassName: widget.ClassName, ExamStarttingDate: widget.ExamStarttingDate,)));
                
                
                
                
                
                
                
                                            }, child: Text("Others Fee", style: TextStyle(color: ColorName().appColor),), style: ButtonStyle(
                                 
                                            backgroundColor: MaterialStatePropertyAll<Color>(Colors.white),
                                          ),),),

                                ],),
                            )
                    

                        ],
                      ),
                    ),
                
                
                  ),
                       
                 decoration: BoxDecoration(

                     boxShadow: [
                      BoxShadow(
                        color: Colors.white70,
                        blurRadius: 20.0,
                      ),
                    ],
                  color: ColorName().appColor,
                
                  border: Border.all(
                            width: 2,
                            color: ColorName().appColor
                          ),
                  borderRadius: BorderRadius.circular(10)      
                 ),)),





            


            
  SizedBox(height: 30,),




               Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                  width: MediaQuery.of(context).size.width*0.75,
                  height: 200,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Column(
                        children: [
                          Text("Monthly Fee", style: TextStyle(
                    // ${moneyAdd.toString()}
                            fontSize: 20,
                            color:Colors.white,
                            overflow: TextOverflow.clip
                           
                          ),),
                    

                             SizedBox(
                                    height: 17,
                                   ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Row(
                                              
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                
                                
                                children: [
                                              
                                              
                                            Container(width: 170, child:TextButton(onPressed: (){
                
                
                
                                              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>MonthlyFee(ExamFee: widget.ExamFee, StudentEmail: widget.StudentEmail, StudentName: widget.StudentName, StudentPhoneNumber: widget.StudentPhoneNumber, FatherPhoneNo: widget.FatherPhoneNo, StudentRollNo: widget.StudentRollNo, ExamName: widget.ExamName, ExamDate: widget.ExamDate, ClassName: widget.ClassName, ExamStarttingDate: widget.ExamStarttingDate,)));
                
                
                
                
                
                
                
                                            }, child: Text("Monthly Fee", style: TextStyle(color: const Color.fromARGB(255,12, 53, 106)),), style: ButtonStyle(
                                 
                                            backgroundColor: MaterialStatePropertyAll<Color>(Colors.white),
                                          ),),),

                                ],),
                            )
                    

                        ],
                      ),
                    ),
                
                
                  ),
                       
                 decoration: BoxDecoration(

                     boxShadow: [
                      BoxShadow(
                        color: Colors.white70,
                        blurRadius: 20.0,
                      ),
                    ],
                  color: Color.fromARGB(255,12, 53, 106),
                
                  border: Border.all(
                            width: 2,
                            color:Color.fromARGB(255,12, 53, 106)
                          ),
                  borderRadius: BorderRadius.circular(10)      
                 ),)),
      

      

      SizedBox(height: 30,),




                      





      
      
          ],
      
      
      
      
      
      
        ),
      )));

  }
}