import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:online_shop/services/authentication.dart';

import '../../login_page.dart';
import 'top_bar.dart';
import 'custom_clipper.dart';

class StackContainer extends StatelessWidget {
  const StackContainer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 670.0,
      child: Stack(
        children: <Widget>[
          Container(),
          ClipPath(
            clipper: MyCustomClipper(),
            child: Container(
              height: 350.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "https://thumbs.dreamstime.com/b/geometric-modern-blue-yellow-background-aesthetic-wallpaper-geometric-modern-blue-yellow-background-205229466.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, 1),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircularProfileAvatar(
                  imageUrl,
                  borderWidth: 4.0,
                  radius: 60.0,
                ),
                SizedBox(height: 4.0),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 21.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: FlatButton(
                    padding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    color: Color(0xFFF5F6F9),
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(Icons.email_outlined, color: Color(0xFF45D1FD)),
                        SizedBox(width: 20),
                        Expanded(child: Text(email)),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: FlatButton(
                    padding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    color: Color(0xFFF5F6F9),
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(Icons.phone_android_outlined,
                            color: Color(0xFF45D1FD)),
                        SizedBox(width: 20),
                        Expanded(child: Text(phone != null ? phone : "None")),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: FlatButton(
                    padding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    color: Color(0xFFF5F6F9),
                    onPressed: () {
                      signOutGoogle();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) {
                        return LoginPage();
                      }), ModalRoute.withName('/'));
                    },
                    child: Row(
                      children: [
                        Icon(Icons.login_outlined, color: Color(0xFF45D1FD)),
                        SizedBox(width: 20),
                        Expanded(child: Text("Logout")),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          TopBar(),
        ],
      ),
    );
  }
}
