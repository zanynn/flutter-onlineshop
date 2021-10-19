import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_shop/pages/cart/components/custom_app_bar.dart';
import 'package:online_shop/services/authentication.dart';

import '../../size_config.dart';
import 'components/cart_card.dart';
import 'components/bottom_component_cart.dart';

class CartScreen extends StatefulWidget {
  // const CartScreen({ Key? key }) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

FirebaseFirestore firestore = FirebaseFirestore.instance;

class _CartScreenState extends State<CartScreen> {
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
      appBar: CustomAppBar(),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: ListView(
          children: [
            Container(
              child: StreamBuilder<QuerySnapshot>(
                stream: carts.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: snapshot.data.docs
                          .map((item) => CartCard(
                                item['product_id'],
                                item['product_code'],
                                item['product_name'],
                                item['product_category'],
                                item['product_image'],
                                item['product_size'],
                                item['product_price'],
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
            ),
          ],
        ),
      ),
      bottomNavigationBar: CheckoutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "Your Cart",
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
