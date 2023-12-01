import 'dart:js';

import 'package:dhuroil/DeveloperAccess/DeveloperAccess.dart';
import 'package:dhuroil/Screens/Students/StudentCertificatePdf.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';








class MarksSheetPdfPreviewPage extends StatefulWidget {


  final StudentName;
  final StudentIDNo;
  final StudentPhoneNumber;
  final StudentEmail;
  final StudentCashIn;
  final CashInDate;










 
  const MarksSheetPdfPreviewPage({Key? key, required this.CashInDate, required this.StudentEmail, required this.StudentCashIn, required this.StudentIDNo, required this.StudentName, required this.StudentPhoneNumber, }) : super(key: key);

  @override
  State<MarksSheetPdfPreviewPage> createState() => _MarksSheetPdfPreviewPageState();
}

class _MarksSheetPdfPreviewPageState extends State<MarksSheetPdfPreviewPage> {
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
      body: PdfPreview(
        build: (context) => makePdf(widget.StudentName,widget.StudentIDNo, widget.StudentPhoneNumber,widget.StudentCashIn,widget.StudentEmail,widget.CashInDate),
      ),
    );
  }
}



// makePdf(widget.StudentName,widget.StudentIDNo, widget.StudentPhoneNumber,widget.StudentCashIn,widget.StudentEmail,widget.CashInDate)










Future<Uint8List> makePdf(StudentName, StudentIDNo, StudentPhoneNumber, StudentCashIn, StudentEmail,CashInDate) async {

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
                                'Mahadi Hasan',
                                
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
                                'Roll No:',
                                
                                textAlign: pw.TextAlign.left,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),


                              pw.Padding(
                              child: pw.Text(
                                '642534636',
                                
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
                                '1200',
                                
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
                                '5.00',
                                
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


                    
                    

                    for(int i=0; i<14; i++)
                        pw.TableRow(

                          decoration: pw.BoxDecoration(color: PdfColors.grey100),

                          children: [
                            pw.Padding(
                              child: pw.Text(
                                'Bangla',
                                
                                textAlign: pw.TextAlign.left,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),


                              pw.Padding(
                              child: pw.Text(
                                '60',
                                
                                textAlign: pw.TextAlign.left,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),



                             pw.Padding(
                              child: pw.Text(
                                '30',
                                
                                textAlign: pw.TextAlign.left,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),


                             pw.Padding(
                              child: pw.Text(
                                '24',
                                
                                textAlign: pw.TextAlign.left,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),


                             pw.Padding(
                              child: pw.Text(
                                '100',
                                
                                textAlign: pw.TextAlign.left,
                              ),
                              padding: pw.EdgeInsets.all(4),
                            ),


                             pw.Padding(
                              child: pw.Text(
                                'A+',
                                
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