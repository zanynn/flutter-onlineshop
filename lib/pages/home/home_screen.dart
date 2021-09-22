import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_shop/pages/cart/cart_screen.dart';
import 'package:online_shop/pages/product_discover.dart';
import 'package:online_shop/services/authentication.dart';
import 'package:online_shop/widgets/coustom_bottom_nav_bar.dart';
import 'package:online_shop/pages/order_history/order_list.dart';
import 'package:online_shop/services/databases.dart';

import '../../enums.dart';
import '../login_page.dart';
import 'components/body.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("MZ.ID"),
        actions: [
          // IconButton(icon: Icon(Icons.th),),
          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => ProductDiscovery()));
            },
            child: Container(
              child: SvgPicture.asset(
                "assets/icons/Discover.svg",
                color: Color(0xFF939393),
                width: 45,
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              await getUserLevel();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => CartScreen()));
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: SvgPicture.asset(
                "assets/icons/Cart Icon.svg",
                color: Color(0xFF939393),
                width: 35,
              ),
            ),
          ),
        ],
      ),
      body: Body(),
      drawer: _drawer(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }

  Widget _drawer() {
    return Drawer(
      child: ListView(
        children: [
          Container(
            child: Stack(
              children: <Widget>[
                Image.network(
                  "https://thumbs.dreamstime.com/b/geometric-modern-blue-yellow-background-aesthetic-wallpaper-geometric-modern-blue-yellow-background-205229466.jpg",
                ),
                UserAccountsDrawerHeader(
                  margin: const EdgeInsets.only(top: 35.0),
                  accountName:
                      Text(name, style: TextStyle(color: Colors.white)),
                  currentAccountPicture: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(imageUrl),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  accountEmail: Text(
                    email,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          //
          ListTile(
            title: Text('Home'),
            leading: Icon(Icons.home),
            onTap: () {
              setState(() {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              });
            },
          ),
          ListTile(
            title: Text('Cart'),
            leading: Icon(Icons.shopping_cart),
            onTap: () {
              setState(() {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => CartScreen()));
              });
            },
          ),
          ListTile(
            title: Text('Order History'),
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
}
