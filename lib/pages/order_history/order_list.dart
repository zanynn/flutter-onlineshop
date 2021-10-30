import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:online_shop/pages/order_history/components/order_item.dart';
import 'package:online_shop/services/authentication.dart';

import '../../size_config.dart';
import '../home/home_screen.dart';

class OrderList extends StatefulWidget {
  @override
  _OrderListState createState() => _OrderListState();
}

FirebaseFirestore firestore = FirebaseFirestore.instance;

class _OrderListState extends State<OrderList> {
  CollectionReference orders = firestore.collection("orders");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          _appbar(),
          Container(
            child: StreamBuilder<QuerySnapshot>(
              //memanggil collection data produk berdasarkan field kategori yang bernilai nama kategori yang diterima
              stream: orders.where("userId", isEqualTo: userId).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: snapshot.data.docs
                        .map((item) => OrderItem(
                              item['name'],
                              item['userEmail'],
                              item['address'],
                              item['phone'],
                              item['totalOrder'],
                              item['orderDateTime'],
                              item['status'],
                              item['collectionRef'],
                              item['note'],
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
    );
  }

  Widget _appbar() {
    return SafeArea(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Row(
          children: [
            SizedBox(
              height: getProportionateScreenWidth(40),
              width: getProportionateScreenWidth(40),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60),
                ),
                color: Colors.white,
                padding: EdgeInsets.zero,
                onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) => HomeScreen(),
                  ),
                ),
                child: SvgPicture.asset(
                  "assets/icons/Back ICon.svg",
                  height: 15,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Text(
                    "Order Transaction History",
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
