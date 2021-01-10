import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class CloudFireStore extends StatelessWidget {

  getData() async {
    //As per firebase doc we must initialize the firebase app first before us
    Firebase.initializeApp();
    //by using the .snapshot() we utilize it for streams, using .get() means ee cannot use it with a stream due to the difference in variable types
    //to access a specific document, after collection call doc([doc string])
    return await FirebaseFirestore.instance.collection('farms').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    List list = [];
    String city  , description , logo , name , owner,email ,produce,
        phone,province,street,streetNumber;
    return Scaffold(
      appBar: AppBar(
        title: Text("Reading from firestore" , style: TextStyle(color: Colors.black),),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: getData(),
        builder: (context , snapshot) {
          //we need to make sure the connection to the backedn has been established before doing anything else
          //remember the spped of the language does not corolate to the internet speed so this makes sure we keep them in "sync"

          if (snapshot.connectionState == ConnectionState.done){
            //for the stream calling snapshot data gives us the required stream.
            return StreamBuilder(
                builder: (context , snapshot) {
                  //remember we need to make sure the data is present before we proces or render,
                  //which is why streams are so uselful as they allow changes to be rendered in almost real time
                  if(snapshot.hasData){
                    QuerySnapshot querySnapshot = snapshot.data;
                    List<QueryDocumentSnapshot> documents = querySnapshot.docs;
                    documents.forEach((element) {
                      element.data().forEach((key, value) {
                        if(key == 'city'){
                          city = value;
                        }else if(key == 'description'){
                          description = value;
                        }else if(key == 'email'){
                          email = value;
                        }else if(key == 'logo'){
                          logo = value;
                        }else if(key == 'name'){
                          name = value;
                        }else if(key == 'owner'){
                          owner = value;
                        }else if (key == 'phone'){
                          phone = value.toString();
                        }else if(key == 'produce'){
                          produce = value;
                        }else if (key == 'province'){
                          province = value;
                        }else if (key == 'street'){
                          street = value;
                        }else{
                          streetNumber = value;
                          //to get the id of the document, the current one being read call element.id
                        }
                      });
                      //this is where you would add elements to to your list
                      list.add(Info(city: city, description: description, logo: logo,
                        name: name, owner: owner, email: email
                      ));
                    });
                    return ListView.builder(
                        itemBuilder: (context , index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // the notation below can be used to convert non strings into strings ${somefunction}
                              Text("name: ${list[index].name}"),
                              Text("city: ${list[index].city}"),
                              Text("owner: ${list[index].owner}"),
                              Text("description: ${list[index].description}"),


                            ],
                          );
                        },
                        itemCount: list.length,
                    );
                  }else {
                    return Center(child: Text("No data present"),);
                  }
                },
              stream: FirebaseFirestore.instance.collection('farms').snapshots(),
            );
          }else{
            return Center(child: Text("Connection not established"),);
          }//end if else
        },
      ),
    );
  }
}

class Info {
  String city  , description , logo , name , owner,email ,produce,
      phone,province,street,streetNumber;
  Info({this.city, this.description, this.email, this.logo, this.name , this.owner , this.phone, this.produce, this.province,
    this.street, this.streetNumber
  });
}
