import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:luntry/main.dart';

class Firedata {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  void sendData({
    pickup_date,
    type = "ragular",
    house_no,
    socity,
    area,
    landmark,
    city,
    item_list,
    item_list_price,
    total_amout,
    total_item,
    request = 'no request',
    pin,
  }) async {
    firestore
        .collection('Orders')
        .doc(userinifomain.email)
        .collection(userinifomain.email)
        .add({
      "pickup_date": pickup_date,
      "type": type,
      "house_no": house_no,
      "socity": socity,
      "area": area,
      "landmark": landmark,
      "city": city,
      "pin": pin,
      "item_list": item_list,
      "item_list_price": item_list_price,
      "total_amout": total_amout,
      "total_item": total_item,
      "request": request,
    });
  }
}
