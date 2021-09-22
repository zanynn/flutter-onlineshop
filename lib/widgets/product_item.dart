import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online_shop/pages/detail/product_detail2.dart';

import '../constants.dart';

class ProductItem extends StatelessWidget {
  final String productId;
  final String productImg;
  final String productName;
  final int productPrice;
  final String productDesc;
  final String productCategory;

  ProductItem(this.productId, this.productImg, this.productName,
      this.productPrice, this.productDesc, this.productCategory);

  @override
  Widget build(BuildContext context) {
    // variabel untuk mengatur format angka untuk harga
    var formatNumber = NumberFormat("#,###");
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDetail2(
              productId: productId,
              productImg: productImg,
              productName: productName,
              productPrice: productPrice,
              productDesc: productDesc,
              productCategory: productCategory,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(.5),
                  offset: Offset(3, 2),
                  blurRadius: 7)
            ]),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    productImg,
                    width: double.infinity,
                    height: 200,
                  )),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 2, right: 2),
                child: Text(
                  productName,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Text(
                    "IDR " + formatNumber.format(productPrice).toString(),
                    style: TextStyle(
                        fontSize: 16,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.remove_red_eye_outlined), onPressed: () {})
              ],
            ),
          ],
        ),
      ),
    );
  }
}
