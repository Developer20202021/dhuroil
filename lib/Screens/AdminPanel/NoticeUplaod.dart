
import 'dart:convert';
import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
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
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

 



class NoticeUpload extends StatefulWidget {




 
  





  const NoticeUpload( {super.key,});

  @override
  State<NoticeUpload> createState() => _EditCustomerInfoState();
}

class _EditCustomerInfoState extends State<NoticeUpload> {


    TextEditingController NoticeController = TextEditingController();
    TextEditingController TitleController = TextEditingController();


bool loading = false;

 var uuid = Uuid();








  // File Upload 


  File? _photo;

  String image64 = "";



  String UploadImageURl = "";

  List AllUploadImageUrl =[];




 var createUserErrorCode = "";


 bool ImageLoading = false;




 

  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery(BuildContext context) async {
    //old
    // final pickedFile = await _picker.pickImage(source: ImageSource.gallery);


     var pickedFile = await FilePicker.platform.pickFiles();

        if (pickedFile != null) {
          print(pickedFile.files.first.name);
        }

    //old
    setState(() {
      if (pickedFile != null) {


        final bytes = Uint8List.fromList(pickedFile.files.first.bytes as List<int>);


        setState(() {
          image64 = base64Encode(bytes);
        });

        uploadFile(context);
      } else {
        print('No image selected.');
      }
    });




  }






  
  Future imgFromCamera(BuildContext context) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        setState(() {
        loading = true;
      });
        uploadFile(context);
      } else {
        print('No image selected.');
      }
    });
  }





  
  Future uploadFile(BuildContext context) async {

    setState(() {
                    loading = true;
                  });


    try {


      



   var request = await http.post(Uri.parse("https://api.imgbb.com/1/upload?key=9a7a4a69d9a602061819c9ee2740be89"),  body: {
          'image':'$image64',
        } ).then((value) => setState(() {


          print(jsonDecode(value.body));



          var serverData = jsonDecode(value.body);

          var serverImageUrl = serverData["data"]["url"];

          setState(() {
            UploadImageURl = serverImageUrl;

            AllUploadImageUrl.insert(AllUploadImageUrl.length, serverImageUrl);
          });

          print(serverImageUrl);

          // updateData(serverImageUrl,context);


            setState(() {
                    loading = false;
                  });

        
             final snackBar = SnackBar(
                    /// need to set following properties for best effect of awesome_snackbar_content
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Your Image Upload Successfull',
                      message:
                          'Your Image Upload Successfull',
        
                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                      contentType: ContentType.success,
                    ),
                  );
        
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);



        })).onError((error, stackTrace) => setState((){


      setState(() {
        loading = false;
      });


      print(error);




           final snackBar = SnackBar(
                    /// need to set following properties for best effect of awesome_snackbar_content
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Something Wrong!!!',
                      message:
                          'Try again later',
        
                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                      contentType: ContentType.failure,
                    ),
                  );
        
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);






        }));




    } catch (e) {
      print(e);
    }
  }






  
  Future updateData(String FileID,BuildContext context) async{

    setState(() {
        loading = true;
      });



  

         final docUser = FirebaseFirestore.instance.collection("NoticeInfo").doc(FileID);
         

                  final UpadateData ={
                    "FileID":FileID,
                    "FileUrl":AllUploadImageUrl,
                    "NoticeTitle":TitleController.text.trim(),
                    "NoticeDescription":NoticeController.text.trim(),
                    "Date":DateTime.now().toIso8601String(),
                    "month":"${DateTime.now().month}/${DateTime.now().year}",
                    "year":"${DateTime.now().year}",

                
                };





                // user Data Update and show snackbar

                  docUser.set(UpadateData).then((value) => setState((){


                    getData();


                      setState(() {
                            loading = false;
                       
                          });


                    print("Done");




                
                       final snackBar = SnackBar(
                    /// need to set following properties for best effect of awesome_snackbar_content
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Your Image Upload Successfull',
                      message:
                          'Your Image Upload Successfull',
        
                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                      contentType: ContentType.success,
                    ),
                  );
        
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);



                  })).onError((error, stackTrace) => setState((){

                    loading = false;




                    
                       final snackBar = SnackBar(
                    /// need to set following properties for best effect of awesome_snackbar_content
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Image Upload Failed',
                      message:
                          'Image Upload Failed',
        
                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                      contentType: ContentType.failure,
                    ),
                  );
        
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);










                    print(error);

                  }));



  }









   // Firebase All Customer Data Load

List  AllData = [];



Future<void> getData() async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();
    
  CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('NoticeInfo');


    // Query query = _collectionRef.where("StudentEmail", isEqualTo: widget.StudentEmail);
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
     AllData = querySnapshot.docs.map((doc) => doc.data()).toList();

     setState(() {
       AllData = querySnapshot.docs.map((doc) => doc.data()).toList();

      loading = false;
     });

    print(AllData);
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


  var FileID = uuid.v4();

    double width = MediaQuery.of(context).size.width;

    double height = MediaQuery.of(context).size.height;

    


 

    return  Scaffold(
      backgroundColor: Colors.white,

      


        bottomNavigationBar:width<669?const Center(child: Text("This Screen size is not Allowed for this Admin panel", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),)): Padding(
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
        title: const Text("Notice Upload & View", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: SingleChildScrollView(
      
                child: loading?Center(
          child: LinearProgressIndicator(),
        ):width<669?const Center(child: Text("This Screen size is not Allowed for this Admin panel", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),)):Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(



                    



                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                                
                        
                          Center(
                            child: Container(

                              
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.9),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.white, Colors.white, ],
                      ),
                    ),
                          
                              width: 400,
                          
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Center(
                                          child: GestureDetector(
                                                      onTap: () {
                                                        _showPicker(context);
                                                      },
                                                      child: CircleAvatar(
                                                        radius: 100,
                                                        backgroundColor: Theme.of(context).primaryColor,
                                                        child: UploadImageURl.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius: BorderRadius.circular(5),
                                          child: Image.network(
                                            "${UploadImageURl}",
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.fitHeight,
                                          ),
                                        )
                                      : Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius: BorderRadius.circular(5)),
                                          width: 200,
                                          height: 200,
                                          child: Icon(
                                            Icons.camera_alt,
                                            color: Colors.grey[800],
                                          ),
                                        ),
                                                      ),
                                          ),
                                        ),
                  
                  
                                        const SizedBox(height: 10,),
                  
                  
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                  
                                            for(int i=0; i<AllUploadImageUrl.length; i++)
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(5),
                                                  child: Image.network(
                                                    "${AllUploadImageUrl[i]}",
                                                    width: 50,
                                                    height: 50,
                                                    fit: BoxFit.fitHeight,
                                                  ),
                                                ),
                                            ),
                  
                                          ],
                                        ),
                  
                  
                  
                                        const SizedBox(height: 20,),
                          
                                                
                                            Container(
                                            width: 350,
                                            child: TextField(
                                              
                                              maxLines: 2,
                                              maxLength: 150,
                                              onChanged: (value) {},
                                              keyboardType: TextInputType.name,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Enter Notice Title',
                                                
                          
                                                hintText: 'Enter Notice Title...',
                          
                                                //  enabledBorder: OutlineInputBorder(
                                                //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                                                //     ),
                                                focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 3, color: Theme.of(context).primaryColor),
                                                ),
                                                errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                                                ),
                                              ),
                                              controller: TitleController,
                                            ),
                                          ),
                  
                  
                  
                  
                  
                          
                                  
                          
                                        SizedBox(height: 20,),
                          
                                                
                                            Container(
                                            width: 350,
                                            child: TextField(
                                              
                                              maxLines: 10,
                                              maxLength: 1100,
                                              onChanged: (value) {},
                                              keyboardType: TextInputType.name,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Enter Notice Description',
                          
                                                hintText: 'Enter Notice Description...',
                          
                                                //  enabledBorder: OutlineInputBorder(
                                                //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                                                //     ),
                                                focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 3, color: Theme.of(context).primaryColor),
                                                ),
                                                errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                                                ),
                                              ),
                                              controller: NoticeController,
                                            ),
                                          ),
                  
                  
                  
                        SizedBox(
                          height: 20,
                        ),
                          
                          
                          
                          
                          
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                                  
                                                                  
                                                ElevatedButton(onPressed: () async{
                                                                  
                                                                  
                                                  updateData(FileID,context);
                                                                  
                                                                  
                                                                  
                                                }, child: Text("Upload"))
                                                                  
                                                                  
                                                                  
                                                                  
                                              ],
                                            ),
                                          )
                          
                          
                          
                          
                          
                                  ],
                                ),
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
                             border: const TableBorder(
                             horizontalInside:
                        BorderSide(color: Colors.white, width: 10.0)),
                            textBaseline: TextBaseline.ideographic,
                              children: [
                  
                  
                               
                      
                      
                      
                      
                            
                                  TableRow(
                                
                                decoration: BoxDecoration(color: Colors.pink.shade300),
                                children: [
                  
                                  Container(
                                          
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text("Title", style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold, color: Colors.white),),
                                          )),
                  
                  
                  
                                        Container(
                                          
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text("Notice", style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold, color: Colors.white),),
                                          )),
                                        
                                        
                                     
                  
                  
                                           
                                        Container(
                                          
                                          
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Center(child: Text("View", style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.bold, color: Colors.white),)),
                                          )),
                  
                  
                  
                  
                  
                                        
                                       
                  
                  
                                          
                                          
                                          
                                           Container(
                                          
                                          
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Center(child: Text("Delete", style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.bold, color: Colors.white),)),
                                          )),
                                      
                                      ]),
                  
                  
                  
                  
                                      for(int i=0; i<AllData.length; i++)
                                      
                                  TableRow(
                                
                                decoration: BoxDecoration(color: Colors.grey[100]),
                                children: [
                  
                  
                                  Container(
                                          
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("${AllData[i]["NoticeTitle"].toString().toUpperCase()}", style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, fontFamily: 'Josefin Sans',),),
                                          )),
                  
                  
                  
                  
                  
                                        Container(
                                          
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("${AllData[i]["NoticeDescription"].toString().toUpperCase()}", style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, fontFamily: 'Josefin Sans',),),
                                          )),
                                        
                                      
                  
                                           
                                        Container(
                                          
                                          
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ElevatedButton(
                                              onPressed: () {
                  
                                      
                                       Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                         NoticeView(NoticeTitle: AllData[i]["NoticeTitle"], FileUrl: AllData[i]["FileUrl"])),
                                                );
                                                
                  
                                              },
                                              child: Text("View", style: const TextStyle(fontSize: 17.0,fontWeight: FontWeight.bold,),)),
                                          )),
                  
                  
                                   
                  
                  
                                           
                                     
                  
                  
                                           
                                     
                  
                  
                  
                  
                                            Container(
                                          
                                          
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: IconButton(onPressed: (){
                  
                     showDialog(
                      context: context,
                      builder: (context) {
                    
                  
                        return StatefulBuilder(
                        builder: (context, setState) {
                          return AlertDialog(
                                                title:const Text('Delete'),
                                                content:const Text('Are you Sure You want to Delete it?'),
                                                actions: [
                                                  ElevatedButton(
                                                  
                                                    onPressed: () {
                  
                                                       Navigator.pop(context);
                  
                                                    },
                                                    child: Text('CANCEL'),
                                                  ),
                                                  ElevatedButton(
                                                   
                                                    onPressed: () async{
                          
                  
                          setState(() {
                  
                            loading = true;
                            
                          },);
                                                
                          CollectionReference collectionRef =
                          FirebaseFirestore.instance.collection('NoticeInfo');
                              collectionRef.doc(AllData[i]["FileID"]).delete().then(
                                      (doc) => setState((){
                  
                  
                                            getData();
                  
                  
                                          Navigator.pop(context);
                  
                  
                  
                  
                  
                                      final snackBar = SnackBar(
                                    
                                        elevation: 0,
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.transparent,
                                        content: AwesomeSnackbarContent(
                                          title: 'Delete Successfull',
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
                  
                  
                  
                  
                                      }),
                                      onError: (e) => setState((){
                  
                  
                                      
                  
                  
                                          Navigator.pop(context);
                  
                  
                  
                  
                  
                                                  final snackBar = SnackBar(
                                    
                                        elevation: 0,
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.transparent,
                                        content: AwesomeSnackbarContent(
                                          title: 'Something Wrong!!!',
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
                  
                  
                  
                  
                  
                                      }),
                                    );
                  
                  
                  
                  
                                                    },
                                                    child: const Text('DELETE'),
                                                  ),
                                                ],
                                              );});});
                  
                  
                  
                  
                  
                                            }, icon: Icon(Icons.delete, color: Colors.red.shade400,)),
                                          )),
                                      
                                      ]),
                            
                            
                  
                             
                              ],
                            ),
                      ),
                    ),
                  
                  
                      const SizedBox(height: 15,),
                  
                  
                  
                                
                      ],
                    ),
                  ),
                ),
              ),
      ),
        
        
      
    );
  }



   void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        imgFromGallery(context);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      imgFromCamera(context);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }




}