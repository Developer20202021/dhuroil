import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:bijoy_helper/bijoy_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhuroil/DeveloperAccess/DeveloperAccess.dart';
import 'package:dhuroil/Screens/AdminPanel/NoticeView.dart';
import 'package:dhuroil/Screens/Students/EditStudent.dart';
import 'package:dhuroil/Screens/Students/ExamFeeHistory.dart';
import 'package:dhuroil/Screens/Students/FileView.dart';
import 'package:dhuroil/Screens/Students/MarksSheet/MarkssheetInvoice.dart';
import 'package:dhuroil/Screens/Students/MonthlyFeeHistory.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class TranscriptBI extends StatefulWidget {
  final ClassName;

  final RollNo;

  final StudentEmail;

  final List SelectedExamName;

  const TranscriptBI(
      {super.key,
      required this.ClassName,
      required this.RollNo,
      required this.StudentEmail, required this.SelectedExamName});

  @override
  State<TranscriptBI> createState() => _EditCustomerInfoState();
}

class _EditCustomerInfoState extends State<TranscriptBI> {
  bool loading = false;

  var uuid = Uuid();

  String SelectedPIID = "";

  List ExamName = ["ষাণ্মাসিক সামষ্টিক মূল্যায়ন", "বাৎসরিক সামষ্টিক মূল্যায়ন"];


  // Firebase All Customer Data Load

  List AllData = [];






// get Churanto BI No


  List ChurantoBINo =[];

  List LastBIData = [];


  Future getChurantoBIData() async{


     setState(() {
      loading = true;
    });

    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('ChurantoSchoolBIData');

    Query query = _collectionRef
        .where("ClassName", isEqualTo: widget.ClassName)
        .where("ExamName", isEqualTo: widget.SelectedExamName)
        ;

        
    QuerySnapshot querySnapshot = await query.get();

    List ChurantoBIData =[];

    // Get data from docs and convert map to List
    ChurantoBIData = querySnapshot.docs.map((doc) => doc.data()).toList();

    if (ChurantoBIData.isEmpty) {


      
    } else {

    setState(() {

      ChurantoBINo = ChurantoBIData[0]["BINo"];
      

    });



    for (int i = 0; i < ChurantoBINo.length; i++) {

      List SameBINoAllSubject =[];

      List SameBINoAnswerAllSubject = [];

      int SquareCount = 0;

      int CircleCount = 0;

      int TriangleCount = 0;

      int BigAnswer = 0;




       CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('SchoolBIDataAnswer');

    Query query = _collectionRef
        .where("ClassName", isEqualTo: widget.ClassName)
        .where("ExamName", isEqualTo: widget.SelectedExamName[0]==true?ExamName[0].toString().toBijoy:ExamName[1].toString().toBijoy)
        .where("BINo", isEqualTo: ChurantoBINo[i])
        .where("StudentEmail", isEqualTo: widget.StudentEmail)
        .where("RollNo", isEqualTo: widget.RollNo);



    QuerySnapshot querySnapshot = await query.get();

    // Get data from docs and convert map to List
    SameBINoAllSubject = querySnapshot.docs.map((doc) => doc.data()).toList();

    for (int j = 0; j < SameBINoAllSubject.length; j++) {

      SameBINoAnswerAllSubject.add(SameBINoAllSubject[j]["BIAnswer"]);
      
    }


    for (int x = 0; x < SameBINoAnswerAllSubject.length; x++) {

      if (SameBINoAnswerAllSubject[x]=="0") {

        SquareCount = SquareCount + 1;
        
      } 
      
      else if(SameBINoAnswerAllSubject[x]=="1"){

        CircleCount = CircleCount + 1;
        
      }

      else if(SameBINoAnswerAllSubject[x]=="2"){

        TriangleCount = TriangleCount + 1;
        
      }
      else{

        continue;
      }
      
    }



    if (SquareCount>CircleCount && CircleCount>TriangleCount) {

      BigAnswer = 0;
      
    } 
    
    else if(CircleCount>SquareCount && SquareCount>TriangleCount){

      BigAnswer = 1;
      
    }

    else {

      BigAnswer = 2;
      
    }



    List<int> threeValue =[TriangleCount, CircleCount, SquareCount];



           int findMax(List<int> numbers) {

                 
                 return numbers.reduce(max);
                } 

        print("maximum${findMax(threeValue)}");





    setState(() {
      LastBIData.add({
        "BINo":SameBINoAllSubject[0]["BINo"],
        "BINoDescription":SameBINoAllSubject[0]["BINoDescription"],
        "BIFatherNo":SameBINoAllSubject[0]["BIFatherNo"],
        "BIFatherNoDescription":SameBINoAllSubject[0]["BIFatherNoDescription"],
        "BIAnswer":threeValue.indexOf(findMax(threeValue)),
        "CircleDescription":SameBINoAllSubject[0]["CircleDescription"],
        "SquareDescription":SameBINoAllSubject[0]["SquareDescription"],
        "TriangleDescription":SameBINoAllSubject[0]["TriangleDescription"],

      });
    });


    setState(() {
      CircleCount =0;
      TriangleCount = 0;
      SquareCount =0;
      BigAnswer =0;
    });











      
    }







      
    }




  




   

    print("___________BILast______________${LastBIData}");


    setState(() {
      loading = false;
    });




  }














  @override
  void initState() {
    // TODO: implement initState

    // getData();

    getChurantoBIData();

    super.initState();
  }

  Future refresh() async {
    setState(() {
      // loading = true;

      //  getData(widget.StudentEmail);
      //  getSaleData();
    });
  }

  @override
  Widget build(BuildContext context) {
    var FileID = uuid.v4();

    double width = MediaQuery.of(context).size.width;

    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
    
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          // Navigation bar
          statusBarColor: ColorName().appColor, // Status bar
        ),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.chevron_left)),
        title: Text(
          "শ্রেণীঃ (${widget.ClassName.toString()})  রোলঃ (${widget.RollNo}) আচরণিক ট্রান্সক্রিপ্ট"
              .toBijoy,
          style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 13,
              fontFamily: "SiyamRupali"),
        ),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: SingleChildScrollView(
          child: loading
              ? Center(
                  child: LinearProgressIndicator(),
                )
              : width < 669
                  ? const Center(
                      child: Text(
                      "This Screen size is not Allowed for this Admin panel",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red),
                    ))
                  : Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),


                           

                            Center(
                              child: Text(
                                "শ্রেণীঃ (${widget.ClassName.toString()})  রোলঃ (${widget.RollNo})  মূল্যায়নঃ (${widget.SelectedExamName[0]==true?"${ExamName[0]},":" "} ${widget.SelectedExamName[1]==true?"${ExamName[1]},":" "} ) আচরণিক ট্রান্সক্রিপ্ট"
                                    .toBijoy,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    fontFamily: "SiyamRupali"),
                              ),
                            ),

                            const SizedBox(
                              height: 15,
                            ),

                            // Student PI answer table

                            Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.75,
                                child: Table(
                                  border: const TableBorder(
                                      horizontalInside: BorderSide(
                                          color: Colors.white, width: 10.0)),
                                  textBaseline: TextBaseline.ideographic,
                                  children: [
                                    TableRow(
                                        decoration: BoxDecoration(
                                            color: Colors.pink.shade300),
                                        children: [
                                          Container(
                                              child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              "BI No",
                                              style: TextStyle(
                                                  fontSize: 17.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          )),
                                          Container(
                                              child: Padding(
                                            padding: EdgeInsets.only(top: 25),
                                            child: Text(
                                                "আচরণিক নির্দেশক".toBijoy,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "SiyamRupali",
                                                    color: Colors.white)),
                                          )),
                                          Container(
                                              child: Padding(
                                            padding: EdgeInsets.only(top: 15),
                                            child: Column(
                                              children: [
                                                const FaIcon(
                                                  FontAwesomeIcons.square,
                                                  size: 20,
                                                  color: Colors.white,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10, top: 14),
                                                  child: Text(
                                                      "আচরণিক মাত্রা"
                                                          .toBijoy,
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              "SiyamRupali",
                                                          color: Colors.white)),
                                                ),
                                              ],
                                            ),
                                          )),
                                          Container(
                                              child: Padding(
                                            padding: EdgeInsets.only(top: 15),
                                            child: Column(
                                              children: [
                                                const FaIcon(
                                                  FontAwesomeIcons.circle,
                                                  size: 20,
                                                  color: Colors.white,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10, top: 14),
                                                  child: Text(
                                                      "আচরণিক মাত্রা"
                                                          .toBijoy,
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              "SiyamRupali",
                                                          color: Colors.white)),
                                                ),
                                              ],
                                            ),
                                          )),
                                          Container(
                                              child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                const FaIcon(
                                                  FontAwesomeIcons.caretUp,
                                                  size: 40,
                                                  color: Colors.white,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10),
                                                  child: Text(
                                                      "আচরণিক মাত্রা"
                                                          .toBijoy,
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              "SiyamRupali",
                                                          color: Colors.white)),
                                                ),
                                              ],
                                            ),
                                          )),
                                          
                                        ]),
                                    for (int i = 0;
                                        i < LastBIData.length;
                                        i++)
                                      TableRow(
                                          decoration: BoxDecoration(
                                              color: Colors.grey[100]),
                                          children: [
                                            Container(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                LastBIData[i]["BINo"].toString().toBijoy,
                                                style: const TextStyle(
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "SiyamRupali"),
                                              ),
                                            )),
                                            Container(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                LastBIData[i]["BINoDescription"].toString().toBijoy,
                                                style: const TextStyle(
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "SiyamRupali"),
                                              ),
                                            )),
                                            Container(
                                                child: Padding(
                                              padding: EdgeInsets.only(top: 15),
                                              child: Column(
                                                children: [
// AllData[i]["PIID"]

                                                  LastBIData[i]
                                                              ["BIAnswer"] ==
                                                          0
                                                      ? Image.asset(
                                                          "square_fill.png",
                                                          width: 30,
                                                          height: 30,
                                                        )
                                                      : Image.asset(
                                                          "square.png",
                                                          width: 30,
                                                          height: 30,
                                                        ),

                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 10,
                                                            top: 14),
                                                    child: Text(
                                                      LastBIData[i]["SquareDescription"].toString().toBijoy,
                                                      style: const TextStyle(
                                                          fontSize: 12.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              "SiyamRupali"),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                            Container(
                                                child: Padding(
                                              padding: EdgeInsets.only(top: 15),
                                              child: Column(
                                                children: [
                                                  LastBIData[i]
                                                              ["BIAnswer"] ==
                                                          1
                                                      ? Image.asset(
                                                          "circle_fill.png",
                                                          width: 30,
                                                          height: 30,
                                                        )
                                                      : Image.asset(
                                                          "circle.png",
                                                          width: 30,
                                                          height: 30,
                                                        ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 10,
                                                            top: 14),
                                                    child: Text(
                                                      LastBIData[i]["CircleDescription"].toString().toBijoy,
                                                      style: const TextStyle(
                                                          fontSize: 12.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              "SiyamRupali"),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                            Container(
                                                child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  LastBIData[i]
                                                              ["BIAnswer"] ==
                                                          2
                                                      ? Image.asset(
                                                          "triangle_fill.png",
                                                          width: 30,
                                                          height: 30,
                                                        )
                                                      : Image.asset(
                                                          "triangle.png",
                                                          width: 30,
                                                          height: 30,
                                                        ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 10,
                                                            top: 14),
                                                    child: Text(
                                                      LastBIData[i]["TriangleDescription"].toString().toBijoy,
                                                      style: const TextStyle(
                                                          fontSize: 12.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              "SiyamRupali"),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                            
                                          ]),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
        ),
      ),
    );
  }
}
