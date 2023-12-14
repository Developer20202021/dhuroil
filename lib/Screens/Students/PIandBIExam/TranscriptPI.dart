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

class TranscriptPI extends StatefulWidget {
  final ClassName;

  final ExamName;

  final SubjectName;

  final RollNo;

  final StudentEmail;

  final List SelectedExam;

  const TranscriptPI(
      {super.key,
      required this.ClassName,
      required this.ExamName,
      required this.SubjectName,
      required this.RollNo,
      required this.StudentEmail,
      required this.SelectedExam});

  @override
  State<TranscriptPI> createState() => _EditCustomerInfoState();
}

class _EditCustomerInfoState extends State<TranscriptPI> {
  bool loading = false;

  var uuid = Uuid();

  String SelectedPIID = "";

  // Firebase All Customer Data Load

  List AllData = [];

  Future<void> getData() async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();

    setState(() {
      loading = true;
    });

    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('SchoolPIData');

    Query query = _collectionRef
        .where("ClassName", isEqualTo: widget.ClassName)
        .where("ExamName", isEqualTo: widget.ExamName.toString().toBijoy)
        .where("SubjectName", isEqualTo: widget.SubjectName.toString().toBijoy);
    QuerySnapshot querySnapshot = await query.get();

    // Get data from docs and convert map to List
    AllData = querySnapshot.docs.map((doc) => doc.data()).toList();

    setState(() {
      AllData = querySnapshot.docs.map((doc) => doc.data()).toList();

      loading = false;

      // getStudentPIData();
    });

    print(AllData);
  }

  List TranscriptData = [];
  List PIFatherNoReportCard = [];
  List ChurantoSchoolPIDataList = [];

  List AllExamName = [
    "ষাণ্মাসিক শিখনকালীন মূল্যায়ন",
    'ষাণ্মাসিক সামষ্টিক মূল্যায়ন',
    "বাৎসরিক শিখনকালীন মূল্যায়ন",
    "বাৎসরিক সামষ্টিক মূল্যায়ন"
  ];

  Future getTranscriptData() async {
    // setState(() {
    //   loading = true;
    // });

    CollectionReference _ChurantoSchoolPIDataRef =
        FirebaseFirestore.instance.collection('ChurantoSchoolPIData');

    Query ChurantoSchoolPIDataquery =
        _ChurantoSchoolPIDataRef.where("ClassName", isEqualTo: widget.ClassName)
            .where("ExamName", isEqualTo: widget.SelectedExam)
            .where("SubjectName",
                isEqualTo: widget.SubjectName.toString().toBijoy);

    QuerySnapshot ChurantoSchoolPIDataquerySnapshot =
        await ChurantoSchoolPIDataquery.get();

    // Get data from docs and convert map to List
    ChurantoSchoolPIDataList = ChurantoSchoolPIDataquerySnapshot.docs
        .map((doc) => doc.data())
        .toList();

    setState(() {
      ChurantoSchoolPIDataList = ChurantoSchoolPIDataquerySnapshot.docs
          .map((doc) => doc.data())
          .toList();

      print(ChurantoSchoolPIDataList);
    });

    for (var i = 0; i < ChurantoSchoolPIDataList.length; i++) {

      for (var a = 0; a < ChurantoSchoolPIDataList[i]["PINo"].length; a++) {
        List SamePIAllExam = [];
        List SamePIAllExamAnswer = [];

        for (var x = 0;
            x < ChurantoSchoolPIDataList[i]["ExamName"].length;
            x++) {
          if (ChurantoSchoolPIDataList[i]["ExamName"][x] == false) {
            continue;
          } else {
            print(ChurantoSchoolPIDataList[i]["ExamName"][x]);

            CollectionReference SchoolStudentPIDataAnswerRef =
                FirebaseFirestore.instance.collection('SchoolPIDataAnswer');

            Query SchoolStudentPIDataAnswerquery = SchoolStudentPIDataAnswerRef
                    .where("ClassName", isEqualTo: widget.ClassName)
                .where("ExamName", isEqualTo: AllExamName[x].toString().toBijoy)
                .where("SubjectName",
                    isEqualTo: widget.SubjectName.toString().toBijoy)
                .where("RollNo", isEqualTo: widget.RollNo)
                .where("StudentEmail", isEqualTo: widget.StudentEmail)
                .where("PINo",
                    isEqualTo: ChurantoSchoolPIDataList[i]["PINo"][a]);

            print(ChurantoSchoolPIDataList[i]["PINo"][a]);

            QuerySnapshot SchoolStudentPIDataAnswerquerySnapshot =
                await SchoolStudentPIDataAnswerquery.get();

            // Get data from docs and convert map to List
            List SchoolStudentPIDataAnswerList =
                SchoolStudentPIDataAnswerquerySnapshot.docs
                    .map((doc) => doc.data())
                    .toList();

            // print(SchoolStudentPIDataAnswerList);

            if (SchoolStudentPIDataAnswerList.isEmpty) {
            } else {
              for (var y = 0; y < SchoolStudentPIDataAnswerList.length; y++) {
                setState(() {
                  SamePIAllExam.insert(
                      SamePIAllExam.length, SchoolStudentPIDataAnswerList[y]);

                  print(SamePIAllExam);
                });
              }
            }
          }
        }

        for (int index = 0; index < SamePIAllExam.length; index++) {
          setState(() {
            SamePIAllExamAnswer.add(SamePIAllExam[index]["PIAnswer"]);
          });
        }

        List<int> intList = [];

        for (var i = 0; i < SamePIAllExamAnswer.length; i++) {
          int intValue = int.parse(SamePIAllExamAnswer[i].toString());
          setState(() {
            intList.add(intValue);
          });

          print(intList);
        }

        var Allvalue =
            intList.reduce((curr, next) => curr > next ? curr : next);

        print("____________________________________________${Allvalue}");

        for (var i = 0; i < SamePIAllExam.length; i++) {
          if (int.parse(SamePIAllExam[i]["PIAnswer"].toString()) == Allvalue) {
            setState(() {
              TranscriptData.insert(TranscriptData.length, SamePIAllExam[i]);
            });
          } else {
            continue;
          }
        }
      }
    }

    getReportCardData();
  }





  // Transcript report card Function

  void getReportCardData() {
    // print("_____________Mahadi___________________________${TranscriptData}");

    for (var i = 0; i < TranscriptData.length; i++) {
      List SamePIFather = [];
      int triangle = 0;
      int square = 0;
      int circle = 0;

      for (var j = 0; j < TranscriptData.length; j++) {
        if (TranscriptData[j]["PIFatherNo"] ==
            TranscriptData[i]["PIFatherNo"]) {
          SamePIFather.insert(SamePIFather.length, TranscriptData[j]);
        }
        else{
          continue;
        }
      }

      print("___________________mahadi_________${SamePIFather}");

      for (int x = 0; x < SamePIFather.length; x++) {
        print(SamePIFather[x]["PIAnswer"]);
        if (SamePIFather[x]["PIAnswer"] == "0") {
          square = square + 1;
        } else if (SamePIFather[x]["PIAnswer"] == "1") {
          circle = circle + 1;
        } else if (SamePIFather[x]["PIAnswer"] == "2") {
          triangle = triangle + 1;
        } else {
          continue;
        }
      }

      print("${triangle}, ${circle}, ${square}");

      double PerformanceReport =
          ((triangle - square) / (SamePIFather.length)) * 100;

      setState(() {
        PIFatherNoReportCard.insert(PIFatherNoReportCard.length,{
          "PIFatherNo": SamePIFather[0]["PIFatherNo"],
          "PIFatherNoDescription": SamePIFather[0]["PIFatherNoDescription"],
          "triangle": triangle,
          "circle": circle,
          "square": square,
          "PINoDescription": SamePIFather[0]["PINoDescription"],
          "Performance": PerformanceReport
        });

        triangle = 0;
        square = 0;
        circle = 0;
      });
    }


    print("__________________Inan________${PIFatherNoReportCard}");
  }

  @override
  void initState() {
    // TODO: implement initState

    // getData();
    getTranscriptData();


   


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
      bottomNavigationBar: width < 669
          ? const Center(
              child: Text(
              "This Screen size is not Allowed for this Admin panel",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
            ))
          : Padding(
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
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.chevron_left)),
        title: Text(
          "শ্রেণীঃ (${widget.ClassName.toString()})  রোলঃ (${widget.RollNo})   বিষয়ঃ (${widget.SubjectName})    মূল্যায়নঃ (${widget.SelectedExam[0]==true?"ষাণ্মাসিক শিখনকালীন মূল্যায়ন, ":""} ${widget.SelectedExam[1]==true?"ষাণ্মাসিক সামষ্টিক মূল্যায়ন, ":""} ${widget.SelectedExam[2]==true?"বাৎসরিক শিখনকালীন মূল্যায়ন, ":""} ${widget.SelectedExam[3]==true?"বাৎসরিক সামষ্টিক মূল্যায়ন, ":""}) ট্রান্সক্রিপ্ট"
              .toBijoy,
          style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 17,
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

                             SingleChildScrollView(
                              child: GridView.count(
                              primary: true,
                              shrinkWrap: true,
                              crossAxisCount: 2,
                              crossAxisSpacing: 40.0,
                              mainAxisSpacing: 40.0,
                              padding: const EdgeInsets.all(20.0),
                              children: [
                                Text("Text")
                              ],
                            ),
                            ),

                            const SizedBox(
                              height: 175,
                            ),

                            Center(
                              child: Text(
                                "শ্রেণীঃ (${widget.ClassName.toString()})  রোলঃ (${widget.RollNo})   বিষয়ঃ (${widget.SubjectName})    মূল্যায়নঃ (${widget.ExamName}) ট্রান্সক্রিপ্ট"
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
                                              "PI No",
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
                                                "পারদর্শিতার নির্দেশক".toBijoy,
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
                                                      "পারদর্শিতার মাত্রা"
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
                                                      "পারদর্শিতার মাত্রা"
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
                                                      "পারদর্শিতার মাত্রা"
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
                                        i < TranscriptData.length;
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
                                                "${TranscriptData.length}     ${TranscriptData[i]["PINo"].toString().toBijoy}",
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
                                                "${TranscriptData[i]["PINoDescription"].toString().toBijoy}",
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

                                                  TranscriptData[i]
                                                              ["PIAnswer"] ==
                                                          "0"
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
                                                      "${TranscriptData[i]["SquareDescription"].toString().toBijoy}",
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
                                                  TranscriptData[i]
                                                              ["PIAnswer"] ==
                                                          "1"
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
                                                      "${TranscriptData[i]["CircleDescription"].toString().toBijoy}",
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
                                                  TranscriptData[i]
                                                              ["PIAnswer"] ==
                                                          "2"
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
                                                      "${TranscriptData[i]["TriangleDescription"].toString().toBijoy}",
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
