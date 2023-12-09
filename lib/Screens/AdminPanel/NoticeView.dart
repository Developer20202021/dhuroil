import 'package:dhuroil/DeveloperAccess/DeveloperAccess.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NoticeView extends StatefulWidget {

  final NoticeTitle;
  final List FileUrl;


  const NoticeView({super.key, required this.NoticeTitle, required this.FileUrl});

  @override
  State<NoticeView> createState() => _NoticeViewState();
}

class _NoticeViewState extends State<NoticeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      
      systemOverlayStyle: SystemUiOverlayStyle(
            // Navigation bar
            statusBarColor: ColorName().appColor, // Status bar
          ),
       
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),
        title: Text("${widget.NoticeTitle} (${widget.FileUrl.length})", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),

      body: SingleChildScrollView(

        child: Center(
          child: Column(
            children: [

              for(int i=0; i<widget.FileUrl.length; i++)
                 Padding(
                   padding: const EdgeInsets.all(18.0),
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
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.red.shade200, Colors.pink.shade500, ],
                      ),
                    ),
                         
                         
                                 child: Image.network(
                                                  "${widget.FileUrl[i]}",
                                                
                                                  fit: BoxFit.fitHeight,
                                                ),
                    
                         
                         
                         
                               ),
                 ),


             
            ],
          ),
        ),
      ),
    );
  }
}