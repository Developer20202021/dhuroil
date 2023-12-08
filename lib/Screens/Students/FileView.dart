import 'package:dhuroil/DeveloperAccess/DeveloperAccess.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FileView extends StatefulWidget {

  final FileName;
  final FileUrl;


  const FileView({super.key, required this.FileName, required this.FileUrl});

  @override
  State<FileView> createState() => _FileViewState();
}

class _FileViewState extends State<FileView> {
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
        title: Text("${widget.FileName}", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),

      body: SingleChildScrollView(

        child: Center(
          child: Container(
        
        
            child: Image.network(
                                            "${widget.FileUrl}",
                                          
                                            fit: BoxFit.fitHeight,
                                          ),
        
        
        
          ),
        ),
      ),
    );
  }
}