import 'package:flutter/material.dart';
import 'package:luntry/main.dart';

class Wallet extends StatefulWidget {
  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('Wallet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Text(
              "Account Info",
              style: TextStyle(color: Colors.blue),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Name",
              style: TextStyle(color: Colors.blueGrey),
            ),
            TextField(
              enabled: false,
              decoration: InputDecoration(labelText: userinifomain.name),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "email",
              style: TextStyle(color: Colors.blueGrey),
            ),
            TextField(
              enabled: false,
              decoration: InputDecoration(labelText: userinifomain.email),
            ),
          ],
        ),
      ),
    );
  }
}
