import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_shop/services/authentication.dart';

Future<void> addProductToCart(
  String product_id,
  String product_code,
  String product_name,
  String product_category,
  String product_image,
  String product_size,
  int product_price,
  int product_qty,
  int product_cost,
) async {
  CollectionReference carts = FirebaseFirestore.instance.collection("carts");
  var itemCart = {
    'product_id': product_id,
    'userId': userId,
    'product_code': product_code,
    'product_name': product_name,
    'product_category': product_category,
    'product_image': product_image,
    'product_size': product_size,
    'product_price': product_price,
    'product_qty': product_qty,
    'product_cost': product_cost,
  };

  String orderCollection = "Order " + levelOrder.toString();
  carts.doc(userId).collection(orderCollection).doc(product_id).set(itemCart);

  carts.doc(userId).set({
    "userId": userId,
    "userName": name,
    "userEmail": email,
  });
}

Future<void> deleteItemCart(String product_id) async {
  CollectionReference carts = FirebaseFirestore.instance.collection("carts");
  String orderCollection = "Order " + levelOrder.toString();

  //menghapus data produk
  carts.doc(userId).collection(orderCollection).doc(product_id).delete();
  print("item deleted");
}

Future<void> updateItemCart(
    String product_id, int product_qty, int product_price) {
  CollectionReference carts = FirebaseFirestore.instance.collection("carts");
  String orderCollection = "Order " + levelOrder.toString();
  int product_cost = product_qty * product_price;
  var updateData = {
    'product_qty': product_qty,
    'product_cost': product_cost,
  };
  carts
      .doc(userId)
      .collection(orderCollection)
      .doc(product_id)
      .update(updateData);
}

Future<void> checkoutOrder(String name, String address, String phone,
    int totalOrder, String orderDateTime, String collectionRef, String status) {
  CollectionReference orders = FirebaseFirestore.instance.collection("orders");

  var orderData = {
    'userEmail': email,
    'userId': userId,
    'name': name,
    'address': address,
    'phone': phone,
    'totalOrder': totalOrder,
    'orderDateTime': orderDateTime,
    'collectionRef': collectionRef,
    'status': status
  };
  orders.add(orderData);

  //update levelOrder User
  int level = levelOrder + 1;
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  var updateLevel = {'levelOrder': level};
  users.doc(userId).update(updateLevel);
}

Future<void> getUserLevel() async {
  QuerySnapshot userSnapShot = await FirebaseFirestore.instance
      .collection("users")
      .where("userId", isEqualTo: userId)
      .get();
  //melakukan penyeleksian data user dari collection "users" dengan melakukan perulangan
  userSnapShot.docs.forEach(
    (data) {
      levelOrder = data["levelOrder"];
    },
  );
}
