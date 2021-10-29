import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_shop/constants.dart';
import 'package:online_shop/pages/home/home_screen.dart';
import 'package:online_shop/widgets/back_app_bar.dart';
import 'package:online_shop/widgets/product_item.dart';

import '../size_config.dart';

class ProductDiscovery extends StatefulWidget {
  @override
  _ProductDiscoveryState createState() => _ProductDiscoveryState();
}

class _ProductDiscoveryState extends State<ProductDiscovery> {
  String key = "";
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    //mereferensikan untuk memanggil collection data "produk"
    CollectionReference products = firestore.collection("products");

    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(
          height: getProportionateScreenWidth(40),
          width: getProportionateScreenWidth(40),
          child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(60),
            ),
            color: Colors.white,
            padding: EdgeInsets.zero,
            onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => HomeScreen(),
              ),
            ),
            child: SvgPicture.asset(
              "assets/icons/Back ICon.svg",
              height: 15,
            ),
          ),
        ),
        title: Container(
          width: SizeConfig.screenWidth * 0.6,
          decoration: BoxDecoration(
            color: kSecondaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            onChanged: (value) {
              setState(() {
                key = value;
              });
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(10),
                  vertical: getProportionateScreenWidth(9)),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              hintText: "Search product",
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: ListView(
            children: [
              Row(
                children: [],
              ),
              Container(
                // height: MediaQuery.of(context).size.height + 5,
                height: 770,
                child: StreamBuilder<QuerySnapshot>(
                  //memanggil collection data produk berdasarkan field kategori yang bernilai nama kategori yang diterima
                  stream: (key != "" && key != null)
                      ? products
                          .where("product_name", isEqualTo: key)
                          // .where('product_stock', isGreaterThan: 5)
                          .snapshots()
                      : products.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 0.72,
                        padding: const EdgeInsets.all(10),
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        scrollDirection: Axis.vertical,
                        children: snapshot.data.docs
                            .map((item) => ProductItem(
                                  item['product_id'],
                                  item['product_code'],
                                  item['product_name'],
                                  item['product_image'],
                                  item['product_desc'],
                                  item['product_price'],
                                  item['product_stock'],
                                  item['product_category'],
                                ))
                            .toList(),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key key,
    @required this.category,
    @required this.image,
    // @required this.numOfBrands,
    // @required this.press,
  }) : super(key: key);

  final String category, image;
  // final int numOfBrands;
  // final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(1)),
      child: GestureDetector(
        // onTap: press,
        child: SizedBox(
          width: getProportionateScreenWidth(300),
          height: getProportionateScreenWidth(65),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF343434).withOpacity(0.4),
                        Color(0xFF343434).withOpacity(0.15),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(15),
                    vertical: getProportionateScreenWidth(15),
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: "$category\n",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(18),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // TextSpan(text: "$numOfBrands Brands")
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
