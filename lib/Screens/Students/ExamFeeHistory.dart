import 'package:bijoy_helper/bijoy_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhuroil/DeveloperAccess/DeveloperAccess.dart';
import 'package:dhuroil/Screens/Students/Pay/AdmitCardInvoice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class ExamFeeHistory extends StatefulWidget {

  

  final StudentEmail;
  final FatherName;
  final MotherName;
  final Gender;




  const ExamFeeHistory({super.key, required this.StudentEmail, required this.FatherName, required this.Gender, required this.MotherName});

  @override
  State<ExamFeeHistory> createState() => _ExamFeeHistoryState();
}

class _ExamFeeHistoryState extends State<ExamFeeHistory> {

  // Firebase All Customer Data Load

List  AllData = [];
var DataLoad = "";

bool loading = false; // change true



Future<void> getData(String StudentEmail) async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();

    
  CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('ExamFeePayHistory');

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
    getData(widget.StudentEmail);
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
        title: const Text("Exam Fee History", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),
      body:loading?Center(child: CircularProgressIndicator()): DataLoad == "0"? Center(child: Text("No Data Available")): RefreshIndicator(
        onRefresh: refresh,
        child: ListView.separated(
              itemCount: AllData.length,
              separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 45,),
              itemBuilder: (BuildContext context, int index) {
      
                // late DateTime paymentDateTime = (AllData[index]["PaymentDateTime"] as Timestamp).toDate();
      
      
                return   Padding(
                  padding: const EdgeInsets.only(left: 300,right: 300, ),
                  child: Container(
                       
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
                    
                                  
                                  
                   
                      
                    
                    child: Tooltip(

                      message: "আপনি ${AllData[index]["StudentName"]} এর Exam Fee History দেখছেন।",
                      decoration: BoxDecoration(
                        color: Colors.pink.withOpacity(0.9),
                        borderRadius: const BorderRadius.all(Radius.circular(4)),
                      ),
                 
                      verticalOffset: 50.30,
                      child: ListTile(

                              trailing: 
                                        PopupMenuButton(
                                          tooltip: "Print Admit card",
                                          onSelected: (value) {
                                            // your logic
                                          },
                                          itemBuilder: (BuildContext bc) {
                                            return  [
                                              PopupMenuItem(
                                                child: Text("Admit Card"),
                                                value: '/hello',
                                                onTap: () {

                                                  Navigator.push(context,
                                            MaterialPageRoute(builder: (context) => AdmitCardPdfPreviewPage(ClassName: AllData[index]["ClassName"], ExamDate: AllData[index]["ExamStartingDate"], ExamFee: AllData[index]["ExamFee"], FatherName: widget.FatherName, Gender: widget.Gender, MotherName: widget.MotherName, StudentRollNo: AllData[index]["StudentRollNo"], StudentName: AllData[index]["StudentName"], StudentPhoneNumber: AllData[index]["StudentPhoneNumber"], ExamName: AllData[index]["ExamName"])),
                                    );
                                                  
                                                },
                                              ),
                                         
                                            ];
                                          },
                                        ),
                        
                                       
                          
                                title: Text("${AllData[index]["pay"]}৳", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                           
                                subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                      
                                    Text("Name: ${AllData[index]["StudentName"]}"),
                    
                                    Text("Class: ${AllData[index]["ClassName"]}"),
                                    Text("Roll No: ${AllData[index]["StudentRollNo"]}"),
                      
                                    Text("Phone No: ${AllData[index]["StudentPhoneNumber"]}"),

                    
                                    Text("F Phone No: ${AllData[index]["StudentFatherPhoneNo"]}"),
                    
                    
                      
                                    Text("Email: ${AllData[index]["StudentEmail"]}"),
                      
                                     Text("Receiver E: ${AllData[index]["moneyReceiverEmail"]}",style: TextStyle(fontWeight: FontWeight.bold)),
                      
                                     
                                     Text("Receiver N: ${AllData[index]["moneyReceiverName"].toString().toUpperCase()}", style: TextStyle(fontWeight: FontWeight.bold),),
                      
                      
                                    // Text("Exam Name:${AllData[index]["ExamName"]}"),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text("Exam Name: "),
                                        Text("${AllData[index]["ExamName"].toString().toBijoy}", style:TextStyle(fontSize: 15, fontWeight: FontWeight.bold, fontFamily: "SiyamRupali")),
                                      ],
                                    ),
                                      
                                    Text("Date: ${AllData[index]["Date"]}"),
                                  ],
                                ),
                          
                          
                          
                              ),
                    ),
                  ),
                );
              },
            ),
      ));
  }
}

