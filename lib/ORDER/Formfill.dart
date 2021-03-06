import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:luntry/Database/datafirebase.dart';
import 'package:luntry/Homepage.dart';

class Item {
  const Item(this.name);
  final String name;
}

class FormFill extends StatefulWidget {
  final totalamount;
  final total_item;
  final items;
  final item_list_price;

  const FormFill(
      {Key key,
      this.totalamount,
      this.total_item,
      this.items,
      this.item_list_price})
      : super(key: key);
  @override
  _FormFillState createState() => _FormFillState();
}

class _FormFillState extends State<FormFill> {
  Item selectedUser;
  var type = "";
  Firedata firedata = Firedata();
  final _formKey = GlobalKey<FormState>();
  TextEditingController houseno = TextEditingController();
  TextEditingController socity = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController landmark = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController request = TextEditingController();

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    _selectDate(BuildContext context) async {
      final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate, // Refer step 1
        firstDate: DateTime(2000),
        lastDate: DateTime(2025),
      );
      if (picked != null && picked != selectedDate)
        setState(() {
          print('Date Change');
          selectedDate = picked;
        });
    }

    List<Item> users = <Item>[
      const Item('Regular'),
      const Item('Urgent'),
      const Item('Super Urgent'),
    ];
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                          child: ListView(
                        shrinkWrap: true,
                        children: [],
                      )),
                    ),
                    Text(
                      'Pick Up Date',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "${selectedDate.toLocal()}".split(' ')[0],
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        RaisedButton(
                          onPressed: () => _selectDate(context), // Refer step 3
                          child: Text(
                            'select date',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Divider(indent: 7, endIndent: 7, thickness: 2),
                    DropdownButton<Item>(
                      hint: Text("Select Type"),
                      value: selectedUser,
                      onChanged: (Item Value) {
                        setState(() {
                          selectedUser = Value;
                          type = Value.name.toString();
                        });
                      },
                      items: users.map((Item user) {
                        return DropdownMenuItem<Item>(
                          value: user,
                          child: Row(
                            children: <Widget>[
                              Text(
                                user.name,
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              TextFormField(
                                controller: houseno,
                                decoration:
                                    InputDecoration(labelText: "House Number"),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter House Number';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: socity,
                                decoration:
                                    InputDecoration(labelText: "Society"),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please Enter Society';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: area,
                                decoration: InputDecoration(labelText: "Area"),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please Enter Area';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: landmark,
                                decoration:
                                    InputDecoration(labelText: "Landmark"),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please Enter Landmark';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: city,
                                decoration: InputDecoration(labelText: "City"),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please Enter City';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: pincode,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "Pincode",
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please Enter Pincode';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: request,
                                decoration: InputDecoration(
                                  labelText: "Special Request",
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please Enter Special Request';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.all(15),
                        color: Colors.blueGrey,
                        width: MediaQuery.of(context).size.width * .4,
                        child: Center(
                          child: Text(
                            'Total Rs.' + widget.totalamount.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )),
                    InkWell(
                      onTap: () async {
                        if (_formKey.currentState.validate()) {
                          _showMyDialog();
                        }
                      },
                      child: Container(
                          margin: EdgeInsets.all(15),
                          padding: EdgeInsets.all(15),
                          color: Colors.blueGrey,
                          width: MediaQuery.of(context).size.width * .4,
                          child: Center(
                            child: Text(
                              'CONFORM',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Place Order'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to place order ?'),
                Text('Total Amount: Rs.' + widget.totalamount.toString()),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('CLOSE'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('CONFORM'),
              onPressed: () async {
                await firedata.sendData(
                  area: area.text,
                  city: city.text,
                  house_no: houseno.text,
                  landmark: landmark.text,
                  pickup_date: "${selectedDate.toLocal()}".split(' ')[0],
                  pin: pincode.text,
                  request: request.text,
                  socity: socity.text,
                  type: type,
                  total_amout: widget.totalamount,
                  total_item: widget.total_item,
                  item_list: widget.items,
                  item_list_price: widget.item_list_price,
                );
                Fluttertoast.showToast(
                    msg: "Order Conform",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0);
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (a) => HomePage()));
              },
            ),
          ],
        );
      },
    );
  }
}
