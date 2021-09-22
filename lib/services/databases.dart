import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_shop/services/authentication.dart';

Future<void> addProductToCart(
    String productId,
    String productName,
    String productCategory,
    String productImg,
    String productSize,
    int productPrice,
    int productQty,
    int productCost) async {
  CollectionReference carts = FirebaseFirestore.instance.collection("carts");
  var itemCart = {
    'productId': productId,
    'userId': userId,
    'productName': productName,
    'productCategory': productCategory,
    'productPrice': productPrice,
    'productImg': productImg,
    'productSize': productSize,
    'productQty': productQty,
    'productCost': productCost,
  };

  String orderCollection = "Order " + levelOrder.toString();
  carts.doc(userId).collection(orderCollection).doc(productId).set(itemCart);

  carts.doc(userId).set({
    "userId": userId,
    "userName": name,
    "userEmail": email,
  });
}

Future<void> deleteItemCart(String productId) async {
  CollectionReference carts = FirebaseFirestore.instance.collection("carts");
  String orderCollection = "Order " + levelOrder.toString();

  //menghapus data produk
  carts.doc(userId).collection(orderCollection).doc(productId).delete();
  print("item deleted");
}

Future<void> updateItemCart(
    String productId, int productQty, int productPrice) {
  CollectionReference carts = FirebaseFirestore.instance.collection("carts");
  String orderCollection = "Order " + levelOrder.toString();
  int productCost = productQty * productPrice;
  var updateData = {
    'productQty': productQty,
    'productCost': productCost,
  };
  carts
      .doc(userId)
      .collection(orderCollection)
      .doc(productId)
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
