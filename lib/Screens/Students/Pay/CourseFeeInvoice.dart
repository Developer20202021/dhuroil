import 'dart:js';

import 'package:dhuroil/DeveloperAccess/DeveloperAccess.dart';
import 'package:dhuroil/Screens/Students/StudentCertificatePdf.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';








class PdfPreviewPage extends StatefulWidget {


  final StudentName;
  final StudentIDNo;
  final StudentPhoneNumber;
  final StudentEmail;
  final StudentCashIn;
  final CashInDate;










 
  const PdfPreviewPage({Key? key, required this.CashInDate, required this.StudentEmail, required this.StudentCashIn, required this.StudentIDNo, required this.StudentName, required this.StudentPhoneNumber, }) : super(key: key);

  @override
  State<PdfPreviewPage> createState() => _PdfPreviewPageState();
}

class _PdfPreviewPageState extends State<PdfPreviewPage> {
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
        title: const Text("Fee Invoice", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),),
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

final netImage = await networkImage('https://i.ibb.co/jTPJtqC/Uttaron-Logo.png');

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
    theme: pw.ThemeData.withFont(base: pw.Font.ttf(await rootBundle.load("lib/fonts/JosefinSans-BoldItalic.ttf")),),
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

                pw.Center(child:  pw.Image(netImage, height: 50, width: 50, ),),

                pw.Padding(
                  padding: pw.EdgeInsets.only(left: 90,),
                  
                  child: pw.Column(children: [

                  pw.Text("ayiBj D”P we`¨vjq", style:pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold, font: Banglattf)),
                  pw.Center(child: pw.Text("cvuPwewe, RqcyinvU, ivRkvnx", style:pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold, font: Banglattf)),),
                  pw.SizedBox(height: 6),
                  pw.Center(child: pw.Text("EIIN: 122026", style:pw.TextStyle(fontSize: 11,  font: ttf)),),



                ]))




            ]),

            


             pw.SizedBox(
                      height: 30,
                      
                
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
                
                
                
                child: pw.Padding(padding: pw.EdgeInsets.all(13), child: pw.Text("Admit Card", style: pw.TextStyle(fontSize: 19, color: PdfColors.white,))))),


               pw.SizedBox(
                      height: 10,
              ),


              pw.Center(child: pw.Text("1g mvgwqK cix¶v", style:pw.TextStyle(fontSize: 17, fontWeight: pw.FontWeight.bold, font: Banglattf)),),








              
              
             pw.SizedBox(
                      height: 20,
                      
                
              ),


              pw.Row(
                
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [

                  pw.Text("Name:", style: pw.TextStyle(fontSize: 14,)),

                  pw.SizedBox(width: 4),

                  pw.Container(
                
                width: 450,
                decoration:  pw.BoxDecoration(
                border: pw.Border(bottom: pw.BorderSide(width: 1, style: pw.BorderStyle.dashed))),
                    child: pw.Padding(padding: pw.EdgeInsets.only(bottom: 5, left: 30),child: pw.Text("Mahadi Hasan", style: pw.TextStyle(fontSize: 14,))))

              ]),



               pw.SizedBox(
                      height: 30,
                      
                
              ),



              pw.Row(
                
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [

                  pw.Text("Father Name:", style: pw.TextStyle(fontSize: 14,)),

                  pw.SizedBox(width: 4),


                pw.Container(
                
                width: 150,
                decoration:  pw.BoxDecoration(
                border: pw.Border(bottom: pw.BorderSide(width: 1, style: pw.BorderStyle.dashed))),
                    child: pw.Padding(padding: pw.EdgeInsets.only(bottom: 5, left: 10),child: pw.Text("Mosta Hasan", style: pw.TextStyle(fontSize: 11,)))),


                pw.Text("Mother Name:", style: pw.TextStyle(fontSize: 14,)),

                pw.SizedBox(width: 4),

                
                pw.Container(
                
                width: 150,
                decoration:  pw.BoxDecoration(
                border: pw.Border(bottom: pw.BorderSide(width: 1, style: pw.BorderStyle.dashed))),
                    child: pw.Padding(padding: pw.EdgeInsets.only(bottom: 5, left: 10),child: pw.Text("Amena Khanam", style: pw.TextStyle(fontSize: 11,)))),

              ]),


                pw.SizedBox(
                      height: 30,
                      
                
              ),


              pw.Row(
                
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [

                  pw.Text("Class:", style: pw.TextStyle(fontSize: 11,)),

                  pw.SizedBox(width: 4),


                pw.Container(
                
                width: 100,
                decoration:  pw.BoxDecoration(
                border: pw.Border(bottom: pw.BorderSide(width: 1, style: pw.BorderStyle.dashed))),
                    child: pw.Padding(padding: pw.EdgeInsets.only(bottom: 5, left: 30),child: pw.Text("7", style: pw.TextStyle(fontSize: 11,)))),


                pw.Text("Roll No:", style: pw.TextStyle(fontSize: 14,)),

                pw.SizedBox(width: 4),

                
                pw.Container(
                
                width: 130,
                decoration:  pw.BoxDecoration(
                border: pw.Border(bottom: pw.BorderSide(width: 1, style: pw.BorderStyle.dashed))),
                    child: pw.Padding(padding: pw.EdgeInsets.only(bottom: 5, left: 30),child: pw.Text("123144", style: pw.TextStyle(fontSize: 11,)))),


              

              pw.Text("Section:", style: pw.TextStyle(fontSize: 14,)),

                pw.SizedBox(width: 4),

                
                pw.Container(
                
                width: 130,
                decoration:  pw.BoxDecoration(
                border: pw.Border(bottom: pw.BorderSide(width: 1, style: pw.BorderStyle.dashed))),
                    child: pw.Padding(padding: pw.EdgeInsets.only(bottom: 5, left: 10),child: pw.Text("", style: pw.TextStyle(fontSize: 14,)))),





              ]),




            
            pw.SizedBox(height: 100,),
            pw.Align(alignment: pw.Alignment.topLeft,child: pw.Text("Instructions for Candidates :", style: pw.TextStyle(fontSize: 16)),),
            pw.SizedBox(height: 7,),
            pw.Text("1. Candidates have to print and bring the admit card during examination and preserve the same for future use. Candidates have to use black ink ball point pen for MCQ Test"),

            // pw.Text("2. Candidates have to use black ink ball point pen for MCQ Test"),
            
            pw.Text("2. Candidates will not carry  Mobile Phone, Smart Watch or any other electronic devices in examination hall."),

            pw.Text("3. Candidates will not bring more than one copy of admit card or any other paper in the examination hall. "),

            pw.Text("4. Candidates shall report to the examination center 1 hour prior to start of examination. No candidate will be   allowed to enter examination hall after the examination has started."),





            

          //       pw.Table(
          //             border: pw.TableBorder.all(color: PdfColors.blue200),
          //             children: [


          //             // The first row just contains a phrase 'INVOICE FOR PAYMENT'
          //               // pw.TableRow(
          //               // decoration: pw.BoxDecoration(color: PdfColors.blue100),
                          
          //               //   children: [
          //               //     pw.Padding(
          //               //       child: pw.Text(
          //               //         'MONEY RECEIPT',
          //               //         style: pw.Theme.of(context).header4,
          //               //         textAlign: pw.TextAlign.center,
          //               //       ),
          //               //       padding: pw.EdgeInsets.all(7),
          //               //     ),
          //               //   ],
          //               // ),



          //                         pw.TableRow(

          //                 decoration: pw.BoxDecoration(color: PdfColors.blue100),

          //                 children: [
          //                   pw.Padding(
          //                     child: pw.Text(
          //                       'ID No',
          //                       style: pw.Theme.of(context).header4,
          //                       textAlign: pw.TextAlign.center,
          //                     ),
          //                     padding: pw.EdgeInsets.all(4),
          //                   ),


          //                     pw.Padding(
          //                     child: pw.Text(
          //                       '${StudentIDNo}',
          //                       style: pw.Theme.of(context).header4,
          //                       textAlign: pw.TextAlign.center,
          //                     ),
          //                     padding: pw.EdgeInsets.all(4),
          //                   ),

          //                   pw.Column(children: [

          //                      pw.Padding(
          //                     child: pw.Text(
          //                       '${StudentIDNo}',
          //                       style: pw.Theme.of(context).header4,
          //                       textAlign: pw.TextAlign.center,
          //                     ),
          //                     padding: pw.EdgeInsets.all(4),
          //                   ),

          //                   pw.Divider(height: 2,),

                            

          //                    pw.Padding(
          //                     child: pw.Text(
          //                       '${StudentIDNo}',
          //                       style: pw.Theme.of(context).header4,
          //                       textAlign: pw.TextAlign.center,
          //                     ),
          //                     padding: pw.EdgeInsets.all(4),
          //                   ),



          //                   ])




          //                 ],
          //               ),


                    
                    

          //                      pw.TableRow(

          //                 decoration: pw.BoxDecoration(color: PdfColors.grey100),

          //                 children: [
          //                   pw.Padding(
          //                     child: pw.Text(
          //                       'Name',
          //                       style: pw.Theme.of(context).header4,
          //                       textAlign: pw.TextAlign.center,
          //                     ),
          //                     padding: pw.EdgeInsets.all(4),
          //                   ),


          //                     pw.Padding(
          //                     child: pw.Text(
          //                       '${StudentName}',
          //                       style: pw.Theme.of(context).header4,
          //                       textAlign: pw.TextAlign.center,
          //                     ),
          //                     padding: pw.EdgeInsets.all(4),
          //                   ),




          //                 ],
          //               ),




          //                           pw.TableRow(

          //                 decoration: pw.BoxDecoration(color: PdfColors.blue100),

          //                 children: [
          //                   pw.Padding(
          //                     child: pw.Text(
          //                       'Phone No',
          //                       style: pw.Theme.of(context).header4,
          //                       textAlign: pw.TextAlign.center,
          //                     ),
          //                     padding: pw.EdgeInsets.all(4),
          //                   ),


          //                     pw.Padding(
          //                     child: pw.Text(
          //                       '${StudentPhoneNumber}',
          //                       style: pw.Theme.of(context).header4,
          //                       textAlign: pw.TextAlign.center,
          //                     ),
          //                     padding: pw.EdgeInsets.all(4),
          //                   ),




          //                 ],
          //               ),




          //                           pw.TableRow(

          //                 decoration: pw.BoxDecoration(color: PdfColors.grey100),

          //                 children: [
          //                   pw.Padding(
          //                     child: pw.Text(
          //                       'Email',
          //                       style: pw.Theme.of(context).header4,
          //                       textAlign: pw.TextAlign.center,
          //                     ),
          //                     padding: pw.EdgeInsets.all(4),
          //                   ),


          //                     pw.Padding(
          //                     child: pw.Text(
          //                       '${StudentEmail}',
          //                       style: pw.Theme.of(context).header4,
          //                       textAlign: pw.TextAlign.center,
          //                     ),
          //                     padding: pw.EdgeInsets.all(4),
          //                   ),




          //                 ],
          //               ),








          //             pw.TableRow(
          //               decoration: pw.BoxDecoration(color: PdfColors.blue100),
          //                 children: [
          //                   pw.Padding(
          //                     child: pw.Text(
          //                       'Cash In',
          //                       style: pw.Theme.of(context).header4,
          //                       textAlign: pw.TextAlign.center,
          //                     ),
          //                     padding: pw.EdgeInsets.all(4),
          //                   ),


          //                     pw.Padding(
          //                     child: pw.Text(
          //                       '${StudentCashIn} tk',
          //                       style: pw.Theme.of(context).header4,
          //                       textAlign: pw.TextAlign.center,
          //                     ),
          //                     padding: pw.EdgeInsets.all(4),
          //                   ),

          //                 ],
          //               ),



                    



                        





          //                      pw.TableRow(

          //                 decoration: pw.BoxDecoration(color: PdfColors.grey100),

          //                 children: [
          //                   pw.Padding(
          //                     child: pw.Text(
          //                       'Date',
          //                       style: pw.Theme.of(context).header4,
          //                       textAlign: pw.TextAlign.center,
          //                     ),
          //                     padding: pw.EdgeInsets.all(4),
          //                   ),


          //                     pw.Padding(
          //                     child: pw.Text(
          //                       '${CashInDate}',
          //                       style: pw.Theme.of(context).header4,
          //                       textAlign: pw.TextAlign.center,
          //                     ),
          //                     padding: pw.EdgeInsets.all(4),
          //                   ),




          //                 ],
          //               ),













          // ]),




                 pw.SizedBox(
                      height: 110,
                      
                
              ),




          //  pw.Image(netImage, height: 330, width: 510),



            // pw.SizedBox(
            //           height: 230,
                      
                
            //   ),



            pw.Row(

              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              
              
              
              children: [

                  pw.Column(children: [

                    pw.Text("___________________________"),

                    pw.Text("Student Signature"),


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