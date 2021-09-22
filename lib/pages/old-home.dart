import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:online_shop/pages/old-cart.dart';
import 'package:online_shop/pages/login_page.dart';
import 'package:online_shop/pages/order_history/order_list.dart';
import 'package:online_shop/pages/product_list.dart';
import 'package:online_shop/widgets/category_item.dart';
import 'package:online_shop/widgets/product_item.dart';
import 'package:online_shop/services/authentication.dart';
import 'package:online_shop/services/databases.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MZ.ID",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        // elevation: 0.0,
        backgroundColor: Colors.grey[100],
        actions: [
          IconButton(icon: Icon(Icons.notifications_none), onPressed: () {}),
          IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () async {
                await getUserLevel();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Cart()));
              }),
        ],
        iconTheme: IconThemeData(color: Colors.black),
      ),
      drawer: _drawer(),
      body: ListView(
        children: <Widget>[
          _carouselImage(),
          _category(),
          SizedBox(
            height: 17,
          ),
          _recommendProduct(),
          SizedBox(
            height: 17,
          ),
          _newProduct(),
        ],
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
    );
  }

  Widget _drawer() {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(name, style: TextStyle(color: Colors.black)),
            currentAccountPicture: CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(imageUrl),
            ),
            decoration: BoxDecoration(color: Color(0xfff2f2f2)),
            accountEmail: Text(
              email,
              style: TextStyle(color: Colors.black),
            ),
          ),
          ListTile(
            title: Text('Home'),
            leading: Icon(Icons.home),
            onTap: () {
              setState(() {});
            },
          ),
          ListTile(
            title: Text('Cart'),
            leading: Icon(Icons.shopping_cart),
            onTap: () {
              setState(() {});
            },
          ),
          ListTile(
            title: Text('Orders'),
            leading: Icon(Icons.payments),
            onTap: () {
              setState(() {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => OrderList()));
              });
            },
          ),
          Divider(
            thickness: 2,
          ),
          ListTile(
            title: Text('Logout'),
            leading: Icon(Icons.exit_to_app),
            onTap: () {
              signOutGoogle();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) {
                return LoginPage();
              }), ModalRoute.withName('/'));
            },
          ),
        ],
      ),
    );
  }

  Widget _carouselImage() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Carousel(
        autoplay: true,
        // showIndicator: false,
        images: [
          NetworkImage(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdeVR36L4bLlswYEzqGqqjHujed5qaYR5kOQ&usqp=CAU"),
          NetworkImage(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGJslhUnudzJtKWKC2NK8g8wdSC8wqNZGvNQ&usqp=CAU"),
          NetworkImage(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHcx6Ju8zOXXlRgOlGeqQCIwOvlxwI6PY05Q&usqp=CAU"),
        ],
        dotSize: 4.0,
        dotSpacing: 15.0,
        dotColor: Colors.grey[300],
        indicatorBgPadding: 5.0,
        dotBgColor: Colors.black.withOpacity(0.17),
      ),
    );
  }

  Widget _category() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.1 - 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Categories",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            // height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                //ITEM CATEGORY
                // Setiap kategori mengirimkan namanya agar dapat diterima dan di filter pada halaman Product List
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) =>
                            ProductList(category: "T-Shirt")));
                  },
                  child: CategoryItem(
                    image: 'https://img.icons8.com/ios/452/t-shirt--v1.png',
                    name: "T-Shirt",
                  ),
                ),

                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => ProductList(category: "Jacket")));
                  },
                  child: CategoryItem(
                    image: 'https://img.icons8.com/ios/2x/tracksuit.png',
                    name: "Jacket",
                  ),
                ),

                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => ProductList(category: "Pants")));
                  },
                  child: CategoryItem(
                    image: 'https://img.icons8.com/ios/2x/trousers.png',
                    name: "Pants",
                  ),
                ),

                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) =>
                            ProductList(category: "Accessories")));
                  },
                  child: CategoryItem(
                    image: 'https://img.icons8.com/ios/2x/apple-watch.png',
                    name: "Accessories",
                  ),
                ),

                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => ProductList(category: "Helmet")));
                  },
                  child: CategoryItem(
                    image: 'https://img.icons8.com/ios/2x/motorbike-helmet.png',
                    name: "Helmet",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _recommendProduct() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Recommended",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "View more",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    // InkWell(
                    //     onTap: () {},
                    //     child: ProductItem(
                    //       image:
                    //           "https://redcanoebrands.com/wp-content/uploads/2013/11/cessna-blue-tshirt-416x416.jpg",
                    //       price: 150000,
                    //       name: "Kaos 1",
                    //     )),
                    // InkWell(
                    //   onTap: () {},
                    //   child: ProductItem(
                    //     image:
                    //         "https://redcanoebrands.com/wp-content/uploads/2013/11/cessna-blue-tshirt-416x416.jpg",
                    //     price: 115000,
                    //     name: "Kaos 2",
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _newProduct() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "New Product",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "View more",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    // InkWell(
                    //   onTap: () {},
                    //   child: ProductItem(
                    //     image:
                    //         "https://redcanoebrands.com/wp-content/uploads/2013/11/cessna-blue-tshirt-416x416.jpg",
                    //     price: 150000,
                    //     name: "Kaos 3",
                    //   ),
                    // ),
                    // InkWell(
                    //   onTap: () {},
                    //   child: ProductItem(
                    //     image:
                    //         "https://redcanoebrands.com/wp-content/uploads/2013/11/cessna-blue-tshirt-416x416.jpg",
                    //     price: 130000,
                    //     name: "Kaos 4",
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
