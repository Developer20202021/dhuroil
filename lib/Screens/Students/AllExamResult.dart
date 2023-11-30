import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhuroil/DeveloperAccess/DeveloperAccess.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class AllExamResult extends StatefulWidget {

  

  final StudentEmail;
  final StudentPhoneNumber;
  final StudentName;
  final StudentClassName;
  final RollNumber;
  final FatherPhoneNo;




  const AllExamResult({super.key, required this.RollNumber,required this.StudentClassName ,required this.StudentEmail, required this.StudentName, required this.StudentPhoneNumber, required this.FatherPhoneNo});

  @override
  State<AllExamResult> createState() => _AllExamResultState();
}

class _AllExamResultState extends State<AllExamResult> {


  TextEditingController WrittenMarksController = TextEditingController();
  TextEditingController PracticalMarksController = TextEditingController();
  TextEditingController MCQMarksController = TextEditingController();
  TextEditingController SubjectNameController = TextEditingController();


  // Firebase All Customer Data Load

List  AllData = [{},{}];
var DataLoad = "";
String SelectedClassName = "";

bool loading = false; // change true



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




void ChangeClassName(){


  setState(() {
    SelectedClassName = widget.StudentClassName;
  });



}









@override
  void initState() {
    // TODO: implement initState
    // getData(widget.StudentEmail);
    ChangeClassName();
    super.initState();
  }




    Future refresh() async{


    setState(() {
      
        // getData(widget.StudentEmail);

    });


  }

















  @override
  Widget build(BuildContext context) {


    // SelectedClassName = widget.StudentClassName;


    



    return Scaffold(
      backgroundColor: Colors.white,
      
      appBar: AppBar(

      
      toolbarHeight: 100,
      
      systemOverlayStyle: SystemUiOverlayStyle(
            // Navigation bar
            statusBarColor: ColorName().appColor, // Status bar
          ),
       
        iconTheme: IconThemeData(color: ColorName().appColor),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),
        title: Container(
          width: MediaQuery.of(context).size.width*0.75,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Class: ${SelectedClassName} All Results", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
              ),
        
        
                                  Container(
                                    width: 200,
                                                height: 40,
                                                child: DropdownButton(
                                                
                                                                  
                                                
                                                  hint:  SelectedClassName == widget.StudentClassName
                                                      ? Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Text(' Search by Class'),
                                                      )
                                                      : Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Text(
                                                          "Class: ${SelectedClassName}",
                                                            style: TextStyle(color: ColorName().appColor, fontWeight: FontWeight.bold, fontSize: 16),
                                                          ),
                                                      ),
                                                  isExpanded: true,
                                                  iconSize: 30.0,
                                                  style: TextStyle(color: ColorName().appColor, fontWeight: FontWeight.bold, fontSize: 16),
                                                  items: ["0","1",'2', "3", "4", "5","6", "7","8",'9','10','ssc'].map(
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
                                                        SelectedClassName = val!;
        
                                                        print(val);
                                                      },
                                                    );
                                                  },
                                                ),
                         ),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        // centerTitle: true,
        
      ),
      body:loading?Center(child: CircularProgressIndicator()): DataLoad == "0"? Center(child: Text("No Data Available")): RefreshIndicator(
        onRefresh: refresh,
        child: ListView.separated(
              itemCount: AllData.length,
              separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 25,),
              itemBuilder: (BuildContext context, int index) {
      
                // late DateTime paymentDateTime = (AllData[index]["PaymentDateTime"] as Timestamp).toDate();
      
      
                return   Padding(
                  padding: const EdgeInsets.only(left: 200, right: 200),
                  child: Container(
                       
                 decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 250, 230, 250),
      
                  border: Border.all(
                            width: 2,
                            color: ColorName().appColor
                          ),
                  borderRadius: BorderRadius.circular(10)      
                 ),
      
                    
                    child: ListTile(
                      
                   
                        
                              title: Text("${AllData[index]["pay"]}৳", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),

                              trailing:  PopupMenuButton(
                                        tooltip: "এখানে Exam এর Result দেখুন এবং Result Add করুন।",
                                          onSelected: (value) {
                                            // your logic
                                          },
                                          itemBuilder: (BuildContext bc) {
                                            return  [
                                              PopupMenuItem(
                                                child: Text("Add Result"),
                                                value: '/hello',


                                               onTap: () async{

                  showDialog(
                    context: context,
                    builder: (context) {
                    String SelectedMCQAvailable ="";
                    String SelectedPracticalAvailable ="";
                    String SelectedSubjectName ="";                    



                      return StatefulBuilder(
                      builder: (context, setState) {
                        return AlertDialog(
                        title: Text("আপনি নিচে Subject wise Marks Add করবেন।"),
                        content:  Container(
                                              height: double.infinity,
                                              child: Column(
                                                children: [

                  Tooltip(
                    message: "যে Subject এর Marks যুক্ত করতে চান তা Select করুন",

                     
                      
                      decoration: BoxDecoration(
                        color: Colors.pink.withOpacity(0.9),
                        borderRadius: const BorderRadius.all(Radius.circular(4)),
                      ),
                      textStyle: TextStyle(color: Colors.white),
                      preferBelow: true,
                      verticalOffset: 20,
                    child: Container(
                              height: 70,
                              width: 300,
                              child: DropdownButton(
                                                      
                                                                        
                                                      
                              hint:  SelectedSubjectName == ""
                                                   ? Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('Subject Name'),
                                                       )
                                                            : Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Text(
                                                                SelectedSubjectName,
                                                                  style: TextStyle(color: ColorName().appColor, fontWeight: FontWeight.bold, fontSize: 16),
                                                                ),
                                                            ),
                                                        isExpanded: true,
                                                        iconSize: 30.0,
                                                        style: TextStyle(color: ColorName().appColor, fontWeight: FontWeight.bold, fontSize: 16),
                                                        items: ["Bangla",'English', "English 1st Paper"].map(
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
                                                              SelectedSubjectName = val!;
                                                    
                                                              print(val);
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ),
                  ),
                  
                          
                          
                          
                          
                     SizedBox(
                      height: 30,
                    ),


                                            

                  Tooltip(
                     message: "Written Marks/CQ Marks যুক্ত করুন",

                      decoration: BoxDecoration(
                        color: Colors.pink.withOpacity(0.9),
                        borderRadius: const BorderRadius.all(Radius.circular(4)),
                      ),
                      textStyle: TextStyle(color: Colors.white),
                      preferBelow: true,
                      verticalOffset: 30,
                    child: Container(
                      width: 300,
                      child: TextField(
                        
                         keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Written Marks',
                               
                              hintText: 'Written Marks',
                      
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
                          controller: WrittenMarksController,
                        ),
                    ),
                  ),
                          
                          
                          
                          
                     SizedBox(
                      height: 30,
                    ),






                          Tooltip(
                          message: "এই Subject এর MCQ আছে? যদি থাকে তবে Yes Click করুন। যদি না থাকে তবে No Click করুন।",

                      decoration: BoxDecoration(
                        color: Colors.pink.withOpacity(0.9),
                        borderRadius: const BorderRadius.all(Radius.circular(4)),
                      ),
                      textStyle: TextStyle(color: Colors.white),
                      preferBelow: true,
                      verticalOffset: 20,

                                                    child: Container(
                                                      height: 70,
                                                      width: 300,
                                                      child: DropdownButton(
                                                      
                                                                        
                                                      
                                                        hint:  SelectedMCQAvailable == ""
                                                            ? Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Text('MCQ Available'),
                                                            )
                                                            : Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Text(
                                                                SelectedMCQAvailable,
                                                                  style: TextStyle(color: ColorName().appColor, fontWeight: FontWeight.bold, fontSize: 16),
                                                                ),
                                                            ),
                                                        isExpanded: true,
                                                        iconSize: 30.0,
                                                        style: TextStyle(color: ColorName().appColor, fontWeight: FontWeight.bold, fontSize: 16),
                                                        items: ["Yes",'No'].map(
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
                                                              SelectedMCQAvailable = val!;
                                                    
                                                              print(val);
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),



                                            
                                            SizedBox(height: 20,),




                SelectedMCQAvailable=="Yes"?
                                 Container(
                    width: 300,
                    child: TextField(
                      
                       keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'MCQ Marks',
                             
                            hintText: 'MCQ Marks',
                    
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
                        controller: MCQMarksController,
                      ),
                  ):Text(""),






                  Tooltip(

                  message: "এই Subject এর Practical Marks আছে? যদি থাকে তবে Yes Click করুন। যদি না থাকে তবে No Click করুন।",

                      decoration: BoxDecoration(
                        color: Colors.pink.withOpacity(0.9),
                        borderRadius: const BorderRadius.all(Radius.circular(4)),
                      ),
                      textStyle: TextStyle(color: Colors.white),
                      preferBelow: true,
                      verticalOffset: 20,



                    child: Container(
                                 height: 70,
                                 width: 300,
                                 child: DropdownButton(
                                                      
                                                                        
                                                      
                                 hint:  SelectedPracticalAvailable == ""
                                  ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Practical Available'),
                                  )
                                   : Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Text(
                                       SelectedPracticalAvailable,
                                             style: TextStyle(color: ColorName().appColor, fontWeight: FontWeight.bold, fontSize: 16),
                                                 ),
                                   ),
                                           isExpanded: true,
                                              iconSize: 30.0,
                                               style: TextStyle(color: ColorName().appColor, fontWeight: FontWeight.bold, fontSize: 16),
                                                        items: ["Yes",'No'].map(
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
                                                              SelectedPracticalAvailable = val!;
                                                    
                                                              print(val);
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ),
                  ),



                                            
                                            SizedBox(height: 20,),


                SelectedPracticalAvailable=="Yes"?
                                 Container(
                    width: 300,
                    child: TextField(
                      
                       keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Practical Marks',
                             
                            hintText: 'Practical Marks',
                    
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
                        controller: PracticalMarksController,
                      ),
                  ):Text(""),




                                            


                                                ],
                                              ),
                                            ),


                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("Cancel"),
                          ),


                        SelectedMCQAvailable==""? Text(""):  TextButton(
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
                                                child: Text("View"),
                                                value: '/about',
                                              ),
                                              PopupMenuItem(
                                                child: Text("Edit"),
                                                value: '/contact',
                                              ),
                                              PopupMenuItem(
                                                child: Text("Delete"),
                                                value: '/contact',
                                              ),
                                            ];
                                          },
                                        ),
                         
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                  
                                  Text("Name:${AllData[index]["StudentName"]}"),

                                  Text("Phone No:${AllData[index]["StudentPhoneNumber"]}"),

                                  Text("Email:${AllData[index]["StudentEmail"]}"),

                                   Text("Receiver E:${AllData[index]["moneyReceiverEmail"]}",style: TextStyle(fontWeight: FontWeight.bold)),

                                   
                                   Text("Receiver N:${AllData[index]["moneyReceiverName"].toString().toUpperCase()}", style: TextStyle(fontWeight: FontWeight.bold),),


                                  Text("Fee Name:${AllData[index]["FeeName"]}"),
                  
                                  Text("Date: ${AllData[index]["Date"]}"),
                                ],
                              ),
                        
                        
                        
                            ),
                  ),
                );
              },
            ),
      ));
  }
}






    