
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:dhuroil/DeveloperAccess/DeveloperAccess.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';




class AllStudents extends StatefulWidget {

  final indexNumber ;






  const AllStudents({super.key, required this.indexNumber,});

  @override
  State<AllStudents> createState() => _AllStudentsState();
}

class _AllStudentsState extends State<AllStudents> {

TextEditingController StudentOTPController = TextEditingController();


bool loading = false;

var DataLoad = "";





    final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
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
        title: Row(

          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [

        
        Text("All Students"),


        
        Container(
          width: 200,
          child: TextField(
                    
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
                    controller: StudentOTPController,
                  ),
        ),



        Container(
          width: 200,
          child: TextField(
                    
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter Phone No',
              
                        hintText: 'Enter Phone No',
                
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
                    controller: StudentOTPController,
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
                  'Select Section',
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



           TextButton(onPressed: (){

                              showDatePicker(
                                context: context,
                                
                                initialDatePickerMode: DatePickerMode.year,
                                initialDate: DateTime(2000,1,1),
                                firstDate: DateTime(2000,1,1),
                                lastDate: DateTime(2040,1,1),
                              ).then((pickedDate) {
                                print(pickedDate);
              });
      
                                      }, child: Text("Select Year", style: TextStyle(color: Colors.white, fontSize: 15),), style: ButtonStyle(
                                       
                  backgroundColor: MaterialStatePropertyAll<Color>(ColorName().appColor),
                ),),

        
          ],
        ),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
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

                              //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ShowTeacherAttendance(TeacherEmail: AllData[index]["TeacherEmail"])));
      
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
                                  return const [
                                    PopupMenuItem(
                                      child: Text("Change Class"),
                                      value: '/hello',
                                    ),
                                    PopupMenuItem(
                                      child: Text("Set Old"),
                                      value: '/about',
                                    ),
                                    PopupMenuItem(
                                      child: Text("Send SMS"),
                                      value: '/contact',
                                    ),

                                    PopupMenuItem(
                                      child: Text("Result Add"),
                                      value: '/contact',
                                    ),

                                    PopupMenuItem(
                                      child: Text("All Results"),
                                      value: '/contact',
                                    ),

                                    PopupMenuItem(
                                      child: Text("Exam Fee History"),
                                      value: '/contact',
                                    ),

                                    PopupMenuItem(
                                      child: Text("Monthly Fee History"),
                                      value: '/contact',
                                    ),

                                    PopupMenuItem(
                                      child: Text("Other Fee History"),
                                      value: '/contact',
                                    ),

                                    PopupMenuItem(
                                      child: Text("Pay"),
                                      value: '/contact',
                                    ),

                                    PopupMenuItem(
                                      child: Text("Edit"),
                                      value: '/contact',
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