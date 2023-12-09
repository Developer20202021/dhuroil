import 'package:dhuroil/Screens/AdminPanel/AdminHomePage.dart';
import 'package:dhuroil/Screens/AdminPanel/NoticeUplaod.dart';
import 'package:dhuroil/Screens/HomePage.dart';
import 'package:dhuroil/Screens/Registration/AllRegistration.dart';
import 'package:dhuroil/Screens/Registration/OtpPage.dart';
import 'package:dhuroil/Screens/Registration/StudentReg.dart';
import 'package:dhuroil/Screens/Registration/TeacherReg.dart';
import 'package:dhuroil/Screens/Students/AllStudent.dart';
import 'package:dhuroil/Screens/Students/AllStudentsHomePage.dart';
import 'package:dhuroil/Screens/Students/Attendance/AttendanceHomePage.dart';
import 'package:dhuroil/Screens/Students/ExamFeeHistory.dart';
import 'package:dhuroil/Screens/Students/MarksSheet/MarkssheetInvoice.dart';
import 'package:dhuroil/Screens/Students/Pay/AdmitCardInvoice.dart';
import 'package:dhuroil/Screens/Students/ShowAttendance.dart';
import 'package:dhuroil/Screens/Students/ViewPerStudentResult.dart';
import 'package:dhuroil/Screens/Teachers/AllTeachers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:ui_web' as ui_web; 





void main() async{



 


  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

    options: FirebaseOptions(apiKey: "AIzaSyA5MUeeQOYAwUccG9KKzLn4HL42GAX4vsk", appId: "1:258461402825:android:dab51d66411dc54c4d2f18", messagingSenderId: "258461402825", projectId: "dhuroil")
    
  );


  // NotificationService().initNotification();
  // tz.initializeTimeZones();


  // await Future.delayed(const Duration(seconds: 3));

  // FlutterNativeSplash.remove();


  await Hive.initFlutter();
  var box = await Hive.openBox('DhuroilBox');





  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dhuroil',
      theme: ThemeData(
        fontFamily: GoogleFonts.spaceGrotesk().fontFamily,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AdminHomePage(),
    );
  }
}


// AdminHomePage()

// MarksSheetPdfPreviewPage(CashInDate: "Hello", StudentEmail: "Hello", StudentCashIn: "Hello", StudentIDNo: "Hello", StudentName: "Hello", StudentPhoneNumber: "Hello")

// AllStudents(indexNumber: "1")

// PdfPreviewPage(CashInDate: "Hello", StudentEmail: "Hello", StudentCashIn: "Hello", StudentIDNo: "Hello", StudentName: "Hello", StudentPhoneNumber: "Hello")



