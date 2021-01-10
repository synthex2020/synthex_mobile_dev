import 'package:flutter/material.dart';
import 'package:synthex_mobile_dev/cloudFirestore.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Synthex mobile dev" , style: TextStyle(color: Colors.black),),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //streams
          Row(
            children: [
              Expanded(child: Card(child: IconButton(icon: Icon(Icons.stream), onPressed: () {
                //go to the stream page
              }),)),
              Expanded(child: Card(child: IconButton(icon: Icon(Icons.cloud_upload_outlined), onPressed: () {
                //go to the cloud fire store page
                Navigator.push(context, MaterialPageRoute(builder: (context) => CloudFireStore()));
              }),))
            ],
          ),
        ],
      ),
    );
  }
}

