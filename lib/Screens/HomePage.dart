import 'dart:convert';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dhuroil/DeveloperAccess/DeveloperAccess.dart';
import 'package:drop_cap_text/drop_cap_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:marquee/marquee.dart';
import 'dart:js' as js;





class HomePage extends StatefulWidget {



  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool loading = false;



    final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];
  String? selectedValue;














  @override
  Widget build(BuildContext context) {



    double width = MediaQuery.of(context).size.width;

    double height = MediaQuery.of(context).size.height;





    return Scaffold(
      backgroundColor: Colors.white,
      
      appBar: AppBar(

      systemOverlayStyle: SystemUiOverlayStyle(
            // Navigation bar
            statusBarColor: ColorName().appColor, // Status bar
          ),
       
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),
        title: const Text("All Pay",  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),
      body: loading?Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Center(
                      child: LoadingAnimationWidget.discreteCircle(
                        color: const Color(0xFF1A1A3F),
                        secondRingColor:  Theme.of(context).primaryColor,
                        thirdRingColor: Colors.white,
                        size: 100,
                      ),
                    ),
              ):SingleChildScrollView(child: Center(
        child: Column(
      
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
      
      
          children: [

    

    // header image 
      
      Container(
        width: MediaQuery.of(context).size.width*0.75,
        height: 200,
          decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("https://i.ibb.co/9ZHqYpx/school-banner.gif"),
            fit: BoxFit.cover,
          ),
        ),
        child: Text(""),
      ),



    // navigation 


    
    
   width>=1536? Container(
      width: MediaQuery.of(context).size.width*0.75,
      
      child: Row(
   
    
        children: [



             Container(width: 100,height: 45,

              child:
              Material(
                color: ColorName().appColor,
                child: InkWell(
                
                hoverColor: Colors.pink.shade300,

                onTap: (){
                
                    //      Navigator.push(
                    //   context,
                
                    //          MaterialPageRoute(builder: (context) => const RegistrationScreen()),
                    // );
                
                
                  }, child: Center(child: Text("প্রচ্ছদ", style: TextStyle(color: Colors.white, fontSize: 16
                  
                  
                  ),)), ),
              ),),



              SizedBox(width: 1,),




              
             Container(width: 100,height: 45,

              child:
              Material(
                color: ColorName().appColor,
                child: InkWell(
                
                hoverColor: Colors.pink.shade300,

                onTap: (){
                
                    //      Navigator.push(
                    //   context,
                
                    //          MaterialPageRoute(builder: (context) => const RegistrationScreen()),
                    // );
                
                
                  }, child: Center(child: Text("প্রচ্ছদ", style: TextStyle(color: Colors.white, fontSize: 16
                  
                  
                  ),)), ),
              ),),


              
              SizedBox(width: 1,),




              
             Container(width: 100,height: 45,

              child:
              Material(
                color: ColorName().appColor,
                child: InkWell(
                
                hoverColor: Colors.pink.shade300,

                onTap: (){
                
                    //      Navigator.push(
                    //   context,
                
                    //          MaterialPageRoute(builder: (context) => const RegistrationScreen()),
                    // );
                
                
                  }, child: Center(child: Text("প্রচ্ছদ", style: TextStyle(color: Colors.white, fontSize: 16
                  
                  
                  ),)), ),
              ),),

              
              SizedBox(width: 1,),




              
             Container(width: 100,height: 45,

              child:
              Material(
                color: ColorName().appColor,
                child: InkWell(
                
                hoverColor: Colors.pink.shade300,

                onTap: (){
                
                    //      Navigator.push(
                    //   context,
                
                    //          MaterialPageRoute(builder: (context) => const RegistrationScreen()),
                    // );
                
                
                  }, child: Center(child: Text("প্রচ্ছদ", style: TextStyle(color: Colors.white, fontSize: 16
                  
                  
                  ),)), ),
              ),),


              
              SizedBox(width: 1,),




              
             Container(width: 100,height: 45,

              child:
              Material(
                color: ColorName().appColor,
                child: InkWell(
                
                hoverColor: Colors.pink.shade300,

                onTap: (){
                
                    //      Navigator.push(
                    //   context,
                
                    //          MaterialPageRoute(builder: (context) => const RegistrationScreen()),
                    // );
                
                
                  }, child: Center(child: Text("প্রচ্ছদ", style: TextStyle(color: Colors.white, fontSize: 16
                  
                  
                  ),)), ),
              ),),




              
              SizedBox(width: 1,),




              
             Container(width: 100,height: 45,

              child:
              Material(
                color: ColorName().appColor,
                child: InkWell(
                
                hoverColor: Colors.pink.shade300,

                onTap: (){
                
                    //      Navigator.push(
                    //   context,
                
                    //          MaterialPageRoute(builder: (context) => const RegistrationScreen()),
                    // );
                
                
                  }, child: Center(child: Text("প্রচ্ছদ", style: TextStyle(color: Colors.white, fontSize: 16
                  
                  
                  ),)), ),
              ),),
              
              SizedBox(width: 1,),




              
             Container(width: 100,height: 45,

              child:
              Material(
                color: ColorName().appColor,
                child: InkWell(
                
                hoverColor: Colors.pink.shade300,

                onTap: (){
                
                    //      Navigator.push(
                    //   context,
                
                    //          MaterialPageRoute(builder: (context) => const RegistrationScreen()),
                    // );
                
                
                  }, child: Center(child: Text("প্রচ্ছদ", style: TextStyle(color: Colors.white, fontSize: 16
                  
                  
                  ),)), ),
              ),),

              
              SizedBox(width: 1,),




              
             Container(width: 100,height: 45,

              child:
              Material(
                color: ColorName().appColor,
                child: InkWell(
                
                hoverColor: Colors.pink.shade300,

                onTap: (){
                
                    //      Navigator.push(
                    //   context,
                
                    //          MaterialPageRoute(builder: (context) => const RegistrationScreen()),
                    // );
                
                
                  }, child: Center(child: Text("প্রচ্ছদ", style: TextStyle(color: Colors.white, fontSize: 16
                  
                  
                  ),)), ),
              ),),
              
              SizedBox(width: 1,),




              
             Container(width: 100,height: 45,

              child:
              Material(
                color: ColorName().appColor,
                child: InkWell(
                
                hoverColor: Colors.pink.shade300,

                onTap: (){
                
                    //      Navigator.push(
                    //   context,
                
                    //          MaterialPageRoute(builder: (context) => const RegistrationScreen()),
                    // );
                
                
                  }, child: Center(child: Text("প্রচ্ছদ", style: TextStyle(color: Colors.white, fontSize: 16
                  
                  
                  ),)), ),
              ),),

              
              SizedBox(width: 1,),




              
             Container(width: 100,height: 45,

              child:
              Material(
                color: ColorName().appColor,
                child: InkWell(
                
                hoverColor: Colors.pink.shade300,

                onTap: (){
                
                    //      Navigator.push(
                    //   context,
                
                    //          MaterialPageRoute(builder: (context) => const RegistrationScreen()),
                    // );
                
                
                  }, child: Center(child: Text("প্রচ্ছদ", style: TextStyle(color: Colors.white, fontSize: 16
                  
                  
                  ),)), ),
              ),),

              
              SizedBox(width: 1,),



               DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            hint: const Row(
              children: [
                Icon(
                  Icons.list,
                  size: 16,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Text(
                    'Select Item',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            items: items
                .map((String item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                .toList(),
            value: selectedValue,
            onChanged: (String? value) {
              setState(() {
                selectedValue = value;
              });
            },
            buttonStyleData: ButtonStyleData(
              height: 45,
              width: 140,
              padding: const EdgeInsets.only(left: 14, right: 14),
              decoration: BoxDecoration(
                
                border: Border.all(
                  color: Colors.black26,
                ),
                color: ColorName().appColor,
              ),
              elevation: 2,
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.arrow_forward_ios_outlined,
              ),
              iconSize: 14,
              iconEnabledColor: Colors.white,
              iconDisabledColor: Colors.grey,
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: ColorName().appColor,
              ),
              offset: const Offset(-20, 0),
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(40),
                thickness: MaterialStateProperty.all<double>(6),
                thumbVisibility: MaterialStateProperty.all<bool>(true),
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
              padding: EdgeInsets.only(left: 14, right: 14),
            ),
          ),
        ),
    




              
            //  Container(width: 140,height: 45,

            //   child:
            //   Material(
            //     color: ColorName().appColor,
            //     child: InkWell(
                
            //     hoverColor: Colors.pink.shade300,

            //     onTap: (){
                
            //         //      Navigator.push(
            //         //   context,
                
            //         //          MaterialPageRoute(builder: (context) => const RegistrationScreen()),
            //         // );
                
                
            //       }, child: Center(child: Text("প্রচ্ছদ", style: TextStyle(color: Colors.white, fontSize: 16
                  
                  
            //       ),)), ),
            //   ),),
              


                      

          
        ],
      ),
    ):Text(""),



      






      // header image gallery

        Container(
          width: MediaQuery.of(context).size.width*0.75,
          child: CarouselSlider(
            
                items: [
                    
                  //1st Image of Slider
        
              for(int i = 0; i<7; i++ )
        
        
                  Container(
                  
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage("https://img.freepik.com/free-vector/hand-drawn-global-handwashing-day-landing-page-template_52683-71631.jpg?w=1060&t=st=1700801190~exp=1700801790~hmac=16cddb944aa8b9b63c750f60cba1f1765c90dfe0db6b5b27ab23f6cadfc41bf7"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                    
            
          
            ],
                
              //Slider Container properties
                options: CarouselOptions(
                
                  height: 380.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 1,
                ),
            ),
        ),







    // Notice Marquee start

        Container(

        width: MediaQuery.of(context).size.width*0.75,

        child: Row(

          children: [

            Container(
              width: (MediaQuery.of(context).size.width*0.75)*0.25,


              height: 45,

              color: ColorName().appColor,

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("ঘোষণা",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
              ),


            ),

            Container(
              width: (MediaQuery.of(context).size.width*0.75)*0.75,
              height: 45,
             
              child: Padding(
                padding: const EdgeInsets.only(top: 11),
                child: Marquee(
                        text: 'আজকে থেকে আমরা নতুন Website Upload করবো। দয়া করে সবাই Visit করুন। ধন্যবাদ ',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        scrollAxis: Axis.horizontal,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        blankSpace: 20.0,
                        velocity: 100.0,
                        pauseAfterRound: Duration(seconds: 1),
                        startPadding: 10.0,
                        accelerationDuration: Duration(seconds: 1),
                        accelerationCurve: Curves.linear,
                        decelerationDuration: Duration(milliseconds: 500),
                        decelerationCurve: Curves.easeOut,
                      ),
              ),

            ),





          ],
        ),


        ),




        // Notice Marquee end





      SizedBox(height: 20,),
      

      Container(

        width: MediaQuery.of(context).size.width*0.75,

        child: Row(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,



          children: [


            //left 

            Container(
              width: (MediaQuery.of(context).size.width*0.75)*0.72,
              child: Column(
                children: [


                  // প্রতিষ্ঠানের ইতিহাস start
           Container(
           
            child: Column(
           
            children: [
           
             Container(
              width: (MediaQuery.of(context).size.width*0.75)*0.75,
                      
                      
              height: 35,
                      
              color: ColorName().appColor,
                      
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("প্রতিষ্ঠানের ইতিহাস",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
              ),
                      
                      
                ),


            

            Container(
              width: (MediaQuery.of(context).size.width*0.75)*0.75,           
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [


                    Image.network("https://img.freepik.com/free-vector/hand-drawn-global-handwashing-day-landing-page-template_52683-71631.jpg?w=1060&t=st=1700801190~exp=1700801790~hmac=16cddb944aa8b9b63c750f60cba1f1765c90dfe0db6b5b27ab23f6cadfc41bf7", 
                    
                    width: 230,
                    height: 230,
                    
                    fit: BoxFit.cover,
                    ),



                    SizedBox(width: 10,),


                    Flexible(
                      
                      child: Text("সুনামগঞ্জ জেলাধীন জগন্নাথপুরস্থ এক প্রাচীন জনপদের নাম ইসহাকপুর । এ গ্রামের সম্ভ্রান্ত ধর্মভীরু মুসলিম পরিবার সমূহের মধ্যে শীর্ষস্থানে অবস্থান খান পরিবারের । বংশমর্যাদায় যেমন শ্রেষ্ঠত্বের দাবীদার তেমনি শিক্ষা-দীক্ষায়, ধর্মভীরুতায়.সামাজিক আচার-অনুষ্ঠানে এ জনপদের অন্য সবের উপর রয়েছে এ পরিবারের অতুলনীয় সম্মান। যতদূর জানা যায় মরহুম দেলওয়ার খান ছিলেন এ পরিবারের একজন শিক্ষিত ব্যক্তি ।তিনি যেমন ছিলেন শিক্ষানুরাগী তেমনটি ধর্মানুরাগী এবং পরহেযগার। তাঁর দুই ছেলে সন্তান বড় ছেলের নাম মুজাম্মিল খান এবং ছোট ছেলের নাম মাহমুদ খান। মুজাম্মিল খানের ৩ (তিন) ছেলে সন্তানের মধ্যে বড় ছেলের নাম আব্দুর গাফ্ফার খান মেঝো ছেলের নাম খান জয়নাল আবেদিন ছোট ছেলের নাম মোনায়েম খান। দীর্ঘদিন থেকেই পূর্বপুরুষের ইতিহাস ঐতিহ্য ধরে রাখার মনোস্কামনায় এবং সমাজ সেবার অংশ হিসেবে নিঃস¦ার্থ ভাবে খান জয়নাল আবেদিন ”খান ওয়েলফেয়ার ট্রাস্ট” নামে একটি ট্রাস্ট গঠনের প্রস্তাব খান বংশের সকল সদস্য বরাবর উপস্থাপন করলে তা অনুমোদিত হয় এবং ২০০০ সালে উক্ত” খান ওয়েল ফেয়ার ট্রাস্ট” গঠন করা হয়। গঠনতন্ত্র অনুযায়ী ট্রাস্টের অধীন মাদরাসা,মসজিদ, এতীমখানা, হাসপাতাল সহ অন্যান্য সেবাধর্মী প্রতিষ্ঠান গড়ে তোলার প্রতিশ্রুতির অংশ হিসেবে ২০০২ সালে অত্র ট্রাস্টের অধীন প্রতিষ্ঠা করা হয় আল জান্নাত ইসলামিক এডুকেশন ইনস্টিটিউট নামের এ বিশাল মাদরাসা ।",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black,),
                      
                      textAlign: TextAlign.justify,
                      
                      )),
                  ],
                ),
              ),
                      
                      
                ),

           
                      ],
                    ),
           
           
                  ),

           // প্রতিষ্ঠানের ইতিহাস end





        
        SizedBox(height: 29,),



        // শিক্ষকের বাণী start
           Container(
           
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [


                // প্রধান শিক্ষকের বাণী

                Column(
           
                children: [
           
                 Container(
                  width: (MediaQuery.of(context).size.width*0.75)*0.3,
                          
                          
                  height: 35,
                          
                  color: ColorName().appColor,
                          
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("প্রধান শিক্ষকের বাণী",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
                  ),
                          
                          
                    ),


                Container(
                  width: (MediaQuery.of(context).size.width*0.75)*0.3,           
                  child: DropCapText(
                            "সুনামগঞ্জ জেলাধীন জগন্নাথপুরস্থ এক প্রাচীন জনপদের নাম ইসহাকপুর । এ গ্রামের সম্ভ্রান্ত ধর্মভীরু মুসলিম পরিবার সমূহের মধ্যে শীর্ষস্থানে অবস্থান খান পরিবারের । বংশমর্যাদায় যেমন শ্রেষ্ঠত্বের দাবীদার তেমনি শিক্ষা-দীক্ষায়, ধর্মভীরুতায়.সামাজিক আচার-অনুষ্ঠানে এ জনপদের অন্য সবের উপর রয়েছে এ পরিবারের অতুলনীয় সম্মান। যতদূর জানা যায় মরহুম দেলওয়ার খান ছিলেন এ পরিবারের একজন শিক্ষিত ব্যক্তি ।তিনি যেমন ছিলেন শিক্ষানুরাগী তেমনটি ধর্মানুরাগী এবং পরহেযগার। তাঁর দুই ছেলে সন্তান বড় ছেলের নাম মুজাম্মিল খান এবং ছোট ছেলের নাম মাহমুদ খান।",
                            textAlign: TextAlign.justify,
                            dropCap: DropCap(
                            width: 100,
                            height: 100,
                            child: Image.network(
                              'https://img.freepik.com/free-vector/hand-drawn-global-handwashing-day-landing-page-template_52683-71631.jpg?w=1060&t=st=1700801190~exp=1700801790~hmac=16cddb944aa8b9b63c750f60cba1f1765c90dfe0db6b5b27ab23f6cadfc41bf7')
                            ),
                        ),
                          
                          
                    ),

           
                          ],

                    
                        ),



          


            
          // সহকারি প্রধান শিক্ষকের বাণী

              // SizedBox(width: 9,),

                Column(
           
                children: [
           
                 Container(
                  width: (MediaQuery.of(context).size.width*0.75)*0.3,
                          
                          
                  height: 35,
                          
                  color: ColorName().appColor,
                          
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("সহকারী প্রধান শিক্ষকের বাণী",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
                  ),
                          
                          
                    ),


                

                Container(
                  width: (MediaQuery.of(context).size.width*0.75)*0.3,           
                  child: DropCapText(
                            
                          
                            "সুনামগঞ্জ জেলাধীন জগন্নাথপুরস্থ এক প্রাচীন জনপদের নাম ইসহাকপুর । এ গ্রামের সম্ভ্রান্ত ধর্মভীরু মুসলিম পরিবার সমূহের মধ্যে শীর্ষস্থানে অবস্থান খান পরিবারের । বংশমর্যাদায় যেমন শ্রেষ্ঠত্বের দাবীদার তেমনি শিক্ষা-দীক্ষায়, ধর্মভীরুতায়.সামাজিক আচার-অনুষ্ঠানে এ জনপদের অন্য সবের উপর রয়েছে এ পরিবারের অতুলনীয় সম্মান। যতদূর জানা যায় মরহুম দেলওয়ার খান ছিলেন এ পরিবারের একজন শিক্ষিত ব্যক্তি ।তিনি যেমন ছিলেন শিক্ষানুরাগী তেমনটি ধর্মানুরাগী এবং পরহেযগার। তাঁর দুই ছেলে সন্তান বড় ছেলের নাম মুজাম্মিল খান এবং ছোট ছেলের নাম মাহমুদ খান। ",
                            textAlign: TextAlign.justify,
                            dropCap: DropCap(
                            width: 100,
                            height: 100,
                            child: Image.network(
                              'https://img.freepik.com/free-vector/hand-drawn-global-handwashing-day-landing-page-template_52683-71631.jpg?w=1060&t=st=1700801190~exp=1700801790~hmac=16cddb944aa8b9b63c750f60cba1f1765c90dfe0db6b5b27ab23f6cadfc41bf7')
                            ),
                        ),
                          
                          
                    ),

           
                          ],
                        ),







              ],
            ),
           
           
          ),


      //শিক্ষকের বাণী end





        SizedBox(height: 29,),






          // ছাত্র ও শিক্ষক তথ্য start
           Container(
           
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [


                // ছাত্র ছাত্রীদের তথ্য

                Column(
           
                children: [
           
                 Container(
                  width: (MediaQuery.of(context).size.width*0.75)*0.3,
                          
                          
                  height: 35,
                          
                  color: ColorName().appColor,
                          
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("ছাত্রছাত্রীদের তথ্য",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
                  ),
                          
                          
                    ),


                Container(
                  width: (MediaQuery.of(context).size.width*0.75)*0.3,           
                  child: Row(

                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [


                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Image.network("http://themesbazar.net/educational/wp-content/themes/educationaltheme/images/menu01.jpg",
                        
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        ),
                      ),


                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            children: [
                          
                              Icon(Icons.check,),
                          
                              InkWell(
                                onTap: () {
                                  print("Done");
                                },
                                hoverColor: Colors.grey.shade300,
                                child: Text("ছাত্রছাত্রীর আসন সংখ্যা")),
                          
                            ],
                          ),


                      
                      SizedBox(height: 3,),


                       Row(
                            children: [
                          
                              Icon(Icons.check),
                          
                              InkWell(
                                onTap: () {
                                  print("Done");
                                },
                                hoverColor: Colors.grey.shade300,
                                child: Text("ভর্তি তথ্য")),
                          
                            ],
                          ),

                      

                      SizedBox(height: 3,),


                       Row(
                            children: [
                          
                              Icon(Icons.check),
                          
                              InkWell(
                                onTap: () {
                                  print("Done");
                                },
                                hoverColor: Colors.grey.shade300,
                                child: Text("নোটিশ")),
                          
                            ],
                          ),


                          SizedBox(height: 3,),

                         Row(
                            children: [
                          
                              Icon(Icons.check),
                          
                              InkWell(
                                onTap: () {
                                  print("Done");
                                },
                                hoverColor: Colors.grey.shade300,
                                child: Text("রুটিন")),
                          
                            ],
                          ),


                          SizedBox(height: 3,),

                          Row(
                            children: [
                          
                              Icon(Icons.check),
                          
                              InkWell(
                                onTap: () {
                                  print("Done");
                                },
                                hoverColor: Colors.grey.shade300,
                                child: Text("কৃতি শিক্ষার্থী")),
                          
                            ],
                          ),









                        ],
                      )





                    
                    




                    ],

                    
                  ),
                          
                          
                    ),

           
                          ],

                    
                        ),



          


            
          // শিক্ষকদের তথ্য

                Column(
           
                children: [
           
                 Container(
                  width: (MediaQuery.of(context).size.width*0.75)*0.3,
                          
                          
                  height: 35,
                          
                  color: ColorName().appColor,
                          
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("শিক্ষকদের তথ্য",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
                  ),
                          
                          
                    ),


                Container(
                  width: (MediaQuery.of(context).size.width*0.75)*0.3,           
                  child: Row(

                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [


                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Image.network("http://themesbazar.net/educational/wp-content/themes/educationaltheme/images/menu02.jpg",
                        
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        ),
                      ),


                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            children: [
                          
                              Icon(Icons.check,),
                          
                              InkWell(
                                onTap: () {
                                  print("Done");
                                },
                                hoverColor: Colors.grey.shade300,
                                child: Text("শিক্ষকবৃন্দ")),
                          
                            ],
                          ),


                      
                      SizedBox(height: 3,),


                       Row(
                            children: [
                          
                              Icon(Icons.check),
                          
                              InkWell(
                                onTap: () {
                                  print("Done");
                                },
                                hoverColor: Colors.grey.shade300,
                                child: Text("শূণ্যপদের তালিকা")),
                          
                            ],
                          ),

                      

                      SizedBox(height: 3,),


                       Row(
                            children: [
                          
                              Icon(Icons.check),
                          
                              InkWell(
                                onTap: () {
                                  print("Done");
                                },
                                hoverColor: Colors.grey.shade300,
                                child: Text("প্রাক্তন প্রধান শিক্ষক")),
                          
                            ],
                          ),


                          SizedBox(height: 3,),

                         Row(
                            children: [
                          
                              Icon(Icons.check),
                          
                              InkWell(
                                onTap: () {
                                  print("Done");
                                },
                                hoverColor: Colors.grey.shade300,
                                child: Text("কর্মকর্তা কর্মচারী")),
                          
                            ],
                          ),


                          SizedBox(height: 3,),

                          Row(
                            children: [
                          
                              Icon(Icons.check),
                          
                              InkWell(
                                onTap: () {
                                  print("Done");
                                },
                                hoverColor: Colors.grey.shade300,
                                child: Text("পরিচালনা পরিষদ")),
                          
                            ],
                          ),









                        ],
                      )





                    
                    




                    ],

                    
                  ),
                          
                          
                    ),

           
                          ],

                    
                        ),







              ],
            ),
           
           
                  ),






            


            
        SizedBox(height: 29,),






          // ছাত্র ও শিক্ষক তথ্য start
           Container(
           
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [


                // ডাউনলোড তথ্য

                Column(
           
                children: [
           
                 Container(
                  width: (MediaQuery.of(context).size.width*0.75)*0.3,
                          
                          
                  height: 35,
                          
                  color: ColorName().appColor,
                          
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("ডাউনলোড",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
                  ),
                          
                          
                    ),


                Container(
                  width: (MediaQuery.of(context).size.width*0.75)*0.3,           
                  child: Row(

                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [


                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Image.network("http://themesbazar.net/educational/wp-content/themes/educationaltheme/images/menu03.jpg",
                        
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        ),
                      ),


                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            children: [
                          
                              Icon(Icons.check,),
                          
                              InkWell(
                                onTap: () {
                                  print("Done");
                                },
                                hoverColor: Colors.grey.shade300,
                                child: Text("বিভিন্ন রুটিন ডাউনলোড")),
                          
                            ],
                          ),


                      
                      SizedBox(height: 3,),


                       Row(
                            children: [
                          
                              Icon(Icons.check),
                          
                              InkWell(
                                onTap: () {
                                  print("Done");
                                },
                                hoverColor: Colors.grey.shade300,
                                child: Text("ছুটির নোটিশ ডাউনলোড")),
                          
                            ],
                          ),

                      

                      SizedBox(height: 3,),


                       Row(
                            children: [
                          
                              Icon(Icons.check),
                          
                              InkWell(
                                onTap: () {
                                  print("Done");
                                },
                                hoverColor: Colors.grey.shade300,
                                child: Text("ভর্তি ফরম ডাউনলোড")),
                          
                            ],
                          ),


                          SizedBox(height: 3,),

                         Row(
                            children: [
                          
                              Icon(Icons.check),
                          
                              InkWell(
                                onTap: () {
                                  print("Done");
                                },
                                hoverColor: Colors.grey.shade300,
                                child: Text("বিভিন্ন ফলাফল ডাউনলোড")),
                          
                            ],
                          ),


                          SizedBox(height: 3,),


                        ],
                      )


                    ],

                    
                  ),
                          
                          
                    ),

           
                          ],

                    
                        ),



          


            
          // একাডেমীক তথ্য

                Column(
           
                children: [
           
                 Container(
                  width: (MediaQuery.of(context).size.width*0.75)*0.3,
                          
                          
                  height: 35,
                          
                  color: ColorName().appColor,
                          
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("একাডেমিক তথ্য",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
                  ),
                          
                          
                    ),


                Container(
                  width: (MediaQuery.of(context).size.width*0.75)*0.3,           
                  child: Row(

                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [


                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Image.network("http://themesbazar.net/educational/wp-content/themes/educationaltheme/images/menu04.jpg",
                        
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        ),
                      ),


                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            children: [
                          
                              Icon(Icons.check,),
                          
                              InkWell(
                                onTap: () {
                                  print("Done");
                                },
                                hoverColor: Colors.grey.shade300,
                                child: Text("কক্ষ সংখ্যা")),
                          
                            ],
                          ),


                      
                      SizedBox(height: 3,),


                       Row(
                            children: [
                          
                              Icon(Icons.check),
                          
                              InkWell(
                                onTap: () {
                                  print("Done");
                                },
                                hoverColor: Colors.grey.shade300,
                                child: Text("ছাত্রছাত্রীর আসন সংখ্যা")),
                          
                            ],
                          ),

                      

                      SizedBox(height: 3,),


                       Row(
                            children: [
                          
                              Icon(Icons.check),
                          
                              InkWell(
                                onTap: () {
                                  print("Done");
                                },
                                hoverColor: Colors.grey.shade300,
                                child: Text("ছুটির তালিকা")),
                          
                            ],
                          ),


                          SizedBox(height: 3,),

                         Row(
                            children: [
                          
                              Icon(Icons.check),
                          
                              InkWell(
                                onTap: () {
                                  print("Done");
                                },
                                hoverColor: Colors.grey.shade300,
                                child: Text("মাল্টিমিডিয়া ক্লাসরুম")),
                          
                            ],
                          ),


                          SizedBox(height: 3,),

                          Row(
                            children: [
                          
                              Icon(Icons.check),
                          
                              InkWell(
                                onTap: () {
                                  print("Done");
                                },
                                hoverColor: Colors.grey.shade300,
                                child: Text("ভিডিও ক্লাস")),
                          
                            ],
                          ),




                        ],
                      )



                    ],

                    
                  ),
                          
                          
                    ),

           
                          ],

                    
                        ),







              ],
            ),
           
           
                  ),
     










                ],
              ),
            ),




          // right

             Container(
              width: (MediaQuery.of(context).size.width*0.75)*0.25,
              child: Column(
                children: [


                  
                 Container(
                  width: (MediaQuery.of(context).size.width*0.75)*0.3,
                          
                          
                  height: 35,
                          
                  color: ColorName().appColor,
                          
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("একাডেমিক তথ্য",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
                  ),
                          
                          
                    ),


                SizedBox(height:
                29),



                    
                 Container(
                  width: (MediaQuery.of(context).size.width*0.75)*0.3,
                          
                          
                  height: 35,
                          
                  color: ColorName().appColor,
                          
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("একাডেমিক তথ্য",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
                  ),
                          
                          
                    ),


                  
                  
                SizedBox(height:
                29),



                    
                 Container(
                  width: (MediaQuery.of(context).size.width*0.75)*0.3,
                          
                          
                  height: 35,
                          
                  color: ColorName().appColor,
                          
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("একাডেমিক তথ্য",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
                  ),
                          
                          
                    ),


                  
                  
                SizedBox(height:
                29),



                    
                 Container(
                  width: (MediaQuery.of(context).size.width*0.75)*0.3,
                          
                          
                  height: 35,
                          
                  color: ColorName().appColor,
                          
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("একাডেমিক তথ্য",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
                  ),
                          
                          
                    ),



                  
                SizedBox(height:
                29),



                    
                 Container(
                  width: (MediaQuery.of(context).size.width*0.75)*0.3,
                          
                          
                  height: 35,
                          
                  color: ColorName().appColor,
                          
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("একাডেমিক তথ্য",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
                  ),
                          
                          
                    ),


                  


          SizedBox(height: 10,),
          // Notice Marquee start

        Container(

        width: (MediaQuery.of(context).size.width*0.75)*0.25,

        child: Column(

          children: [

            Container(
              width: (MediaQuery.of(context).size.width*0.75)*0.25,


              height: 45,

              color: ColorName().appColor,

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("নোটিশ",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
              ),


            ),


            for(int i =0; i<7; i++)

                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                              width: (MediaQuery.of(context).size.width*0.75)*0.75,
                              height: 45,
                             
                              child: Padding(
                  padding: const EdgeInsets.only(top: 11),
                  child: Marquee(
                          
                          text: 'আজকে থেকে আমরা নতুন Website Upload করবো। দয়া করে সবাই Visit করুন। ধন্যবাদ ',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                          scrollAxis: Axis.horizontal,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          blankSpace: 20.0,
                          velocity: 100.0,
                          pauseAfterRound: Duration(seconds: 1),
                          startPadding: 10.0,
                          accelerationDuration: Duration(seconds: 1),
                          accelerationCurve: Curves.linear,
                          decelerationDuration: Duration(milliseconds: 500),
                          decelerationCurve: Curves.easeOut,
                        ),
                              ),
                
                            ),
                ),
          

          





                      ],
                    ),


                    ),




        // Notice Marquee end



        SizedBox(height:
        20),




        // একাডেমীক তথ্য

                Column(
           
                children: [
           
                 Container(
                  width: (MediaQuery.of(context).size.width*0.75)*0.3,
                          
                          
                  height: 35,
                          
                  color: ColorName().appColor,
                          
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("অফিসিয়াল লিংক",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
                  ),
                          
                          
                    ),


                Container(
                  width: (MediaQuery.of(context).size.width*0.75)*0.3,           
                  child: Row(

                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [


                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Image.network("http://themesbazar.net/educational/wp-content/themes/educationaltheme/images/menu04.jpg",
                        
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                        ),
                      ),


                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            children: [
                          
                              Icon(Icons.check,),
                          
                              InkWell(
                                onTap: () {
                                 js.context.callMethod('open', ['https://moedu.gov.bd/']);
                                },
                                hoverColor: Colors.grey.shade300,
                                child: Text("শিক্ষা মন্ত্রণালয়", style: TextStyle(fontSize: 12))),
                          
                            ],
                          ),


                      
                      SizedBox(height: 3,),



                      
                          Row(
                            children: [
                          
                              Icon(Icons.check,),
                          
                              InkWell(
                                onTap: () {
                                 js.context.callMethod('open', ['https://teachers.gov.bd/']);
                                },
                                hoverColor: Colors.grey.shade300,
                                child: Text("শিক্ষক বাতায়ন", style: TextStyle(fontSize: 12))),
                          
                            ],
                          ),


                      
                      SizedBox(height: 3,),



                        Row(
                            children: [
                          
                              Icon(Icons.check,),
                          
                              InkWell(
                                onTap: () {
                                 js.context.callMethod('open', ['https://bangladesh.gov.bd/index.php']);
                                },
                                hoverColor: Colors.grey.shade300,
                                child: Text("বাংলাদেশ জাতীয় তথ্য বাতায়ন", style: TextStyle(fontSize: 10, overflow: TextOverflow.ellipsis))),
                          
                            ],
                          ),


                      
                      SizedBox(height: 3,),



                      


                       Row(
                            children: [
                          
                              Icon(Icons.check),
                          
                              InkWell(
                                onTap: () {
                                     js.context.callMethod('open', ['http://www.educationboardresults.gov.bd/']);
                                },
                                hoverColor: Colors.grey.shade300,
                                child: Text("এসএসসি ফলাফল", style: TextStyle(fontSize: 12),)),
                          
                            ],
                          ),

                      

                      SizedBox(height: 3,),


                       Row(
                            children: [
                          
                              Icon(Icons.check),
                          
                              InkWell(
                                onTap: () {
                                    js.context.callMethod('open', ['https://banbeis.gov.bd/new/']);
                                },
                                hoverColor: Colors.grey.shade300,
                                child: Text("ব্যানবেইস", style: TextStyle(fontSize: 12))),
                          
                            ],
                          ),


                          SizedBox(height: 3,),

                         Row(
                            children: [
                          
                              Icon(Icons.check),
                          
                              InkWell(
                                onTap: () {
                                 js.context.callMethod('open', ['https://rajshahieducationboard.gov.bd/']);
                                },
                                hoverColor: Colors.grey.shade300,
                                child: Text("রাজশাহী শিক্ষাবোর্ড", style: TextStyle(fontSize: 12))),
                          
                            ],
                          ),


                          SizedBox(height: 3,),

                          Row(
                            children: [
                          
                              Icon(Icons.check),
                          
                              InkWell(
                                onTap: () {
                              js.context.callMethod('open', ['http://emis.gov.bd/emis']);

                                 
                                },
                                hoverColor: Colors.grey.shade300,
                                child: Text("EMIS", style: TextStyle(fontSize: 12))),
                          
                            ],
                          ),



                                 SizedBox(height: 3,),

                          Row(
                            children: [
                          
                              Icon(Icons.check),
                          
                              InkWell(
                                onTap: () {
                              js.context.callMethod('open', ['https://accounts.noipunno.gov.bd/login']);

                                 
                                },
                                hoverColor: Colors.grey.shade300,
                                child: Text("নৈপুণ্য", style: TextStyle(fontSize: 12))),
                          
                            ],
                          ),



                                SizedBox(height: 3,),

                          Row(
                            children: [
                          
                              Icon(Icons.check),
                          
                              InkWell(
                                onTap: () {
                              js.context.callMethod('open', ['http://www.joypurhat.gov.bd/']);

                                 
                                },
                                hoverColor: Colors.grey.shade300,
                                child: Text("জেলা প্রশাসন", style: TextStyle(fontSize: 12))),
                          
                            ],
                          ),


                          


                             SizedBox(height: 3,),

                          Row(
                            children: [
                          
                              Icon(Icons.check),
                          
                              InkWell(
                                onTap: () {
                              js.context.callMethod('open', ['http://deo.joypurhatsadar.joypurhat.gov.bd/']);

                                 
                                },
                                hoverColor: Colors.grey.shade300,
                                child: Text("উপজেলা শিক্ষা অফিস", style: TextStyle(fontSize: 12))),
                          
                            ],
                          ),





                        ],
                      )



                    ],

                    
                  ),
                          
                          
                    ),

           
                          ],

                    
                        ),









                ],
              ),
            ),




          ],






        ),



      ),






















        Text("${width}")







            






                      





      
      
          ],
      
      
      
      
      
      
        ),
      )));

  }
}