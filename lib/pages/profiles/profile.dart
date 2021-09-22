import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_shop/widgets/coustom_bottom_nav_bar.dart';
import '../../enums.dart';
import 'components/stack_container.dart';

class Profiles extends StatefulWidget {
  @override
  _ProfilesState createState() => _ProfilesState();
}

FirebaseFirestore firestore = FirebaseFirestore.instance;

class _ProfilesState extends State<Profiles> {
  CollectionReference orders = firestore.collection("orders");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StackContainer(),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
