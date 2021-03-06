import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class Rate extends StatefulWidget {
  @override
  _RateState createState() => _RateState();
}

class _RateState extends State<Rate> {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('items');

    return Scaffold(
      appBar: AppBar(title: Text('Rate')),
      body: SingleChildScrollView(
        child: Container(
          height: 900,
          child: StreamBuilder(
            stream: users.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('error');
              }
              if (!snapshot.hasData) {
                return Text('No Data');
              }
              if (snapshot.hasData)
                return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot snap = snapshot.data.docs[index];
                    return ListTile(
                      title: Text(
                        snap.data()['name'],
                        style: TextStyle(color: Colors.black),
                      ),
                      trailing: Text(
                        "Rs." + snap.data()['price'].toString(),
                      ),
                    );
                  },
                );
            },
          ),
        ),
      ),
    );
  }
}
