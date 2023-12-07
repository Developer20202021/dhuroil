
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhuroil/DeveloperAccess/DeveloperAccess.dart';
import 'package:dhuroil/Screens/Students/EditStudent.dart';
import 'package:dhuroil/Screens/Students/ExamFeeHistory.dart';
import 'package:dhuroil/Screens/Students/MonthlyFeeHistory.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


 



class StudentProfile extends StatefulWidget {


  final String StudentEmail;
  





  const StudentProfile({super.key, required this.StudentEmail});

  @override
  State<StudentProfile> createState() => _EditCustomerInfoState();
}

class _EditCustomerInfoState extends State<StudentProfile> {


bool loading = false;







   // Firebase All Customer Data Load

List  AllData = [{
  "StudentName":""
}];



Future<void> getData(String StudentEmail) async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();
    
  CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('StudentInfo');


    Query query = _collectionRef.where("StudentEmail", isEqualTo: StudentEmail);
    QuerySnapshot querySnapshot = await query.get();

    // Get data from docs and convert map to List
     AllData = querySnapshot.docs.map((doc) => doc.data()).toList();

     setState(() {
       AllData = querySnapshot.docs.map((doc) => doc.data()).toList();

      loading = false;
     });

    print(AllData);
}














  // Firebase All Customer Data Load

List  AllOrderHistoryData = [];
var BikeSaleDataLoad = "";



Future<void> getSaleData() async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();
  // setState(() {
  //   loading = true;
  // });


  CollectionReference _collectionCustomerOrderHistoryRef =
    FirebaseFirestore.instance.collection('CustomerOrderHistory');

    Query CustomerOrderHistoryQuery = _collectionCustomerOrderHistoryRef.where("StudentEmail", isEqualTo: widget.StudentEmail);
    QuerySnapshot CustomerOrderHistoryQuerySnapshot = await CustomerOrderHistoryQuery.get();

    // Get data from docs and convert map to List
     AllOrderHistoryData = CustomerOrderHistoryQuerySnapshot.docs.map((doc) => doc.data()).toList();

       if (AllOrderHistoryData.length == 0) {
      setState(() {
        BikeSaleDataLoad = "0";
      });
       
     } else {

      setState(() {
      
       AllOrderHistoryData = CustomerOrderHistoryQuerySnapshot.docs.map((doc) => doc.data()).toList();
       loading = false;
     });
       
     }

    print(AllOrderHistoryData);
}


















@override
  void initState() {
    // TODO: implement initState

    
    
    getData(widget.StudentEmail);

    // getSaleData();
    super.initState();
  }



  Future refresh() async{


    setState(() {
            // loading = true;
            
          //  getData(widget.StudentEmail);
          //  getSaleData();

    });

  }
















  @override
  Widget build(BuildContext context) {




    


 

    return  Scaffold(
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
          ),),
      ),



      
      
      appBar: AppBar(

      
      systemOverlayStyle: SystemUiOverlayStyle(
            // Navigation bar
            statusBarColor: ColorName().appColor, // Status bar
          ),
       
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),
        title: const Text("Student Profile", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: SingleChildScrollView(
      
                child: loading?Center(
          child: LoadingAnimationWidget.discreteCircle(
            color: const Color(0xFF1A1A3F),
            secondRingColor: Theme.of(context).primaryColor,
            thirdRingColor: Colors.white,
            size: 100,
          ),
        ):Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              
                      
                      Center(
                        child:  CircleAvatar(
                          radius: 70,
                          backgroundImage: NetworkImage(
                            "${AllData[0]["StudentImageUrl"]}",
                          ),
                        ),
                      ),
              
               SizedBox(
                        height: 20,
                      ),
      
      
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.75,
                      child: Table(
                           border: TableBorder(
                           horizontalInside:
                      BorderSide(color: Colors.white, width: 10.0)),
                          textBaseline: TextBaseline.ideographic,
                            children: [
                    
                    
                    
                    
                          
                                TableRow(
                              
                              decoration: BoxDecoration(color: Colors.grey[200]),
                              children: [
                                      Container(
                                        
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Roll No", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                        )),
                                      
                                      
                                      Container(
                                        
                                        
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("${AllData[0]["RollNo"].toString().toUpperCase()}", style: TextStyle(fontSize: 15.0),),
                                        )),
                                    
                                    ]),
                          
                      
                      
                          
                            TableRow(
                              
                              decoration: BoxDecoration(color: Colors.grey[200]),
                              children: [
                                      Container(
                                        
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Name", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                        )),
                                      
                                      
                                      Container(
                                        
                                        
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("${AllData[0]["StudentName"].toString().toUpperCase()}", style: TextStyle(fontSize: 15.0),),
                                        )),
                                    
                                    ]),
                              
                    
                    
                    
                            
                            TableRow(
                              
                              decoration: BoxDecoration(color: Colors.grey[200]),
                              children: [
                                      Container(
                                        
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("F Name", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                        )),
                                      
                                      
                                      Container(
                                        
                                        
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("${AllData[0]["FatherName"].toString().toUpperCase()}", style: TextStyle(fontSize: 15.0),),
                                        )),
                                    
                                    ]),
                    
                    
                    
                    
                    
                                    TableRow(
                              
                              decoration: BoxDecoration(color: Colors.grey[200]),
                              children: [
                                      Container(
                                        
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("M Name", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                        )),
                                      
                                      
                                      Container(
                                        
                                        
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("${AllData[0]["MotherName"].toString().toUpperCase()}", style: TextStyle(fontSize: 15.0),),
                                        )),
                                    
                                    ]),
                    
                    
                    
                    
                                
                    
                                       TableRow(
                              
                              decoration: BoxDecoration(color: Colors.grey[200]),
                              children: [
                                      Container(
                                        
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("F Phone No", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                        )),
                                      
                                      
                                      Container(
                                        
                                        
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("${AllData[0]["FatherPhoneNo"].toString().toUpperCase()}", style: TextStyle(fontSize: 15.0),),
                                        )),
                                    
                                    ]),
                    
                    
                    
                    
                    
                    
                                  
                                
                    
                                       TableRow(
                              
                              decoration: BoxDecoration(color: Colors.grey[200]),
                              children: [
                                      Container(
                                        
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Birth C No", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                        )),
                                      
                                      
                                      Container(
                                        
                                        
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("${AllData[0]["StudentBirthCertificateNo"].toString().toUpperCase()}", style: TextStyle(fontSize: 15.0),),
                                        )),
                                    
                                    ]),
                    
                    
                    
                    
                    
                              
                    
                                    
                    
                                       TableRow(
                              
                              decoration: BoxDecoration(color: Colors.grey[200]),
                              children: [
                                      Container(
                                        
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Date Of Birth", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                        )),
                                      
                                      
                                      Container(
                                        
                                        
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("${AllData[0]["StudentDateOfBirth"].toString().toUpperCase()}", style: TextStyle(fontSize: 15.0),),
                                        )),
                                    
                                    ]),


                                     TableRow(decoration: BoxDecoration(color: Colors.grey[200]),children: [
                                      Container(child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("Gender", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                      )),
                                      Container(child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("${AllData[0]["Gender"]}", style: TextStyle(fontSize: 15.0),),
                                      )),
                                    
                                    ]),




                                     TableRow(decoration: BoxDecoration(color: Colors.grey[200]),children: [
                                      Container(child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("Religion", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                      )),
                                      Container(child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("${AllData[0]["Religion"]}", style: TextStyle(fontSize: 15.0),),
                                      )),
                                    
                                    ]),
                    
                    
                    
                                
                    
                    
                                
                                       TableRow(
                              
                              decoration: BoxDecoration(color: Colors.grey[200]),
                              children: [
                                      Container(
                                        
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Student NID", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                        )),
                                      
                                      
                                      Container(
                                        
                                        
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("${AllData[0]["StudentNID"].toString().toUpperCase()}", style: TextStyle(fontSize: 15.0),),
                                        )),
                                    
                                    ]),
                          
                          
                          
                          
                          
                          
                          
                          
                      
                          
                            TableRow(decoration: BoxDecoration(color: Colors.grey[200]),children: [
                                      Container(child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("Email", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                      )),
                                      Container(child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("${AllData[0]["StudentEmail"]}", style: TextStyle(fontSize: 15.0),),
                                      )),
                                    
                                    ]),
                          
                          
                             TableRow(decoration: BoxDecoration(color: Colors.grey[200]),children: [
                                      Container(child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("Address", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                      )),
                                      Container(child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("${AllData[0]["StudentAddress"]}", style: TextStyle(fontSize: 15.0),),
                                      )),
                                    
                                    ]),
                              
                          
                              TableRow(decoration: BoxDecoration(color: Colors.grey[200]),children: [
                                      Container(child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("Phone Number", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                      )),
                                      Container(child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("${AllData[0]["StudentPhoneNumber"]}", style: TextStyle(fontSize: 15.0),),
                                      )),
                                    
                                    ]),
                    
                    
                    
                    
                                     TableRow(decoration: BoxDecoration(color: Colors.grey[200]),children: [
                                      Container(child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("Class", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                      )),
                                      Container(child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("${AllData[0]["ClassName"]}", style: TextStyle(fontSize: 15.0),),
                                      )),
                                    
                                    ]),
                    
                    
                    
                                          
                                     TableRow(decoration: BoxDecoration(color: Colors.grey[200]),children: [
                                      Container(child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("Department", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                      )),
                                      Container(child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("${AllData[0]["Department"]}", style: TextStyle(fontSize: 15.0),),
                                      )),
                                    
                                    ]),
                    
                    
                    
                                     



                                     TableRow(decoration: BoxDecoration(color: Colors.grey[200]),children: [
                                      Container(child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("PSC", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                      )),
                                      Container(child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("${AllData[0]["PSCResult"]}", style: TextStyle(fontSize: 15.0),),
                                      )),
                                    
                                    ]),




                                     TableRow(decoration: BoxDecoration(color: Colors.grey[200]),children: [
                                      Container(child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("JSC", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                      )),
                                      Container(child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("${AllData[0]["JSCResult"]}", style: TextStyle(fontSize: 15.0),),
                                      )),
                                    
                                    ]),





                                     TableRow(decoration: BoxDecoration(color: Colors.grey[200]),children: [
                                      Container(child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("SSC", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                      )),
                                      Container(child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("${AllData[0]["SSCResult"]}", style: TextStyle(fontSize: 15.0),),
                                      )),
                                    
                                    ]),
                    
                    
       
                                         TableRow(decoration: BoxDecoration(color: Colors.grey[200]),children: [
                                      Container(child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("Admission Date", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                      )),
                                      Container(child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("${AllData[0]["AdmissionDate"]}", style: TextStyle(fontSize: 15.0),),
                                      )),
                                    
                                    ]),
                          
                          
                          
                       
                          
                              
                          
                                    
                          
                               TableRow(decoration: BoxDecoration(color: Colors.grey[200]),children: [
                                      Container(child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("Fine Type", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                      )),
                                      Container(child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("${AllData[0]["StudentFineType"]}", style: TextStyle(fontSize: 15.0),),
                                      )),
                                    
                                    ]),


                                     TableRow(decoration: BoxDecoration(color: Colors.grey[200]),children: [
                                      Container(child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("জরিমানা", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                      )),
                                      Container(child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("${AllData[0]["FineAmount"]}", style: TextStyle(fontSize: 15.0),),
                                      )),
                                    
                                    ]),



                                    TableRow(decoration: BoxDecoration(color: Colors.grey[200]),children: [
                                      Container(child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("Status", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                      )),
                                      Container(child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("${AllData[0]["StudentStatus"]}", style: TextStyle(fontSize: 15.0),),
                                      )),
                                    
                                    ]),
                             
                              
                          
                          
                       
                          
                          
                          
                             
                        
                           
                            ],
                          ),
                    ),
                  ),


                    SizedBox(height: 15,),




       




      
      
      
      
      
      
      
      



                      

      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                    
                        children: [
      
                          Container(width: 150, child:TextButton(onPressed: (){
      
      
                                  //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ExamFeeHistory(StudentEmail: widget.StudentEmail)));
      
      
                           
      
      
      
      
      
                          }, child: Text("Exam Fee History", style: TextStyle(color: Colors.white),), style: ButtonStyle(
                           
                  backgroundColor: MaterialStatePropertyAll<Color>(Theme.of(context).primaryColor),
                ),),),





                
                          Container(width: 150, child:TextButton(onPressed: (){
      
      
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => MonthlyFeeHistory(StudentEmail: widget.StudentEmail)));
      
      
                           
      
      
      
      
      
                          }, child: Text("Monthly Fee", style: TextStyle(color: Colors.white),), style: ButtonStyle(
                           
                  backgroundColor: MaterialStatePropertyAll<Color>(Theme.of(context).primaryColor),
                ),),),






                        ],
                      ),
      
      
                 
      
      
      
      
                     
      
      
      
              
              
              
              
              
                    ],
                  ),
                ),
              ),
      ),
        
        floatingActionButton: FloatingActionButton(
      onPressed: (){




          Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditStudent(Religion: "", Department: "", FatherName: "", FatherPhoneNo: "", MotherName: "", ClassName: "", StudentAddress: "", StudentBirthCertificateNo: "", StudentDateOfBirth: "", StudentNID: "", StudentName: "", StudentEmail: "", SSCResult: "", Gender: "", JSCResult: "", PSCResult: "")),
                      );











      },
        tooltip: 'Edit',
        child: const Icon(Icons.edit),
      ), 
      
    );
  }
}



class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.purple;
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