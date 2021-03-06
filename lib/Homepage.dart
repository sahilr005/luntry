import 'package:flutter/material.dart';
import 'package:luntry/Order_details/Order_details.dart';
import 'package:luntry/Rate/rate.dart';
import 'package:luntry/main.dart';
import 'package:luntry/wallet/wallet.dart';
import 'ORDER/placreOreder.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey,
        title: Text('Laundrywala'),
        centerTitle: true,
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 10, top: 15),
              child: Text('Logout'))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ListView(
            shrinkWrap: true,
            children: [
              Container(
                height: 240,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            'https://www.getmyneed.com/images/institutes/515d2f4d582ccf07bec66e1b0058b6a6.jpg'))),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (a) => PlaceOrder())),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: Icon(
                            Icons.date_range_outlined,
                            size: 60,
                            color: Colors.blue[400],
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.only(top: 18),
                            height: 100,
                            child: Text(
                              "Place Order",
                              style: TextStyle(fontSize: 20),
                            )),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (a) => Oreder_Details())),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: Icon(
                            Icons.online_prediction_rounded,
                            size: 60,
                            color: Colors.blue[400],
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.only(top: 18),
                            height: 100,
                            child: Text(
                              "Order summery",
                              style: TextStyle(fontSize: 20),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.blue[400],
                indent: 10,
                endIndent: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (a) => Rate())),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Column(
                        children: [
                          Icon(
                            Icons.rate_review_outlined,
                            size: 60,
                            color: Colors.blue[400],
                          ),
                          Container(
                              padding: EdgeInsets.only(top: 18),
                              height: 100,
                              child: Text(
                                "Rate",
                                style: TextStyle(fontSize: 20),
                              )),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (a) => Wallet())),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Column(
                        children: [
                          Icon(
                            Icons.account_balance_wallet_outlined,
                            size: 60,
                            color: Colors.blue[400],
                          ),
                          Container(
                              padding: EdgeInsets.only(top: 18),
                              height: 100,
                              child: Text(
                                "Wallet",
                                style: TextStyle(fontSize: 20),
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  Container(
                    color: Colors.blueGrey,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'minimum Oredr Rs.350 ',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    )),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    color: Colors.blueGrey,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'CALL US: +91 9045624354',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    )),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
