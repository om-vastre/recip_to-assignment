import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recip.to App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Recip.to Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isOfferSelected = true;
  bool _showOfferImage = true;
  int _selectRowItem = 0;

  static const String API = "https://recip.to";
  List<Widget> offerCardsWidget = [];

  @override
  void initState() {
    super.initState();
    fetchOffers();
  }

  Future<void> fetchOffers() async {
    final resp = await http.post(
      Uri.parse("${API}/offers"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "token" : "xxxx"
      }),
    );

    // if(resp.statusCode == 200){
    //   final json_resp = jsonDecode(resp.body);
    //   final data = json_resp['data'];
    //   final List<dynamic> offers_data = data['data'];
    //
    //   List<Widget> temp = offers_data.map((item){
    //     final store = item['store']['_id'];
    //     final title = item['brandproduct']['name'];
    //     final coins = item['brandproduct']['customer_cashback'];
    //
    //     return offerCardsWidget(store, title, coins);
    //   }).toList();
    //
    //   setState(() {
    //     offerCardsWidget = temp;
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Main Logo & Title
            SizedBox(height: 10,),
            ClipOval(child: Image.asset('images/recipto_logo.jpg', width: 100, height: 100,)),
            SizedBox(height: 10,),
            Text("Recip.to", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),),
            SizedBox(height: 5,),

            // Main Section 2: Offer, Coupons & Filter Btns
            Container(width: double.infinity, height: 75,
              child: Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: 50,),

                  // Slider Button Row: Offers & My Coupons Btn
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    color: Colors.white,
                    elevation: 2,
                    child: Row(
                      children: [

                        // Offers Btn
                        GestureDetector(
                          onTap:(){setState(() { _isOfferSelected = !_isOfferSelected;});},
                          child: Container(
                            width: 120, height: 40,
                            decoration: BoxDecoration(
                              color: _isOfferSelected ? Color(0xFF3F1EA4): Colors.white,
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: Row( mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                              Text("Offers ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: _isOfferSelected ? Colors.white : Colors.black),),
                              Image.asset('images/reward_stars.png', width: 25, height: 25, ),
                            ],),
                          ),
                        ),

                        // My Coupons Btn
                        GestureDetector(
                          onTap:(){setState(() {_isOfferSelected = !_isOfferSelected;});},
                          child: Container(
                            width: 120, height: 40,
                            decoration: BoxDecoration(
                                color: _isOfferSelected ? Colors.white : Color(0xFF3F1EA4),
                                borderRadius: BorderRadius.circular(20)
                            ),
                            // padding: EdgeInsets.fromLTRB(5, 10, 20, 10),
                            child: Center(child: Text("My Coupons", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400,  color: _isOfferSelected ? Colors.black :  Colors.white))),
                          ),
                        ),
                      ],),
                  ),

                  // Filter Button
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    color: Colors.white,
                    elevation: 2,
                    child: IconButton(
                      onPressed: (){},
                      icon: Icon(Icons.tune),
                      iconSize: 25,
                      padding: EdgeInsets.all(0),
                    ),
                  )
                ],
              ),
            ),

            // Main Section 3: Tax Services Offers
            Container( margin: EdgeInsets.all(10),
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Container(
                  margin: EdgeInsets.all(15),
                  width: double.infinity,
                  // decoration: BoxDecoration( color: Color(0xFF3F1EA4), borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      // Image : Tax Offer
                      _showOfferImage ? ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset('images/taxservices.webp', fit: BoxFit.cover,),
                      ) : SizedBox(width: 0,),

                      // Offer Title & Shrink-Expand Btn
                      Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Offer Title
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10,),
                              Text("Tax Services Offers", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                              SizedBox(height: 2,),
                              Text("14 Offers", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF777777)),),
                          ],),

                          // Shrink-Expand Btn
                          IconButton(
                            onPressed: (){setState(() {_showOfferImage = !_showOfferImage;});},
                            icon: Icon(_showOfferImage ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, weight: 400, grade: 0, opticalSize: 24,),
                            iconSize: 30,
                            padding: EdgeInsets.all(0),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Main Section 4: Horizontal Slider
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10 ),
              height: 70,
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    sliderBtns('images/stars.png', "All", 0),
                    SizedBox(width: 5,),
                    sliderBtns('images/person.png', "For Salaried Professionals", 1),
                    SizedBox(width: 5,),
                    sliderBtns('images/business.png', "For Business Professionals", 2),
                  ],
                ),
              ),
            ),

            // Main Section 5: Offers Section
            // ListView(children: offerCardsWidget,),
            Column(
              children: [
                offerCard("Recip.to", "Salaried? Get FREE Tax Help +40% OFF On Tax Services", 900),
                offerCard("Recip.to", "Salaried? Get FREE Tax Help +40% OFF On Tax Services", 900),
              ],
            ),
          ],
        ),
      ),

    );
  }

  Widget sliderBtns(String imagePath, String title, int index){
    return
      ElevatedButton(
        onPressed: (){setState(() {
          _selectRowItem = index;
        });},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          side: BorderSide(color: _selectRowItem == index ? Color(0xFF603BE8) : Color(0xFFE4E6E9), width: 2),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(imagePath, width: 20, height: 20,),
            SizedBox(width: 5,),
            Text(title),
          ],
        ),
      );
  }

  Widget offerCard(String title, String name, int coins){
    return Container( margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          margin: EdgeInsets.all(15),
          width: double.infinity,
          // decoration: BoxDecoration( color: Color(0xFF3F1EA4), borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              // Image, Name & Info Button
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset('images/recipto_logo.jpg', width: 60, height:60, fit: BoxFit.cover,),
                  ),
                  SizedBox(width: 10,),
                  Expanded(child: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFF777777)))),
                  IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.info_outline, color: Color(0xFF939393),),
                    iconSize: 30,
                    padding: EdgeInsets.all(0),
                  ),
                ],
              ),
              SizedBox(height: 10,),

              Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      side: BorderSide(color: Color(0xFFE7E8EC), width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      )
                    ),
                    onPressed: (){},
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Text("Earn ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
                          Image.asset('images/coin.png', width: 24, height: 24,),
                          Text("  ${(coins*10)} Coins", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
                        ],
                      ),
                    )
                  ),
                  
                  FilledButton(
                    onPressed: (){},
                    style: FilledButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      backgroundColor: Color(0xFF754CF2),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Container(margin: EdgeInsets.all(10), child: Text("VIEW", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),))
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}
