
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhuroil/DeveloperAccess/DeveloperAccess.dart';
import 'package:dhuroil/Screens/Students/EditStudent.dart';
import 'package:dhuroil/Screens/Students/ExamFeeHistory.dart';
import 'package:dhuroil/Screens/Students/MarksSheet/MarkssheetInvoice.dart';
import 'package:dhuroil/Screens/Students/MonthlyFeeHistory.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


 



class PerStudentViewResult extends StatefulWidget {


  final StudentEmail;
  final StudentPhoneNumber;
  final StudentName;
  final StudentClassName;
  final RollNumber;
  final FatherPhoneNo;

  final String ExamResultID;
  





  const PerStudentViewResult( {super.key, required this.StudentEmail, required this.ExamResultID, required this.FatherPhoneNo, required this.RollNumber, required this.StudentClassName, required this.StudentName, required this.StudentPhoneNumber});

  @override
  State<PerStudentViewResult> createState() => _EditCustomerInfoState();
}

class _EditCustomerInfoState extends State<PerStudentViewResult> {


bool loading = false;







   // Firebase All Customer Data Load

List  AllData = [];



Future<void> getData() async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();
    
  CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('PerExamPerSubjectResult');


    Query query = _collectionRef.where("ExamResultID", isEqualTo: widget.ExamResultID).where("ClassName", isEqualTo: widget.StudentClassName).where("StudentEmail", isEqualTo: widget.StudentEmail);
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

    
    
    getData();

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
        title: const Text("View Result", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),),
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
              
                      
              //         Center(
              //           child:  CircleAvatar(
              //             radius: 70,
              //             backgroundImage: NetworkImage(
              //               "${AllData[0]["StudentImageUrl"]}",
              //             ),
              //           ),
              //         ),
              
              //  SizedBox(
              //           height: 20,
              //         ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                
                children: [


                                        
                      PopupMenuButton(
                        tooltip: "Print Marks Sheet",
                        onSelected: (value) {
                          // your logic
                        },
                        itemBuilder: (BuildContext bc) {
                          return [
                            PopupMenuItem(
                              child: Text("Print Marks Sheet"),
                              value: '/hello',
                              onTap: () {

                                 Navigator.of(context).push(MaterialPageRoute(builder: (context) =>MarksSheetPdfPreviewPage(CashInDate: "", StudentEmail: "", StudentCashIn: "", StudentIDNo: "", StudentName: "", StudentPhoneNumber: "")));
                                
                              },
                            ),
                     
                          ];
                        },
                      )


              ],),
      
      
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
                              
                              decoration: BoxDecoration(color: Colors.pink.shade300),
                              children: [
                                      Container(
                                        
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Subject", style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold, color: Colors.white),),
                                        )),
                                      
                                      
                                      Container(
                                        
                                        
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Written", style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold, color: Colors.white),),
                                        )),


                                         
                                      Container(
                                        
                                        
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("MCQ", style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.bold, color: Colors.white),),
                                        )),


                                         
                                      Container(
                                        
                                        
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Practical", style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold, color: Colors.white),),
                                        )),


                                         
                                      Container(
                                        
                                        
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Total", style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.bold, color: Colors.white),),
                                        )),


                                         
                                      Container(
                                        
                                        
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Grade", style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.bold, color: Colors.white),),
                                        )),
                                    
                                    ]),




                                    for(int i=0; i<AllData.length; i++)
                                    
                                TableRow(
                              
                              decoration: BoxDecoration(color: Colors.grey[100]),
                              children: [
                                      Container(
                                        
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("${AllData[i]["SubejectName"]}", style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold, ),),
                                        )),
                                      
                                      
                                      Container(
                                        
                                        
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("${AllData[i]["WrittenMarks"]}", style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold,),),
                                        )),


                                         
                                      Container(
                                        
                                        
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("${AllData[i]["MCQMarks"]}", style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.bold,),),
                                        )),


                                         
                                      Container(
                                        
                                        
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("${AllData[i]["PracticalMarks"]}", style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold,),),
                                        )),


                                         
                                      Container(
                                        
                                        
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("${AllData[i]["TotalMarks"]}", style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.bold,),),
                                        )),


                                         
                                      Container(
                                        
                                        
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("${AllData[i]["Grade"]}", style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.bold,),),
                                        )),
                                    
                                    ]),
                          
                          

                           
                            ],
                          ),
                    ),
                  ),


                    SizedBox(height: 15,),



              
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