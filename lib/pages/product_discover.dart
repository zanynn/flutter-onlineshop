import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_shop/constants.dart';
import 'package:online_shop/pages/home/home_screen.dart';
import 'package:online_shop/widgets/back_app_bar.dart';
import 'package:online_shop/widgets/product_item.dart';
import 'package:http/http.dart' as http;

import '../size_config.dart';

class ProductDiscovery extends StatefulWidget {
  @override
  _ProductDiscoveryState createState() => _ProductDiscoveryState();
}

class _ProductDiscoveryState extends State<ProductDiscovery> {
  String key = "";

  getProducts() async {
    String uri = "http://10.0.2.2:8000/api/product";
    var response = await http.get(Uri.parse(uri));
    return json.decode(response.body);
  }

  @override
  void initState() {
    getProducts();
    super.initState();
  }

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
                child: StreamBuilder(
                  //memanggil collection data produk berdasarkan field kategori yang bernilai nama kategori yang diterima
                  stream: getProducts(),
                  // (key != "" && key != null)
                  //     ? products.where("name", isEqualTo: key).snapshots()
                  //     : products.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  childAspectRatio: 0.72,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          itemCount: snapshot.data['data'].length,
                          itemBuilder: (BuildContext context, index) {
                            return Container(
                                padding: const EdgeInsets.all(10),
                                alignment: Alignment.center,
                                child: ProductItem(
                                  product_code: snapshot.data['data'][index]
                                      ['product_code'],
                                  product_name: snapshot.data['data'][index]
                                      ['product_name'],
                                  product_image: snapshot.data['data'][index]
                                      ['product_image'],
                                  product_price: snapshot.data['data'][index]
                                      ['product_price'],
                                  product_desc: snapshot.data['data'][index]
                                      ['product_desc'],
                                  product_stock: snapshot.data['data'][index]
                                      ['product_stock'],
                                  category_id: snapshot.data['data'][index]
                                      ['category_id'],
                                ));
                          });
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
