import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online_shop/pages/order/components/order_productItem.dart';
import 'package:online_shop/services/authentication.dart';
import 'package:online_shop/pages/order_history/order_list.dart';
import 'package:online_shop/widgets/default_button.dart';

import '../../size_config.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class Order extends StatelessWidget {
  final String buyerName;
  final String buyerAddress;
  final String buyerPhone;
  final String buyerTime;
  final String orderCollection;
  final int totalOrder;
  final String status;

  Order(
      {this.buyerName,
      this.buyerAddress,
      this.buyerPhone,
      this.buyerTime,
      this.orderCollection,
      this.totalOrder,
      this.status});

  @override
  Widget build(BuildContext context) {
    var formatNumber = NumberFormat("#,###");
    CollectionReference productsOrder =
        firestore.collection("carts").doc(userId).collection(orderCollection);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 20),
        child: ListView(
          children: <Widget>[
            _appbar(),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(.5), blurRadius: 15)
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Deliver To",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("#" + orderCollection),
                          Text(buyerTime),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(imageUrl),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  child: Text(
                                    "Name",
                                    style: TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: AutoSizeText(
                                    buyerName,
                                    textAlign: TextAlign.right,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Email",
                                    style: TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: AutoSizeText(
                                    email,
                                    textAlign: TextAlign.right,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Address",
                                    style: TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: AutoSizeText(
                                    buyerAddress,
                                    textAlign: TextAlign.right,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Phone",
                                    style: TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: AutoSizeText(
                                    buyerPhone,
                                    textAlign: TextAlign.right,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(.5), blurRadius: 15)
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Product Item",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: productsOrder.snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: snapshot.data.docs
                              .map((item) => OrderItem(
                                    item['product_image'],
                                    item['product_name'],
                                    item['product_category'],
                                    item['product_price'],
                                    item['product_size'],
                                    item['product_qty'],
                                    item['product_cost'],
                                  ))
                              .toList(),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(.5), blurRadius: 15)
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Order Total",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "IDR " + formatNumber.format(totalOrder).toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              decoration: BoxDecoration(
                color: Color(0xFF4A3298),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(.5), blurRadius: 15)
                ],
              ),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Order Status",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        status == "Unverified"
                            ? Text(
                                "Unverified",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.orangeAccent[400]),
                              )
                            : Text(
                                "Success",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.greenAccent[400]),
                              ),
                      ],
                    ),
                    status == "Unverified"
                        ? Text(
                            "Please contact the admin for verify your order.",
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.white),
                          )
                        : Text(
                            "Your order has been successful. Thank's for buying",
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.white),
                          ),
                    status == "Unverified"
                        ? Row(
                            children: [
                              Image.network(
                                  "http://assets.stickpng.com/images/5ae21cc526c97415d3213554.png",
                                  width: 50),
                              Text(
                                "+62 876 1234 5678",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              width: double.infinity,
              height: 50,
              // color: Color(0xFF1C1C1C),
              child: DefaultButton(
                press: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => OrderList()));
                },
                text: "Go To Your History Order",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _appbar() {
    return SafeArea(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(0)),
        child: Row(
          children: [
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(120)),
              child: Center(
                child: Text("Detail Order",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                    )),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
