import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhuroil/DeveloperAccess/DeveloperAccess.dart';
import 'package:dhuroil/Screens/Students/ViewPerStudentResult.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';





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
  TextEditingController SubjectMarksController = TextEditingController();

    var uuid = Uuid();


  // Firebase All Customer Data Load

List  AllData = [];
var DataLoad = "";
String SelectedClassName = "";

bool loading = false; // change true



Future<void> getData( String ClassName) async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();

    
  CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('ExamResult');

    setState(() {
      loading = true;
    });


    Query query = _collectionRef.where("ClassName", isEqualTo: ClassName).where("ExamYear", isEqualTo: "${DateTime.now().year}");
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
       DataLoad = "";
       AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
       loading = false;
     });
       
     }

    print("_____________________________________________________${AllData}");
}




void ChangeClassName(){


  setState(() {
    SelectedClassName = widget.StudentClassName;
  });



}









@override
  void initState() {
    // TODO: implement initState
    getData(widget.StudentClassName);
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

    var SubjectResultID = uuid.v4();


    



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

                                                        getData(val);
        
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
                      
                   
                        
                              title: Text("Exam Name:${AllData[index]["OtherExamName"]==""?AllData[index]["ExamName"]:AllData[index]["OtherExamName"]}"),

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
                        content:  SingleChildScrollView(
                                             
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
                                                        items: ["Bangla 1st Paper",'Bangla 2nd Paper', "English 1st Paper", "English 2nd Paper"].map(
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



                  SizedBox(height: 10,),


                  Container(
                    width: 300,
                    child: TextField(
                      
                       keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Subject Marks',
                             
                            hintText: 'Subject Marks',
                    
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
                        controller: SubjectMarksController,
                      ),),




                                            


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


                              var PerExamPerSubjectResult ={

                                "ExamResultID":AllData[index]["ExamResultID"],
                                "SubejctResultID":SubjectResultID,
                                "ExamYear":AllData[index]["ExamYear"],
                                "ExamDate":AllData[index]["ExamDate"],
                                "ClassName":AllData[index]["ClassName"],
                                "ExamName":AllData[index]["ExamName"],
                                "OtherExamName": AllData[index]["OtherExamName"],
                                "WrittenMarks":WrittenMarksController.text.trim().toLowerCase(),
                                "MCQAvailable":SelectedMCQAvailable,
                                "MCQMarks":SelectedMCQAvailable=="Yes"?MCQMarksController.text.trim().toLowerCase():"",
                                "PracticalAvailable":SelectedPracticalAvailable,
                                "PracticalMarks":SelectedPracticalAvailable=="Yes"?PracticalMarksController.text.trim().toLowerCase():"",

                                "TotalMarks":((SelectedMCQAvailable=="Yes"?double.parse(MCQMarksController.text.trim().toLowerCase()):0)+(SelectedPracticalAvailable=="Yes"?double.parse(PracticalMarksController.text.trim().toLowerCase()):0)+double.parse(WrittenMarksController.text.trim().toLowerCase())).toString(),
                                "SubjectMarks":SubjectMarksController.text.trim().toLowerCase(),
                                "SubejectName":SelectedSubjectName.toLowerCase().trim(),
                                "StudentEmail":widget.StudentEmail,
                                "StudentName":widget.StudentName,
                                "StudentPhoneNumber":widget.StudentPhoneNumber,
                                "RollNumber":widget.RollNumber,
                                "FatherPhoneNumber":widget.FatherPhoneNo,
                                "Grade":(() {
                                          if (((SelectedMCQAvailable=="Yes"?double.parse(MCQMarksController.text.trim().toLowerCase()):0)+(SelectedPracticalAvailable=="Yes"?double.parse(PracticalMarksController.text.trim().toLowerCase()):0)+double.parse(WrittenMarksController.text.trim().toLowerCase()))>=80.0) {

                                            return "A+";
                                            
                                          } else if(((SelectedMCQAvailable=="Yes"?double.parse(MCQMarksController.text.trim().toLowerCase()):0)+(SelectedPracticalAvailable=="Yes"?double.parse(PracticalMarksController.text.trim().toLowerCase()):0)+double.parse(WrittenMarksController.text.trim().toLowerCase()))>=70.0 && ((SelectedMCQAvailable=="Yes"?double.parse(MCQMarksController.text.trim().toLowerCase()):0)+(SelectedPracticalAvailable=="Yes"?double.parse(PracticalMarksController.text.trim().toLowerCase()):0)+double.parse(WrittenMarksController.text.trim().toLowerCase()))<=79.0){

                                            return "A";
                                            
                                          }

                                          else if(((SelectedMCQAvailable=="Yes"?double.parse(MCQMarksController.text.trim().toLowerCase()):0)+(SelectedPracticalAvailable=="Yes"?double.parse(PracticalMarksController.text.trim().toLowerCase()):0)+double.parse(WrittenMarksController.text.trim().toLowerCase()))>=60.0 && ((SelectedMCQAvailable=="Yes"?double.parse(MCQMarksController.text.trim().toLowerCase()):0)+(SelectedPracticalAvailable=="Yes"?double.parse(PracticalMarksController.text.trim().toLowerCase()):0)+double.parse(WrittenMarksController.text.trim().toLowerCase()))<=69.0){


                                            return "A-";



                                          }

                                           else if(((SelectedMCQAvailable=="Yes"?double.parse(MCQMarksController.text.trim().toLowerCase()):0)+(SelectedPracticalAvailable=="Yes"?double.parse(PracticalMarksController.text.trim().toLowerCase()):0)+double.parse(WrittenMarksController.text.trim().toLowerCase()))>=50.0 && ((SelectedMCQAvailable=="Yes"?double.parse(MCQMarksController.text.trim().toLowerCase()):0)+(SelectedPracticalAvailable=="Yes"?double.parse(PracticalMarksController.text.trim().toLowerCase()):0)+double.parse(WrittenMarksController.text.trim().toLowerCase()))<=59.0){


                                            return "B";

                                          }


                                          
                                           else if(((SelectedMCQAvailable=="Yes"?double.parse(MCQMarksController.text.trim().toLowerCase()):0)+(SelectedPracticalAvailable=="Yes"?double.parse(PracticalMarksController.text.trim().toLowerCase()):0)+double.parse(WrittenMarksController.text.trim().toLowerCase()))>=40.0 && ((SelectedMCQAvailable=="Yes"?double.parse(MCQMarksController.text.trim().toLowerCase()):0)+(SelectedPracticalAvailable=="Yes"?double.parse(PracticalMarksController.text.trim().toLowerCase()):0)+double.parse(WrittenMarksController.text.trim().toLowerCase()))<=49.0){


                                            return "C";

                                          }


                                          
                                           else if(((SelectedMCQAvailable=="Yes"?double.parse(MCQMarksController.text.trim().toLowerCase()):0)+(SelectedPracticalAvailable=="Yes"?double.parse(PracticalMarksController.text.trim().toLowerCase()):0)+double.parse(WrittenMarksController.text.trim().toLowerCase()))>=33.0 && ((SelectedMCQAvailable=="Yes"?double.parse(MCQMarksController.text.trim().toLowerCase()):0)+(SelectedPracticalAvailable=="Yes"?double.parse(PracticalMarksController.text.trim().toLowerCase()):0)+double.parse(WrittenMarksController.text.trim().toLowerCase()))<=39.0){


                                            return "D";

                                          }

                                          else{

                                            return "F";
                                          }



                                        }())
                                

                                                 
                                                 
                                                 
                                 

                                    };


                    final PerExamResultInfo =
                      FirebaseFirestore.instance.collection('PerExamPerSubjectResult').doc(SubjectResultID);

                                                
                                            PerExamResultInfo.set(PerExamPerSubjectResult).then((value) => setState((){

                                        
                                        // getData();


                                        Navigator.pop(context);





                                                final snackBar = SnackBar(
                                  
                                      elevation: 0,
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.transparent,
                                      content: AwesomeSnackbarContent(
                                        title: 'Marks Successfully Added',
                                        message:
                                            'Hey Thank You. Good Job',
                          
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





                                            })).onError((error, stackTrace) => setState((){




                                                final snackBar = SnackBar(
                                      /// need to set following properties for best effect of awesome_snackbar_content
                                      elevation: 0,
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.transparent,
                                      content: AwesomeSnackbarContent(
                                        title: 'Something Wrong!!!!',
                                        message:
                                            'Try again later...',
                          
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
                            child: Text("Save"),
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
                                                onTap: () {

                                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  PerStudentViewResult(StudentEmail: widget.StudentEmail, ExamResultID: AllData[index]["ExamResultID"],StudentClassName: AllData[index]["ClassName"], FatherPhoneNo: widget.FatherPhoneNo, RollNumber: widget.RollNumber, StudentName: widget.StudentName, StudentPhoneNumber: widget.StudentPhoneNumber,)));
                                                  


                                                },


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
            
                                  Text("Exam Name:${AllData[index]["OtherExamName"]==""?AllData[index]["ExamName"]:AllData[index]["OtherExamName"]}"),

                                  Text("Exam Year:${AllData[index]["ExamYear"]}"),

                                  Text("Class:${AllData[index]["ClassName"]}"),

                                   Text("Exam Total Marks:${AllData[index]["ExamTotalMarks"]}",style: TextStyle(fontWeight: FontWeight.bold)),

                                   
                                   Text("Creator N:${AllData[index]["CreatorName"].toString().toUpperCase()}", style: TextStyle(fontWeight: FontWeight.bold),),


                                  Text("Creator E:${AllData[index]["CreatorEmail"]}"),
                  
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






    