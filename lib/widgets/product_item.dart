import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online_shop/models/product.dart';
import 'package:online_shop/pages/detail/product_detail2.dart';

import '../constants.dart';

class ProductItem extends StatelessWidget {
  // final Product product;
  final String product_code;
  final String product_name;
  final String product_image;
  final int product_price;
  final String product_desc;
  final int product_stock;
  final int category_id;

  ProductItem(
      {this.product_code,
      this.product_name,
      this.product_image,
      this.product_price,
      this.product_desc,
      this.product_stock,
      this.category_id});

  @override
  Widget build(BuildContext context) {
    // variabel untuk mengatur format angka untuk harga
    var formatNumber = NumberFormat("#,###");
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDetail2(
              product_code: product_code,
              product_name: product_name,
              product_image: product_image,
              product_price: product_price,
              product_desc: product_desc,
              product_stock: product_stock,
              category_id: category_id,
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
                    "http://10.0.2.2:8000/storage/" + product_image,
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
                  product_name,
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
                    "IDR " + formatNumber.format(product_price).toString(),
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
