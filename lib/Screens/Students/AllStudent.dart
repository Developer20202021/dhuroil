import 'dart:convert';
import 'dart:io';
import 'package:bijoy_helper/bijoy_helper.dart';
import 'package:dhuroil/Screens/Students/AllExamResult.dart';
import 'package:dhuroil/Screens/Students/CreateNewExamResult.dart';
import 'package:dhuroil/Screens/Students/EditStudent.dart';
import 'package:dhuroil/Screens/Students/ExamFeeHistory.dart';
import 'package:dhuroil/Screens/Students/MonthlyFeeHistory.dart';
import 'package:dhuroil/Screens/Students/OtherFeeHistory.dart';
import 'package:dhuroil/Screens/Students/PIandBIExam/ClassWisePI.dart';
import 'package:dhuroil/Screens/Students/PIandBIExam/TranscriptPI.dart';
import 'package:dhuroil/Screens/Students/Pay/AllPay.dart';
import 'package:dhuroil/Screens/Students/PerClassRoutineView.dart';
import 'package:dhuroil/Screens/Students/ShowAttendance.dart';
import 'package:dhuroil/Screens/Students/StudentFileAndFileUpload.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:dhuroil/DeveloperAccess/DeveloperAccess.dart';
import 'package:dhuroil/Screens/Students/StudentProfile.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:universal_html/html.dart' as html;
import 'package:uuid/uuid.dart';

class AllStudents extends StatefulWidget {
  final indexNumber;
  final ClassName;

  const AllStudents(
      {super.key, required this.indexNumber, required this.ClassName});

  @override
  State<AllStudents> createState() => _AllStudentsState();
}

class _AllStudentsState extends State<AllStudents> {
  TextEditingController StudentRollNumberController = TextEditingController();

  TextEditingController StudentSendController = TextEditingController();

  TextEditingController StudentNewRollNoController = TextEditingController();

  TextEditingController PIFatherNoController = TextEditingController();

  TextEditingController PIGrandFatherNoController = TextEditingController();

  TextEditingController PINoController = TextEditingController();

  TextEditingController PIFatherNoDescriptionController =
      TextEditingController();

  TextEditingController PIGrandFatherNoDescriptionController =
      TextEditingController();

  TextEditingController PINoDescriptionController = TextEditingController();

  TextEditingController CircleController = TextEditingController();

  TextEditingController SquareController = TextEditingController();

  TextEditingController TriangleController = TextEditingController();

  TextEditingController TeacherNameController = TextEditingController();

  var uuid = Uuid();

  bool loading = false;

  var DataLoad = "";

  bool ExamFeeCollectionSwich = false;
  bool MonthlyFeeCollectionSwitch = false;

  String SelectedYear = "Select Year";
//  String SelectedDate ="Select Exam Year";

// UniCode to Bijoy Converter

  void getUniData() {
    print(unicodeToBijoy(
        "উভয় পাশে ধানের শীষে বেষ্টিত পানিতে ভাসমান জাতীয় ফুল শাপলা। তার মাথায় পাটগাছের পরস্পর সংযুক্ত তিনটি পাতা এবং উভয পাশে দুটি করে তারকা।"));
  }

  final List<String> items = [
    "0",
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    "9",
    "10",
    "ssc"
  ];
  String? selectedValue;

  List AllAbsenceData = [];
  int totalAbsence = 0;
  List AllPresenceData = [];
  int totalPresence = 0;

  Future<void> getPresenceData(String StudentEmail, context) async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();

    setState(() {
      loading = true;
    });

    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('StudentAttendance');

    Query query = _collectionRef
        .where("StudentEmail", isEqualTo: StudentEmail)
        .where("type", isEqualTo: "presence")
        .where("ClassName", isEqualTo: "${widget.ClassName}")
        .where("year", isEqualTo: "${DateTime.now().year}");
    QuerySnapshot querySnapshot = await query.get();

    // Get data from docs and convert map to List
    AllPresenceData = querySnapshot.docs.map((doc) => doc.data()).toList();

    setState(() {
      totalPresence = AllPresenceData.length;
    });

    if (AllPresenceData.isEmpty) {
      setState(() {
        loading = false;
      });

      getAbsenceData(StudentEmail, context);
    } else {
      setState(() {
        AllPresenceData = querySnapshot.docs.map((doc) => doc.data()).toList();

        loading = false;
      });

      getAbsenceData(StudentEmail, context);
    }
  }

  Future<void> getAbsenceData(String StudentEmail, context) async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();

    setState(() {
      loading = true;
    });

    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('StudentAttendance');

    Query query = _collectionRef
        .where("StudentEmail", isEqualTo: StudentEmail)
        .where("type", isEqualTo: "absence")
        .where("ClassName", isEqualTo: "${widget.ClassName}")
        .where("year", isEqualTo: "${DateTime.now().year}");
    QuerySnapshot querySnapshot = await query.get();

    // Get data from docs and convert map to List
    AllAbsenceData = querySnapshot.docs.map((doc) => doc.data()).toList();

    print(AllAbsenceData);

    setState(() {
      totalAbsence = AllAbsenceData.length;
    });

    final snackBar = SnackBar(
      duration: Duration(seconds: 7),
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title:
            'Presence:${(totalPresence / (totalPresence + totalAbsence)) * 100}%||Absence:${(totalAbsence / (totalPresence + totalAbsence)) * 100}%',
        message: 'Presence & Absence History',
        // Presence & Absence History
        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
        contentType: ContentType.success,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);

    if (AllAbsenceData.isEmpty) {
      setState(() {
        // Dataload ="0";

        loading = false;
      });
    } else {
      setState(() {
        AllAbsenceData = querySnapshot.docs.map((doc) => doc.data()).toList();

        loading = false;
      });
    }

    print(AllAbsenceData);
  }

// Firebase All Customer Data Load

  List AllData = [];

  Future<void> getData() async {
    // Get docs from collection reference
    CollectionReference _CustomerOrderHistoryCollectionRef =
        FirebaseFirestore.instance.collection('StudentInfo');

    Query _CustomerOrderHistoryCollectionRefDueQueryCount =
        _CustomerOrderHistoryCollectionRef.where("ClassName",
            isEqualTo: widget.ClassName);
    // .where("StudentStatus", isEqualTo: "new");

    // // all Due Query Count
    //    Query _CustomerOrderHistoryCollectionRefDueQueryCount = _CustomerOrderHistoryCollectionRef.where("Department", isEqualTo: widget.DepartmentName).where("Semister", isEqualTo: widget.SemisterName).where("StudentStatus", isEqualTo: "new");

    QuerySnapshot queryDueSnapshot =
        await _CustomerOrderHistoryCollectionRefDueQueryCount.get();

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

  Future<void> getSpecificData(String Status, context) async {
    // Get docs from collection reference
    CollectionReference _CustomerOrderHistoryCollectionRef =
        FirebaseFirestore.instance.collection('StudentInfo');

    Query _CustomerOrderHistoryCollectionRefDueQueryCount =
        _CustomerOrderHistoryCollectionRef.where("ClassName",
                isEqualTo: widget.ClassName)
            .where("StudentStatus", isEqualTo: Status);
    // .where("StudentStatus", isEqualTo: "new");

    // // all Due Query Count
    //    Query _CustomerOrderHistoryCollectionRefDueQueryCount = _CustomerOrderHistoryCollectionRef.where("Department", isEqualTo: widget.DepartmentName).where("Semister", isEqualTo: widget.SemisterName).where("StudentStatus", isEqualTo: "new");

    QuerySnapshot queryDueSnapshot =
        await _CustomerOrderHistoryCollectionRefDueQueryCount.get();

    var AllDueData = queryDueSnapshot.docs.map((doc) => doc.data()).toList();

    if (AllDueData.length == 0) {
      setState(() {
        Navigator.pop(context);
        DataLoad = "0";
        loading = false;
      });
    } else {
      setState(() {
        Navigator.pop(context);
        DataLoad = "";
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

    //  getUniData();

    getData();
    super.initState();
  }

  Future refresh() async {
    setState(() {
      // getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    FocusNode myFocusNode = new FocusNode();

    double width = MediaQuery.of(context).size.width;

    double height = MediaQuery.of(context).size.height;

    var PIID = uuid.v4();

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
          ),
        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
          toolbarHeight: 100,
          systemOverlayStyle: SystemUiOverlayStyle(
            // Navigation bar
            statusBarColor: ColorName().appColor, // Status bar
          ),
          iconTheme: IconThemeData(color: Color.fromRGBO(92, 107, 192, 1)),
          leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.chevron_left)),
          title: Container(
            width: MediaQuery.of(context).size.width * 0.75,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("All Students class:${widget.ClassName}"),
                Container(
                  width: 200,
                  child: TextField(
                    onChanged: (value) {},
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Roll No',

                      hintText: 'Enter Roll No',

                      //  enabledBorder: OutlineInputBorder(
                      //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                      //     ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3, color: Theme.of(context).primaryColor),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                      ),
                    ),
                    controller: StudentRollNumberController,
                  ),
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: Row(
                      children: [
                        Icon(
                          Icons.list,
                          size: 16,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Text(
                            'Select Class',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    items: items
                        .map((String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    value: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value;
                      });
                    },
                    buttonStyleData: ButtonStyleData(
                      height: 50,
                      width: 160,
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Colors.black26,
                        ),
                        color: ColorName().appColor,
                      ),
                      elevation: 2,
                    ),
                    iconStyleData: IconStyleData(
                      icon: Icon(
                        Icons.arrow_forward_ios_outlined,
                      ),
                      iconSize: 14,
                      iconEnabledColor: ColorName().appColor,
                      iconDisabledColor: Colors.grey,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: ColorName().appColor,
                      ),
                      offset: const Offset(-20, 0),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: MaterialStateProperty.all(6),
                        thumbVisibility: MaterialStateProperty.all(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding: EdgeInsets.only(left: 14, right: 14),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 160,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(255, 143, 158, 1),
                          Color.fromRGBO(255, 188, 143, 1),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(25.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.2),
                          spreadRadius: 4,
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        )
                      ]),
                  child: TextButton(
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDatePickerMode: DatePickerMode.year,
                        initialDate: DateTime(2000, 1, 1),
                        firstDate: DateTime(2000, 1, 1),
                        lastDate: DateTime(2090, 1, 1),
                      ).then((pickedDate) {
                        print(pickedDate);

                        setState(() {
                          SelectedYear = "Year: ${pickedDate?.year}";
                        });

                        // SelectedDate = "${pickedDate}";
                        // SelectedDate = SelectedDate.split(" ")[0];

                        print(SelectedYear);
                        // print(SelectedDate.split(" ")[0]);
                      });
                    },
                    child: Text(
                      "${SelectedYear}",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(ColorName().appColor),
                    ),
                  ),
                ),
                selectedValue == "" ||
                        StudentRollNumberController.text.isEmpty ||
                        SelectedYear == "Select Year" ||
                        SelectedYear == "null"
                    ? Text("")
                    : Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(255, 143, 158, 1),
                                Color.fromRGBO(255, 188, 143, 1),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(25.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.2),
                                spreadRadius: 4,
                                blurRadius: 10,
                                offset: Offset(0, 3),
                              )
                            ]),
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Search",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(
                                Colors.pink.shade300),
                          ),
                        ),
                      ),
              ],
            ),
          ),
          backgroundColor: Colors.transparent,
          bottomOpacity: 0.0,
          elevation: 0.0,
          centerTitle: true,
          actions: [
            PopupMenuButton(onSelected: (value) {
              // your logic
            }, itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  onTap: () {
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllDepartment()));
                  },
                  child: ListTile(
                    title: ExamFeeCollectionSwich
                        ? Text("Exam Fee Collection.Now ON")
                        : Text("Exam Fee Collection.Now OFF"),
                    trailing: Switch(
                      trackColor: MaterialStateProperty.all(Colors.black38),
                      activeColor: Colors.green.withOpacity(0.4),
                      inactiveThumbColor: Colors.red.withOpacity(0.4),
                      value: ExamFeeCollectionSwich,
                      onChanged: (value) {
                        setState(() {
                          ExamFeeCollectionSwich = value;

                          html.window.location.reload();
                        });
                      },
                    ),
                  ),
                  padding: EdgeInsets.all(18.0),
                ),
                PopupMenuItem(
                  onTap: () {
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllDepartment()));
                  },
                  child: ListTile(
                    title: MonthlyFeeCollectionSwitch
                        ? Text("Monthly Fee Collection.Now ON")
                        : Text("Monthly Fee Collection.Now OFF"),
                    trailing: Switch(
                      trackColor: MaterialStateProperty.all(Colors.black38),
                      activeColor: Colors.green.withOpacity(0.4),
                      inactiveThumbColor: Colors.red.withOpacity(0.4),
                      value: MonthlyFeeCollectionSwitch,
                      onChanged: (value) {
                        setState(() {
                          MonthlyFeeCollectionSwitch = value;

                          html.window.location.reload();
                        });
                      },
                    ),
                  ),
                  padding: EdgeInsets.all(18.0),
                ),
                PopupMenuItem(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CreateNewExamResult(
                              StudentClassName: "${widget.ClassName}",
                            )));
                  },
                  child: ListTile(
                    title: Text("Create Exam Result"),
                    trailing: Icon(Icons.arrow_forward),
                  ),
                  padding: EdgeInsets.all(18.0),
                ),
                PopupMenuItem(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PerClassRoutine(
                            indexNumber: "", ClassName: widget.ClassName)));
                  },
                  child: ListTile(
                    title: Text("View Routine"),
                    trailing: Icon(Icons.arrow_forward),
                  ),
                  padding: EdgeInsets.all(18.0),
                ),
                PopupMenuItem(
                  onTap: () {},
                  child: ListTile(
                    title: Text("Change Class"),
                    trailing: Icon(Icons.arrow_forward),
                  ),
                  padding: EdgeInsets.all(18.0),
                ),
                PopupMenuItem(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: ListTile(
                        trailing: Icon(Icons.arrow_forward),
                        title: Text("Search By Status")),
                  ),
                  value: '/about',
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (context) {
                        String SelectedStudentStatus = "";

                        return StatefulBuilder(
                          builder: (context, setState) {
                            return AlertDialog(
                              title: const Text("Please Select a Status."),
                              content: Container(
                                height: 70,
                                child: Column(
                                  children: [
                                    DropdownButton(
                                      hint: SelectedStudentStatus == ""
                                          ? const Text('Select Student Status')
                                          : Text(
                                              SelectedStudentStatus,
                                              style: TextStyle(
                                                  color: ColorName().appColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                      isExpanded: true,
                                      iconSize: 30.0,
                                      style: TextStyle(
                                          color: ColorName().appColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                      items: ["New", 'Old', "Running"].map(
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
                                            SelectedStudentStatus = val!;

                                            print(val);
                                          },
                                        );
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("Cancel"),
                                ),
                                SelectedStudentStatus == ""
                                    ? Text("")
                                    : TextButton(
                                        onPressed: () async {
                                          getSpecificData(
                                              SelectedStudentStatus.toString()
                                                  .toLowerCase(),
                                              context);
                                        },
                                        child: const Text("Find"),
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
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: ListTile(
                        trailing: Icon(Icons.arrow_forward),
                        title: Text("Create PI")),
                  ),
                  value: '/about',
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (context) {
                        String SelectedExam = "";

                        String SelectedSubject = "";

                        String SubjectNameTitle = "বিষয় নির্বাচন করবেন";

                        String PIGrandFatherNoTextFieldTitle =
                            "অভিজ্ঞতা নং / পারদর্শিতার ক্ষেত্র নং";

                        String PIFatherNoTextFieldTitle = "একক যোগ্যতা নং";

                        String PINoTextFieldTitle = "PI No";

                        String PIGrandFatherNoTextFieldDescription =
                            "অভিজ্ঞতা বর্ণনা / পারদর্শিতার ক্ষেত্র বর্ণনা";

                        String PIFatherNoTextFieldDescription =
                            "একক যোগ্যতা বর্ণনা";

                        String PINoTextFieldDescription =
                            "পারদর্শিতা নির্দেশক বর্ণনা";

                        String AlertTitle =
                            "আপনি নিচে প্রথমে মূল্যায়নের নাম এবং যে বিষয়ের মূল্যায়ন তৈরী করতে চান তা নির্বাচন করবেন";

                        String ExamNameTitle = "মূল্যায়নের নাম নির্বাচন করবেন";

                        return StatefulBuilder(
                          builder: (context, setState) {
                            return AlertDialog(
                              title: Center(
                                child: Text("${AlertTitle.toBijoy}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "SiyamRupali")),
                              ),
                              content: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    DropdownButton(
                                      hint: SelectedExam == ""
                                          ? Text("${ExamNameTitle.toBijoy}",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "SiyamRupali"))
                                          : Text("${SelectedExam.toBijoy}",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "SiyamRupali")),
                                      isExpanded: true,
                                      iconSize: 30.0,
                                      style: TextStyle(
                                          color: ColorName().appColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                      items: [
                                        "ষাণ্মাসিক শিখনকালীন মূল্যায়ন",
                                        'ষাণ্মাসিক সামষ্টিক মূল্যায়ন',
                                        "বাৎসরিক শিখনকালীন মূল্যায়ন",
                                        "বাৎসরিক সামষ্টিক মূল্যায়ন"
                                      ].map(
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
                                            SelectedExam = val!;

                                            print(val);
                                          },
                                        );
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    DropdownButton(
                                      hint: SelectedSubject == ""
                                          ? Text("${SubjectNameTitle.toBijoy}",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "SiyamRupali"))
                                          : Text("${SelectedSubject.toBijoy}",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "SiyamRupali")),
                                      isExpanded: true,
                                      iconSize: 30.0,
                                      style: TextStyle(
                                          color: ColorName().appColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                      items: [
                                        "বাংলা",
                                        'ইংরেজি',
                                        "গণিত",
                                        "বিজ্ঞান অনুসন্ধানী পাঠ",
                                        "বিজ্ঞান অনুশীলন বই",
                                        "ইতিহাস ও সামাজিক বিজ্ঞান অনুসন্ধানী পাঠ",
                                        "ইতিহাস ও সামাজিক বিজ্ঞান অনুশীলন বই",
                                        "ডিজিটাল প্রযুক্তি",
                                        "স্বাস্থ্য সুরক্ষা",
                                        "জীবন ও জীবিকা",
                                        "শিল্প ও সংস্কৃতি",
                                        "ইসলাম শিক্ষা",
                                        "হিন্দুর্ধম শিক্ষা",
                                        "খ্রিষ্টধর্ম শিক্ষা",
                                        "বৌদ্ধধর্ম শিক্ষা",
                                      ].map(
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
                                            SelectedSubject = val!;

                                            print(val);
                                          },
                                        );
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      width: 600,
                                      child: TextField(
                                        onChanged: (value) {},
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'শিক্ষকের নাম'.toBijoy,
                                          labelStyle: TextStyle(
                                              fontFamily: "SiyamRupali"),

                                          hintText: 'শিক্ষকের নাম'.toBijoy,
                                          hintStyle: TextStyle(
                                              fontFamily: "SiyamRupali"),

                                          //  enabledBorder: OutlineInputBorder(
                                          //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                                          //     ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 3,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                          errorBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 3,
                                                color: Color.fromARGB(
                                                    255, 66, 125, 145)),
                                          ),
                                        ),
                                        controller: TeacherNameController,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      width: 600,
                                      child: TextField(
                                        onChanged: (value) {},
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText:
                                              '${PIGrandFatherNoTextFieldTitle.toBijoy}',
                                          labelStyle: TextStyle(
                                              fontFamily: "SiyamRupali"),
                                          hintText:
                                              '${PIGrandFatherNoTextFieldTitle.toBijoy}',
                                          hintStyle: TextStyle(
                                              fontFamily: "SiyamRupali"),

                                          //  enabledBorder: OutlineInputBorder(
                                          //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                                          //     ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 3,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                          errorBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 3,
                                                color: Color.fromARGB(
                                                    255, 66, 125, 145)),
                                          ),
                                        ),
                                        controller: PIGrandFatherNoController,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      width: 600,
                                      child: TextField(
                                        maxLength: 2000,
                                        onChanged: (value) {},
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText:
                                              '${PIGrandFatherNoTextFieldDescription.toBijoy}',
                                          labelStyle: TextStyle(
                                              fontFamily: "SiyamRupali"),
                                          hintText:
                                              '${PIGrandFatherNoTextFieldDescription.toBijoy}',
                                          hintStyle: TextStyle(
                                              fontFamily: "SiyamRupali"),

                                          //  enabledBorder: OutlineInputBorder(
                                          //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                                          //     ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 3,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                          errorBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 3,
                                                color: Color.fromARGB(
                                                    255, 66, 125, 145)),
                                          ),
                                        ),
                                        controller:
                                            PIGrandFatherNoDescriptionController,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      width: 600,
                                      child: TextField(
                                        onChanged: (value) {},
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText:
                                              '${PIFatherNoTextFieldTitle.toBijoy}',
                                          labelStyle: TextStyle(
                                              fontFamily: "SiyamRupali"),

                                          hintText:
                                              '${PIFatherNoTextFieldTitle.toBijoy}',
                                          hintStyle: TextStyle(
                                              fontFamily: "SiyamRupali"),

                                          //  enabledBorder: OutlineInputBorder(
                                          //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                                          //     ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 3,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                          errorBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 3,
                                                color: Color.fromARGB(
                                                    255, 66, 125, 145)),
                                          ),
                                        ),
                                        controller: PIFatherNoController,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      width: 600,
                                      child: TextField(
                                        maxLength: 2000,
                                        onChanged: (value) {},
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText:
                                              '${PIFatherNoTextFieldDescription.toBijoy}',
                                          labelStyle: TextStyle(
                                              fontFamily: "SiyamRupali"),

                                          hintText:
                                              '${PIFatherNoTextFieldDescription.toBijoy}',
                                          hintStyle: TextStyle(
                                              fontFamily: "SiyamRupali"),

                                          //  enabledBorder: OutlineInputBorder(
                                          //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                                          //     ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 3,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                          errorBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 3,
                                                color: Color.fromARGB(
                                                    255, 66, 125, 145)),
                                          ),
                                        ),
                                        controller:
                                            PIFatherNoDescriptionController,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      width: 600,
                                      child: TextField(
                                        onChanged: (value) {},
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: '${PINoTextFieldTitle}',

                                          hintText: '${PINoTextFieldTitle}',

                                          //  enabledBorder: OutlineInputBorder(
                                          //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                                          //     ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 3,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                          errorBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 3,
                                                color: Color.fromARGB(
                                                    255, 66, 125, 145)),
                                          ),
                                        ),
                                        controller: PINoController,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      width: 600,
                                      child: TextField(
                                        maxLength: 2000,
                                        onChanged: (value) {},
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText:
                                              '${PINoTextFieldDescription.toBijoy}',
                                          labelStyle: TextStyle(
                                              fontFamily: "SiyamRupali"),

                                          hintText:
                                              '${PINoTextFieldDescription.toBijoy}',
                                          hintStyle: TextStyle(
                                              fontFamily: "SiyamRupali"),

                                          //  enabledBorder: OutlineInputBorder(
                                          //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                                          //     ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 3,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                          errorBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 3,
                                                color: Color.fromARGB(
                                                    255, 66, 125, 145)),
                                          ),
                                        ),
                                        controller: PINoDescriptionController,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    const Center(
                                      child: Text(
                                          "পারদর্শিতার মাত্রার বর্ণনা লিখুন",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "SiyamRupali")),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextField(
                                      onChanged: (value) {},
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        prefixIcon: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child:
                                              FaIcon(FontAwesomeIcons.square),
                                        ),
                                        helperStyle: TextStyle(
                                            color: Colors.red.shade400),
                                        border: const OutlineInputBorder(),
                                        labelText: 'বর্ণনা লিখুন',
                                        labelStyle: const TextStyle(
                                            fontFamily: "SiyamRupali"),
                                        hintText: 'বর্ণনা লিখুন',
                                        hintStyle: const TextStyle(
                                            fontFamily: "SiyamRupali"),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 3,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                        errorBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 3,
                                              color: Color.fromARGB(
                                                  255, 66, 125, 145)),
                                        ),
                                      ),
                                      controller: SquareController,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextField(
                                      onChanged: (value) {},
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        prefixIcon: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child:
                                              FaIcon(FontAwesomeIcons.circle),
                                        ),
                                        helperStyle: TextStyle(
                                            color: Colors.red.shade400),
                                        border: const OutlineInputBorder(),
                                        labelText: 'বর্ণনা লিখুন',
                                        labelStyle: const TextStyle(
                                            fontFamily: "SiyamRupali"),
                                        hintText: 'বর্ণনা লিখুন',
                                        hintStyle: const TextStyle(
                                            fontFamily: "SiyamRupali"),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 3,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                        errorBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 3,
                                              color: Color.fromARGB(
                                                  255, 66, 125, 145)),
                                        ),
                                      ),
                                      controller: CircleController,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextField(
                                      onChanged: (value) {},
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        prefixIcon: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: FaIcon(
                                            FontAwesomeIcons.caretUp,
                                            size: 40,
                                          ),
                                        ),
                                        helperStyle: TextStyle(
                                            color: Colors.red.shade400),
                                        border: const OutlineInputBorder(),
                                        labelText: 'বর্ণনা লিখুন',
                                        labelStyle: const TextStyle(
                                            fontFamily: "SiyamRupali"),
                                        hintText: 'বর্ণনা লিখুন',
                                        hintStyle: const TextStyle(
                                            fontFamily: "SiyamRupali"),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 3,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                        errorBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 3,
                                              color: Color.fromARGB(
                                                  255, 66, 125, 145)),
                                        ),
                                      ),
                                      controller: TriangleController,
                                    ),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("Cancel"),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    setState(() {
                                      loading = true;
                                    });

// PI Data Create from here

                                    var SchoolPIData = {
                                      "PIID": PIID,
                                      "ExamName": SelectedExam.toBijoy,
                                      "ClassName": widget.ClassName,
                                      "SubjectName": SelectedSubject.toBijoy,
                                      "TeacherName": TeacherNameController.text
                                          .trim()
                                          .toLowerCase(),
                                      "PIGrandFatherNo":
                                          PIGrandFatherNoController.text
                                              .trim()
                                              .toBijoy,
                                      "PIGrandFatherNoDescription":
                                          PIGrandFatherNoDescriptionController
                                              .text
                                              .trim()
                                              .toBijoy,
                                      "PIFatherNo": PIFatherNoController.text
                                          .trim()
                                          .toBijoy,
                                      "PIFatherNoDescription":
                                          PIFatherNoDescriptionController.text
                                              .trim()
                                              .toBijoy,
                                      "PINo":
                                          PINoController.text.trim().toBijoy,
                                      "PINoDescription":
                                          PINoDescriptionController.text
                                              .trim()
                                              .toBijoy,
                                      "SquareDescription":
                                          SquareController.text.trim().toBijoy,
                                      "CircleDescription":
                                          CircleController.text.trim().toBijoy,
                                      "TriangleDescription": TriangleController
                                          .text
                                          .trim()
                                          .toBijoy,
                                      "DateTime":
                                          DateTime.now().toIso8601String(),
                                      "year": "${DateTime.now().year}"
                                    };

                                    final SchoolPI = FirebaseFirestore.instance
                                        .collection('SchoolPIData')
                                        .doc(PIID);

                                    SchoolPI.set(SchoolPIData)
                                        .then((value) => setState(() {
                                              getData();

                                              Navigator.pop(context);

                                              final snackBar = SnackBar(
                                                elevation: 0,
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                backgroundColor:
                                                    Colors.transparent,
                                                content: AwesomeSnackbarContent(
                                                  title:
                                                      'PI Created Successfull',
                                                  message:
                                                      'Hey Thank You. Good Job',

                                                  /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                                  contentType:
                                                      ContentType.success,
                                                ),
                                              );

                                              ScaffoldMessenger.of(context)
                                                ..hideCurrentSnackBar()
                                                ..showSnackBar(snackBar);

                                              setState(() {
                                                loading = false;
                                              });
                                            }))
                                        .onError((error, stackTrace) =>
                                            setState(() {
                                              final snackBar = SnackBar(
                                                /// need to set following properties for best effect of awesome_snackbar_content
                                                elevation: 0,
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                backgroundColor:
                                                    Colors.transparent,
                                                content: AwesomeSnackbarContent(
                                                  title: 'Something Wrong!!!!',
                                                  message: 'Try again later...',

                                                  /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                                  contentType:
                                                      ContentType.failure,
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
                                  child: const Text("Create"),
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
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: ListTile(
                        trailing: Icon(Icons.arrow_forward),
                        title: Text("Create BI")),
                  ),
                  value: '/about',
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (context) {
                        String SelectedExam = "";

                       

                     

                        String BIFatherNoTextFieldTitle =
                            "আচরণিক ক্ষেত্র নং";

                        

                        String BINoTextFieldTitle = "BI No";

                        String BIFatherNoTextFieldDescription =
                            "আচরণিক ক্ষেত্র বর্ণনা";


                        String BINoTextFieldDescription =
                            "আচরণিক নির্দেশক বর্ণনা";

                        String AlertTitle =
                            "আপনি নিচে মূল্যায়নের নাম নির্বাচন করবেন";

                        String ExamNameTitle = "মূল্যায়নের নাম নির্বাচন করবেন";

                        return StatefulBuilder(
                          builder: (context, setState) {
                            return AlertDialog(
                              title: Center(
                                child: Text("${AlertTitle.toBijoy}",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "SiyamRupali")),
                              ),
                              content: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    DropdownButton(
                                      hint: SelectedExam == ""
                                          ? Text("${ExamNameTitle.toBijoy}",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "SiyamRupali"))
                                          : Text("${SelectedExam.toBijoy}",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "SiyamRupali")),
                                      isExpanded: true,
                                      iconSize: 30.0,
                                      style: TextStyle(
                                          color: ColorName().appColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                      items: [
                                        "ষাণ্মাসিক শিখনকালীন মূল্যায়ন",
                                        'ষাণ্মাসিক সামষ্টিক মূল্যায়ন',
                                        "বাৎসরিক শিখনকালীন মূল্যায়ন",
                                        "বাৎসরিক সামষ্টিক মূল্যায়ন"
                                      ].map(
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
                                            SelectedExam = val!;

                                            print(val);
                                          },
                                        );
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                
                             
                                    Container(
                                      width: 600,
                                      child: TextField(
                                        onChanged: (value) {},
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText:
                                              '${BIFatherNoTextFieldTitle.toBijoy}',
                                          labelStyle: const TextStyle(
                                              fontFamily: "SiyamRupali"),
                                          hintText:
                                              '${BIFatherNoTextFieldTitle.toBijoy}',
                                          hintStyle: const TextStyle(
                                              fontFamily: "SiyamRupali"),

                                          //  enabledBorder: OutlineInputBorder(
                                          //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                                          //     ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 3,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                          errorBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 3,
                                                color: Color.fromARGB(
                                                    255, 66, 125, 145)),
                                          ),
                                        ),
                                        controller: PIGrandFatherNoController,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      width: 600,
                                      child: TextField(
                                        maxLength: 2000,
                                        onChanged: (value) {},
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText:
                                              BIFatherNoTextFieldDescription.toBijoy,
                                          labelStyle: const TextStyle(
                                              fontFamily: "SiyamRupali"),
                                          hintText:
                                              BIFatherNoTextFieldDescription.toBijoy,
                                          hintStyle: const TextStyle(
                                              fontFamily: "SiyamRupali"),

                                          //  enabledBorder: OutlineInputBorder(
                                          //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                                          //     ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 3,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                          errorBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 3,
                                                color: Color.fromARGB(
                                                    255, 66, 125, 145)),
                                          ),
                                        ),
                                        controller:
                                            PIGrandFatherNoDescriptionController,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                   
                                 
                                    Container(
                                      width: 600,
                                      child: TextField(
                                        onChanged: (value) {},
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: '${BINoTextFieldTitle}',

                                          hintText: '${BINoTextFieldTitle}',

                                          //  enabledBorder: OutlineInputBorder(
                                          //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                                          //     ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 3,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                          errorBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 3,
                                                color: Color.fromARGB(
                                                    255, 66, 125, 145)),
                                          ),
                                        ),
                                        controller: PINoController,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      width: 600,
                                      child: TextField(
                                        maxLength: 2000,
                                        onChanged: (value) {},
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText:
                                              '${BINoTextFieldDescription.toBijoy}',
                                          labelStyle: const TextStyle(
                                              fontFamily: "SiyamRupali"),

                                          hintText:
                                              BINoTextFieldDescription.toBijoy,
                                          hintStyle: const TextStyle(
                                              fontFamily: "SiyamRupali"),

                                          //  enabledBorder: OutlineInputBorder(
                                          //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                                          //     ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 3,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                          errorBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 3,
                                                color: Color.fromARGB(
                                                    255, 66, 125, 145)),
                                          ),
                                        ),
                                        controller: PINoDescriptionController,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Center(
                                      child: Text(
                                          "আচরণিক মাত্রার বর্ণনা লিখুন",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "SiyamRupali")),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextField(
                                      onChanged: (value) {},
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        prefixIcon: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child:
                                              FaIcon(FontAwesomeIcons.square),
                                        ),
                                        helperStyle: TextStyle(
                                            color: Colors.red.shade400),
                                        border: const OutlineInputBorder(),
                                        labelText: 'বর্ণনা লিখুন',
                                        labelStyle: const TextStyle(
                                            fontFamily: "SiyamRupali"),
                                        hintText: 'বর্ণনা লিখুন',
                                        hintStyle: const TextStyle(
                                            fontFamily: "SiyamRupali"),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 3,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                        errorBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 3,
                                              color: Color.fromARGB(
                                                  255, 66, 125, 145)),
                                        ),
                                      ),
                                      controller: SquareController,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextField(
                                      onChanged: (value) {},
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        prefixIcon: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child:
                                              FaIcon(FontAwesomeIcons.circle),
                                        ),
                                        helperStyle: TextStyle(
                                            color: Colors.red.shade400),
                                        border: const OutlineInputBorder(),
                                        labelText: 'বর্ণনা লিখুন',
                                        labelStyle: const TextStyle(
                                            fontFamily: "SiyamRupali"),
                                        hintText: 'বর্ণনা লিখুন',
                                        hintStyle: const TextStyle(
                                            fontFamily: "SiyamRupali"),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 3,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                        errorBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 3,
                                              color: Color.fromARGB(
                                                  255, 66, 125, 145)),
                                        ),
                                      ),
                                      controller: CircleController,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextField(
                                      onChanged: (value) {},
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        prefixIcon: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: FaIcon(
                                            FontAwesomeIcons.caretUp,
                                            size: 40,
                                          ),
                                        ),
                                        helperStyle: TextStyle(
                                            color: Colors.red.shade400),
                                        border: const OutlineInputBorder(),
                                        labelText: 'বর্ণনা লিখুন',
                                        labelStyle: const TextStyle(
                                            fontFamily: "SiyamRupali"),
                                        hintText: 'বর্ণনা লিখুন',
                                        hintStyle: const TextStyle(
                                            fontFamily: "SiyamRupali"),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 3,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                        errorBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 3,
                                              color: Color.fromARGB(
                                                  255, 66, 125, 145)),
                                        ),
                                      ),
                                      controller: TriangleController,
                                    ),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("Cancel"),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    setState(() {
                                      loading = true;
                                    });

// PI Data Create from here

                                    var SchoolPIData = {
                                      "BIID": PIID,
                                      "ExamName": SelectedExam.toBijoy,
                                      "ClassName": widget.ClassName,
                                      
                                  
                                      "PIGrandFatherNo":
                                          PIGrandFatherNoController.text
                                              .trim()
                                              .toBijoy,
                                      "PIGrandFatherNoDescription":
                                          PIGrandFatherNoDescriptionController
                                              .text
                                              .trim()
                                              .toBijoy,
                                      "PIFatherNo": PIFatherNoController.text
                                          .trim()
                                          .toBijoy,
                                      "PIFatherNoDescription":
                                          PIFatherNoDescriptionController.text
                                              .trim()
                                              .toBijoy,
                                      "PINo":
                                          PINoController.text.trim().toBijoy,
                                      "PINoDescription":
                                          PINoDescriptionController.text
                                              .trim()
                                              .toBijoy,
                                      "SquareDescription":
                                          SquareController.text.trim().toBijoy,
                                      "CircleDescription":
                                          CircleController.text.trim().toBijoy,
                                      "TriangleDescription": TriangleController
                                          .text
                                          .trim()
                                          .toBijoy,
                                      "DateTime":
                                          DateTime.now().toIso8601String(),
                                      "year": "${DateTime.now().year}"
                                    };

                                    final SchoolPI = FirebaseFirestore.instance
                                        .collection('SchoolBIData')
                                        .doc(PIID);

                                    SchoolPI.set(SchoolPIData)
                                        .then((value) => setState(() {
                                              getData();

                                              Navigator.pop(context);

                                              final snackBar = SnackBar(
                                                elevation: 0,
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                backgroundColor:
                                                    Colors.transparent,
                                                content: AwesomeSnackbarContent(
                                                  title:
                                                      'PI Created Successfull',
                                                  message:
                                                      'Hey Thank You. Good Job',

                                                  /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                                  contentType:
                                                      ContentType.success,
                                                ),
                                              );

                                              ScaffoldMessenger.of(context)
                                                ..hideCurrentSnackBar()
                                                ..showSnackBar(snackBar);

                                              setState(() {
                                                loading = false;
                                              });
                                            }))
                                        .onError((error, stackTrace) =>
                                            setState(() {
                                              final snackBar = SnackBar(
                                                /// need to set following properties for best effect of awesome_snackbar_content
                                                elevation: 0,
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                backgroundColor:
                                                    Colors.transparent,
                                                content: AwesomeSnackbarContent(
                                                  title: 'Something Wrong!!!!',
                                                  message: 'Try again later...',

                                                  /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                                  contentType:
                                                      ContentType.failure,
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
                                  child: const Text("Create"),
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
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: ListTile(
                        trailing: Icon(Icons.arrow_forward),
                        title: Text(
                            "ফলাফল তৈরীর জন্য চূড়ান্ত পিআই প্রস্তুত করুন",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: "SiyamRupali"))),
                  ),
                  value: '/about',
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (context) {
                        String SelectedSubject = "";

                        String SubjectNameTitle = "বিষয় নির্বাচন করুন";

                        bool? checkedValueOne = false;

                        bool? checkedValueTwo = false;

                        bool? checkedValueThree = false;

                        bool? checkedValueFour = false;

                        return StatefulBuilder(
                          builder: (context, setState) {
                            return AlertDialog(
                              title: Text(
                                  "চূড়ান্ত ফলাফল প্রস্তুতির জন্য বিষয় নির্বাচন করবেন এবং বছর নির্বাচন করবেন।"
                                      .toBijoy,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "SiyamRupali")),
                              content: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    DropdownButton(
                                      hint: SelectedSubject == ""
                                          ? Text("${SubjectNameTitle.toBijoy}",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "SiyamRupali"))
                                          : Text("${SelectedSubject.toBijoy}",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "SiyamRupali")),
                                      isExpanded: true,
                                      iconSize: 30.0,
                                      style: TextStyle(
                                          color: ColorName().appColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                      items: [
                                        "বাংলা",
                                        'ইংরেজি',
                                        "গণিত",
                                        "বিজ্ঞান অনুসন্ধানী পাঠ",
                                        "বিজ্ঞান অনুশীলন বই",
                                        "ইতিহাস ও সামাজিক বিজ্ঞান অনুসন্ধানী পাঠ",
                                        "ইতিহাস ও সামাজিক বিজ্ঞান অনুশীলন বই",
                                        "ডিজিটাল প্রযুক্তি",
                                        "স্বাস্থ্য সুরক্ষা",
                                        "জীবন ও জীবিকা",
                                        "শিল্প ও সংস্কৃতি",
                                        "ইসলাম শিক্ষা",
                                        "হিন্দুর্ধম শিক্ষা",
                                        "খ্রিষ্টধর্ম শিক্ষা",
                                        "বৌদ্ধধর্ম শিক্ষা",
                                      ].map(
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
                                            SelectedSubject = val!;

                                            print(val);
                                          },
                                        );
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    CheckboxListTile(
                                      title: Text(
                                          "ষাণ্মাসিক শিখনকালীন মূল্যায়ন"
                                              .toBijoy,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "SiyamRupali")),
                                      value: checkedValueOne,
                                      onChanged: (newValue) {
                                        setState(() {
                                          checkedValueOne = newValue;
                                        });
                                      },
                                      controlAffinity: ListTileControlAffinity
                                          .leading, //  <-- leading Checkbox
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    CheckboxListTile(
                                      title: Text(
                                          "ষাণ্মাসিক সামষ্টিক মূল্যায়ন".toBijoy,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "SiyamRupali")),
                                      value: checkedValueTwo,
                                      onChanged: (newValue) {
                                        setState(() {
                                          checkedValueTwo = newValue;
                                        });
                                      },
                                      controlAffinity: ListTileControlAffinity
                                          .leading, //  <-- leading Checkbox
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    CheckboxListTile(
                                      title: Text(
                                          "বাৎসরিক শিখনকালীন মূল্যায়ন".toBijoy,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "SiyamRupali")),
                                      value: checkedValueThree,
                                      onChanged: (newValue) {
                                        setState(() {
                                          checkedValueThree = newValue;
                                        });
                                      },
                                      controlAffinity: ListTileControlAffinity
                                          .leading, //  <-- leading Checkbox
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    CheckboxListTile(
                                      title: Text(
                                          "বাৎসরিক সামষ্টিক মূল্যায়ন".toBijoy,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "SiyamRupali")),
                                      value: checkedValueFour,
                                      onChanged: (newValue) {
                                        setState(() {
                                          checkedValueFour = newValue;
                                        });
                                      },
                                      controlAffinity: ListTileControlAffinity
                                          .leading, //  <-- leading Checkbox
                                    ),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("Cancel"),
                                ),
                                ElevatedButton(
                                    onPressed: () async {
                                      setState(() {
                                        loading = true;
                                      });

                                      List SelectedExamNameList = [
                                        checkedValueOne,
                                        checkedValueTwo,
                                        checkedValueThree,
                                        checkedValueFour
                                      ];

                                      List AllExamName = [
                                        "ষাণ্মাসিক শিখনকালীন মূল্যায়ন",
                                        'ষাণ্মাসিক সামষ্টিক মূল্যায়ন',
                                        "বাৎসরিক শিখনকালীন মূল্যায়ন",
                                        "বাৎসরিক সামষ্টিক মূল্যায়ন"
                                      ];

                                      List AllPINo = [];

                                      Future closeChurantoPI(
                                          List ExamName,
                                          String SubjectName,
                                          String year) async {
                                        // Get docs from collection reference
                                        CollectionReference
                                            _ChurantoPICollectionRef =
                                            FirebaseFirestore.instance
                                                .collection(
                                                    'ChurantoSchoolPIData');

                                        Query _ChurantoPICollectionRefCount =
                                            _ChurantoPICollectionRef.where(
                                                    "ClassName",
                                                    isEqualTo: widget.ClassName)
                                                .where("SubjectName",
                                                    isEqualTo:
                                                        SubjectName.toBijoy)
                                                .where("ExamName",
                                                    isEqualTo: ExamName)
                                                .where("year", isEqualTo: year);

                                        QuerySnapshot ChurantoPISnapshot =
                                            await _ChurantoPICollectionRefCount
                                                .get();

                                        List AllChurantoPI = ChurantoPISnapshot
                                            .docs
                                            .map((doc) => doc.data())
                                            .toList();

                                        if (AllChurantoPI.isEmpty) {


                                        } else {
                                          CollectionReference collectionRef =
                                              FirebaseFirestore.instance
                                                  .collection(
                                                      'ChurantoSchoolPIData');
                                          collectionRef
                                              .doc(AllChurantoPI[0]["ChurantoPIID"])
                                              .delete()
                                              .then(
                                                (doc) => setState(() {print("Delete Successfull");}),
                                                onError: (e) => setState(() {}),
                                              );
                                        }
                                      }

                                      // close same churanto PI Function

                                      closeChurantoPI(
                                          SelectedExamNameList,
                                          SelectedSubject.toBijoy,
                                          "${DateTime.now().year}");

                                      for (int ExamNameIndex = 0;
                                          ExamNameIndex <
                                              SelectedExamNameList.length;
                                          ExamNameIndex++) {
                                        if (SelectedExamNameList[
                                            ExamNameIndex]) {
                                          // Get docs from collection reference
                                          CollectionReference SchoolPIDataRef =
                                              FirebaseFirestore.instance
                                                  .collection('SchoolPIData');

                                          Query SchoolPIDataRefCount =
                                              SchoolPIDataRef.where("ClassName",
                                                      isEqualTo:
                                                          widget.ClassName)
                                                  .where("SubjectName",
                                                      isEqualTo: SelectedSubject
                                                          .toBijoy)
                                                  .where("ExamName",
                                                      isEqualTo: AllExamName[
                                                              ExamNameIndex]
                                                          .toString()
                                                          .toBijoy);

                                          QuerySnapshot SchoolPIDataSnapshot =
                                              await SchoolPIDataRefCount.get();

                                          List SchoolPIData =
                                              SchoolPIDataSnapshot.docs
                                                  .map((doc) => doc.data())
                                                  .toList();

                                          if (SchoolPIData.length == 0) {
                                            // setState(() {
                                            //   DataLoad = "0";
                                            //   loading = false;
                                            // });

                                            print(
                                                "No ${AllExamName[ExamNameIndex]}");
                                          } else {
                                            setState(() {
                                              SchoolPIData =
                                                  SchoolPIDataSnapshot.docs
                                                      .map((doc) => doc.data())
                                                      .toList();

                                              for (int i = 0;
                                                  i < SchoolPIData.length;
                                                  i++) {
                                                AllPINo.insert(AllPINo.length,
                                                    SchoolPIData[i]["PINo"]);
                                              }

                                              List nonMachedPINo =
                                                  AllPINo.toSet().toList();

                                              var ChurantoSchoolPIData = {
                                                "ChurantoPIID": PIID,
                                                "ExamName":
                                                    SelectedExamNameList,
                                                "ClassName": widget.ClassName,
                                                "SubjectName":
                                                    SelectedSubject.toBijoy,
                                                "TeacherName":
                                                    TeacherNameController.text
                                                        .trim()
                                                        .toLowerCase(),
                                                "PINo": nonMachedPINo,
                                                "DateTime": DateTime.now()
                                                    .toIso8601String(),
                                                "year": "${DateTime.now().year}"
                                              };

                                              final SchoolPI = FirebaseFirestore
                                                  .instance
                                                  .collection(
                                                      'ChurantoSchoolPIData')
                                                  .doc(PIID);

                                              SchoolPI.set(ChurantoSchoolPIData)
                                                  .then((value) => setState(() {
                                                        getData();

                                                        Navigator.pop(context);

                                                        final snackBar =
                                                            SnackBar(
                                                          elevation: 0,
                                                          behavior:
                                                              SnackBarBehavior
                                                                  .floating,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          content:
                                                              AwesomeSnackbarContent(
                                                            title:
                                                                'PI  Successfull',
                                                            message:
                                                                'Hey Thank You. Good Job',

                                                            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                                            contentType:
                                                                ContentType
                                                                    .success,
                                                          ),
                                                        );

                                                        ScaffoldMessenger.of(
                                                            context)
                                                          ..hideCurrentSnackBar()
                                                          ..showSnackBar(
                                                              snackBar);

                                                        setState(() {
                                                          loading = false;
                                                        });
                                                      }))
                                                  .onError((error,
                                                          stackTrace) =>
                                                      setState(() {
                                                        final snackBar =
                                                            SnackBar(
                                                          /// need to set following properties for best effect of awesome_snackbar_content
                                                          elevation: 0,
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
                                                                ContentType
                                                                    .failure,
                                                          ),
                                                        );

                                                        ScaffoldMessenger.of(
                                                            context)
                                                          ..hideCurrentSnackBar()
                                                          ..showSnackBar(
                                                              snackBar);

                                                        setState(() {
                                                          loading = false;
                                                        });
                                                      }));

                                            });
                                          }
                                        } else {
                                          continue;
                                        }

                                        // setState(() {
                                        //   loading = false;
                                        // });
                                      }
                                    },
                                    child: Text("নিশ্চিত করবেন".toBijoy,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "SiyamRupali"))),
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ];
            })
          ]),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : DataLoad == "0"
              ? Center(child: Text("No Data Available"))
              : RefreshIndicator(
                  onRefresh: refresh,
                  child: Padding(
                    padding: const EdgeInsets.all(36),
                    child: DataTable2(
                        isHorizontalScrollBarVisible: true,
                        headingTextStyle: TextStyle(color: Colors.white),
                        headingRowDecoration:
                            BoxDecoration(color: Colors.pink.shade300),
                        columnSpacing: 12,
                        horizontalMargin: 12,
                        minWidth: 1500,
                        smRatio: 0.75,
                        lmRatio: 1.5,
                        columns: const [
                          DataColumn2(
                            size: ColumnSize.S,
                            label: Text('Roll No'),
                          ),
                          DataColumn2(
                            size: ColumnSize.S,
                            label: Text('Name'),
                          ),
                          DataColumn(
                            label: Text('Father Name'),
                          ),
                          DataColumn(
                            label: Text('Mother Name'),
                          ),
                          DataColumn(
                            label: Text('Class'),
                          ),
                          DataColumn(
                            label: Text('Birth C No'),
                          ),
                          DataColumn(
                            label: Text('PSC'),
                          ),
                          DataColumn(
                            label: Text('JSC'),
                          ),
                          DataColumn(
                            label: Text('Phone No'),
                          ),
                          DataColumn(
                            label: Text('Father Phone No'),
                          ),
                          DataColumn(
                            label: Text('Status'),
                          ),
                          DataColumn(
                            label: Text('A/P %'),
                          ),
                          DataColumn(
                            label: Text('জরিমানা ৳'),
                          ),
                          DataColumn2(
                            label: Text('View Profile'),
                          ),
                          DataColumn2(
                            label: Text('Settings'),
                          ),
                        ],
                        rows: List<DataRow>.generate(
                            AllData.length,
                            (index) => DataRow(cells: [
                                  DataCell(Text('${AllData[index]["RollNo"]}')),
                                  DataCell(
                                      Text('${AllData[index]["StudentName"]}')),
                                  DataCell(
                                      Text('${AllData[index]["FatherName"]}')),
                                  DataCell(
                                      Text('${AllData[index]["MotherName"]}')),
                                  DataCell(
                                      Text("${AllData[index]["ClassName"]}")),
                                  DataCell(Text(
                                      '${AllData[index]["StudentBirthCertificateNo"]}')),
                                  DataCell(
                                      Text('${AllData[index]["PSCResult"]}')),
                                  DataCell(
                                      Text('${AllData[index]["JSCResult"]}')),
                                  DataCell(Text(
                                      '${AllData[index]["StudentPhoneNumber"]}')),
                                  DataCell(Text(
                                      '${AllData[index]["FatherPhoneNo"]}')),
                                  DataCell(Text(
                                    AllData[index]["StudentStatus"]
                                        .toString()
                                        .toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: AllData[index]
                                                    ["StudentStatus"] ==
                                                "new"
                                            ? Colors.red
                                            : Colors.green,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  DataCell(
                                    Text('Click Me'),
                                    onTap: () async {
                                      getPresenceData(
                                          "${AllData[index]["StudentEmail"]}",
                                          context);

                                      getAbsenceData(
                                          "${AllData[index]["StudentEmail"]}",
                                          context);
                                    },
                                  ),
                                  DataCell(
                                      Text('${AllData[index]["FineAmount"]}৳')),
                                  DataCell(
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    StudentProfile(
                                                        StudentEmail: AllData[
                                                                index]
                                                            ["StudentEmail"])));
                                      },
                                      child: Text(
                                        "Profile",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll<Color>(
                                                ColorName().appColor),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    PopupMenuButton(
                                      tooltip: 'Show Settings',
                                      onSelected: (value) {
                                        // your logic
                                      },
                                      itemBuilder: (BuildContext bc) {
                                        return [
                                          PopupMenuItem(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  String SelectedExam = "";

                                                  String SelectedSubject = "";

                                                  String SelectedPIAndBI = "";

                                                  return StatefulBuilder(
                                                      builder:
                                                          (context, setState) {
                                                    return AlertDialog(
                                                      title: Text(
                                                          "মূল্যায়ন নির্বাচন করবেন"
                                                              .toBijoy,
                                                          style: const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  "SiyamRupali")),
                                                      content:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          children: [
                                                            DropdownButton(
                                                              hint: SelectedExam == ""
                                                                  ? Text(
                                                                      "মূল্যায়ন নির্বাচন করবেন"
                                                                          .toBijoy,
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontFamily:
                                                                              "SiyamRupali"))
                                                                  : Text(
                                                                      "${SelectedExam.toBijoy}",
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontFamily:
                                                                              "SiyamRupali")),
                                                              isExpanded: true,
                                                              iconSize: 30.0,
                                                              style: TextStyle(
                                                                  color: ColorName()
                                                                      .appColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16),
                                                              items: [
                                                                "ষাণ্মাসিক শিখনকালীন মূল্যায়ন",
                                                                'ষাণ্মাসিক সামষ্টিক মূল্যায়ন',
                                                                "বাৎসরিক শিখনকালীন মূল্যায়ন",
                                                                "বাৎসরিক সামষ্টিক মূল্যায়ন"
                                                              ].map(
                                                                (val) {
                                                                  return DropdownMenuItem<
                                                                      String>(
                                                                    value: val,
                                                                    child: Text(
                                                                        val),
                                                                  );
                                                                },
                                                              ).toList(),
                                                              onChanged: (val) {
                                                                setState(
                                                                  () {
                                                                    SelectedExam =
                                                                        val!;

                                                                    print(val);
                                                                  },
                                                                );
                                                              },
                                                            ),
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            DropdownButton(
                                                              hint: SelectedSubject == ""
                                                                  ? Text(
                                                                      "বিষয় নির্বাচন করবেন"
                                                                          .toBijoy,
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontFamily:
                                                                              "SiyamRupali"))
                                                                  : Text(
                                                                      "${SelectedSubject.toBijoy}",
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontFamily:
                                                                              "SiyamRupali")),
                                                              isExpanded: true,
                                                              iconSize: 30.0,
                                                              style: TextStyle(
                                                                  color: ColorName()
                                                                      .appColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16),
                                                              items: [
                                                                "বাংলা",
                                                                'ইংরেজি',
                                                                "গণিত",
                                                                "বিজ্ঞান অনুসন্ধানী পাঠ",
                                                                "বিজ্ঞান অনুশীলন বই",
                                                                "ইতিহাস ও সামাজিক বিজ্ঞান অনুসন্ধানী পাঠ",
                                                                "ইতিহাস ও সামাজিক বিজ্ঞান অনুশীলন বই",
                                                                "ডিজিটাল প্রযুক্তি",
                                                                "স্বাস্থ্য সুরক্ষা",
                                                                "জীবন ও জীবিকা",
                                                                "শিল্প ও সংস্কৃতি",
                                                                "ইসলাম শিক্ষা",
                                                                "হিন্দুর্ধম শিক্ষা",
                                                                "খ্রিষ্টধর্ম শিক্ষা",
                                                                "বৌদ্ধধর্ম শিক্ষা",
                                                              ].map(
                                                                (val) {
                                                                  return DropdownMenuItem<
                                                                      String>(
                                                                    value: val,
                                                                    child: Text(
                                                                        val),
                                                                  );
                                                                },
                                                              ).toList(),
                                                              onChanged: (val) {
                                                                setState(
                                                                  () {
                                                                    SelectedSubject =
                                                                        val!;

                                                                    print(val);
                                                                  },
                                                                );
                                                              },
                                                            ),
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            DropdownButton(
                                                              hint: SelectedPIAndBI ==
                                                                      ""
                                                                  ? Text(
                                                                      'পিআই অথবা বিআই নির্বাচন করবেন'
                                                                          .toBijoy,
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontFamily:
                                                                              "SiyamRupali"))
                                                                  : Text(
                                                                      SelectedPIAndBI,
                                                                      style: TextStyle(
                                                                          color: ColorName()
                                                                              .appColor,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              16),
                                                                    ),
                                                              isExpanded: true,
                                                              iconSize: 30.0,
                                                              style: TextStyle(
                                                                  color: ColorName()
                                                                      .appColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16),
                                                              items: [
                                                                "PI",
                                                                "BI"
                                                              ].map(
                                                                (val) {
                                                                  return DropdownMenuItem<
                                                                      String>(
                                                                    value: val,
                                                                    child: Text(
                                                                        val),
                                                                  );
                                                                },
                                                              ).toList(),
                                                              onChanged: (val) {
                                                                setState(
                                                                  () {
                                                                    SelectedPIAndBI =
                                                                        val!;

                                                                    print(val);
                                                                  },
                                                                );
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context),
                                                          child: Text("Cancel"),
                                                        ),
                                                        ElevatedButton(
                                                          child: Text("Go"),
                                                          onPressed: () {
                                                            Navigator.of(context).push(
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            ClassWisePI(
                                                                              ClassName: widget.ClassName,
                                                                              ExamName: SelectedExam,
                                                                              SubjectName: SelectedSubject,
                                                                              RollNo: AllData[index]["RollNo"],
                                                                              StudentEmail: AllData[index]["StudentEmail"],
                                                                            )));
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  });
                                                },
                                              );
                                            },
                                            child: Text("মূল্যায়ন".toBijoy,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "SiyamRupali")),
                                          ),






                                          PopupMenuItem(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  String SelectedExam = "";

                                                  String SelectedSubject = "";

                                                  String SelectedPIAndBI = "";
                                                  
                                                  bool? checkedValueOne = false;

                                                  bool? checkedValueTwo = false;

                                                  bool? checkedValueThree = false;

                                                  bool? checkedValueFour = false;

                                                  return StatefulBuilder(
                                                      builder:
                                                          (context, setState) {
                                                    return AlertDialog(
                                                      title: Text(
                                                          "ট্রান্সক্রিপ্ট তৈরীর জন্য যে যে মূল্যায়ন নিয়ে তৈরী করতে চান তা অবশ্যই নির্বাচন করবেন।"
                                                              .toBijoy,
                                                          style: const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  "SiyamRupali")),
                                                      content:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          children: [

                                    
                                    CheckboxListTile(
                                      title: Text(
                                          "ষাণ্মাসিক শিখনকালীন মূল্যায়ন"
                                              .toBijoy,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "SiyamRupali")),
                                      value: checkedValueOne,
                                      onChanged: (newValue) {
                                        setState(() {
                                          checkedValueOne = newValue;
                                        });
                                      },
                                      controlAffinity: ListTileControlAffinity
                                          .leading, //  <-- leading Checkbox
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    CheckboxListTile(
                                      title: Text(
                                          "ষাণ্মাসিক সামষ্টিক মূল্যায়ন".toBijoy,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "SiyamRupali")),
                                      value: checkedValueTwo,
                                      onChanged: (newValue) {
                                        setState(() {
                                          checkedValueTwo = newValue;
                                        });
                                      },
                                      controlAffinity: ListTileControlAffinity
                                          .leading, //  <-- leading Checkbox
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    CheckboxListTile(
                                      title: Text(
                                          "বাৎসরিক শিখনকালীন মূল্যায়ন".toBijoy,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "SiyamRupali")),
                                      value: checkedValueThree,
                                      onChanged: (newValue) {
                                        setState(() {
                                          checkedValueThree = newValue;
                                        });
                                      },
                                      controlAffinity: ListTileControlAffinity
                                          .leading, //  <-- leading Checkbox
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    CheckboxListTile(
                                      title: Text(
                                          "বাৎসরিক সামষ্টিক মূল্যায়ন".toBijoy,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "SiyamRupali")),
                                      value: checkedValueFour,
                                      onChanged: (newValue) {
                                        setState(() {
                                          checkedValueFour = newValue;
                                        });
                                      },
                                      controlAffinity: ListTileControlAffinity
                                          .leading, //  <-- leading Checkbox
                                    ),
                                                      
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            DropdownButton(
                                                              hint: SelectedSubject == ""
                                                                  ? Text(
                                                                      "বিষয় নির্বাচন করবেন"
                                                                          .toBijoy,
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontFamily:
                                                                              "SiyamRupali"))
                                                                  : Text(
                                                                      "${SelectedSubject.toBijoy}",
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontFamily:
                                                                              "SiyamRupali")),
                                                              isExpanded: true,
                                                              iconSize: 30.0,
                                                              style: TextStyle(
                                                                  color: ColorName()
                                                                      .appColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16),
                                                              items: [
                                                                "বাংলা",
                                                                'ইংরেজি',
                                                                "গণিত",
                                                                "বিজ্ঞান অনুসন্ধানী পাঠ",
                                                                "বিজ্ঞান অনুশীলন বই",
                                                                "ইতিহাস ও সামাজিক বিজ্ঞান অনুসন্ধানী পাঠ",
                                                                "ইতিহাস ও সামাজিক বিজ্ঞান অনুশীলন বই",
                                                                "ডিজিটাল প্রযুক্তি",
                                                                "স্বাস্থ্য সুরক্ষা",
                                                                "জীবন ও জীবিকা",
                                                                "শিল্প ও সংস্কৃতি",
                                                                "ইসলাম শিক্ষা",
                                                                "হিন্দুর্ধম শিক্ষা",
                                                                "খ্রিষ্টধর্ম শিক্ষা",
                                                                "বৌদ্ধধর্ম শিক্ষা",
                                                              ].map(
                                                                (val) {
                                                                  return DropdownMenuItem<
                                                                      String>(
                                                                    value: val,
                                                                    child: Text(
                                                                        val),
                                                                  );
                                                                },
                                                              ).toList(),
                                                              onChanged: (val) {
                                                                setState(
                                                                  () {
                                                                    SelectedSubject =
                                                                        val!;

                                                                    print(val);
                                                                  },
                                                                );
                                                              },
                                                            ),
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                    
                                                          ],
                                                        ),
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context),
                                                          child: Text("Cancel"),
                                                        ),
                                                        ElevatedButton(
                                                          child: Text("Go"),
                                                          onPressed: () {
                                                            Navigator.of(context).push(
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            TranscriptPI(
                                                                              ClassName: widget.ClassName,
                                                                              ExamName: SelectedExam,
                                                                              SubjectName: SelectedSubject,
                                                                              RollNo: AllData[index]["RollNo"],
                                                                              StudentEmail: AllData[index]["StudentEmail"], SelectedExam:[
                                                                                                                                                        checkedValueOne,
                                                                                                                                                        checkedValueTwo,
                                                                                                                                                        checkedValueThree,
                                                                                                                                                        checkedValueFour
                                                                                                            ],
                                                                            )));

                                 



                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  });
                                                },
                                              );
                                            },
                                            child: Text("ট্রান্সক্রিপ্ট".toBijoy,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "SiyamRupali")),
                                          ),


















                                          PopupMenuItem(
                                            child: Text("Change Class"),
                                            value: '/hello',
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  String SelectedClass = "";
                                                  String SelectedDepartment =
                                                      "";

                                                  return StatefulBuilder(
                                                    builder:
                                                        (context, setState) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                            "Are You Sure? You Want to Change The Class."),
                                                        content:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                height: 50,
                                                                width: 160,
                                                                decoration:
                                                                    BoxDecoration(
                                                                        gradient:
                                                                            const LinearGradient(
                                                                          colors: [
                                                                            Color.fromRGBO(
                                                                                255,
                                                                                143,
                                                                                158,
                                                                                1),
                                                                            Color.fromRGBO(
                                                                                255,
                                                                                188,
                                                                                143,
                                                                                1),
                                                                          ],
                                                                          begin:
                                                                              Alignment.centerLeft,
                                                                          end: Alignment
                                                                              .centerRight,
                                                                        ),
                                                                        borderRadius:
                                                                            const BorderRadius.all(
                                                                          Radius.circular(
                                                                              25.0),
                                                                        ),
                                                                        boxShadow: [
                                                                      BoxShadow(
                                                                        color: Colors
                                                                            .white
                                                                            .withOpacity(0.2),
                                                                        spreadRadius:
                                                                            4,
                                                                        blurRadius:
                                                                            10,
                                                                        offset: Offset(
                                                                            0,
                                                                            3),
                                                                      )
                                                                    ]),
                                                                child:
                                                                    TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    showDatePicker(
                                                                      context:
                                                                          context,
                                                                      initialDatePickerMode:
                                                                          DatePickerMode
                                                                              .year,
                                                                      initialDate:
                                                                          DateTime(
                                                                              2000,
                                                                              1,
                                                                              1),
                                                                      firstDate:
                                                                          DateTime(
                                                                              2000,
                                                                              1,
                                                                              1),
                                                                      lastDate:
                                                                          DateTime(
                                                                              2090,
                                                                              1,
                                                                              1),
                                                                    ).then(
                                                                        (pickedDate) {
                                                                      print(
                                                                          pickedDate);

                                                                      setState(
                                                                          () {
                                                                        SelectedYear =
                                                                            "Year: ${pickedDate?.year}";
                                                                      });

                                                                      // SelectedDate = "${pickedDate}";
                                                                      // SelectedDate = SelectedDate.split(" ")[0];

                                                                      print(
                                                                          SelectedYear);
                                                                      // print(SelectedDate.split(" ")[0]);
                                                                    });
                                                                  },
                                                                  child: Text(
                                                                    "${SelectedYear}",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            15),
                                                                  ),
                                                                  style:
                                                                      ButtonStyle(
                                                                    backgroundColor: MaterialStatePropertyAll<
                                                                            Color>(
                                                                        ColorName()
                                                                            .appColor),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              Container(
                                                                width: 200,
                                                                child:
                                                                    TextField(
                                                                  onChanged:
                                                                      (value) {},
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    border:
                                                                        OutlineInputBorder(),
                                                                    labelText:
                                                                        'Enter New Roll No',

                                                                    hintText:
                                                                        'Enter New Roll No',

                                                                    //  enabledBorder: OutlineInputBorder(
                                                                    //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                                                                    //     ),
                                                                    focusedBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                          width:
                                                                              3,
                                                                          color:
                                                                              Theme.of(context).primaryColor),
                                                                    ),
                                                                    errorBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                          width:
                                                                              3,
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              66,
                                                                              125,
                                                                              145)),
                                                                    ),
                                                                  ),
                                                                  controller:
                                                                      StudentNewRollNoController,
                                                                ),
                                                              ),
                                                              DropdownButton(
                                                                hint: SelectedClass ==
                                                                        ""
                                                                    ? const Text(
                                                                        'Class')
                                                                    : Text(
                                                                        SelectedClass,
                                                                        style: TextStyle(
                                                                            color:
                                                                                ColorName().appColor,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 16),
                                                                      ),
                                                                isExpanded:
                                                                    true,
                                                                iconSize: 30.0,
                                                                style: TextStyle(
                                                                    color: ColorName()
                                                                        .appColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        16),
                                                                items: [
                                                                  "0",
                                                                  '1',
                                                                  '2',
                                                                  '3',
                                                                  "4",
                                                                  "5",
                                                                  "6",
                                                                  "7",
                                                                  "8",
                                                                  "9",
                                                                  "10",
                                                                  "ssc"
                                                                ].map(
                                                                  (val) {
                                                                    return DropdownMenuItem<
                                                                        String>(
                                                                      value:
                                                                          val,
                                                                      child: Text(
                                                                          val),
                                                                    );
                                                                  },
                                                                ).toList(),
                                                                onChanged:
                                                                    (val) {
                                                                  setState(
                                                                    () {
                                                                      SelectedClass =
                                                                          val!;

                                                                      print(
                                                                          val);
                                                                    },
                                                                  );
                                                                },
                                                              ),
                                                              const SizedBox(
                                                                height: 20,
                                                              ),
                                                              SelectedClass ==
                                                                          "9" ||
                                                                      SelectedClass ==
                                                                          "10" ||
                                                                      SelectedClass ==
                                                                          "ssc"
                                                                  ? DropdownButton(
                                                                      hint: SelectedDepartment ==
                                                                              ""
                                                                          ? const Text(
                                                                              'Department')
                                                                          : Text(
                                                                              SelectedDepartment,
                                                                              style: TextStyle(color: ColorName().appColor, fontWeight: FontWeight.bold, fontSize: 16),
                                                                            ),
                                                                      isExpanded:
                                                                          true,
                                                                      iconSize:
                                                                          30.0,
                                                                      style: TextStyle(
                                                                          color: ColorName()
                                                                              .appColor,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              16),
                                                                      items: [
                                                                        "বিজ্ঞান",
                                                                        'মানবিক',
                                                                        'ব্যবসা',
                                                                      ].map(
                                                                        (val) {
                                                                          return DropdownMenuItem<
                                                                              String>(
                                                                            value:
                                                                                val,
                                                                            child:
                                                                                Text(val),
                                                                          );
                                                                        },
                                                                      ).toList(),
                                                                      onChanged:
                                                                          (val) {
                                                                        setState(
                                                                          () {
                                                                            SelectedDepartment =
                                                                                val!;

                                                                            print(val);
                                                                          },
                                                                        );
                                                                      },
                                                                    )
                                                                  : Text(""),
                                                            ],
                                                          ),
                                                        ),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context),
                                                            child:
                                                                Text("Cancel"),
                                                          ),
                                                          SelectedClass == ""
                                                              ? Text("")
                                                              : TextButton(
                                                                  onPressed:
                                                                      () async {
                                                                    var updateData =
                                                                        {
                                                                      "ClassName":
                                                                          SelectedClass.toString()
                                                                              .toLowerCase(),
                                                                      "RollNo": StudentNewRollNoController
                                                                          .text
                                                                          .trim()
                                                                          .toLowerCase(),
                                                                      "StudentStatus":
                                                                          "new",
                                                                      "AdmissionYear": SelectedYear.split(
                                                                              ":")[1]
                                                                          .trim()
                                                                          .toString(),
                                                                      "Department": SelectedClass == "9" ||
                                                                              SelectedClass == "10" ||
                                                                              SelectedClass == "ssc"
                                                                          ? SelectedDepartment.toString().trim()
                                                                          : "None"
                                                                    };

                                                                    final StudentInfo = FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'StudentInfo')
                                                                        .doc(AllData[index]
                                                                            [
                                                                            "StudentEmail"]);

                                                                    StudentInfo.update(
                                                                            updateData)
                                                                        .then((value) =>
                                                                            setState(
                                                                                () {
                                                                              var OldInfo = {
                                                                                "StudentName": AllData[index]["StudentName"],
                                                                                "StudentEmail": AllData[index]["StudentEmail"],
                                                                                "OldClassName": AllData[index]["ClassName"],
                                                                                "TransferedClassName": SelectedClass,
                                                                                "OldClassRoll": AllData[index]["RollNo"],
                                                                                "OldClassYear": AllData[index]["AdmissionYear"],
                                                                                "NewClassRoll": StudentNewRollNoController.text.trim().toLowerCase()
                                                                              };

                                                                              final StudentOldInfo = FirebaseFirestore.instance.collection('StudentOldInfo').doc();

                                                                              StudentOldInfo.set(OldInfo).then((value) => setState(() {})).onError(
                                                                                    (error, stackTrace) => setState(() {}),
                                                                                  );

                                                                              getData();

                                                                              Navigator.pop(context);

                                                                              final snackBar = SnackBar(
                                                                                elevation: 0,
                                                                                behavior: SnackBarBehavior.floating,
                                                                                backgroundColor: Colors.transparent,
                                                                                content: AwesomeSnackbarContent(
                                                                                  title: 'Student Class Change Successfull',
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
                                                                            }))
                                                                        .onError((error,
                                                                                stackTrace) =>
                                                                            setState(() {
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

                                                                              setState(() {
                                                                                loading = false;
                                                                              });
                                                                            }));
                                                                  },
                                                                  child: Text(
                                                                      "Change"),
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
                                            child: Text("Change Status"),
                                            value: '/about',
                                            onTap: () async {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  String SelectedStudentStatus =
                                                      "";

                                                  return StatefulBuilder(
                                                    builder:
                                                        (context, setState) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                            "Are You Sure? You Want to Change The Student Status."),
                                                        content: Container(
                                                          height: 70,
                                                          child: Column(
                                                            children: [
                                                              DropdownButton(
                                                                hint: SelectedStudentStatus ==
                                                                        ""
                                                                    ? const Text(
                                                                        'Change Student Status')
                                                                    : Text(
                                                                        SelectedStudentStatus,
                                                                        style: TextStyle(
                                                                            color:
                                                                                ColorName().appColor,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 16),
                                                                      ),
                                                                isExpanded:
                                                                    true,
                                                                iconSize: 30.0,
                                                                style: TextStyle(
                                                                    color: ColorName()
                                                                        .appColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        16),
                                                                items: [
                                                                  "New",
                                                                  'Old',
                                                                  "Running"
                                                                ].map(
                                                                  (val) {
                                                                    return DropdownMenuItem<
                                                                        String>(
                                                                      value:
                                                                          val,
                                                                      child: Text(
                                                                          val),
                                                                    );
                                                                  },
                                                                ).toList(),
                                                                onChanged:
                                                                    (val) {
                                                                  setState(
                                                                    () {
                                                                      SelectedStudentStatus =
                                                                          val!;

                                                                      print(
                                                                          val);
                                                                    },
                                                                  );
                                                                },
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context),
                                                            child:
                                                                Text("Cancel"),
                                                          ),
                                                          SelectedStudentStatus ==
                                                                  ""
                                                              ? Text("")
                                                              : TextButton(
                                                                  onPressed:
                                                                      () async {
                                                                    var updateData =
                                                                        {
                                                                      "StudentStatus": SelectedStudentStatus
                                                                              .toString()
                                                                          .toLowerCase()
                                                                          .trim()
                                                                    };

                                                                    final StudentInfo = FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'StudentInfo')
                                                                        .doc(AllData[index]
                                                                            [
                                                                            "StudentEmail"]);

                                                                    StudentInfo.update(
                                                                            updateData)
                                                                        .then((value) =>
                                                                            setState(
                                                                                () {
                                                                              getData();

                                                                              Navigator.pop(context);

                                                                              final snackBar = SnackBar(
                                                                                elevation: 0,
                                                                                behavior: SnackBarBehavior.floating,
                                                                                backgroundColor: Colors.transparent,
                                                                                content: AwesomeSnackbarContent(
                                                                                  title: 'Student Status Change Successfull',
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
                                                                            }))
                                                                        .onError((error,
                                                                                stackTrace) =>
                                                                            setState(() {
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

                                                                              setState(() {
                                                                                loading = false;
                                                                              });
                                                                            }));
                                                                  },
                                                                  child: Text(
                                                                      "Change"),
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
                                            child: Text("Send SMS"),
                                            value: '/contact',
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  String SelectedStudentStatus =
                                                      "";

                                                  return StatefulBuilder(
                                                    builder:
                                                        (context, setState) {
                                                      return AlertDialog(
                                                        title: Text("Send SMS"),
                                                        content: Container(
                                                          height: 200,
                                                          child: Column(
                                                            children: [
                                                              TextField(
                                                                keyboardType:
                                                                    TextInputType
                                                                        .multiline,
                                                                maxLines: 5,
                                                                decoration:
                                                                    InputDecoration(
                                                                  border:
                                                                      OutlineInputBorder(),
                                                                  labelText:
                                                                      'Enter Message',
                                                                  labelStyle: TextStyle(
                                                                      color: myFocusNode.hasFocus
                                                                          ? Theme.of(context)
                                                                              .primaryColor
                                                                          : Colors
                                                                              .black),
                                                                  hintText:
                                                                      'Enter Your Message',
                                                                  //  enabledBorder: OutlineInputBorder(
                                                                  //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                                                                  //   ),
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        width:
                                                                            3,
                                                                        color: Theme.of(context)
                                                                            .primaryColor),
                                                                  ),
                                                                  errorBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        width:
                                                                            3,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            66,
                                                                            125,
                                                                            145)),
                                                                  ),
                                                                ),
                                                                controller:
                                                                    StudentSendController,
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Container(
                                                                    width: 150,
                                                                    child:
                                                                        TextButton(
                                                                      onPressed:
                                                                          () async {
                                                                        setState(
                                                                            () {
                                                                          loading =
                                                                              true;
                                                                        });

                                                                        // String StudentPhoneNumber="";

                                                                        Future SendSMSToCustomer(
                                                                            context,
                                                                            msg) async {
                                                                          try {
                                                                            final response =
                                                                                await http.get(Uri.parse('https://api.greenweb.com.bd/api.php?token=1024519252916991043295858a1b3ac3cb09ae52385b1489dff95&to=${AllData[index]["StudentPhoneNumber"]}&message=${msg}'));

                                                                            Navigator.pop(context);

                                                                            if (response.statusCode ==
                                                                                200) {
                                                                              // If the server did return a 200 OK response,
                                                                              // then parse the JSON.
                                                                              // print(jsonDecode(response.body));

                                                                              final snackBar = SnackBar(
                                                                                elevation: 0,
                                                                                behavior: SnackBarBehavior.floating,
                                                                                backgroundColor: Colors.transparent,
                                                                                content: AwesomeSnackbarContent(
                                                                                  title: 'Message Successfull',
                                                                                  message: 'Hey Thank You. Good Job',

                                                                                  /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                                                                  contentType: ContentType.success,
                                                                                ),
                                                                              );

                                                                              ScaffoldMessenger.of(context)
                                                                                ..hideCurrentSnackBar()
                                                                                ..showSnackBar(snackBar);

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
                                                                          } catch (e) {
                                                                            print(e);
                                                                          }
                                                                        }

                                                                        SendSMSToCustomer(
                                                                            context,
                                                                            StudentSendController.text);
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        "Send",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                      style:
                                                                          ButtonStyle(
                                                                        backgroundColor: MaterialStatePropertyAll<
                                                                            Color>(Theme.of(
                                                                                context)
                                                                            .primaryColor),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context),
                                                            child:
                                                                Text("Cancel"),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                          ),

                                          //       PopupMenuItem(
                                          //         child: Text("Create Exam For Result"),
                                          //         value: '/contact',
                                          //          onTap: () {

                                          // Navigator.push(context,
                                          //               MaterialPageRoute(builder: (context) => CreateNewExamResult( StudentClassName: "7", )),

                                          //       );
                                          //         },

                                          //       ),

                                          PopupMenuItem(
                                            child: Text("All Exams & Results"),
                                            value: '/contact',
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => AllExamResult(
                                                        RollNumber:
                                                            AllData[index]
                                                                ["RollNo"],
                                                        StudentClassName:
                                                            AllData[index]
                                                                ["ClassName"],
                                                        StudentEmail: AllData[index]
                                                            ["StudentEmail"],
                                                        StudentName:
                                                            AllData[index]
                                                                ["StudentName"],
                                                        StudentPhoneNumber:
                                                            AllData[index][
                                                                "StudentPhoneNumber"],
                                                        FatherPhoneNo: AllData[
                                                                index]
                                                            ["FatherPhoneNo"])),
                                              );
                                            },
                                          ),

                                          PopupMenuItem(
                                            child: Text("Exam Fee History"),
                                            value: '/contact',
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ExamFeeHistory(
                                                          StudentEmail: AllData[
                                                                  index]
                                                              ["StudentEmail"],
                                                          FatherName: AllData[
                                                                  index]
                                                              ["FatherName"],
                                                          Gender: AllData[index]
                                                              ["Gender"],
                                                          MotherName: AllData[
                                                                  index]
                                                              ["MotherName"],
                                                        )),
                                              );
                                            },
                                          ),

                                          PopupMenuItem(
                                            child: Text("Monthly Fee History"),
                                            value: '/contact',
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MonthlyFeeHistory(
                                                            StudentEmail: "")),
                                              );
                                            },
                                          ),

                                          PopupMenuItem(
                                            child: Text("Other Fee History"),
                                            value: '/contact',
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        OtherFeeHistory(
                                                            StudentEmail: "")),
                                              );
                                            },
                                          ),

                                          PopupMenuItem(
                                            child: Text("Pay"),
                                            value: '/contact',
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AllPay(
                                                          ExamFee: "",
                                                          StudentEmail: AllData[
                                                                  index]
                                                              ["StudentEmail"],
                                                          StudentName: AllData[
                                                                  index]
                                                              ["StudentName"],
                                                          StudentPhoneNumber:
                                                              AllData[index][
                                                                  "StudentPhoneNumber"],
                                                          FatherPhoneNo: AllData[
                                                                  index]
                                                              ["FatherPhoneNo"],
                                                          StudentRollNo:
                                                              AllData[index]
                                                                  ["RollNo"],
                                                          ExamName: "",
                                                          ExamDate: "",
                                                          ClassName:
                                                              widget.ClassName,
                                                          ExamStarttingDate: "",
                                                          ExamResultID: "",
                                                          TotalExamFeeCollection:
                                                              "",
                                                        )),
                                              );
                                            },
                                          ),

                                          PopupMenuItem(
                                            child: Text("Show Attendance"),
                                            value: '/contact',
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ShowAttendance(
                                                          StudentEmail: AllData[
                                                                  index]
                                                              ["StudentEmail"],
                                                          ClassName:
                                                              AllData[index]
                                                                  ["ClassName"],
                                                        )),
                                              );
                                            },
                                          ),

                                          PopupMenuItem(
                                            child: Text("Edit"),
                                            value: '/contact',
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditStudent(
                                                            Religion: "",
                                                            Department: "",
                                                            FatherName: "",
                                                            FatherPhoneNo: "",
                                                            MotherName: "",
                                                            ClassName: "",
                                                            StudentAddress: "",
                                                            StudentBirthCertificateNo:
                                                                "",
                                                            StudentDateOfBirth:
                                                                "",
                                                            StudentNID: "",
                                                            StudentName: "",
                                                            StudentEmail: "",
                                                            SSCResult: "",
                                                            Gender: "",
                                                            JSCResult: "",
                                                            PSCResult: "")),
                                              );
                                            },
                                          ),

                                          PopupMenuItem(
                                            child: Text("Upload File"),
                                            value: '/about',
                                            onTap: () async {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        StudentFileAndFileUpload(
                                                            StudentEmail:
                                                                AllData[index][
                                                                    "StudentEmail"],
                                                            FatherPhoneNo: AllData[
                                                                    index][
                                                                "FatherPhoneNo"],
                                                            RollNumber:
                                                                AllData[index]
                                                                    ["RollNo"],
                                                            StudentClassName:
                                                                AllData[index][
                                                                    "ClassName"],
                                                            StudentPhoneNumber:
                                                                AllData[index]
                                                                    ["StudentPhoneNumber"])),
                                              );
                                            },
                                          ),
                                        ];
                                      },
                                    ),
                                  ),
                                ]))),
                  ),
                ),
    );
  }
}
