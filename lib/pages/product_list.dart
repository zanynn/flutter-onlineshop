import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_shop/widgets/back_app_bar.dart';
import 'package:online_shop/widgets/product_item.dart';
import 'package:http/http.dart' as http;

import '../size_config.dart';

class ProductList extends StatelessWidget {
  final String category;
  ProductList({this.category});

  getProducts() async {
    String uri = "http://10.0.2.2:8000/api/product";
    var response = await http.get(Uri.parse(uri));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    //mereferensikan untuk memanggil collection data "produk"
    CollectionReference products = firestore.collection("products");

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: ListView(
            children: [
              BackAppBar(),
              // Container(
              //   padding: EdgeInsets.only(left: 10),
              //   child: Text(
              //     category,
              //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              //   ),
              // ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: getProportionateScreenWidth(35),
                      bottom: getProportionateScreenHeight(15)),
                  child: Row(
                    children: [
                      SpecialOfferCard(
                        image: "assets/images/List.jpg",
                        category: category,
                        // numOfBrands: 18,
                        // press: () {},
                      ),
                      SizedBox(height: (50)),
                    ],
                  ),
                ),
              ),
              Container(
                height: 650,
                child: StreamBuilder(
                  //memanggil collection data produk berdasarkan field kategori yang bernilai nama kategori yang diterima
                  stream: getProducts(),
                  // products
                  //     .where('category', isEqualTo: category)
                  //     .snapshots(),
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
