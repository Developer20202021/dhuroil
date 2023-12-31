import 'dart:convert';
import 'dart:math';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhuroil/DeveloperAccess/DeveloperAccess.dart';
import 'package:dhuroil/Screens/Registration/AllRegistration.dart';
import 'package:dhuroil/Screens/Registration/OtpPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;


class StudentRegistration extends StatefulWidget {
  const StudentRegistration({super.key});

  @override
  State<StudentRegistration> createState() => _StudentRegistrationState();
}

class _StudentRegistrationState extends State<StudentRegistration> {
  TextEditingController myEmailController = TextEditingController();
  TextEditingController myPassController = TextEditingController();
  TextEditingController myAddressController = TextEditingController();
  TextEditingController myPhoneNumberController = TextEditingController();
  TextEditingController myAdminNameController = TextEditingController();
  TextEditingController MotherNameController = TextEditingController();
  TextEditingController FatherNameController = TextEditingController();
  TextEditingController DateOfBirthController = TextEditingController();
  TextEditingController BirthCertificateNoController = TextEditingController();
  TextEditingController NIDController = TextEditingController();
  TextEditingController FatherPhoneNoController = TextEditingController();
  TextEditingController CourseFeeController = TextEditingController();
  TextEditingController IDNoController = TextEditingController();
  TextEditingController RegCodeController = TextEditingController();


  String errorTxt = "";

  String RegCode ="dhuroil123";
  
  var RegCodeTextField ="";



  String SelectedValue = ""; 

  String SelectedGenderValue="";

  String SelectedRegionValue ="";

  String SelectedClass ="";

  String SelectedDateOfBirth ="Select Date of Birth";




 var createUserErrorCode = "";

 bool loading = false;




var rng = new Random();
var code = Random().nextInt(900000) + 100000;




    // All Error Message Show

  bool NameError = false;
  bool phoneNumberError = false;
  bool EmailError = false;
  bool addressError = false;
  bool passwordError = false;
  bool FatherPhoneError = false;
  bool CourseFeeError = false;
  bool IDError = false;





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








  void checkFatherPhoneNoTextField(){


     if(FatherPhoneNoController.text.isEmpty){

      setState(() {
        FatherPhoneError =true;
      });

    }
    else{


    setState(() {
        FatherPhoneError =false;
      });

    }

    
  }






    void checkCourseFeeTextField(){


     if(CourseFeeController.text.isEmpty){

      setState(() {
        CourseFeeError =true;
      });

    }
    else{


    setState(() {
       CourseFeeError =false;
      });

    }

    
  }




    void checkIDTextField(){


     if(IDNoController.text.isEmpty){

      setState(() {
        IDError =true;
      });

    }
    else{


    setState(() {
       IDError =false;
      });

    }

    
  }









  
  @override
  void initState() {
  
    super.initState();
    // FlutterNativeSplash.remove();

    print(code);
    
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
        title: const Text("Student Registration", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),),
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




                    
                   errorTxt.isNotEmpty?  Padding(
               padding: const EdgeInsets.all(8.0),
               child: Container(
             
                         color: Colors.red.shade400,
                         
                         
                         child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("${errorTxt}", style: TextStyle(color: Colors.white),),
                         )),
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
                        checkFatherPhoneNoTextField();
                        checkCourseFeeTextField();
                        checkIDTextField();


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
                        checkFatherPhoneNoTextField();
                        checkCourseFeeTextField();
                        checkIDTextField();



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
                        checkFatherPhoneNoTextField();
                        checkCourseFeeTextField();
                        checkIDTextField();


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
                        checkFatherPhoneNoTextField();
                        checkCourseFeeTextField();
                        checkIDTextField();

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

                  

                   onChanged: (value) {
                        checkAddressTextField();
                        checkEmailTextField();
                        checkNameTextField();
                        checkPasswordTextField();
                        checkPhoneNumberTextField();
                        checkFatherPhoneNoTextField();
                        checkCourseFeeTextField();
                        checkIDTextField();



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




           







                    TextField(
                      
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Father Name',
                           labelStyle: TextStyle(
              color: myFocusNode.hasFocus ? Theme.of(context).primaryColor: Colors.black
                  ),
                          hintText: 'Father Name',
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
                      controller: FatherNameController,
                    ),






                         SizedBox(
                      height: 15,
                    ),




           







                    TextField(
                      
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Mother Name',
                           labelStyle: TextStyle(
              color: myFocusNode.hasFocus ? Theme.of(context).primaryColor: Colors.black
                  ),
                          hintText: 'Mother Name',
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
                      controller: MotherNameController,
                    ),






                         SizedBox(
                      height: 15,
                    ),




           







                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Birth Cert No',
                           labelStyle: TextStyle(
              color: myFocusNode.hasFocus ? Theme.of(context).primaryColor: Colors.black
                  ),
                          hintText: 'Birth Cert No',
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
                      controller: BirthCertificateNoController,
                    ),






                         SizedBox(
                      height: 15,
                    ),




           







                    TextField(
                      
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'NID No',
                           labelStyle: TextStyle(
              color: myFocusNode.hasFocus ? Theme.of(context).primaryColor: Colors.black
                  ),
                          hintText: 'NID No',
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
                      controller: NIDController,
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
                        checkFatherPhoneNoTextField();
                        checkCourseFeeTextField();
                        checkIDTextField();

                        // For Android 

                        // setState(() {
                        //   FatherPhoneNoController.text =value;
                        // });


                      },



                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(

                      prefixIcon: Icon(Icons.phone_android, color: ColorName().appColor,),

                      helperText: FatherPhoneError?'Required Enter Father Phone No':"",
                      helperStyle: TextStyle(color: Colors.red.shade400),



                          border: OutlineInputBorder(),
                          labelText: 'Father Phone No',
                           labelStyle: TextStyle(
              color: myFocusNode.hasFocus ? Theme.of(context).primaryColor: Colors.black
                  ),
                          hintText: 'Father Phone No',
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
                      controller: FatherPhoneNoController,
                    ),




                         SizedBox(
                      height: 15,
                    ),




           







                      Container(
              height: 50,
              width: 200,
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

                                      SelectedDateOfBirth = "Year: ${pickedDate.toString().split(" ")[0]}";
                                      

                                    });

                                  
                                  // SelectedDate = "${pickedDate}";
                                  // SelectedDate = SelectedDate.split(" ")[0];

                                  print(SelectedDateOfBirth);
                                  // print(SelectedDate.split(" ")[0]);




                  });
                   
                                          }, child: Text("${SelectedDateOfBirth}", style: TextStyle(color: Colors.white, fontSize: 15),), style: ButtonStyle(
                                           
                      backgroundColor: MaterialStatePropertyAll<Color>(ColorName().appColor),
                    ),),
             ),





                           SizedBox(
                      height: 15,
                    ),




           












                  // SizedBox(
                  //     height: 15,
                  //   ),




           







                    TextField(

                      onChanged: (value) {
                        checkAddressTextField();
                        checkEmailTextField();
                        checkNameTextField();
                        checkPasswordTextField();
                        checkPhoneNumberTextField();
                        checkFatherPhoneNoTextField();
                        checkCourseFeeTextField();
                        checkIDTextField();



                        // For Android 



                        // setState(() {
                        //   IDNoController.text = value;
                        // });


                      },




                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(

                    prefixIcon: Icon(Icons.numbers, color: ColorName().appColor,),

                      helperText: IDError?'Required Enter Roll NO':"",
                      helperStyle: TextStyle(color: Colors.red.shade400),
                   


                          border: OutlineInputBorder(),
                          labelText: 'Roll No',
                           labelStyle: TextStyle(
              color: myFocusNode.hasFocus ? Theme.of(context).primaryColor: Colors.black
                  ),
                          hintText: 'Roll No',
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
                      controller: IDNoController,
                    ),





              

                              SizedBox(height: 11,),


                        

                        Container(
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
                                items: ["0",'1', '2', '3', "4","5","6","7","8","9","10","ssc"].map(
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





                      SizedBox(height: 11,),









                     SelectedClass=="9"||SelectedClass=="10"||SelectedClass=="ssc"?   Container(
                              height: 70,
                              child: DropdownButton(
                               
                                                 
                               
                                hint:  SelectedValue == ""
                                    ? Text('Department')
                                    : Text(
                                       SelectedValue,
                                        style: TextStyle(color: ColorName().appColor, fontWeight: FontWeight.bold, fontSize: 16),
                                      ),
                                isExpanded: true,
                                iconSize: 30.0,
                                style: TextStyle(color: ColorName().appColor, fontWeight: FontWeight.bold, fontSize: 16),
                                items: ['None','বিজ্ঞান', 'মানবিক', 'ব্যবসা'].map(
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
                                       SelectedValue = val!;
                                    },
                                  );
                                },
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


















       

              TextField(
                onChanged: (value) {


                  setState(() {
                    RegCodeTextField = value.trim().toLowerCase();
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














            

            SizedBox(
                      height: 15,
                    ),










// যদি Android হয় তখন নিচে RegCodeTextField change করে RegCodeController.text.trim().tolowerCase() ব্যবহার করতে হবে। 
            
                    RegCode==RegCodeTextField&& myPassController.text.isNotEmpty && myAddressController.text.isNotEmpty && myAdminNameController.text.isNotEmpty && myPhoneNumberController.text.isNotEmpty && myEmailController.text.isNotEmpty && IDNoController.text.isNotEmpty  && FatherPhoneNoController.text.isNotEmpty && SelectedValue.isNotEmpty?Row(
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

                       


                        // await credential.user?.updatePhoneNumber(myPhoneNumberController.text.trim() as PhoneAuthCredential);
                        


                     
                      
                        // await credential.user?.sendEmailVerification();






                  // var AdminMsg = "Dear Admin, ${myEmailController.text.trim()}  ${myPhoneNumberController.text} Admin হতে চায়। Please Check App";



                  // final response = await http
                  //     .get(Uri.parse('https://api.greenweb.com.bd/api.php?token=100651104321696050272e74e099c1bc81798bc3aa4ed57a8d030&to=01713773514&message=${AdminMsg}'));

                  // if (response.statusCode == 200) {
                    // If the server did return a 200 OK response,
                    // then parse the JSON.
                     final docUser =  FirebaseFirestore.instance.collection("StudentInfo");

                      final jsonData ={

                        "StudentName":myAdminNameController.text.trim().toLowerCase(),
                        "StudentEmail":myEmailController.text.trim().toLowerCase(),
                        "emailVerified":"",
                        "AdminApprove":"false",
                        "registrationType":"student",
                        "StudentPhoneNumber":myPhoneNumberController.text.trim(),
                        "StudentPassword":myPassController.text.trim(),
                        "StudentAddress":myAddressController.text.trim(),
                        "StudentDateOfBirth":SelectedDateOfBirth,
                        "StudentBirthCertificateNo":BirthCertificateNoController.text.trim(),
                        "StudentNID":NIDController.text.trim(),
                        "FatherName":FatherNameController.text.trim().toLowerCase(),
                        "MotherName":MotherNameController.text.trim().toLowerCase(),
                        "FatherPhoneNo":FatherPhoneNoController.text.trim(),
                        "Department":SelectedValue.toString().toLowerCase(),
                        "ClassName":SelectedClass.toString().toLowerCase(),
                        "Gender":SelectedGenderValue.toString().toLowerCase(),
                        "Religion":SelectedRegionValue.toString().toLowerCase(),
                        "StudentFineType":"Paid",
                        "ExamFeeType":"Paid",
                        "ExamFeeAmount":"0",
                        "FineAmount":"0",
                        "RollNo":IDNoController.text.trim().toLowerCase(),
                        "AdmissionDateTime":"${DateTime.now().toIso8601String()}",
                        "AdmissionDate":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                        "AdmissionMonth":"${DateTime.now().month}/${DateTime.now().year}",
                        "AdmissionYear":"${DateTime.now().year}",
                        "StudentStatus":"new",
                        "LastAttendance":"",
                        "AccountStatus":"open",
                        "OtpCode":code.toString(),
                        "PhoneVerify":"false",
                        "StudentImageUrl":"https://t4.ftcdn.net/jpg/00/65/77/27/360_F_65772719_A1UV5kLi5nCEWI0BNLLiFaBPEkUbv5Fv.jpg"

                     
                      };




                    await docUser.doc(myEmailController.text.trim().toLowerCase()).set(jsonData).then((value) =>  setState(() async{



                  var OtpMsg ="Your OTP ${code} Dhuroil High School. InanSoft";

                  final response = await http
                      .get(Uri.parse('https://api.greenweb.com.bd/api.php?token=100651104321696050272e74e099c1bc81798bc3aa4ed57a8d030&to=${myPhoneNumberController.text.trim()}&message=${OtpMsg}'));

                  if (response.statusCode == 200) {
                    // If the server did return a 200 OK response,
                    // then parse the JSON.

                    print("");
                    
                  } else {
                    // If the server did not return a 200 OK response,
                    // then throw an exception.
                    throw Exception('Failed to load album');
                  }



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


                    



                   Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AllRegistration()),
                );





                  //  myAdminNameController.clear();
                  //     myEmailController.clear();
                  //     myPassController.clear();
                  //     myPhoneNumberController.clear();

                
                
                setState(() {
                    loading = false;
                  });




                    })).onError((error, stackTrace) => setState((){

                      setState(() {
                    loading = false;
                  });


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



                    }));



         
                setState(() {
                    loading = false;
                  });


                        

                        // print(credential.user!.email.toString());
                      } on FirebaseAuthException catch (e) {


                  setState(() {
                    loading = false;
                  });

                        setState(() {

                          errorTxt = e.code.toString();
                          
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
                  setState(() {
                    loading = false;
                  });
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