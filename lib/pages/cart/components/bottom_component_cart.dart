import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:online_shop/pages/order/order.dart';
import 'package:online_shop/services/authentication.dart';
import 'package:online_shop/services/databases.dart';
import 'package:online_shop/widgets/default_button.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CheckoutCard extends StatefulWidget {
  // const CheckoutCard({
  //   Key key,
  // }) : super(key: key);

  @override
  _CheckoutCardState createState() => _CheckoutCardState();
}

FirebaseFirestore firestore = FirebaseFirestore.instance;
int totalOrder;

class _CheckoutCardState extends State<CheckoutCard> {
  var formatNumber = NumberFormat("#,###");
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
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15),
        horizontal: getProportionateScreenWidth(30),
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: getProportionateScreenWidth(40),
                  width: getProportionateScreenWidth(40),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset(
                    "assets/icons/Parcel.svg",
                    color: kPrimaryColor,
                  ),
                ),
                Spacer(),
                Text("Packages packed safely"),
                const SizedBox(width: 10),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Text(
                //   "Total",
                //   style: TextStyle(color: Colors.black, fontSize: 13),
                // ),
                //
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: carts.snapshots(),
                    builder: (context, snapshot) {
                      int total = 0;
                      if (snapshot.hasData) {
                        //menghitung total biaya
                        snapshot.data.docs
                            .map((e) => total += e["product_cost"])
                            .toList();
                        totalOrder = total;
                        return Container(
                          child: Text(
                            "Total\n" +
                                "IDR " +
                                formatNumber.format(total).toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 15),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(170),
                  child: DefaultButton(
                    text: "Check Out",
                    press: () {
                      if (totalOrder == 0) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text(
                              'Information',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            content: const Text(
                                'Empty cart, please add the product'),
                            actions: <Widget>[
                              MaterialButton(
                                onPressed: () => Navigator.of(context).pop(),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  child: Text(
                                    'OK',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                color: kPrimaryColor,
                              ),
                            ],
                          ),
                        );
                      } else {
                        showCheckoutForm();
                      }
                    },
                  ),
                ),
              ],
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
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
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
                              color: Colors.redAccent[400],
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
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              color: kPrimaryColor,
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
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Text(
                                              "Yes",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            onPressed: () {
                                              var now = new DateTime.now();
                                              var formatter =
                                                  new DateFormat('dd-MM-yyyy')
                                                      .add_Hms();
                                              String formattedDateNow =
                                                  formatter.format(now);
                                              String status = "Unconfirmed";
                                              String note = "-";
                                              checkoutOrder(
                                                  nameController.text,
                                                  addressController.text,
                                                  phoneController.text,
                                                  totalOrder,
                                                  formattedDateNow,
                                                  orderCollection,
                                                  status,
                                                  note);
                                              Navigator.of(context).pushReplacement(
                                                  MaterialPageRoute(
                                                      builder: (context) => Order(
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
                                                          note: note)));
                                            },
                                            color: kPrimaryColor,
                                          ),

                                          //BUTTON "Cancel"
                                          MaterialButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            color: Colors.redAccent[400],
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
