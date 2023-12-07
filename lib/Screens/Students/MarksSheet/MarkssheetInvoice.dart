import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhuroil/DeveloperAccess/DeveloperAccess.dart';
import 'package:dhuroil/Screens/Students/StudentCertificatePdf.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';








class MarksSheetPdfPreviewPage extends StatefulWidget {


  final StudentEmail;
  final StudentPhoneNumber;
  final StudentName;
  final StudentClassName;
  final RollNumber;
  final FatherPhoneNo;
  final String ExamResultID;










 
  const MarksSheetPdfPreviewPage({Key? key, required this.ExamResultID, required this.FatherPhoneNo, required this.RollNumber, required this.StudentClassName, required this.StudentEmail, required this.StudentName, required this.StudentPhoneNumber}) : super(key: key);

  @override
  State<MarksSheetPdfPreviewPage> createState() => _MarksSheetPdfPreviewPageState();
}

class _MarksSheetPdfPreviewPageState extends State<MarksSheetPdfPreviewPage> {




List  AllData = [];


double TotalMarks = 0;

double TotalGradePoint = 0;

int TotalSubject = 0;



void getTotalMarksAndGradePoint(){

   setState(() {
     TotalSubject = AllData.length;
   });


  for (var i = 0; i < AllData.length; i++) {

   setState(() {
      TotalMarks = TotalMarks + double.parse(AllData[i]["TotalMarks"]);

    TotalGradePoint = TotalGradePoint + double.parse(AllData[i]["GradePoint"]);
   });
    
  }




}










Future<void> getData() async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();
    
  CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('PerExamPerSubjectResult');


    Query query = _collectionRef.where("ExamResultID", isEqualTo: widget.ExamResultID).where("ClassName", isEqualTo: widget.StudentClassName).where("StudentEmail", isEqualTo: widget.StudentEmail);
    QuerySnapshot querySnapshot = await query.get();

    // Get data from docs and convert map to List
     setState(() {
       AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
     });
 
    // AllData = querySnapshot.docs.map((doc) => doc.data()).toList();

    getTotalMarksAndGradePoint();

    print(AllData);
}



@override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }


  
  Future refresh() async{


    setState(() {
          getData();

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
       
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),
        title: const Text("Marks Sheet", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: PdfPreview(
          build: (context) => makePdf(widget.StudentEmail, widget.StudentPhoneNumber, widget.StudentName, widget.StudentClassName, widget.RollNumber,widget.FatherPhoneNo, widget.ExamResultID, AllData, TotalMarks,TotalGradePoint, TotalSubject ),
        ),
      ),
    );
  }
}



// makePdf(widget.StudentName,widget.StudentIDNo, widget.StudentPhoneNumber,widget.StudentCashIn,widget.StudentEmail,widget.CashInDate)








Future<Uint8List> makePdf(StudentEmail, StudentPhoneNumber, StudentName, StudentClassName, RollNumber,FatherPhoneNo, ExamResultID, List AllData, double TotalMarks, double TotalGradePoint, int TotalSubject) async {

final netImage = await networkImage('https://i.ibb.co/PYNsGBJ/bangladesh-govt-logo-A2-C7688845-seeklogo-com.png');

final backImage = await networkImage('https://i.ibb.co/X4QQgpc/13783.jpg');












final pdf = pw.Document();

final garland = await rootBundle.loadString('assets/garland.svg');
final swirls3 = await rootBundle.loadString('assets/swirls3.svg');
final swirls = await rootBundle.loadString('assets/swirls.svg');
final swirls1 = await rootBundle.loadString('assets/swirls1.svg');
final swirls2 = await rootBundle.loadString('assets/swirls2.svg');
final font = await rootBundle.load("lib/fonts/JosefinSans-BoldItalic.ttf");
final ttf = pw.Font.ttf(font);

final Banglafont = await rootBundle.load("lib/fonts/Siyam-Rupali-ANSI.ttf");
final Banglattf = pw.Font.ttf(Banglafont);


pdf.addPage(pw.Page(
  
  pageTheme: pw.PageTheme(
    pageFormat: PdfPageFormat.a4,
    theme: pw.ThemeData.withFont(base: pw.Font.ttf(await rootBundle.load("lib/fonts/Caladea-BoldItalic.ttf")),),
    buildBackground: (context)=>pw.FullPage(ignoreMargins: true,child: pw.Container(

       margin: const pw.EdgeInsets.all(10),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(
                  color: const PdfColor.fromInt(0xcc7722), width: 1),
            ),

      child:  pw.Container(

         margin: const pw.EdgeInsets.all(5),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                    color: const PdfColor.fromInt(0xcc7722), width: 5),
              ),
              width: double.infinity,
              height: double.infinity,
              child: pw.Stack(
                alignment: pw.Alignment.center,
                children: [

           pw.Positioned(
                    bottom: 5,
                    left: 5,
                    child: pw.Transform(
                      transform: Matrix4.diagonal3Values(1, -1, 1),
                      adjustLayout: true,
                      child: pw.SvgImage(
                        svg: swirls3,
                        height: 160,
                      ),
                    ),
                  ),


                    pw.Positioned(
                    top: 5,
                    left: 5,
                    child: pw.SvgImage(
                      svg: swirls3,
                      height: 160,
                    ),
                  ),
                  pw.Positioned(
                    top: 5,
                    right: 5,
                    child: pw.Transform(
                      transform: Matrix4.diagonal3Values(-1, 1, 1),
                      adjustLayout: true,
                      child: pw.SvgImage(
                        svg: swirls3,
                        height: 160,
                      ),
                    ),
                  ),

                  pw.Positioned(
                    bottom: 5,
                    right: 5,
                    child: pw.Transform(
                      transform: Matrix4.diagonal3Values(-1, -1, 1),
                      adjustLayout: true,
                      child: pw.SvgImage(
                        svg: swirls3,
                        height: 160,
                      ),
                    ),
                  ),


                     pw.Image(backImage, height: 750, width: 550, ),


                ]
              )
      )
    ))
  ),
  
  // theme: pw.ThemeData.withFont(base: pw.Font.ttf(await rootBundle.load("lib/fonts/JosefinSans-BoldItalic.ttf")),),
  //     pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Column(children: [

            pw.Row(
              
              mainAxisAlignment: pw.MainAxisAlignment.start,

              children: [

                pw.Center(child:  pw.Image(netImage, height: 70, width: 70, ),),

                pw.Padding(
                  padding: pw.EdgeInsets.only(left: 90,),
                  
                  child: pw.Column(children: [

                  pw.Text("ayiBj D”P we`¨vjq", style:pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold, font: Banglattf)),
                  pw.Center(child: pw.Text("cvuPwewe, RqcyinvU, ivRkvnx", style:pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold, font: Banglattf)),),
                  pw.SizedBox(height: 6),
                  // pw.Center(child: pw.Text("EIIN: 122026", style:pw.TextStyle(fontSize: 11,  font: ttf)),),



                ]))




            ]),

            


             pw.SizedBox(
                      height: 10,
                      
                
              ),


              // pw.Center(child:  pw.Image(netImage, height: 150, width: 250, ),),

              //    pw.SizedBox(
              //         height: 20,
                      
                
              // ),



              pw.Center(child: pw.Container(

                 decoration: pw.BoxDecoration(
                        borderRadius: pw.BorderRadius.only(
                            topRight: pw.Radius.circular(10.0),
                            topLeft: pw.Radius.circular(10.0),
                            bottomLeft: pw.Radius.circular(10.0),
                            bottomRight: pw.Radius.circular(10.0)),
                        color: PdfColor.fromInt(0xcc7722),
                      ),
                
                
                
                child: pw.Padding(padding: pw.EdgeInsets.all(10), child: pw.Text("Marks Sheet", style: pw.TextStyle(fontSize: 14, color: PdfColors.white,))))),


           




            pw.SizedBox(height: 10),




            pw.Table(
                      border: pw.TableBorder.all(color: PdfColors.blue200),
                      children: [



                    pw.TableRow(

                          decoration: pw.BoxDecoration(color: PdfColors.grey100),

                          children: [
                            pw.Padding(
                              child: pw.Text(
                                'Name:',
                                
                                textAlign: pw.TextAlign.left,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),


                              pw.Padding(
                              child: pw.Text(
                                '${StudentName}',
                                
                                textAlign: pw.TextAlign.left,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),


                          ],
                        ),


                    
                    

                   
                        pw.TableRow(

                          decoration: pw.BoxDecoration(color: PdfColors.grey100),

                          children: [
                            pw.Padding(
                              child: pw.Text(
                                'Class:',
                                
                                textAlign: pw.TextAlign.left,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),


                              pw.Padding(
                              child: pw.Text(
                                '${StudentClassName}',
                                
                                textAlign: pw.TextAlign.left,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),


                          ],
                        ),


                    
                        pw.TableRow(

                          decoration: pw.BoxDecoration(color: PdfColors.grey100),

                          children: [
                            pw.Padding(
                              child: pw.Text(
                                'Roll No:',
                                
                                textAlign: pw.TextAlign.left,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),


                              pw.Padding(
                              child: pw.Text(
                                '${RollNumber}',
                                
                                textAlign: pw.TextAlign.left,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),


                          ],
                        ),



                        
                        pw.TableRow(

                          decoration: pw.BoxDecoration(color: PdfColors.grey100),

                          children: [
                            pw.Padding(
                              child: pw.Text(
                                'Position:',
                                
                                textAlign: pw.TextAlign.left,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),


                              pw.Padding(
                              child: pw.Text(
                                '6',
                                
                                textAlign: pw.TextAlign.left,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),


                          ],
                        ),


                        pw.TableRow(

                          decoration: pw.BoxDecoration(color: PdfColors.grey100),

                          children: [
                            pw.Padding(
                              child: pw.Text(
                                'Total Marks:',
                                
                                textAlign: pw.TextAlign.left,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),


                              pw.Padding(
                              child: pw.Text(
                                '${TotalMarks.toString()}',
                                
                                textAlign: pw.TextAlign.left,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),


                          ],
                        ),




                        pw.TableRow(

                          decoration: pw.BoxDecoration(color: PdfColors.grey100),

                          children: [
                            pw.Padding(
                              child: pw.Text(
                                'GPA:',
                                
                                textAlign: pw.TextAlign.left,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),


                              pw.Padding(
                              child: pw.Text(
                                '${(TotalGradePoint/TotalSubject).toStringAsFixed(2)}',
                                
                                textAlign: pw.TextAlign.left,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),


                          ],
                        ),



          ]),





              
              pw.SizedBox(height: 10),
         



            

                pw.Table(
                      border: pw.TableBorder.all(color: PdfColors.blue200),
                      children: [



                      pw.TableRow(

                          decoration: pw.BoxDecoration(color: PdfColor.fromInt(0xcc7722)),

                          children: [
                            pw.Padding(
                              child: pw.Text(
                                'Subject',
                                style: pw.TextStyle(fontSize: 16, color: PdfColors.white),
                                textAlign: pw.TextAlign.center,

                                
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),


                          
                          pw.Padding(
                              child: pw.Text(
                                'Written',
                                style: pw.TextStyle(fontSize: 16, color: PdfColors.white),
                                textAlign: pw.TextAlign.center,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),



                            pw.Padding(
                              child: pw.Text(
                                'MCQ',
                                style: pw.TextStyle(fontSize: 16, color: PdfColors.white),
                                textAlign: pw.TextAlign.center,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),



                            pw.Padding(
                              child: pw.Text(
                                'Practical',
                                style: pw.TextStyle(fontSize: 16, color: PdfColors.white),
                                textAlign: pw.TextAlign.center,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),

                            pw.Padding(
                              child: pw.Text(
                                'Total',
                                style: pw.TextStyle(fontSize: 16, color: PdfColors.white),
                                textAlign: pw.TextAlign.center,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),


                            pw.Padding(
                              child: pw.Text(
                                'Grade',
                                style: pw.TextStyle(fontSize: 16, color: PdfColors.white),
                                textAlign: pw.TextAlign.center,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),

                          




                          ],
                        ),


                    
                    

                    for(int i=0; i<AllData.length; i++)
                        pw.TableRow(

                          decoration: pw.BoxDecoration(color: PdfColors.grey100),

                          children: [
                            pw.Padding(
                              child: pw.Text(
                                '${AllData[i]["SubejectName"]}',
                                
                                textAlign: pw.TextAlign.left,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),


                              pw.Padding(
                              child: pw.Text(
                                '${AllData[i]["WrittenMarks"]}',
                                
                                textAlign: pw.TextAlign.left,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),



                             pw.Padding(
                              child: pw.Text(
                                '${AllData[i]["MCQMarks"]}',
                                
                                textAlign: pw.TextAlign.left,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),


                             pw.Padding(
                              child: pw.Text(
                                '${AllData[i]["PracticalMarks"]}',
                                
                                textAlign: pw.TextAlign.left,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),


                             pw.Padding(
                              child: pw.Text(
                                '${AllData[i]["TotalMarks"]}',
                                
                                textAlign: pw.TextAlign.left,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),


                             pw.Padding(
                              child: pw.Text(
                                '${AllData[i]["Grade"]}',
                                
                                textAlign: pw.TextAlign.left,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),




                          ],
                        ),






          ]),




                 pw.SizedBox(
                      height: 70,
                      
                
              ),





            pw.Row(

              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              
              
              
              children: [

                  pw.Column(children: [

                    pw.Text("___________________________"),

                    pw.Text("Student's Signature"),


                  ]),



                        pw.Column(children: [

                    pw.Text("For and on behalf of",style: pw.TextStyle(fontSize: 12, color: PdfColors.black)),

                    pw.Text("ayiBj D”P we`¨vjq", style:pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold, font: Banglattf)),


                  ])



              ]),







        ])); // Center
      }));



return pdf.save();
}