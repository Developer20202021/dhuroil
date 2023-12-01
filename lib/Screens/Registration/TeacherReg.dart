import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhuroil/DeveloperAccess/DeveloperAccess.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;


class TeacherRegistration extends StatefulWidget {
  const TeacherRegistration({super.key});

  @override
  State<TeacherRegistration> createState() => _TeacherRegistrationState();
}

class _TeacherRegistrationState extends State<TeacherRegistration> {
  TextEditingController myEmailController = TextEditingController();
  TextEditingController myPassController = TextEditingController();
  TextEditingController myAddressController = TextEditingController();
  TextEditingController myPhoneNumberController = TextEditingController();
  TextEditingController myAdminNameController = TextEditingController();
  TextEditingController SubjectController = TextEditingController();
  TextEditingController RegCodeController = TextEditingController();



String SelectedRole = ""; 

var createUserErrorCode = "";

bool loading = false;


String SelectedClass ="";

String SelectedRegionValue ="";

String SelectedGenderValue ="";








 
String errorTxt = "";

String RegCode ="uttaron123";

var RegCodeTextField ="";



    // All Error Message Show

  bool NameError = false;
  bool phoneNumberError = false;
  bool EmailError = false;
  bool addressError = false;
  bool passwordError = false;





 void checkEmailTextField() {


    if (myEmailController.text.isEmpty) {

      setState(() {

        EmailError=true;
        
      });
      
    }
   else{

    setState(() {
      EmailError=false;
    });


    }


  }




  void checkPhoneNumberTextField(){


     if(myPhoneNumberController.text.isEmpty){

      setState(() {
        phoneNumberError =true;
      });

    }
    else{


    setState(() {
        phoneNumberError =false;
      });

    }

    
  }





    void checkNameTextField(){


     if(myAdminNameController.text.isEmpty){

      setState(() {
        NameError =true;
      });

    }
    else{


    setState(() {
        NameError =false;
      });

    }

    
  }



  void checkAddressTextField(){


     if(myAddressController.text.isEmpty){

      setState(() {
        addressError =true;
      });

    }
    else{


    setState(() {
        addressError =false;
      });

    }

    
  }




  void checkPasswordTextField(){


     if(myPassController.text.isEmpty){

      setState(() {
        passwordError =true;
      });

    }
    else{


    setState(() {
        passwordError =false;
      });

    }

    
  }











  
  @override
  void initState() {
  
    super.initState();
    // FlutterNativeSplash.remove();
    
  }


  @override
  Widget build(BuildContext context) {

    FocusNode myFocusNode = new FocusNode();



   







    


 

    return  Scaffold(
      backgroundColor: Colors.white,
      
      appBar: AppBar(

      
      systemOverlayStyle: SystemUiOverlayStyle(
            // Navigation bar
            statusBarColor: ColorName().appColor, // Status bar
          ),
       
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
       automaticallyImplyLeading: false,
        title: const Text("Teacher Registration", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),
      body: SingleChildScrollView(

              child:  loading?Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Center(
                      child: LoadingAnimationWidget.discreteCircle(
                        color: const Color(0xFF1A1A3F),
                        secondRingColor: Theme.of(context).primaryColor,
                        thirdRingColor: Colors.white,
                        size: 100,
                      ),
                    ),
              ):Padding(
                padding: const EdgeInsets.only(left: 300, right: 200, top: 20),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [




                          errorTxt.isNotEmpty?  Center(
                            child: Padding(
                                         padding: const EdgeInsets.all(8.0),
                                         child: Container(
                                       
                                                   color: Colors.red.shade400,
                                                   
                                                   
                                                   child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("${errorTxt}", style: TextStyle(color: Colors.white),),
                                                   )),
                                       ),
                          ):Text(""),




            
          SizedBox(height: 15,),



                    
                    // Center(
                    //   child: Lottie.asset(
                    //   'lib/images/animation_lk8g4ixk.json',
                    //     fit: BoxFit.cover,
                    //     width: 300,
                    //     height: 200
                    //   ),
                    // ),
            
            // SizedBox(
            //           height: 20,
            //         ),
            
            
            
                    TextField(

                    onChanged: (value) {
                        checkAddressTextField();
                        checkEmailTextField();
                        checkNameTextField();
                        checkPasswordTextField();
                        checkPhoneNumberTextField();


                        // For Android 

                        // setState(() {
                        //   myAdminNameController.text =value;
                        // });

                      },
                      
                      decoration: InputDecoration(


                     prefixIcon: Icon(Icons.person, color: ColorName().appColor,),

                      helperText: NameError?'Required Enter Full Name':"",
                      helperStyle: TextStyle(color: Colors.red.shade400),



                          border: OutlineInputBorder(),
                          labelText: 'Enter Name',
                           labelStyle: TextStyle(
              color: myFocusNode.hasFocus ? Theme.of(context).primaryColor: Colors.black
                  ),
                          hintText: 'Enter Your Name',
            
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
                      controller: myAdminNameController,
                    ),
            
            
            
            
                 
            
            
            
            
                   
                    SizedBox(
                      height: 15,
                    ),



            
            
            
                    TextField(

                    onChanged: (value) {
                        checkAddressTextField();
                        checkEmailTextField();
                        checkNameTextField();
                        checkPasswordTextField();
                        checkPhoneNumberTextField();

                        // For Android 

                        // setState(() {
                        //   myPhoneNumberController.text =value;
                        // });



                      },


                      keyboardType: TextInputType.phone,
                  
                      decoration: InputDecoration(


                     prefixIcon: Icon(Icons.phone_android, color: ColorName().appColor,),

                      helperText: phoneNumberError?'Required Enter Phone Number':"",
                      helperStyle: TextStyle(color: Colors.red.shade400),



                          border: OutlineInputBorder(),
                          labelText: 'Enter Phone Number',
                           labelStyle: TextStyle(
              color: myFocusNode.hasFocus ? Theme.of(context).primaryColor: Colors.black
                  ),
                          hintText: 'Enter Your Phone Number',
            
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
                      controller: myPhoneNumberController,
                    ),
            
            
            
            
                    SizedBox(
                      height: 15,
                    ),
            
            
            
            
            
                    TextField(

                        onChanged: (value) {
                        checkAddressTextField();
                        checkEmailTextField();
                        checkNameTextField();
                        checkPasswordTextField();
                        checkPhoneNumberTextField();


                        // For Android 

                        // setState(() {
                        //   myEmailController.text = value;
                        // });


                      },


                      
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(


                     prefixIcon: Icon(Icons.email, color: ColorName().appColor,),

                      helperText: EmailError?'Required Enter Email':"",
                      helperStyle: TextStyle(color: Colors.red.shade400),



                          border: OutlineInputBorder(),
                          labelText: 'Enter Email',
                           labelStyle: TextStyle(
              color: myFocusNode.hasFocus ? Colors.purple: Colors.black
                  ),
                          hintText: 'Enter Your Email',
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
                      controller: myEmailController,
                    ),
            
                    SizedBox(
                      height: 15,
                    ),



                    
                    TextField(


                      onChanged: (value) {
                        checkAddressTextField();
                        checkEmailTextField();
                        checkNameTextField();
                        checkPasswordTextField();
                        checkPhoneNumberTextField();

                        // For Android 

                        // setState(() {
                        //   myAddressController.text = value;
                        // });
                        
                        
                        },




                      keyboardType: TextInputType.streetAddress,
                      
                      decoration: InputDecoration(

                    prefixIcon: Icon(Icons.location_city, color: ColorName().appColor,),

                      helperText: addressError?'Required Enter Address':"",
                      helperStyle: TextStyle(color: Colors.red.shade400),



                          border: OutlineInputBorder(),
                          labelText: 'Enter Address',
                           labelStyle: TextStyle(
              color: myFocusNode.hasFocus ? Theme.of(context).primaryColor: Colors.black
                  ),
                          hintText: 'Enter Address',
            
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
                      controller: myAddressController,
                    ),
            
            
            
            
                 
        
                   
                    SizedBox(
                      height: 15,
                    ),


                    
                    TextField(
                      
                      decoration: InputDecoration(

                    prefixIcon: Icon(Icons.subject, color: ColorName().appColor,),
                          border: OutlineInputBorder(),
                          labelText: 'Enter Teacher Subject',
                           labelStyle: TextStyle(
              color: myFocusNode.hasFocus ? Theme.of(context).primaryColor: Colors.black
                  ),
                          hintText: 'Enter Teacher Subject',
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
                      controller: SubjectController,
                    ),
            

            SizedBox(
                      height: 15,
                    ),




                  
                      Tooltip(
                        // padding: EdgeInsets.only(left: 200, right: 200),
                        // message: "এই শিক্ষক Software কোন Access পাবে তা এটির মাধ্যমে নির্ধারণ হবে। (i)আপনি Teacher Select করলে তিনি শুধু তার Information দেখতে পাবে। (ii) আপনি Guide Teacher Select করলে তিনি তার এবং তার ক্লাসের Student এর Information দেখতে পাবে। (iii)আপনি Admin Select করলে তিনি তার এবং পুরো Software এর Access। (iv) আপনি Head Teacher Select করলে তিনি তার এবং পুরো Software এর Access। ",
                         richMessage: WidgetSpan(
                                alignment: PlaceholderAlignment.baseline,
                                baseline: TextBaseline.alphabetic,
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  constraints:
                                      const BoxConstraints(maxWidth: 250),
                                  child: Text("এই শিক্ষক Software এর কোন Access পাবে তা এটির মাধ্যমে নির্ধারণ হবে। (i)আপনি Teacher Select করলে তিনি শুধু তার Information দেখতে পাবে। (ii) আপনি Guide Teacher Select করলে তিনি তার এবং তার ক্লাসের Student এর Information দেখতে পাবে। (iii)আপনি Admin Select করলে তিনি তার এবং পুরো Software এর Access। (iv) আপনি Head Teacher Select করলে তিনি তার এবং পুরো Software এর Access। "),
                                )),
                            decoration: BoxDecoration(
                              color: Color(0XFFDFE0FF),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(4)),
                            ),
                            preferBelow: false,
                            verticalOffset: 10,
                        child: Container(
                          height: 70,
                          child: DropdownButton(
                      
                      
                            hint:  SelectedRole == ""
                                ? Text('Role')
                                : Text(
                                   SelectedRole,
                                    style: TextStyle(color: ColorName().appColor, fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                            isExpanded: true,
                            iconSize: 30.0,
                            style: TextStyle(color: ColorName().appColor, fontWeight: FontWeight.bold, fontSize: 16),
                            items: ["Teacher",'Admin', 'Guide Teacher', 'Head Teacher', "Ast. Head Teacher"].map(
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
                                   SelectedRole = val!;
                                },
                              );
                            },
                          ),
                        ),
                      ),





                              SizedBox(height: 11,),





           







                    TextField(

                      onChanged: (value) {
                        checkAddressTextField();
                        checkEmailTextField();
                        checkNameTextField();
                        checkPasswordTextField();
                        checkPhoneNumberTextField();

                        // For Android 

                        // setState(() {
                        //   myPassController.text =value;
                        // });


                      },
                      
                      decoration: InputDecoration(

                  

                   prefixIcon: Icon(Icons.password, color: ColorName().appColor,),

                      helperText: passwordError?'Required Enter password':"",
                      helperStyle: TextStyle(color: Colors.red.shade400),



                          border: OutlineInputBorder(),
                          labelText: 'Enter Password',
                           labelStyle: TextStyle(
              color: myFocusNode.hasFocus ? Theme.of(context).primaryColor: Colors.black
                  ),
                          hintText: 'Enter Your Password',
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
                      controller: myPassController,
                    ),
            

            SizedBox(
                      height: 15,
                    ),


              

            SelectedRole=="Guide Teacher"?  Tooltip(
                message: "এই শিক্ষক যদি Guide Teacher হন তবে নিচে থাকা ক্লাস Select করুন। অথবা None Select করুন।",
                child: Container(
                                height: 70,
                                child: DropdownButton(
                                 
                                                   
                                 
                                  hint:  SelectedClass == ""
                                      ? Text('Class')
                                      : Text(
                                         SelectedClass,
                                          style: TextStyle(color: ColorName().appColor, fontWeight: FontWeight.bold, fontSize: 16),
                                        ),
                                  isExpanded: true,
                                  iconSize: 30.0,
                                  style: TextStyle(color: ColorName().appColor, fontWeight: FontWeight.bold, fontSize: 16),
                                  items: ["None","0",'1', '2', '3', "4","5","6","7","8","9","10","ssc"].map(
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
                                      },
                                    );
                                  },
                                ),
                              ),
              ):Text(""),





                SizedBox(height: 11,),


                            Container(
                              height: 70,
                              child: DropdownButton(
                               
                                                 
                               
                                hint:  SelectedGenderValue == ""
                                    ? Text('Gender')
                                    : Text(
                                       SelectedGenderValue,
                                        style: TextStyle(color: ColorName().appColor, fontWeight: FontWeight.bold, fontSize: 16),
                                      ),
                                isExpanded: true,
                                iconSize: 30.0,
                                style: TextStyle(color: ColorName().appColor, fontWeight: FontWeight.bold, fontSize: 16),
                                items: ['Male', 'Female', 'Custom'].map(
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
                                       SelectedGenderValue = val!;
                                    },
                                  );
                                },
                              ),
                            ),
                  
                  
                  




                            SizedBox(height: 11,),

                            Container(
                              height: 70,
                              child: DropdownButton(
                               
                                                 
                               
                                hint:  SelectedRegionValue == ""
                                    ? Text('Religion')
                                    : Text(
                                       SelectedRegionValue,
                                        style: TextStyle(color: ColorName().appColor, fontWeight: FontWeight.bold, fontSize: 16),
                                      ),
                                isExpanded: true,
                                iconSize: 30.0,
                                style: TextStyle(color: ColorName().appColor, fontWeight: FontWeight.bold, fontSize: 16),
                                items: ['Islam', 'Hinduism', 'Buddhism','Christianity',].map(
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
                                       SelectedRegionValue = val!;
                                    },
                                  );
                                },
                              ),
                            ),

                    

                    SizedBox(
                      height: 15,
                    ),




              
              
              TextField(
                onChanged: (value) {

                  setState(() {
                    RegCodeTextField =value.trim().toLowerCase();
                  });


                  // For Android 

                  // setState(() {
                  //   RegCodeController.text = value;
                  // });

                  
                },
                      
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter Reg Code',
                           labelStyle: TextStyle(
              color: myFocusNode.hasFocus ? Theme.of(context).primaryColor: Colors.black
                  ),
                          hintText: 'Enter Reg Code',
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
                      controller: RegCodeController,
                    ),
            

            SizedBox(
                      height: 15,
                    ),










      // যদি Android হয় তখন নিচে RegCodeTextField change করে RegCodeController.text.trim().tolowerCase() ব্যবহার করতে হবে। 
            
                    RegCode==RegCodeTextField&& myPassController.text.isNotEmpty && myAddressController.text.isNotEmpty && myAdminNameController.text.isNotEmpty && myPhoneNumberController.text.isNotEmpty && myEmailController.text.isNotEmpty?Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(width: 150, child:TextButton(onPressed: () async{

                   


                          setState(() {
                            loading = true;
                          });





                      try {
                        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: myEmailController.text.trim(),
                          password: myPassController.text.trim(),
                        );


                        

                      



                       
                    await credential.user?.updateDisplayName(myAdminNameController.text.trim().toLowerCase());



                     final docUser =  FirebaseFirestore.instance.collection("TeacherInfo");

                      final jsonData ={
                        "TeacherName":myAdminNameController.text.trim().toLowerCase(),
                        "TeacherEmail":myEmailController.text.trim().toLowerCase(),
                        "emailVerified":"",
                        "role":SelectedRole.toString().toLowerCase(),
                        "ClassName":SelectedClass,
                        "AdminApprove":"false",
                        "registrationType":"teacher",
                        "TeacherPhoneNumber":myPhoneNumberController.text.trim(),
                        "TeacherPassword":myPassController.text.trim(),
                        "TeacherAddress":myAddressController.text.trim(),
                        "SubjectName":SubjectController.text.trim(),
                        "Department":SelectedRole,
                        "TeacherStatus":"new",
                        "LastAttendance":"",
                        "Gender":SelectedGenderValue.toString().toLowerCase(),
                        "Religion":SelectedRegionValue.toString().toLowerCase(),
                        "TeacherImageUrl":"https://t4.ftcdn.net/jpg/00/65/77/27/360_F_65772719_A1UV5kLi5nCEWI0BNLLiFaBPEkUbv5Fv.jpg"
                      };




                    await docUser.doc(myEmailController.text.trim().toLowerCase()).set(jsonData).then((value) =>  setState(()async{

                           await credential.user?.sendEmailVerification();


                       final snackBar = SnackBar(
                    /// need to set following properties for best effect of awesome_snackbar_content
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Registration Successfull',
                      message:
                          'Registration Successfull',
        
                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                      contentType: ContentType.success,
                    ),
                  );
        
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);


                    



                //    Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => NewEmailNotVerified(AdminEmail: myEmailController.text.trim().toLowerCase())),
                // );




                
                
                setState(() {
                    loading = false;
                  });




                    })).onError((error, stackTrace) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                              content: const Text('Something Wrong!'),
                              action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            )));




                setState(() {
                    loading = false;
                  });


                        

                        // print(credential.user!.email.toString());
                      } on FirebaseAuthException catch (e) {


                        setState(() {

                          errorTxt = e.code.toString();

                          loading = false;
                          


                        });




                        
                        // if (e.code == 'weak-password') {

                        //   setState(() {
                        //     loading = false;
                        //     createUserErrorCode = "weak-password";
                        //   });
                        //   print('The password provided is too weak.');
                        // } else if (e.code == 'email-already-in-use') {

                        //   setState(() {
                        //     loading = false;
                        //     createUserErrorCode = "email-already-in-use";
                        //   });
                        //   print('The account already exists for that email.');
                        // }



                      } catch (e) {
                        loading = false;
                        print(e);
                      }












                      
                        }, child: Text("Create Account", style: TextStyle(color: Colors.white),), style: ButtonStyle(
                         
                backgroundColor: MaterialStatePropertyAll<Color>(Theme.of(context).primaryColor),
              ),),),










               





                      ],
                    ):Text("")
            
            
            
                  ],
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