import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online_shop/pages/order/components/order_productItem.dart';
import 'package:online_shop/services/authentication.dart';
import 'package:online_shop/pages/order_history/order_list.dart';
import 'package:online_shop/widgets/default_button.dart';
import 'package:url_launcher/url_launcher.dart';

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
  final String note;

  Order(
      {this.buyerName,
      this.buyerAddress,
      this.buyerPhone,
      this.buyerTime,
      this.orderCollection,
      this.totalOrder,
      this.status,
      this.note});

  void launchWhatsApp(@required number, @required message) async {
    String url = "whatsapp://send?phone=$number&text=$message";

    await canLaunch(url) ? launch(url) : print("Can't open whatsapp");
  }

  @override
  Widget build(BuildContext context) {
    var formatNumber = NumberFormat("#,###");
    String orderId;
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
                        if (status == "Unconfirmed") ...[
                          Text(
                            "Unconfirmed",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Color(0xffFB6340)),
                          )
                        ] else if (status == "Confirmed") ...[
                          Text(
                            "Confirmed",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Color(0xff007BFF)),
                          )
                        ] else if (status == "Delivered") ...[
                          Text(
                            "Delivered",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Color(0xff11CDEF)),
                          )
                        ] else if (status == "Success") ...[
                          Text(
                            "Success",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Color(0xff2DCE89)),
                          )
                        ] else if (status == "Invalid") ...[
                          Text(
                            "Invalid",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Color(0xffE6dd2f)),
                          )
                        ] else ...[
                          Text(
                            "Failed",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Color(0xffF5365C)),
                          )
                        ],
                      ],
                    ),
                    if (status == "Unconfirmed") ...[
                      Text(
                        "Pesanan belum dikonfirmasi. Silahkan menghubungi admin untuk melanjutnkan proses transaksi",
                        style: TextStyle(
                            fontStyle: FontStyle.italic, color: Colors.white),
                      )
                    ] else if (status == "Confirmed") ...[
                      Text(
                        "Pesanan telah dikonfirmasi. Admin mempersiapkan proses pengiriman.",
                        style: TextStyle(
                            fontStyle: FontStyle.italic, color: Colors.white),
                      )
                    ] else if (status == "Delivered") ...[
                      Text(
                        "Pesanan dalam proses pengiriman.",
                        style: TextStyle(
                            fontStyle: FontStyle.italic, color: Colors.white),
                      )
                    ] else if (status == "Success") ...[
                      Text(
                        "Pesanan sukses. Pesanan telah sampai pada tujuan. Terima kasih",
                        style: TextStyle(
                            fontStyle: FontStyle.italic, color: Colors.white),
                      )
                    ] else if (status == "Invalid") ...[
                      Text(
                        "Persyaratan transaksi tidak sesuai / belum terpenuhi.",
                        style: TextStyle(
                            fontStyle: FontStyle.italic, color: Colors.white),
                      )
                    ] else ...[
                      Text(
                        "Pesanan gagal.",
                        style: TextStyle(
                            fontStyle: FontStyle.italic, color: Colors.white),
                      )
                    ],
                    Text(
                      "Catatan: ",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      note,
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            status != "Success"
                ? Container(
                    margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    width: double.infinity,
                    height: 50,
                    // color: Color(0xFF1C1C1C),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Color(0xFF56CD63),
                      onPressed: () async {
                        QuerySnapshot orderSnapShot = await FirebaseFirestore
                            .instance
                            .collection("orders")
                            .where("orderDateTime", isEqualTo: buyerTime)
                            .get();
                        orderSnapShot.docs.forEach(
                          (data) {
                            orderId = "" + data.id.toString().toUpperCase();
                          },
                        );
                        print(orderId);
                        launchWhatsApp("+6282143614124",
                            "==[KONFIRMASI PESANAN]==\nNama : $buyerName\nEmail: $email\nWaktu: $buyerTime\nKode : $orderId\n(mohon chat langsung dikirim tanpa mengubah apapun)");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Konfirmasikan ke Admin",
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(18),
                              color: Colors.white,
                            ),
                          ),
                          Image.network(
                              "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/2c90bb65-3c93-4f38-8f43-0469c153c1e0/detplej-37c88091-ddd9-4fb0-87cc-b2c6c41b1184.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcLzJjOTBiYjY1LTNjOTMtNGYzOC04ZjQzLTA0NjljMTUzYzFlMFwvZGV0cGxlai0zN2M4ODA5MS1kZGQ5LTRmYjAtODdjYy1iMmM2YzQxYjExODQucG5nIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.uFJYd2MzmBjm-3_R8MnL0VMn47Nv5-41Rlc-bJ_IhLY",
                              width: 65),
                        ],
                      ),
                    ),
                  )
                : Container(),
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
                text: "Kembali ke riwayat pesanan",
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
