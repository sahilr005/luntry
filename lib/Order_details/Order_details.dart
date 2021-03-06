import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luntry/main.dart';

class Oreder_Details extends StatefulWidget {
  @override
  _Oreder_DetailsState createState() => _Oreder_DetailsState();
}

class _Oreder_DetailsState extends State<Oreder_Details> {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance
        .collection('Orders')
        .doc(userinifomain.email)
        .collection(userinifomain.email);
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            height: 300,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                      "https://www.google.com/maps/uv?pb=!1s0x390cef31a312a66b:0x857e77e5c262b295!3m1!7e115!4shttps://lh5.googleusercontent.com/p/AF1QipNfofrd4jxTDCLmrQrbR3IA01LWGZ7Quo2D6hQL%3Dw113-h160-k-no!5slaundrywala+-+Google+Search!15zQ2dJZ0FRPT0&imagekey=!1e10!2sAF1QipNfofrd4jxTDCLmrQrbR3IA01LWGZ7Quo2D6hQL&hl=en&sa=X&ved=2ahUKEwi2vdW0wtLuAhX2xTgGHetWBWgQoiowC3oECBUQAw#",
                    ),
                    fit: BoxFit.fill)),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: MediaQuery.of(context).size.height * .8,
              child: StreamBuilder<QuerySnapshot>(
                stream: users.snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }
                  if (!snapshot.hasData) {
                    return Text("No Order's");
                  }
                  return new ListView(
                    children:
                        snapshot.data.docs.map((DocumentSnapshot document) {
                      return ListView(
                        shrinkWrap: true,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                "Order Details",
                                style: GoogleFonts.abel(
                                    fontSize: 19, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Card(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 5),
                                child: Text(
                                  "Pick Up Date :" +
                                      document.data()['pickup_date'],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 5),
                                child: Text('Total Items : ' +
                                    document.data()['total_item'].toString()),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 5),
                                child: Text('Total Amount : ' +
                                    document.data()['total_amout'].toString()),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 5),
                                child: Text('Address: ' +
                                    document.data()['house_no'].toString() +
                                    ' ' +
                                    document.data()['socity'].toString() +
                                    ', ' +
                                    document.data()['area'].toString() +
                                    ', ' +
                                    document.data()['city'].toString()),
                              ),
                            ],
                          )),
                        ],
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
