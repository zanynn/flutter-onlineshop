import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online_shop/pages/detail/product_detail2.dart';

import '../constants.dart';

class ProductItem extends StatelessWidget {
  final String product_id;
  final String product_code;
  final String product_name;
  final String product_image;
  final String product_desc;
  final int product_price;
  final int product_stock;
  final String product_category;

  ProductItem(
      this.product_id,
      this.product_code,
      this.product_name,
      this.product_image,
      this.product_desc,
      this.product_price,
      this.product_stock,
      this.product_category);

  @override
  Widget build(BuildContext context) {
    // variabel untuk mengatur format angka untuk harga
    var formatNumber = NumberFormat("#,###");
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDetail2(
              product_id: product_id,
              product_code: product_code,
              product_name: product_name,
              product_image: product_image,
              product_desc: product_desc,
              product_price: product_price,
              product_stock: product_stock,
              product_category: product_category,
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
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          //gambar sementara
                          "https://png.pngtree.com/png-vector/20190225/ourlarge/pngtree-vector-avatar-icon-png-image_702436.jpg"),
                    ),
                  ),
                ),
                // Image.network(
                //   "https://png.pngtree.com/png-vector/20190225/ourlarge/pngtree-vector-avatar-icon-png-image_702436.jpg",
                //   width: double.infinity,
                //   height: 200,
                // ),
              ),
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
