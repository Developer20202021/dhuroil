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

class ExamFeePay extends StatefulWidget {
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

  const ExamFeePay(
      {super.key,
      required this.ExamFee,
      required this.StudentEmail,
      required this.StudentName,
      required this.StudentPhoneNumber,
      required this.FatherPhoneNo,
      required this.StudentRollNo,
      required this.ExamName,
      required this.ExamDate,
      required this.ClassName,
      required this.ExamStarttingDate});

  @override
  State<ExamFeePay> createState() => _ExamFeePayState();
}

class _ExamFeePayState extends State<ExamFeePay> {
  TextEditingController StudentPhoneNumberController = TextEditingController();
  TextEditingController PaymentController = TextEditingController();
  TextEditingController ExamNameController = TextEditingController();
  TextEditingController RollNoController = TextEditingController();
  TextEditingController FeeController = TextEditingController();
  TextEditingController StudentNameController = TextEditingController();
  TextEditingController StudentEmailController = TextEditingController();
  TextEditingController StudentFatherPhoneNoController = TextEditingController();
  TextEditingController ClassNameController = TextEditingController();
  
  

  var uuid = Uuid();

  bool loading = false;

  var ServerMsg = "";

  Future StudentExamFeePayFunction(
      PaymentID, moneyReceiverEmail, moneyReceiverName) async {
    setState(() {
      loading = true;
    });

    final docUser = FirebaseFirestore.instance.collection("ExamFeePayHistory");

    final jsonData = {
      "PaymentID": PaymentID,
      "StudentName": widget.StudentName,
      "StudentEmail": widget.StudentEmail,
      "StudentPhoneNumber": widget.StudentPhoneNumber,
      "StudentFatherPhoneNo": widget.FatherPhoneNo,
      "StudentRollNo": widget.StudentRollNo,
      "ClassName": widget.ClassName,
      "pay": PaymentController.text.trim(),
      "Date":
          "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
      "month": "${DateTime.now().month}/${DateTime.now().year}",
      "year": "${DateTime.now().year}",
      "DateTime": "${DateTime.now().toIso8601String()}",
      "moneyReceiverEmail": moneyReceiverEmail,
      "moneyReceiverName": moneyReceiverName,
      "ExamName": widget.ExamName,
      "ExamFee": widget.ExamFee,
      "ExamStartingDate": widget.ExamStarttingDate
    };

    await docUser
        .doc(PaymentID)
        .set(jsonData)
        .then((value) => setState(() async {
              try {
                var AdminMsg =
                    "Dear ${widget.StudentName}, আপনি ${PaymentController.text.trim()} Taka Pay করেছেন। Dhuroil";

                final response = await http.get(Uri.parse(
                    'https://api.greenweb.com.bd/api.php?token=1024519252916991043295858a1b3ac3cb09ae52385b1489dff95&to=${widget.StudentPhoneNumber}&message=${AdminMsg}'));

                if (response.statusCode == 200) {
                  // If the server did return a 200 OK response,
                  // then parse the JSON.
                  print(jsonDecode(response.body));
                } else {
                  // If the server did not return a 200 OK response,
                  // then throw an exception.
                  throw Exception('Failed to load album');
                }
              } catch (e) {}

              setState(() {
                loading = false;
              });

              setState(() {
              final snackBar = SnackBar(
                /// need to set following properties for best effect of awesome_snackbar_content
                elevation: 0,
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: 'Successfull',
                  message: 'Payment Successfull',

                  /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                  contentType: ContentType.success,
                ),
              );

              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(snackBar);
            });

            }))
        .onError((error, stackTrace) => setState(() {
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

              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(snackBar);
            }));
  }





  @override
  Widget build(BuildContext context) {
    var PaymentID = uuid.v4();

    FocusNode myFocusNode = new FocusNode();

    // StudentPhoneNumberController.text = widget.StudentPhoneNumber;
    // StudentEmailController.text = widget.StudentEmail;
    // StudentFatherPhoneNoController.text = widget.FatherPhoneNo;
    // StudentNameController.text = widget.StudentName;
    // ExamNameController.text = widget.ExamName;
    // ClassNameController.text = widget.ClassName;
    // FeeController.text = widget.ExamFee;
    // RollNoController.text = widget.StudentRollNo;

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
          ),
        ),
      ),
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          // Navigation bar
          statusBarColor: ColorName().appColor, // Status bar
        ),
        iconTheme: IconThemeData(color: Color.fromRGBO(92, 107, 192, 1)),
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.chevron_left)),
        title: const Text(
          "Exam Fee",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
        ),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: loading
          ? Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Center(
                child: LoadingAnimationWidget.discreteCircle(
                  color: const Color(0xFF1A1A3F),
                  secondRingColor: Color.fromRGBO(92, 107, 192, 1),
                  thirdRingColor: Colors.white,
                  size: 100,
                ),
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 400, right: 400, top: 100),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 18.0, left: 18.0, top: 18.0),
                        child: TextField(
                          enabled: false,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Name: ${widget.StudentName}',
                            labelStyle: TextStyle(
                                color: myFocusNode.hasFocus
                                    ? Color.fromRGBO(92, 107, 192, 1)
                                    : Colors.black),
                            hintText: '',

                            //  enabledBorder: OutlineInputBorder(
                            //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                            //     ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3,
                                  color: Theme.of(context).primaryColor),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3,
                                  color: Color.fromARGB(255, 66, 125, 145)),
                            ),
                          ),
                          controller: StudentNameController,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),



                            Padding(
                        padding: const EdgeInsets.only(
                            right: 18.0, left: 18.0, top: 18.0),
                        child: TextField(
                          enabled: false,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Class: ${widget.ClassName}',
                            labelStyle: TextStyle(
                                color: myFocusNode.hasFocus
                                    ? Color.fromRGBO(92, 107, 192, 1)
                                    : Colors.black),
                            hintText: '',

                            //  enabledBorder: OutlineInputBorder(
                            //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                            //     ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3,
                                  color: Theme.of(context).primaryColor),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3,
                                  color: Color.fromARGB(255, 66, 125, 145)),
                            ),
                          ),
                          controller: ClassNameController,
                        ),
                      ),
               




                      SizedBox(
                        height: 10,
                      ),


                  
                    Padding(
                        padding: const EdgeInsets.only(
                            right: 18.0, left: 18.0, top: 18.0),
                        child: TextField(
                          enabled: false,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Roll: ${widget.StudentRollNo}',
                            labelStyle: TextStyle(
                                color: myFocusNode.hasFocus
                                    ? Color.fromRGBO(92, 107, 192, 1)
                                    : Colors.black),
                            hintText: '',

                            //  enabledBorder: OutlineInputBorder(
                            //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                            //     ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3,
                                  color: Theme.of(context).primaryColor),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3,
                                  color: Color.fromARGB(255, 66, 125, 145)),
                            ),
                          ),
                          controller: RollNoController,
                        ),
                      ),
               




                      SizedBox(
                        height: 10,
                      ),



                        Padding(
                        padding: const EdgeInsets.only(
                            right: 18.0, left: 18.0, top: 18.0),
                        child: TextField(
                          enabled: false,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Fee: ${widget.ExamFee}',
                            labelStyle: TextStyle(
                                color: myFocusNode.hasFocus
                                    ? Color.fromRGBO(92, 107, 192, 1)
                                    : Colors.black),
                            hintText: '',

                            //  enabledBorder: OutlineInputBorder(
                            //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                            //     ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3,
                                  color: Theme.of(context).primaryColor),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3,
                                  color: Color.fromARGB(255, 66, 125, 145)),
                            ),
                          ),
                          controller: FeeController,
                        ),
                      ),



                        Padding(
                        padding: const EdgeInsets.only(
                            right: 18.0, left: 18.0, top: 18.0),
                        child: TextField(
                          enabled: false,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Student Phone No: ${widget.StudentPhoneNumber}',
                            labelStyle: TextStyle(
                                color: myFocusNode.hasFocus
                                    ? Color.fromRGBO(92, 107, 192, 1)
                                    : Colors.black),
                            hintText: '',

                            //  enabledBorder: OutlineInputBorder(
                            //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                            //     ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3,
                                  color: Theme.of(context).primaryColor),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3,
                                  color: Color.fromARGB(255, 66, 125, 145)),
                            ),
                          ),
                          controller: StudentPhoneNumberController,
                        ),
                      ),
               




                      SizedBox(
                        height: 10,
                      ),



                        Padding(
                        padding: const EdgeInsets.only(
                            right: 18.0, left: 18.0, top: 18.0),
                        child: TextField(
                          enabled: false,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Father Phone No: ${widget.FatherPhoneNo}',
                            labelStyle: TextStyle(
                                color: myFocusNode.hasFocus
                                    ? Color.fromRGBO(92, 107, 192, 1)
                                    : Colors.black),
                            hintText: '',

                            //  enabledBorder: OutlineInputBorder(
                            //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                            //     ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3,
                                  color: Theme.of(context).primaryColor),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3,
                                  color: Color.fromARGB(255, 66, 125, 145)),
                            ),
                          ),
                          controller: StudentFatherPhoneNoController,
                        ),
                      ),
               




                      SizedBox(
                        height: 10,
                      ),
               




                    




                      Padding(
                        padding: const EdgeInsets.only(right: 18.0, left: 18.0),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter Amount',
                            labelStyle: TextStyle(
                                color: myFocusNode.hasFocus
                                    ? Color.fromRGBO(92, 107, 192, 1)
                                    : Colors.black),
                            hintText: 'Enter Amount',

                            //  enabledBorder: OutlineInputBorder(
                            //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                            //     ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3,
                                  color: Theme.of(context).primaryColor),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3,
                                  color: Color.fromARGB(255, 66, 125, 145)),
                            ),
                          ),
                          controller: PaymentController,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 150,
                              child: TextButton(
                                onPressed: () async {
                                  setState(() {
                                    loading = true;
                                  });


                                   StudentExamFeePayFunction(PaymentID,
                                         "Hasan", "mahadi");

                                  // FirebaseAuth.instance
                                  //     .authStateChanges()
                                  //     .listen((User? user) async {
                                  //   if (user == null) {
                                  //     print('User is currently signed out!');
                                  //   } else {
                                  //     StudentExamFeePayFunction(PaymentID,
                                  //         user.email, user.displayName);
                                  //   }
                                  // });
                                },
                                child: Text(
                                  "Money Receive",
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll<Color>(
                                          Color.fromRGBO(92, 107, 192, 1)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
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
