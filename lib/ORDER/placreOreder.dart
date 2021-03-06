import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:luntry/Database/datafirebase.dart';
import 'package:luntry/ORDER/Formfill.dart';

class PlaceOrder extends StatefulWidget {
  @override
  _PlaceOrderState createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  int total_items = 0;
  int total = 0;
  List items = [];
  List items_price = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Place Order'),
        backgroundColor: Colors.blueGrey[600],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .76,
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('items').snapshots(),
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
                        trailing: Container(
                          height: 100,
                          width: 156,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (total == 0) {
                                      print("No Items");
                                    } else {
                                      setState(() {
                                        print('case 2');
                                        --total_items;
                                        total = total - (snap.data()['price']);
                                      });
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.cyan),
                                    child: Icon(Icons.remove),
                                  ),
                                ),
                                Text(
                                  "Rs." + snap.data()['price'].toString(),
                                ),
                                // snap.data()['ind'] == '1'
                                //     ? Text(shirt.toString())
                                //     : Text(pants.toString()),
                                InkWell(
                                  onTap: () {
                                    print('s');
                                    items.add(snap.data()['name']);
                                    items_price.add(snap.data()['price']);
                                    print(snap.data()['name']);
                                    setState(() {
                                      print('case 2');
                                      ++total_items;
                                      total = total + (snap.data()['price']);
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.cyan),
                                      child: Icon(Icons.add),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
              },
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width * .73,
              padding: EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(color: Colors.blueGrey),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "Total item's : " + total_items.toString(),
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * .43,
                    decoration: BoxDecoration(color: Colors.blueGrey),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Total : " + total.toString(),
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    )),
                InkWell(
                  onTap: () {
                    if (total > 350) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (a) => FormFill(
                                totalamount: total,
                                total_item: total_items,
                                items: items,
                                item_list_price: items_price,
                              )));
                    } else {
                      Fluttertoast.showToast(
                          msg: "Minimun order Rs. 350",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width * .43,
                      decoration: BoxDecoration(color: Colors.blueGrey),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Continue',
                          style: TextStyle(color: Colors.white, fontSize: 19),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
