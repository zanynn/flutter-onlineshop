import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online_shop/services/authentication.dart';
import 'package:online_shop/services/databases.dart';

class ProductDetail extends StatefulWidget {
  String productId;
  String productImg;
  String productName;
  int productPrice;
  String productDesc;
  String productCategory;

  ProductDetail(
      {this.productId,
      this.productImg,
      this.productName,
      this.productPrice,
      this.productDesc,
      this.productCategory});

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<bool> sizeSelect = [true, false, false, false, false];
  String productSize;

  int quantity = 1;

  void _showScaffold(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Detail", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: Colors.black),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_sharp, color: Colors.black),
            label: 'User',
          ),
        ],
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            //IMAGE
            _productImage(),
            Container(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //NAME and PRICE
                  _productNameAndPrice(),
                  SizedBox(
                    height: 10,
                  ),

                  //DESCRIPTION
                  _description(),
                  SizedBox(
                    height: 15,
                  ),

                  //SIZE SELECTION
                  _chooseSize(),
                  SizedBox(
                    height: 15,
                  ),

                  //SET QUANTITY
                  _setQuantity(),
                  SizedBox(
                    height: 15,
                  ),

                  //ADD TO CART
                  _addToCartButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _productImage() {
    return Center(
      child: Container(
        width: 380,
        child: Card(
          child: Container(
            padding: EdgeInsets.all(13),
            child: Container(
              height: 260,
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
    );
  }

  Widget _productNameAndPrice() {
    var formatNumber = NumberFormat("#,###");
    return Container(
      height: 70,
      child: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.productName,
                // "Kaos Oblong",
                style: TextStyle(
                  fontSize: 23,
                ),
              ),
              Text(
                // "IDR 100.000",
                formatNumber.format(widget.productPrice).toString() + " IDR",
                style: TextStyle(
                    color: Color(0xFF1C1C1C),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _description() {
    return Wrap(
      children: <Widget>[
        Text("Description :", style: TextStyle(fontSize: 18)),
        SizedBox(
          height: 30,
        ),
        Text(
          widget.productDesc,
          style: TextStyle(
            fontSize: 16,
          ),
          textAlign: TextAlign.justify,
        )
      ],
    );
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

  Widget _chooseSize() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Choose your size :",
            style: TextStyle(fontSize: 18),
          ),
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
        Text(
          "Quantity",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: <Widget>[
            Container(
              height: 40,
              width: 40,
              color: Color(0xFF1C1C1C),
              child: InkWell(
                child: Icon(
                  Icons.remove,
                  color: Colors.white,
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
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFF1C1C1C),
                ),
              ),
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
              color: Color(0xFF1C1C1C),
              child: InkWell(
                child: Container(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
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

  @override
  Widget _addToCartButton() {
    return Container(
      height: 60,
      child: Container(
        height: 45,
        width: double.infinity,
        child: RaisedButton(
          child: Text(
            "Add To Cart",
            style: TextStyle(color: Colors.white),
          ),
          color: Color(0xFF1C1C1C),
          onPressed: () {
            setSize();
            int productCost = widget.productPrice * quantity;
            CollectionReference carts =
                FirebaseFirestore.instance.collection("carts");
            String orderCollection = "Order " + levelOrder.toString();

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
                _showScaffold(
                    "Product " + widget.productName + " successfully added!");
              }
            });
          },
        ),
      ),
    );
  }
}
