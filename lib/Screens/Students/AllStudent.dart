import 'dart:convert';
import 'package:bijoy_helper/bijoy_helper.dart';
import 'package:dhuroil/Screens/Students/AllExamResult.dart';
import 'package:dhuroil/Screens/Students/CreateNewExamResult.dart';
import 'package:dhuroil/Screens/Students/EditStudent.dart';
import 'package:dhuroil/Screens/Students/ExamFeeHistory.dart';
import 'package:dhuroil/Screens/Students/MonthlyFeeHistory.dart';
import 'package:dhuroil/Screens/Students/OtherFeeHistory.dart';
import 'package:dhuroil/Screens/Students/Pay/AllPay.dart';
import 'package:dhuroil/Screens/Students/ShowAttendance.dart';
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



class AllStudents extends StatefulWidget {

  final indexNumber ;






  const AllStudents({super.key, required this.indexNumber,});

  @override
  State<AllStudents> createState() => _AllStudentsState();
}

class _AllStudentsState extends State<AllStudents> {

TextEditingController StudentRollNumberController = TextEditingController();

TextEditingController StudentSendController = TextEditingController();


bool loading = false;

var DataLoad = "";

bool ExamFeeCollectionSwich = false;
bool MonthlyFeeCollectionSwitch = false;


 String SelectedYear ="Select Year";
//  String SelectedDate ="Select Exam Year";





// UniCode to Bijoy Converter

void getUniData(){

  print(unicodeToBijoy("উভয় পাশে ধানের শীষে বেষ্টিত পানিতে ভাসমান জাতীয় ফুল শাপলা। তার মাথায় পাটগাছের পরস্পর সংযুক্ত তিনটি পাতা এবং উভয পাশে দুটি করে তারকা।"));
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
   
   getUniData();
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

        toolbarHeight: 100,
    
      systemOverlayStyle: SystemUiOverlayStyle(
            // Navigation bar
            statusBarColor: ColorName().appColor, // Status bar
          ),
       
        iconTheme: IconThemeData(color: Color.fromRGBO(92, 107, 192, 1)),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),
        title: Container(
          width: MediaQuery.of(context).size.width*0.75,
          child: Row(
        
            mainAxisAlignment: MainAxisAlignment.spaceAround,
        
            children: [
        
          
          Text("All Students"),
        
        
          
          Container(
            width: 200,
            child: TextField(
                      onChanged: (value) {
                        
                      },
                      
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter Roll No',
                
                          hintText: 'Enter Roll No',
                  
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
                      controller: StudentRollNumberController,
                    ),
          ),
        
        
        
          // Container(
          //   width: 200,
          //   child: TextField(
                      
          //             keyboardType: TextInputType.number,
          //             decoration: InputDecoration(
          //                 border: OutlineInputBorder(),
          //                 labelText: 'Enter Phone No',
                
          //                 hintText: 'Enter Phone No',
                  
          //                 //  enabledBorder: OutlineInputBorder(
          //                 //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
          //                 //     ),
          //                     focusedBorder: OutlineInputBorder(
          //                       borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
          //                     ),
          //                     errorBorder: OutlineInputBorder(
          //                       borderSide: BorderSide(
          //                           width: 3, color: Color.fromARGB(255, 66, 125, 145)),
          //                     ),
                          
                          
          //                 ),
          //             controller: StudentRollNumberController,
          //           ),
          // ),
        
        
        
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
                ]
              ),
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

                                      SelectedYear = "Year: ${pickedDate?.year}";
                                      

                                    });

                                  
                                  // SelectedDate = "${pickedDate}";
                                  // SelectedDate = SelectedDate.split(" ")[0];

                                  print(SelectedYear);
                                  // print(SelectedDate.split(" ")[0]);




                  });
                   
                                          }, child: Text("${SelectedYear}", style: TextStyle(color: Colors.white, fontSize: 15),), style: ButtonStyle(
                                           
                      backgroundColor: MaterialStatePropertyAll<Color>(ColorName().appColor),
                    ),),
             ),






          selectedValue==""||StudentRollNumberController.text.isEmpty || SelectedYear=="Select Year" || SelectedYear=="null"?Text(""):
          
          
          Container(
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
                ]
              ),
               child: TextButton(onPressed: (){
             
                             
                   
                                          }, child: Text("Search", style: TextStyle(color: Colors.white, fontSize: 15),), style: ButtonStyle(
                                           
                      backgroundColor: MaterialStatePropertyAll<Color>(Colors.pink.shade300),
                    ),),
             ),

             
        
          
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        actions: [
          PopupMenuButton(
          onSelected: (value) {
            // your logic
          },
          itemBuilder: (BuildContext context) {
            return  [

              PopupMenuItem(
                onTap: (){


                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllDepartment()));




                },
                child: ListTile(
                  title: ExamFeeCollectionSwich? Text("Exam Fee Collection.Now ON"):Text("Exam Fee Collection.Now OFF"),
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
                onTap: (){


                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllDepartment()));




                },
                child: ListTile(
                  title: MonthlyFeeCollectionSwitch? Text("Monthly Fee Collection.Now ON"):Text("Monthly Fee Collection.Now OFF"),
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
                onTap: (){


                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateNewExamResult( StudentClassName: "7", )));




                },
                child: ListTile(
                  title: Text("Create Exam For Result"),
                  trailing: Icon(Icons.arrow_forward),
                ),
                
                padding: EdgeInsets.all(18.0),
              ),



              



        ];})]
        
      ),
      body:loading?Center(child: CircularProgressIndicator()): DataLoad == "0"? Center(child: Text("No Data Available")): RefreshIndicator(
        onRefresh: refresh,
        child: Padding(
      padding: const EdgeInsets.all(36),
      child: DataTable2(
          isHorizontalScrollBarVisible: true,
          
        
          headingTextStyle: TextStyle(color: Colors.white),
          headingRowDecoration: BoxDecoration(color: ColorName().appColor),
          columnSpacing: 12,
          horizontalMargin: 12,
          minWidth: 600,
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
              label: Text('Absent %'),
            ),

              DataColumn(
              label: Text('Present %'),
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
              100,
              (index) => DataRow(cells: [
                    DataCell(Text('A' * (10 - index % 10))),
                    DataCell(Text('B' * (10 - (index + 5) % 10))),
                    DataCell(Text('C' * (15 - (index + 5) % 10))),
                    DataCell(Text('D' * (15 - (index + 10) % 10))),
                    DataCell(Text(((index + 0.1) * 25.4).toString())),
                    DataCell(Text('D' * (15 - (index + 10) % 10))),
                    DataCell(Text('D' * (15 - (index + 10) % 10))),
                    DataCell(Text('D' * (15 - (index + 10) % 10))),
                    DataCell(Text('D' * (15 - (index + 10) % 10))),
                    DataCell(Text('D' * (15 - (index + 10) % 10))),
                    DataCell(Text('D' * (15 - (index + 10) % 10))),
                    DataCell(Text('D' * (15 - (index + 10) % 10))),
                    DataCell(Text('D' * (15 - (index + 10) % 10))),

                    DataCell(
                    TextButton(onPressed: (){

                               Navigator.of(context).push(MaterialPageRoute(builder: (context) => StudentProfile(StudentEmail: "")));
      
                                      }, child: Text("Profile", style: TextStyle(color: Colors.white, fontSize: 12),), style: ButtonStyle(
                                       
                  backgroundColor: MaterialStatePropertyAll<Color>(ColorName().appColor),
                ),),
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
                                      child: Text("Change Class"),
                                      value: '/hello',
                                      onTap: () {

                showDialog(
                    context: context,
                    builder: (context) {
                    String SelectedClass ="";
                    String SelectedDepartment ="";



                      return StatefulBuilder(
                      builder: (context, setState) {
                        return AlertDialog(
                        title: Text("Are You Sure? You Want to Change The Class."),
                        content:  Container(
                                              height: 170,
                                              child: Column(
                                                children: [


                                                  DropdownButton(
                                                  
                                                                    
                                                  
                                                    hint:  SelectedClass == ""
                                                        ? Text('Class')
                                                        : Text(
                                                          SelectedClass,
                                                            style: TextStyle(color: ColorName().appColor, fontWeight: FontWeight.bold, fontSize: 16),
                                                          ),
                                                    isExpanded: true,
                                                    iconSize: 30.0,
                                                    style: TextStyle(color: ColorName().appColor, fontWeight: FontWeight.bold, fontSize: 16),
                                                    items: ["0",'1', '2', '3', "4","5","6","7","8", "9","10", "ssc"].map(
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
                                                          SelectedClass = val!;

                                                          print(val);
                                                        },
                                                      );
                                                    },
                                                  ),



                                            
                                            SizedBox(height: 20,),




                                              SelectedClass=="9"||SelectedClass=="10"||SelectedClass=="ssc"? DropdownButton(
                                                  
                                                                    
                                                  
                                                    hint:  SelectedDepartment == ""
                                                        ? Text('Department')
                                                        : Text(
                                                          SelectedDepartment,
                                                            style: TextStyle(color: ColorName().appColor, fontWeight: FontWeight.bold, fontSize: 16),
                                                          ),
                                                    isExpanded: true,
                                                    iconSize: 30.0,
                                                    style: TextStyle(color: ColorName().appColor, fontWeight: FontWeight.bold, fontSize: 16),
                                                    items: ["বিজ্ঞান",'মানবিক', 'ব্যবসা',].map(
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
                                                          SelectedDepartment = val!;

                                                          print(val);
                                                        },
                                                      );
                                                    },
                                                  ):Text(""),





                                                ],
                                              ),
                                            ),


                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("Cancel"),
                          ),


                        SelectedClass==""? Text(""):  TextButton(
                            onPressed: () async{


                    //           var updateData ={

                    //                               "Category":SelectedClass.toString().toLowerCase()

                    //                             };


                    // final StudentInfo =
                    //   FirebaseFirestore.instance.collection('StudentInfo').doc(AllData[index]["StudentEmail"]);

                                                
                    //                         StudentInfo.update(updateData).then((value) => setState((){

                                        
                    //                     getData();


                    //                     Navigator.pop(context);





                    //                             final snackBar = SnackBar(
                                  
                    //                   elevation: 0,
                    //                   behavior: SnackBarBehavior.floating,
                    //                   backgroundColor: Colors.transparent,
                    //                   content: AwesomeSnackbarContent(
                    //                     title: 'Successfull',
                    //                     message:
                    //                         'Hey Thank You. Good Job',
                          
                    //                     /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                    //                     contentType: ContentType.success,
                    //                   ),
                    //                 );
                          
                    //                 ScaffoldMessenger.of(context)
                    //                   ..hideCurrentSnackBar()
                    //                   ..showSnackBar(snackBar);

                                


                                
                            



                    //                       setState(() {
                    //                           loading = false;
                    //                         });





                    //                         })).onError((error, stackTrace) => setState((){




                    //                             final snackBar = SnackBar(
                    //                   /// need to set following properties for best effect of awesome_snackbar_content
                    //                   elevation: 0,
                    //                   behavior: SnackBarBehavior.floating,
                    //                   backgroundColor: Colors.transparent,
                    //                   content: AwesomeSnackbarContent(
                    //                     title: 'Something Wrong!!!!',
                    //                     message:
                    //                         'Try again later...',
                          
                    //                     /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                    //                     contentType: ContentType.failure,
                    //                   ),
                    //                 );
                          
                    //                 ScaffoldMessenger.of(context)
                    //                   ..hideCurrentSnackBar()
                    //                   ..showSnackBar(snackBar);






                    //                 setState(() {
                    //                           loading = false;
                    //                         });


                    //                         }));
                        
                            },
                            child: Text("Change"),
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
                                      child: Text("Set Old"),
                                      value: '/about',

                                      onTap: () async{

                  showDialog(
                    context: context,
                    builder: (context) {
                    String SelectedStudentStatus ="";
                    



                      return StatefulBuilder(
                      builder: (context, setState) {
                        return AlertDialog(
                        title: Text("Are You Sure? You Want to Change The Student Status."),
                        content:  Container(
                                              height: 70,
                                              child: Column(
                                                children: [


                                                  DropdownButton(
                                                  
                                                                    
                                                  
                                                    hint:  SelectedStudentStatus == ""
                                                        ? Text('Change Student Status')
                                                        : Text(
                                                          SelectedStudentStatus,
                                                            style: TextStyle(color: ColorName().appColor, fontWeight: FontWeight.bold, fontSize: 16),
                                                          ),
                                                    isExpanded: true,
                                                    iconSize: 30.0,
                                                    style: TextStyle(color: ColorName().appColor, fontWeight: FontWeight.bold, fontSize: 16),
                                                    items: ["New",'Old'].map(
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



                                            
                                            SizedBox(height: 20,),




                                            


                                                ],
                                              ),
                                            ),


                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("Cancel"),
                          ),


                        SelectedStudentStatus==""? Text(""):  TextButton(
                            onPressed: () async{


                    //           var updateData ={

                    //                               "Category":SelectedClass.toString().toLowerCase()

                    //                             };


                    // final StudentInfo =
                    //   FirebaseFirestore.instance.collection('StudentInfo').doc(AllData[index]["StudentEmail"]);

                                                
                    //                         StudentInfo.update(updateData).then((value) => setState((){

                                        
                    //                     getData();


                    //                     Navigator.pop(context);





                    //                             final snackBar = SnackBar(
                                  
                    //                   elevation: 0,
                    //                   behavior: SnackBarBehavior.floating,
                    //                   backgroundColor: Colors.transparent,
                    //                   content: AwesomeSnackbarContent(
                    //                     title: 'Successfull',
                    //                     message:
                    //                         'Hey Thank You. Good Job',
                          
                    //                     /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                    //                     contentType: ContentType.success,
                    //                   ),
                    //                 );
                          
                    //                 ScaffoldMessenger.of(context)
                    //                   ..hideCurrentSnackBar()
                    //                   ..showSnackBar(snackBar);

                                


                                
                            



                    //                       setState(() {
                    //                           loading = false;
                    //                         });





                    //                         })).onError((error, stackTrace) => setState((){




                    //                             final snackBar = SnackBar(
                    //                   /// need to set following properties for best effect of awesome_snackbar_content
                    //                   elevation: 0,
                    //                   behavior: SnackBarBehavior.floating,
                    //                   backgroundColor: Colors.transparent,
                    //                   content: AwesomeSnackbarContent(
                    //                     title: 'Something Wrong!!!!',
                    //                     message:
                    //                         'Try again later...',
                          
                    //                     /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                    //                     contentType: ContentType.failure,
                    //                   ),
                    //                 );
                          
                    //                 ScaffoldMessenger.of(context)
                    //                   ..hideCurrentSnackBar()
                    //                   ..showSnackBar(snackBar);






                    //                 setState(() {
                    //                           loading = false;
                    //                         });


                    //                         }));
                        
                            },
                            child: Text("Change"),
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
                                      child: Text("All Results"),
                                      value: '/contact',
                                      onTap: () {
              
                              Navigator.push(context,
                                            MaterialPageRoute(builder: (context) => AllExamResult(RollNumber: "", StudentClassName: "7", StudentEmail: "", StudentName: "", StudentPhoneNumber: "", FatherPhoneNo: "")),

                                    );
                                      },






                                    ),

                                    PopupMenuItem(
                                      child: Text("Exam Fee History"),
                                      value: '/contact',
                                      onTap: () {
              
                              Navigator.push(context,
                                            MaterialPageRoute(builder: (context) => ExamFeeHistory(StudentEmail: "")),
                                    );
                                      },


                                    ),

                                    PopupMenuItem(
                                      child: Text("Monthly Fee History"),
                                      value: '/contact',
                                      onTap: () {
              
                              Navigator.push(context,
                                            MaterialPageRoute(builder: (context) => MonthlyFeeHistory(StudentEmail: "")),
                                    );
                                      },

                                    ),

                                    PopupMenuItem(
                                      child: Text("Other Fee History"),
                                      value: '/contact',
                                      onTap: () {
              
                              Navigator.push(context,
                                            MaterialPageRoute(builder: (context) => OtherFeeHistory(StudentEmail: "")),
                                    );
                                      },


                                    ),

                                    PopupMenuItem(
                                      child: Text("Pay"),
                                      value: '/contact',
                                       onTap: () {
              
                              Navigator.push(context,
                                            MaterialPageRoute(builder: (context) => AllPay(StudentDueAmount: "10", StudentEmail: "", StudentName: "", StudentPhoneNumber: "", FatherPhoneNo: "", StudentIDNo: "")),
                                    );
                                      },



                                    ),


                                     PopupMenuItem(
                                      child: Text("Show Attendance"),
                                      value: '/contact',
                                       onTap: () {
              
                              Navigator.push(context,
                                            MaterialPageRoute(builder: (context) => ShowAttendance(StudentEmail: "")),
                                    );
                                      },



                                    ),




                                    PopupMenuItem(
                                      child: Text("Edit"),
                                      value: '/contact',
                                      onTap: () {
              
                              Navigator.push(context,
                                            MaterialPageRoute(builder: (context) => EditStudent(Religion: "", Department: "", FatherName: "", FatherPhoneNo: "", MotherName: "", ClassName: "", StudentAddress: "", StudentBirthCertificateNo: "", StudentDateOfBirth: "", StudentNID: "", StudentName: "", StudentEmail: "", SSCResult: "", Gender: "", JSCResult: "", PSCResult: "")),
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