import 'package:flutter/material.dart';
import 'package:online_shop/services/databases.dart';

class CartItem extends StatefulWidget {
  String productImg;
  String productName;
  String productCategory;
  int productPrice;
  String productId;
  String productSize;
  int productQty;
  int productCost;
  CartItem(
      this.productImg,
      this.productName,
      this.productCategory,
      this.productPrice,
      this.productId,
      this.productSize,
      this.productQty,
      this.productCost);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(.5),
                offset: Offset(3, 2),
                blurRadius: 7)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              // "https://purepng.com/public/uploads/large/wrist-watch-ogx.png",
              widget.productImg,
              width: 80,
            ),
          ),
          Expanded(
            child: Wrap(
              direction: Axis.vertical,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.productName,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            widget.productCategory,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Text(
                            "Size: " + widget.productSize,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.productPrice.toString() + " IDR",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                )
              ],
            ),
          ),
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
                Text(
                  // "100.000 IDR",
                  widget.productCost.toString(),
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
