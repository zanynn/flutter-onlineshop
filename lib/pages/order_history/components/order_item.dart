import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online_shop/pages/order/order.dart';
import 'package:online_shop/services/authentication.dart';

class OrderItem extends StatelessWidget {
  final String name;
  final String userEmail;
  final String address;
  final String phone;
  final int totalOrder;
  final String orderDateTime;
  final String status;
  final String collectionRef;

  OrderItem(
    this.name,
    this.userEmail,
    this.address,
    this.phone,
    this.totalOrder,
    this.orderDateTime,
    this.status,
    this.collectionRef,
  );

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    var formatNumber = NumberFormat("#,###");

    //mereferensikan kembali ke collection di dalam collection "cart" untuk menghitung jumlah item produk yg dibeli
    CollectionReference productsOrder =
        firestore.collection("carts").doc(userId).collection(collectionRef);
    int length = 0;

    return InkWell(
      onTap: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => Order(
                  buyerName: name,
                  buyerAddress: address,
                  buyerPhone: phone,
                  buyerTime: orderDateTime,
                  totalOrder: totalOrder,
                  orderCollection: collectionRef,
                  status: status,
                )));
      },
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(color: Colors.grey.withOpacity(.5), blurRadius: 15)
            ]),
        child: Column(
          children: [
            ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("#" + collectionRef,
                        style: TextStyle(
                          color: Colors.grey,
                        )),
                    Text(orderDateTime,
                        style: TextStyle(
                          color: Colors.grey,
                        )),
                  ],
                ),
                trailing: Column(
                  children: [
                    if (status == "Unconfirmed") ...[
                      Text(
                        "Unconfirmed",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color(0xffFB6340)),
                      )
                    ] else if (status == "Confirmed") ...[
                      Text(
                        "Confirmed",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color(0xff007BFF)),
                      )
                    ] else if (status == "Delivered") ...[
                      Text(
                        "Delivered",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color(0xff11CDEF)),
                      )
                    ] else if (status == "Success") ...[
                      Text(
                        "Success",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color(0xff2DCE89)),
                      )
                    ] else ...[
                      Text(
                        "Failed",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color(0xffF5365C)),
                      )
                    ],
                  ],
                )
                // status == "Unverified"
                //     ? Text("Unverified",
                //         style: TextStyle(
                //           color: Colors.orangeAccent[400],
                //           fontSize: 18,
                //           fontWeight: FontWeight.bold,
                //         ))
                //     : Text("Success",
                //         style: TextStyle(
                //           color: Colors.greenAccent[400],
                //           fontSize: 18,
                //           fontWeight: FontWeight.bold,
                //         )),
                ),
            Divider(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "ITEMS: ",
                        style: TextStyle(color: Colors.grey),
                      )),
                  Expanded(
                    child: Container(
                      child: StreamBuilder<QuerySnapshot>(
                          stream: productsOrder.snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              //menghitung jumlah produk yang dibeli pada setiap pembelian
                              length = snapshot.data.size;
                              return Container(
                                child: Text(
                                  length.toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "IDR " + formatNumber.format(totalOrder).toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
