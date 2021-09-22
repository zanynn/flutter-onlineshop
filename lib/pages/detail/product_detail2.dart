import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online_shop/pages/detail/component/top_rounded_container.dart';
import 'package:online_shop/services/authentication.dart';
import 'package:online_shop/services/databases.dart';
import 'package:online_shop/widgets/default_button.dart';
import 'package:online_shop/widgets/rounded_icon_btn.dart';

import '../../constants.dart';
import '../../size_config.dart';
import 'component/custom_app_bar.dart';

class ProductDetail2 extends StatefulWidget {
  String productId;
  String productImg;
  String productName;
  int productPrice;
  String productDesc;
  String productCategory;

  ProductDetail2(
      {this.productId,
      this.productImg,
      this.productName,
      this.productPrice,
      this.productDesc,
      this.productCategory});

  @override
  _ProductDetail2State createState() => _ProductDetail2State();
}

class _ProductDetail2State extends State<ProductDetail2> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<bool> sizeSelect = [true, false, false, false, false];
  String productSize;

  int quantity = 1;

  void _showScaffold(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  int indexSize = 0;
  void setSize() {
    setState(() {
      if (indexSize == 0) {
        productSize = "S";
      } else if (indexSize == 1) {
        productSize = "M";
      } else if (indexSize == 2) {
        productSize = "L";
      } else if (indexSize == 3) {
        productSize = "XL";
      } else if (indexSize == 4) {
        productSize = "XXL";
      }
    });
  }

  var formatNumber = NumberFormat("#,###");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: CustomAppBar(),
        body: ListView(
          children: [
            Center(
              child: Container(
                color: Color(0xFFF6F7F6),
                // color: Color(0xFFF9AAA6),
                width: 220,
                child: Card(
                  child: Container(
                    padding: EdgeInsets.all(13),
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(widget.productImg),
                          // image: NetworkImage(
                          //     "https://redcanoebrands.com/wp-content/uploads/2013/11/cessna-blue-tshirt-416x416.jpg"),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            TopRoundedContainer(
                color: Colors.white,
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding:
                                EdgeInsets.all(getProportionateScreenWidth(15)),
                            width: getProportionateScreenWidth(184),
                            decoration: BoxDecoration(
                              color: Color(0xFFFFE6E6),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "IDR " +
                                    formatNumber
                                        .format(widget.productPrice)
                                        .toString(),
                                style: TextStyle(
                                    color: kPrimaryColor, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(20)),
                          child: Text(
                            widget.productName,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: getProportionateScreenWidth(20),
                            right: getProportionateScreenWidth(64),
                          ),
                          child: new DescriptionTextWidget(
                              text: widget.productDesc),
                        ),
                      ],
                    ),
                    TopRoundedContainer(
                      color: Color(0xFFF6F7F9),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(20)),
                            child: Row(
                              children: [
                                _chooseSize(),
                                _setQuantity(),
                              ],
                            ),
                          ),
                          TopRoundedContainer(
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: SizeConfig.screenWidth * 0.15,
                                right: SizeConfig.screenWidth * 0.15,
                                bottom: getProportionateScreenWidth(40),
                                top: getProportionateScreenWidth(15),
                              ),
                              child: DefaultButton(
                                text: "Add To Cart",
                                press: () {
                                  setSize();
                                  int productCost =
                                      widget.productPrice * quantity;
                                  CollectionReference carts = FirebaseFirestore
                                      .instance
                                      .collection("carts");
                                  String orderCollection =
                                      "Order " + levelOrder.toString();

                                  carts
                                      .doc(userId)
                                      .collection(orderCollection)
                                      .doc(widget.productId)
                                      .snapshots()
                                      .listen((DocumentSnapshot event) async {
                                    //ketika document ada, maka tidak ditambahkan pada cart
                                    if (event.exists) {
                                      widget.productId = "";

                                      _showScaffold("Product " +
                                          widget.productName +
                                          " already exist, please check your cart!");
                                    } else {
                                      addProductToCart(
                                          widget.productId,
                                          widget.productName,
                                          widget.productCategory,
                                          widget.productImg,
                                          productSize,
                                          widget.productPrice,
                                          quantity,
                                          productCost);

                                      widget.productId = "";
                                      _showScaffold("Product " +
                                          widget.productName +
                                          " successfully added!");
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ))
          ],
        ));
  }

  Widget _chooseSize() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   "Choose your size :",
          //   style: TextStyle(fontSize: 18),
          // ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: 265,
            child: ToggleButtons(
              children: [
                Text("S"),
                Text("M"),
                Text("L"),
                Text("XL"),
                Text("XXL"),
              ],
              borderColor: Colors.lightBlueAccent,
              selectedBorderColor: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              onPressed: (int index) {
                setState(() {
                  for (int idx = 0; idx < sizeSelect.length; idx++) {
                    if (idx == index) {
                      sizeSelect[idx] = true;
                    } else {
                      sizeSelect[idx] = false;
                    }
                  }
                });
                setState(() {
                  indexSize = index;
                });
              },
              isSelected: sizeSelect,
            ),
          ),
        ],
      ),
    );
  }

  Widget _setQuantity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Row(
          children: <Widget>[
            Container(
              height: 40,
              width: 40,
              child: InkWell(
                child: RoundedIconBtn(
                  icon: Icons.remove,
                ),
                onTap: () {
                  setState(() {
                    if (quantity > 1) {
                      quantity--;
                    }
                  });
                },
              ),
            ),
            Container(
              height: 40,
              width: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(),
              child: Text(
                quantity.toString(),
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Container(
              height: 40,
              width: 40,
              child: InkWell(
                child: Container(
                  child: RoundedIconBtn(
                    icon: Icons.add,
                    // color: Colors.white,
                  ),
                ),
                onTap: () {
                  setState(() {
                    quantity++;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class DescriptionTextWidget extends StatefulWidget {
  final String text;

  DescriptionTextWidget({@required this.text});

  @override
  _DescriptionTextWidgetState createState() =>
      new _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  String firstHalf;
  String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 50) {
      firstHalf = widget.text.substring(0, 50);
      secondHalf = widget.text.substring(50, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: secondHalf.isEmpty
          ? new Text(firstHalf)
          : new Column(
              children: <Widget>[
                new Text(flag ? (firstHalf + "...") : (firstHalf + secondHalf)),
                new InkWell(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        flag ? "Show More Detail" : "Show Less Detail",
                        style: new TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                ),
              ],
            ),
    );
  }
}
