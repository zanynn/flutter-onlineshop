import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_shop/pages/old-home.dart';
import 'package:online_shop/pages/order/order.dart';
import 'package:online_shop/services/authentication.dart';
import 'package:online_shop/services/databases.dart';
import 'package:online_shop/widgets/old-cart_item.dart';
import 'package:intl/intl.dart';

import 'home/home_screen.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

FirebaseFirestore firestore = FirebaseFirestore.instance;

class _CartState extends State<Cart> {
  String orderCollection = "Order " + levelOrder.toString();
  CollectionReference carts = firestore
      .collection("carts")
      .doc(userId)
      .collection("Order " + levelOrder.toString());

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();

  int totalOrder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Cart", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => HomeScreen(),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.5),
            blurRadius: 7,
          )
        ]),
        child: Row(
          children: [
            Expanded(
              child: ListTile(
                title: Text("Total: "),
                subtitle: Container(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: carts.snapshots(),
                    builder: (context, snapshot) {
                      int total = 0;
                      if (snapshot.hasData) {
                        //menghitung total biaya
                        snapshot.data.docs
                            .map((e) => total += e["productCost"])
                            .toList();
                        totalOrder = total;
                        return Container(
                          child: Text(
                            total.toString() + " IDR",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 18),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 50,
                child: MaterialButton(
                  child: Text(
                    "Checkout",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Color(0xFF1C1C1C),
                  onPressed: () {
                    showCheckoutForm();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: ListView(
                children: [
                  Container(
                    child: StreamBuilder<QuerySnapshot>(
                      //memanggil collection data produk berdasarkan field kategori yang bernilai nama kategori yang diterima
                      stream: carts.snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            children: snapshot.data.docs
                                .map((item) => CartItem(
                                      item['productImg'],
                                      item['productName'],
                                      item['productCategory'],
                                      item['productPrice'],
                                      item['productId'],
                                      item['productSize'],
                                      item['productQty'],
                                      item['productCost'],
                                    ))
                                .toList(),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget showCheckoutForm() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
      ),
      builder: (BuildContext bc) {
        return Padding(
          padding: EdgeInsets.only(left: 25, right: 25),
          child: Container(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: (MediaQuery.of(context).size.height * 0.4),
                ),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 250, top: 50),
                  child: new Column(
                    children: <Widget>[
                      Text(
                        "Checkout Form",
                        style: TextStyle(
                          fontSize: 20.00,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                        thickness: 2.5,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name: ",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              controller: nameController,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                prefixIcon: Icon(
                                  Icons.text_fields,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please input the name';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Address: ",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              controller: addressController,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                prefixIcon: Icon(
                                  Icons.home,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please input the address';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Phone / WhatsApp: ",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              controller: phoneController,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                prefixIcon: Icon(
                                  Icons.phone,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please input your phone';
                                } else if (value.length < 11 ||
                                    value.length > 13) {
                                  return 'Phone number must be 11 until 13 characters';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            //button Cancel
                            MaterialButton(
                              onPressed: () {
                                nameController.clear();
                                addressController.clear();
                                phoneController.clear();

                                Navigator.pop(context);
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              color: Color(0xFF1C1C1C),
                            ),

                            //button order
                            MaterialButton(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Order now !',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              color: Color(0xFF1C1C1C),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text("Are you sure to order ?"),
                                        actions: [
                                          //BUTTON "Yes"
                                          MaterialButton(
                                            child: Text("Yes"),
                                            onPressed: () {
                                              var now = new DateTime.now();
                                              var formatter =
                                                  new DateFormat('dd-MM-yyyy')
                                                      .add_Hms();
                                              String formattedDateNow =
                                                  formatter.format(now);
                                              String status = "Unverified";
                                              checkoutOrder(
                                                  nameController.text,
                                                  addressController.text,
                                                  phoneController.text,
                                                  totalOrder,
                                                  formattedDateNow,
                                                  orderCollection,
                                                  status);
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Order(
                                                                buyerName:
                                                                    nameController
                                                                        .text,
                                                                buyerAddress:
                                                                    addressController
                                                                        .text,
                                                                buyerPhone:
                                                                    phoneController
                                                                        .text,
                                                                buyerTime:
                                                                    formattedDateNow,
                                                                orderCollection:
                                                                    orderCollection,
                                                                totalOrder:
                                                                    totalOrder,
                                                                status: status,
                                                              )));
                                            },
                                            color: Color(0xFF1C1C1C),
                                          ),

                                          //BUTTON "Cancel"
                                          MaterialButton(
                                            child: Text("Cancel"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            color: Colors.red,
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
