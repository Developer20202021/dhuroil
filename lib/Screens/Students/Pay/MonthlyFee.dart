import 'dart:convert';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhuroil/DeveloperAccess/DeveloperAccess.dart';
import 'package:dhuroil/Screens/Students/Pay/AdmitCardInvoice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';












class MonthlyFee extends StatefulWidget {

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





  const MonthlyFee({super.key, required this.ExamFee, required this.StudentEmail, required this.StudentName, required this.StudentPhoneNumber, required this.FatherPhoneNo, required this.StudentRollNo, required this.ExamName, required this.ExamDate,required this.ClassName, required this.ExamStarttingDate});

  @override
  State<MonthlyFee> createState() => _MonthlyFeeState();
}

class _MonthlyFeeState extends State<MonthlyFee> {
  TextEditingController StudentPhoneNumberController = TextEditingController();
  TextEditingController PaymentController = TextEditingController();




    var uuid = Uuid();


  bool loading = false;

  var ServerMsg = "";








  // Future StudentMonthlyFeeFunction(PaymentID, moneyReceiverEmail, moneyReceiverName) async{

  //   setState(() {
  //     loading = true;
  //   });


  //   int DuePayment = int.parse(widget.StudentDueAmount);




  //         final docUser =  FirebaseFirestore.instance.collection("MonthlyFeePayHistory");

  //                     final jsonData ={

  //                       "PaymentID":PaymentID,
  //                       "StudentName":widget.StudentName,
  //                       "StudentEmail":widget.StudentEmail,
  //                       "StudentPhoneNumber":widget.StudentPhoneNumber,
  //                       "pay":PaymentController.text.trim(),
  //                       "Date":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
  //                       "month":"${DateTime.now().month}/${DateTime.now().year}",
  //                       "year":"${DateTime.now().year}",
  //                       "DateTime":"${DateTime.now().toIso8601String()}",
  //                       "moneyReceiverEmail":moneyReceiverEmail,
  //                       "moneyReceiverName":moneyReceiverName,
  //                       "IDNo":widget.StudentIDNo

                     
  //                     };




  //        await docUser.doc(PaymentID).set(jsonData).then((value) =>  setState(() async{





                      
  //        final StudentInfo = FirebaseFirestore.instance.collection("StudentInfo").doc(widget.StudentEmail);

  //                 final UpadateData ={

  //                   "DueAmount":(DuePayment-int.parse(PaymentController.text.trim()))<0?"0":(DuePayment-int.parse(PaymentController.text.trim())).toString(),
  //                   "StudentType":"Paid",
  //                   "AccountStatus":(DuePayment-int.parse(PaymentController.text.trim()))<=0?"close":"open"

                
  //               };





  //               // user Data Update and show snackbar

  //                 StudentInfo.update(UpadateData).then((value) => setState(() async{





  //         try {



                                   
  //            var AdminMsg = "Dear ${widget.StudentName}, আপনি ${PaymentController.text.trim()} Taka Pay করেছেন। Uttaron";



  //           final response = await http
  //               .get(Uri.parse('https://api.greenweb.com.bd/api.php?token=1024519252916991043295858a1b3ac3cb09ae52385b1489dff95&to=${widget.FatherPhoneNo}&message=${AdminMsg}'));

  //           if (response.statusCode == 200) {
  //             // If the server did return a 200 OK response,
  //             // then parse the JSON.
  //             print(jsonDecode(response.body));
              
            
  //           } else {
  //             // If the server did not return a 200 OK response,
  //             // then throw an exception.
  //             throw Exception('Failed to load album');
  //           }








                        
  //                     } catch (e) {
                        
  //                     }






  //                    setState(() {
  //                       loading = false;
                 
  //                     });


  //             Navigator.push(
  //                 context,
  //                 MaterialPageRoute(builder: (context) => AdmitCardPdfPreviewPage(CashInDate: "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}", StudentEmail: widget.StudentEmail, StudentCashIn: PaymentController.text.trim(), StudentIDNo:widget.StudentIDNo, StudentName:widget.StudentName, StudentPhoneNumber: widget.StudentPhoneNumber)),
  //               );







  //                    final snackBar = SnackBar(
  //                   /// need to set following properties for best effect of awesome_snackbar_content
  //                   elevation: 0,
  //                   behavior: SnackBarBehavior.floating,
  //                   backgroundColor: Colors.transparent,
  //                   content: AwesomeSnackbarContent(
  //                     title: 'Pay Successfull',
  //                     message:
  //                         'Pay Successfull',
        
  //                     /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
  //                     contentType: ContentType.success,
  //                   ),
  //                 );
        
  //                 ScaffoldMessenger.of(context)
  //                   ..hideCurrentSnackBar()
  //                   ..showSnackBar(snackBar);



  //                 })).onError((error, stackTrace) => setState((){

  //                   print(error);

  //                 }));











  //                      final snackBar = SnackBar(
  //                   /// need to set following properties for best effect of awesome_snackbar_content
  //                   elevation: 0,
  //                   behavior: SnackBarBehavior.floating,
  //                   backgroundColor: Colors.transparent,
  //                   content: AwesomeSnackbarContent(
  //                     title: 'Pay Successfull',
  //                     message:
  //                         'Pay Successfull',
        
  //                     /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
  //                     contentType: ContentType.success,
  //                   ),
  //                 );
        
  //                 ScaffoldMessenger.of(context)
  //                   ..hideCurrentSnackBar()
  //                   ..showSnackBar(snackBar);


                    



               





  //                 //  myAdminNameController.clear();
  //                 //     myEmailController.clear();
  //                 //     myPassController.clear();
  //                 //     myPhoneNumberController.clear();

                
                
  //               setState(() {
  //                   loading = false;
  //                 });




  //                   })).onError((error, stackTrace) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //                   backgroundColor: Colors.green,
  //                             content: const Text('Success'),
  //                             action: SnackBarAction(
  //                               label: 'Undo',
  //                               onPressed: () {
  //                                 // Some code to undo the change.
  //                               },
  //                             ),
  //                           )));





  // }













  @override
  Widget build(BuildContext context) {



    var PaymentID = uuid.v4();

    FocusNode myFocusNode = new FocusNode();

    StudentPhoneNumberController.text = widget.StudentPhoneNumber;
    
 

    return Scaffold(
      backgroundColor: Colors.white,

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, bottom: 9),
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

//  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>AdminDashboard(indexNumber: "1")));

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


                  //  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>MonthlyMonthlyFeeCollection()));



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
        title: const Text("Monthly Fee",  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),),
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
                        secondRingColor: Color.fromRGBO(92, 107, 192, 1),
                        thirdRingColor: Colors.white,
                        size: 100,
                      ),
                    ),
              ): SingleChildScrollView(

        child:  Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            
              
         
            
            
            
              TextField(
              enabled: false,
               keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone: ${widget.StudentPhoneNumber}',
                     labelStyle: TextStyle(
        color: myFocusNode.hasFocus ? Color.fromRGBO(92, 107, 192, 1): Colors.black
            ),
                    hintText: 'Enter Customer Phone No',
            
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
                controller: StudentPhoneNumberController,
              ),




                   
              SizedBox(
                height: 10,
              ),



              TextField(
              enabled: false,
               keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Due: ৳',
                     labelStyle: TextStyle(
        color: myFocusNode.hasFocus ? Color.fromRGBO(92, 107, 192, 1): Colors.black
            ),
                    hintText: 'Enter Amount',
            
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
          
              ),









            
            
            
            
              SizedBox(
                height: 10,
              ),



              TextField(
               keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Amount',
                     labelStyle: TextStyle(
        color: myFocusNode.hasFocus ? Color.fromRGBO(92, 107, 192, 1): Colors.black
            ),
                    hintText: 'Enter Amount',
            
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
                controller: PaymentController,
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


                FirebaseAuth.instance
                  .authStateChanges()
                  .listen((User? user) async{
                    if (user == null) {

                      print('User is currently signed out!');
                    } else {



                  // StudentMonthlyFeeFunction(PaymentID, user.email, user.displayName);


          

                    }
                  });




             













                              






                  }, child: Text("Money Receive", style: TextStyle(color: Colors.white),), style: ButtonStyle(
                   
          backgroundColor: MaterialStatePropertyAll<Color>(Color.fromRGBO(92, 107, 192, 1)),
        ),),),



              




                ],
              )
            
            
            
            ],
          ),
        ),
        ),
      
      
    );
  }
}



class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Color.fromRGBO(92, 107, 192, 1);
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.875,
        size.width * 0.5, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9584,
        size.width * 1.0, size.height * 0.9167);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}