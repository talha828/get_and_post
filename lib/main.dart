import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner:false,
      home: MyPage(),
    );
  }
}

class MyPage extends StatefulWidget {

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  var temp;
  var humidity;
  var wind;
  var max;
  var cloude;
   String data='';
void Post()async {
  var response = await http.post(Uri.parse('https://jsonplaceholder.typicode.com/posts'),body: {
    "name": "London",
    "tempereture":"49",
    "Humidity":"30%",
    "Wind":"59%",});
    print(response.body);

}
void fetch()async{
   var apiKey = '7be156f187bf9c482b57653593931c5e';
     var  url="https://api.openweathermap.org/data/2.5/weather?q=London&appid=$apiKey&units=metric";

  var response =await http.get(Uri.parse(url));
  print(response.body);
 data = response.body;
 dataa(data);
}
 void dataa(String data){
    setState(() {
      humidity = jsonDecode(data)['main']['humidity'];
      temp = jsonDecode(data)['main']['temp'];
      cloude= jsonDecode(data)['weather'][0]['main'];
      wind = jsonDecode(data)['wind']['speed'];
      max = jsonDecode(data)['main']['feels_like'];
    });
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    Post();
    fetch();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:Colors.white,
        body: Stack(
          children: [
            Container(child: Image.asset("assets/cloud.jpg",fit:BoxFit.cover,height: MediaQuery.of(context).size.height,)),
            Container(
              width:MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.black45,
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20,top: 40),
                    child: Text("London",style: TextStyle(color: Colors.white,fontSize: 80,fontWeight:FontWeight.bold,)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20,top: 100),
                    child: Text(temp.toString(),style: TextStyle(color: Colors.white,fontSize: 120,fontWeight:FontWeight.w500,)),
                  ),
                  Row(children: [
                    SizedBox(width: 20,),
                    Icon(Icons.cloud,color: Colors.white,size: 60,),
                    SizedBox(width: 10,),
                    Text(cloude.toString(),style: TextStyle(fontSize: 30,color: Colors.white),)
                  ],),

                Row(
                  mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                  children: [
                     design(num: humidity.toString().substring(0,2),text: "Humidity",),
                     design(num: wind.toString(),text: "Wind",),
                     design(num:max.toString(),text: "temperature",),
                ],)

                ],),)
          ],
        )
    ));
  }
}

class design extends StatelessWidget {
  design({this.num,this.text});
  final text;
  final num;

  @override
  Widget build(BuildContext context) {
    return Container(child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children:[
        Text(text,style:TextStyle(color: Colors.white,fontSize: 20)),
        SizedBox(height:10,),
      Text(num,style:TextStyle(color: Colors.white,fontSize: 25))
      ]),
    ));
  }
}