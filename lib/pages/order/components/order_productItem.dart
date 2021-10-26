import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class OrderItem extends StatelessWidget {
  final String productImg;
  final String productName;
  final String productCategory;
  final int productPrice;
  final String productSize;
  final int productQty;
  final int productCost;

  OrderItem(this.productImg, this.productName, this.productCategory,
      this.productPrice, this.productSize, this.productQty, this.productCost);

  @override
  Widget build(BuildContext context) {
    var formatNumber = NumberFormat("#,###");
    return Row(
      children: [
        SizedBox(height: 50),
        SizedBox(
          width: 90,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage('http://10.0.2.2:8000' + productImg),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  productName,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  maxLines: 2,
                ),
                Column(
                  children: [
                    SizedBox(height: 2),
                    Text(
                      " Size : " + productSize,
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                      // maxLines: 2,
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          " IDR " +
                              formatNumber.format(productPrice).toString(),
                          style: TextStyle(color: Colors.black, fontSize: 12),
                          // maxLines: 2,
                        ),
                        Text(
                          "  x " + productQty.toString(),
                          style: TextStyle(color: kTextColor, fontSize: 14),
                          // maxLines: 2,
                        ),
                      ],
                    ),
                    Text(
                      " IDR " + formatNumber.format(productCost).toString(),
                      style: TextStyle(color: kPrimaryColor, fontSize: 16),
                      // maxLines: 2,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}



  // Widget build(BuildContext context) {
  //   var formatNumber = NumberFormat("#,###");
  //   return Container(
  //     margin: EdgeInsets.symmetric(vertical: 2),
  //     child: Row(
  //       children: [
  //         Image.network(
  //           // "https://www.freeiconspng.com/uploads/belt-png-14.png",
  //           productImg,
  //           width: 80,
  //           height: 80,
  //         ),
  //         SizedBox(
  //           width: 10,
  //         ),
  //         Column(
  //           children: [
  //             Text(
  //               // "Long Sleeve",
  //               productName,
  //               style: TextStyle(
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 15,
  //               ),
  //             ),
  //             Text(productCategory),
  //             Text(productPrice.toString())
  //           ],
  //         ),
  //         SizedBox(
  //           width: 20,
  //         ),
  //         Row(
  //           children: [
  //             Text("Qty: "),
  //             Text(productQty.toString()),
  //           ],
  //         ),
  //         Expanded(
  //           child: Container(
  //             alignment: Alignment.centerRight,
  //             child: Text(
  //               // "IDR 200,000",
  //               "IDR " + formatNumber.format(productCost).toString(),
  //               style: TextStyle(
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 19,
  //               ),
  //             ),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }
