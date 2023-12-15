import 'dart:convert';
import 'dart:io';

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

class ClassWiseBI extends StatefulWidget {
  final ClassName;

  final ExamName;

  final SubjectName;

  final RollNo;

  final StudentEmail;

  const ClassWiseBI(
      {super.key,
      required this.ClassName,
      required this.ExamName,
      required this.SubjectName,
      required this.RollNo,
      required this.StudentEmail});

  @override
  State<ClassWiseBI> createState() => _EditCustomerInfoState();
}

class _EditCustomerInfoState extends State<ClassWiseBI> {
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
        FirebaseFirestore.instance.collection('SchoolBIData');

    Query query = _collectionRef
        .where("ClassName", isEqualTo: widget.ClassName)
        .where("ExamName", isEqualTo: widget.ExamName.toString().toBijoy);
        
    QuerySnapshot querySnapshot = await query.get();

    // Get data from docs and convert map to List
    AllData = querySnapshot.docs.map((doc) => doc.data()).toList();

    setState(() {
      AllData = querySnapshot.docs.map((doc) => doc.data()).toList();

      loading = false;

      getStudentPIData();
    });

    print(AllData);
  }

  List AllStudentPIData = [];

  Future getStudentPIData() async {
    setState(() {
      loading = true;
    });

    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('SchoolBIDataAnswer');

    Query query = _collectionRef
        .where("ClassName", isEqualTo: widget.ClassName)
        .where("ExamName", isEqualTo: widget.ExamName.toString().toBijoy)
        .where("SubjectName", isEqualTo: widget.SubjectName.toString().toBijoy)
        .where("StudentEmail", isEqualTo: widget.StudentEmail)
        .where("RollNo", isEqualTo: widget.RollNo);
    QuerySnapshot querySnapshot = await query.get();

    // Get data from docs and convert map to List
    AllStudentPIData = querySnapshot.docs.map((doc) => doc.data()).toList();

    setState(() {
      AllStudentPIData = querySnapshot.docs.map((doc) => doc.data()).toList();

      loading = false;
    });

    print(AllStudentPIData);
  }

  @override
  void initState() {
    // TODO: implement initState

    getData();

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
          "শ্রেণীঃ (${widget.ClassName.toString()})  রোলঃ (${widget.RollNo})   বিষয়ঃ (${widget.SubjectName})    মূল্যায়নঃ (${widget.ExamName}) আচরণিক ট্রান্সক্রিপ্ট নিচে উত্তর নিশ্চত করুন"
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
                                          Container(
                                              child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Center(
                                                child: Text(
                                              "Submit",
                                              style: TextStyle(
                                                  fontSize: 17.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            )),
                                          )),
                                          Container(
                                              child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Center(
                                                child: Text(
                                              "Delete",
                                              style: TextStyle(
                                                  fontSize: 17.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            )),
                                          )),
                                        ]),
                                    for (int i = 0; i < AllData.length; i++)
                                      TableRow(
                                          decoration: BoxDecoration(
                                              color: Colors.grey[100]),
                                          children: [
                                            Container(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                AllData[i]["BINo"].toString().toBijoy,
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
                                                AllData[i]["BINoDescription"].toString().toBijoy,
                                                style: const TextStyle(
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "SiyamRupali"),
                                              ),
                                            )),
                                            Container(
                                                child: Padding(
                                              padding:const EdgeInsets.only(top: 15),
                                              child: Column(
                                                children: [
                                                  SelectedPIID ==
                                                          "${AllData[i]["BIID"]}+0"
                                                      ? IconButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              SelectedPIID = "";
                                                            });
                                                          },
                                                          icon: const FaIcon(
                                                            FontAwesomeIcons
                                                                .squareCheck,
                                                            size: 30,
                                                            color: Colors.green,
                                                          ),
                                                        )
                                                      : IconButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              SelectedPIID =
                                                                  "${AllData[i]["BIID"]}+0";
                                                            });
                                                          },
                                                          icon: const FaIcon(
                                                            FontAwesomeIcons
                                                                .square,
                                                            size: 20,
                                                          ),
                                                        ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 10,
                                                            top: 14),
                                                    child: Text(
                                                      AllData[i]["SquareDescription"].toString().toBijoy,
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
                                              padding: const EdgeInsets.only(top: 15),
                                              child: Column(
                                                children: [
                                                  SelectedPIID ==
                                                          "${AllData[i]["BIID"]}+1"
                                                      ? IconButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              SelectedPIID = "";
                                                            });
                                                          },
                                                          icon: const Icon(
                                                            Icons.circle,
                                                            color: Colors.green,
                                                            size: 30,
                                                          ),
                                                        )
                                                      : IconButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              SelectedPIID =
                                                                  "${AllData[i]["BIID"]}+1";
                                                            });
                                                          },
                                                          icon: const FaIcon(
                                                            FontAwesomeIcons
                                                                .circle,
                                                            size: 20,
                                                          ),
                                                        ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 10,
                                                            top: 14),
                                                    child: Text(
                                                      AllData[i]["CircleDescription"].toString().toBijoy,
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
                                                  SelectedPIID ==
                                                          "${AllData[i]["BIID"]}+2"
                                                      ? IconButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              SelectedPIID = "";
                                                            });
                                                          },
                                                          icon: const FaIcon(
                                                            FontAwesomeIcons
                                                                .caretUp,
                                                            size: 45,
                                                            color: Colors.green,
                                                          ),
                                                        )
                                                      : IconButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              SelectedPIID =
                                                                  "${AllData[i]["BIID"]}+2";
                                                            });
                                                          },
                                                          icon: const FaIcon(
                                                            FontAwesomeIcons
                                                                .caretUp,
                                                            size: 40,
                                                          ),
                                                        ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 10),
                                                    child: Text(
                                                      AllData[i]["TriangleDescription"].toString().toBijoy,
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
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10),
                                                child: SelectedPIID ==
                                                            "${AllData[i]["BIID"]}+0" ||
                                                        SelectedPIID ==
                                                            "${AllData[i]["BIID"]}+1" ||
                                                        SelectedPIID ==
                                                            "${AllData[i]["BIID"]}+2"
                                                    ? ElevatedButton(
                                                        onPressed: () async {
                                                          setState(() {
                                                            loading = true;
                                                          });

// BI Data Create from here

                                                          var SchoolPIData = {
                                                            "BIID": AllData[i]
                                                                ["BIID"],
                                                            "ExamName": AllData[
                                                                i]["ExamName"],
                                                            "ClassName": AllData[
                                                                i]["ClassName"],
                                                            "SubjectName": widget.SubjectName.toString().toBijoy,

                                                            "BIFatherNo":
                                                                AllData[i][
                                                                    "BIFatherNo"],
                                                            "BIFatherNoDescription":
                                                                AllData[i][
                                                                    "BIFatherNoDescription"],
                                                        
                                                            "BINo": AllData[i]
                                                                ["BINo"],
                                                            "BINoDescription":
                                                                AllData[i][
                                                                    "BINoDescription"],
                                                            "SquareDescription":
                                                                AllData[i][
                                                                    "SquareDescription"],
                                                            "CircleDescription":
                                                                AllData[i][
                                                                    "CircleDescription"],
                                                            "TriangleDescription":
                                                                AllData[i][
                                                                    "TriangleDescription"],
                                                            "DateTime": DateTime
                                                                    .now()
                                                                .toIso8601String(),
                                                            "year":
                                                                "${DateTime.now().year}",
                                                            "BIAnswer":
                                                                SelectedPIID
                                                                    .split(
                                                                        "+")[1],
                                                            "RollNo":
                                                                widget.RollNo,
                                                            "StudentEmail":
                                                                widget
                                                                    .StudentEmail
                                                          };

                                                          final SchoolPI =
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'SchoolBIDataAnswer')
                                                                  .doc();

                                                          SchoolPI.set(
                                                                  SchoolPIData)
                                                              .then((value) =>
                                                                  setState(() {
                                                                    getData();

                                                                    getStudentPIData();

                                                                    // Navigator.pop(context);

                                                                    final snackBar =
                                                                        SnackBar(
                                                                      elevation:
                                                                          0,
                                                                      behavior:
                                                                          SnackBarBehavior
                                                                              .floating,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .transparent,
                                                                      content:
                                                                          AwesomeSnackbarContent(
                                                                        title:
                                                                            'BI Answer Successfull',
                                                                        message:
                                                                            'Hey Thank You. Good Job',

                                                                        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                                                        contentType:
                                                                            ContentType.success,
                                                                      ),
                                                                    );

                                                                    ScaffoldMessenger.of(
                                                                        context)
                                                                      ..hideCurrentSnackBar()
                                                                      ..showSnackBar(
                                                                          snackBar);

                                                                    setState(
                                                                        () {
                                                                      loading =
                                                                          false;
                                                                    });
                                                                  }))
                                                              .onError((error,
                                                                      stackTrace) =>
                                                                  setState(() {
                                                                    final snackBar =
                                                                        SnackBar(
                                                                      /// need to set following properties for best effect of awesome_snackbar_content
                                                                      elevation:
                                                                          0,
                                                                      behavior:
                                                                          SnackBarBehavior
                                                                              .floating,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .transparent,
                                                                      content:
                                                                          AwesomeSnackbarContent(
                                                                        title:
                                                                            'Something Wrong!!!!',
                                                                        message:
                                                                            'Try again later...',

                                                                        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                                                        contentType:
                                                                            ContentType.failure,
                                                                      ),
                                                                    );

                                                                    ScaffoldMessenger.of(
                                                                        context)
                                                                      ..hideCurrentSnackBar()
                                                                      ..showSnackBar(
                                                                          snackBar);

                                                                    setState(
                                                                        () {
                                                                      loading =
                                                                          false;
                                                                    });
                                                                  }));
                                                        },
                                                        child: Text("Submit"))
                                                    : Text(""),
                                              ),
                                            )),
                                            Container(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: IconButton(
                                                  onPressed: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return StatefulBuilder(
                                                              builder: (context,
                                                                  setState) {
                                                            return AlertDialog(
                                                              title: const Text(
                                                                  'Delete'),
                                                              content: const Text(
                                                                  'Are you Sure You want to Delete it?'),
                                                              actions: [
                                                                ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: const Text(
                                                                      'CANCEL'),
                                                                ),
                                                                ElevatedButton(
                                                                  onPressed:
                                                                      () async {
                                                                    setState(
                                                                      () {
                                                                        loading =
                                                                            true;
                                                                      },
                                                                    );

                                                                    CollectionReference
                                                                        collectionRef =
                                                                        FirebaseFirestore
                                                                            .instance
                                                                            .collection('NoticeInfo');
                                                                    collectionRef
                                                                        .doc(AllData[i]
                                                                            [
                                                                            "FileID"])
                                                                        .delete()
                                                                        .then(
                                                                          (doc) =>
                                                                              setState(() {
                                                                            getData();

                                                                            Navigator.pop(context);

                                                                            final snackBar =
                                                                                SnackBar(
                                                                              elevation: 0,
                                                                              behavior: SnackBarBehavior.floating,
                                                                              backgroundColor: Colors.transparent,
                                                                              content: AwesomeSnackbarContent(
                                                                                title: 'Delete Successfull',
                                                                                message: 'Hey Thank You. Good Job',

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
                                                                          onError: (e) =>
                                                                              setState(() {
                                                                            Navigator.pop(context);

                                                                            final snackBar =
                                                                                SnackBar(
                                                                              elevation: 0,
                                                                              behavior: SnackBarBehavior.floating,
                                                                              backgroundColor: Colors.transparent,
                                                                              content: AwesomeSnackbarContent(
                                                                                title: 'Something Wrong!!!',
                                                                                message: 'Try again later...',

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
                                                                  child: const Text(
                                                                      'DELETE'),
                                                                ),
                                                              ],
                                                            );
                                                          });
                                                        });
                                                  },
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color: Colors.red.shade400,
                                                  )),
                                            )),
                                          ]),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 175,
                            ),

                            Center(
                              child: Text(
                                "শ্রেণীঃ (${widget.ClassName.toString()})  রোলঃ (${widget.RollNo})   বিষয়ঃ (${widget.SubjectName})    মূল্যায়নঃ (${widget.ExamName}) আচরণিক ট্রান্সক্রিপ্ট"
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
                                          Container(
                                              child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Center(
                                                child: Text(
                                              "Delete",
                                              style: TextStyle(
                                                  fontSize: 17.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            )),
                                          )),
                                        ]),
                                    for (int i = 0;
                                        i < AllStudentPIData.length;
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
                                                AllStudentPIData[i]["BINo"].toString().toBijoy,
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
                                                AllStudentPIData[i]["BINoDescription"].toString().toBijoy,
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

                                                  AllStudentPIData[i]
                                                              ["BIAnswer"] ==
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
                                                      AllStudentPIData[i]["SquareDescription"].toString().toBijoy,
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
                                                  AllStudentPIData[i]
                                                              ["BIAnswer"] ==
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
                                                      AllStudentPIData[i]["CircleDescription"].toString().toBijoy,
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
                                                  AllStudentPIData[i]
                                                              ["BIAnswer"] ==
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
                                                      AllStudentPIData[i]["TriangleDescription"].toString().toBijoy,
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: IconButton(
                                                  onPressed: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return StatefulBuilder(
                                                              builder: (context,
                                                                  setState) {
                                                            return AlertDialog(
                                                              title: const Text(
                                                                  'Delete'),
                                                              content: const Text(
                                                                  'Are you Sure You want to Delete it?'),
                                                              actions: [
                                                                ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: const Text(
                                                                      'CANCEL'),
                                                                ),
                                                                ElevatedButton(
                                                                  onPressed:
                                                                      () async {
                                                                    setState(
                                                                      () {
                                                                        loading =
                                                                            true;
                                                                      },
                                                                    );

                                                                    CollectionReference
                                                                        collectionRef =
                                                                        FirebaseFirestore
                                                                            .instance
                                                                            .collection('NoticeInfo');
                                                                    collectionRef
                                                                        .doc(AllData[i]
                                                                            [
                                                                            "FileID"])
                                                                        .delete()
                                                                        .then(
                                                                          (doc) =>
                                                                              setState(() {
                                                                            getData();

                                                                            Navigator.pop(context);

                                                                            final snackBar =
                                                                                SnackBar(
                                                                              elevation: 0,
                                                                              behavior: SnackBarBehavior.floating,
                                                                              backgroundColor: Colors.transparent,
                                                                              content: AwesomeSnackbarContent(
                                                                                title: 'Delete Successfull',
                                                                                message: 'Hey Thank You. Good Job',

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
                                                                          onError: (e) =>
                                                                              setState(() {
                                                                            Navigator.pop(context);

                                                                            final snackBar =
                                                                                SnackBar(
                                                                              elevation: 0,
                                                                              behavior: SnackBarBehavior.floating,
                                                                              backgroundColor: Colors.transparent,
                                                                              content: AwesomeSnackbarContent(
                                                                                title: 'Something Wrong!!!',
                                                                                message: 'Try again later...',

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
                                                                  child: const Text(
                                                                      'DELETE'),
                                                                ),
                                                              ],
                                                            );
                                                          });
                                                        });
                                                  },
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color: Colors.red.shade400,
                                                  )),
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
