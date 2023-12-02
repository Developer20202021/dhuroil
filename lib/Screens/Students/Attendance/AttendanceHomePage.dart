import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhuroil/DeveloperAccess/DeveloperAccess.dart';
import 'package:dhuroil/Screens/Students/Attendance/AllStudentAttendance.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class AttendanceHomePage extends StatefulWidget {

  






  const AttendanceHomePage({super.key,});

  @override
  State<AttendanceHomePage> createState() => _AttendanceHomePageState();
}

class _AttendanceHomePageState extends State<AttendanceHomePage> {


  // Firebase All Customer Data Load

List  AllData = [{},{},{},{}];
var DataLoad = "";

bool loading = false; // change true

String SelectedClass ="";



Future<void> getData(String StudentEmail) async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();

    
  CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('ExamFeePayPayHistory');

    setState(() {
      loading = true;
    });


    Query query = _collectionRef.where("StudentEmail", isEqualTo: StudentEmail);
    QuerySnapshot querySnapshot = await query.get();

    // Get data from docs and convert map to List
     AllData = querySnapshot.docs.map((doc) => doc.data()).toList();

       if (AllData.length == 0) {
      setState(() {
        DataLoad = "0";
        loading = false;
      });
       
     } else {

      setState(() {
      
       AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
       loading = false;
     });
       
     }

    print(AllData);
}


@override
  void initState() {
    // TODO: implement initState
    // getData(widget.StudentEmail);
    super.initState();
  }




    Future refresh() async{


    setState(() {
      
        // getData(widget.StudentEmail);

    });


  }

















  @override
  Widget build(BuildContext context) {


    









    return Scaffold(
      backgroundColor: Colors.white,
      
      appBar: AppBar(
      
      
      systemOverlayStyle: SystemUiOverlayStyle(
            // Navigation bar
            statusBarColor: ColorName().appColor, // Status bar
          ),
       
        iconTheme: IconThemeData(color: ColorName().appColor),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),
        title: const Text("Attendance", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),
      body: Center(
        child: Padding(
                  padding: const EdgeInsets.only(left: 300,right: 300, ),
                  child: Container(

                    width: 400,
                    height: 300,
                       
                   decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.green.shade300),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              // offset: Offset(4, 3), // changes position of shadow
                            ),
                          ],
                        ),
                    
                                  
                                  
                   
                      
                    
                    child: Container(
                      child: Tooltip(
                        message: "আপনি  এখানে Class Select করলে সেই ক্লাসের Details দেখতে পাবেন।",
                        decoration: BoxDecoration(
                          color: Colors.pink.withOpacity(0.9),
                          borderRadius: const BorderRadius.all(Radius.circular(4)),
                        ),
                        verticalOffset: 50.30,
                        child: Column(
                          children: [


                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Class Select করুন", style: TextStyle(fontWeight: FontWeight.bold),),
                              ),
                            ),


                            DropdownButton(

                              padding: EdgeInsets.only(left: 30, right: 30, top: 60),
                                                        
                                                                          
                                                        
                                                          hint:  SelectedClass == ""
                                                              ? Text('Choose Class')
                                                              : Text(
                                                                "Class: ${SelectedClass}",
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


                          
                    
                    
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(width: 150, child:TextButton(onPressed: () async{



                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllStudentAttendance(indexNumber: "", ClassName: SelectedClass)));
                    
                    
                    
                          }, child: Text("Search", style: TextStyle(color: Colors.white),), style: ButtonStyle(
                           
                                    backgroundColor: MaterialStatePropertyAll<Color>(Theme.of(context).primaryColor),
                                  ),),),
                    
                    
                    
                      
                    
                    
                    
                    
                        ],
                      ),
                    )
                          ],
                        ),
                      ),
                    ),
                  ),
                
            
            ),
      ));
  }
}
