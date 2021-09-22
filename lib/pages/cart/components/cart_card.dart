import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online_shop/services/databases.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CartCard extends StatefulWidget {
  String productImg;
  String productName;
  String productCategory;
  int productPrice;
  String productId;
  String productSize;
  int productQty;
  int productCost;
  CartCard(
      this.productImg,
      this.productName,
      this.productCategory,
      this.productPrice,
      this.productId,
      this.productSize,
      this.productQty,
      this.productCost);

  @override
  _CartCardState createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  var formatNumber = NumberFormat("#,###");

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 120,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(
                widget.productImg,
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
                  widget.productName,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  maxLines: 2,
                ),
                Column(
                  children: [
                    SizedBox(height: 2),
                    Text(
                      " Size : " + widget.productSize,
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
                              formatNumber
                                  .format(widget.productPrice)
                                  .toString(),
                          style: TextStyle(color: Colors.black, fontSize: 12),
                          // maxLines: 2,
                        ),
                        Text(
                          "  x " + widget.productQty.toString(),
                          style: TextStyle(color: kTextColor, fontSize: 14),
                          // maxLines: 2,
                        ),
                      ],
                    ),
                    Text(
                      " IDR " +
                          formatNumber.format(widget.productCost).toString(),
                      style: TextStyle(color: kPrimaryColor, fontSize: 16),
                      // maxLines: 2,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        // SizedBox(height: 2),
                        SizedBox(width: 80),
                        Padding(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            children: [
                              IconButton(
                                  icon: Icon(
                                    Icons.delete_outline,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    //menghapus item cart
                                    deleteItemCart(widget.productId);
                                  }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        icon: Icon(Icons.chevron_left),
                        onPressed: () {
                          setState(() {
                            if (widget.productQty > 1) {
                              widget.productQty--;
                            }
                          });
                          updateItemCart(widget.productId, widget.productQty,
                              widget.productPrice);
                        }),
                    Container(
                        child: Text(
                      widget.productQty.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        // fontWeight: FontWeight.bold,
                      ),
                    )),
                    IconButton(
                        icon: Icon(Icons.chevron_right),
                        onPressed: () {
                          setState(() {
                            widget.productQty++;
                          });
                          updateItemCart(widget.productId, widget.productQty,
                              widget.productPrice);
                        }),
                  ],
                ),
              ],
            ),
            // Text.rich(
            //   TextSpan(
            //       " IDR " + formatNumber.format(widget.productPrice).toString(),
            //     style: TextStyle(
            //         fontWeight: FontWeight.w600, color: kPrimaryColor),
            //     children: [
            //       TextSpan(
            //           // text: " x${cart.numOfItem}",
            //           style: Theme.of(context).textTheme.bodyText1),
            //     ],
            //   ),
            // ),
          ],
        ),
      ],
    );
  }
}
