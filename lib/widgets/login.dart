import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:online_shop/pages/home/home_screen.dart';
import 'package:online_shop/services/authentication.dart';

import '../size_config.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String error = "";
  bool passwordVisible = false;
  bool isLoading = false;
  void _loadingbutton() {
    setState(() {
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 5,
          ),
          errorMessageLogin != null ? showAlert() : Container(),
          Text(
            "Welcome To",
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF1C1C1C),
              height: 2,
            ),
          ),
          Text(
            "TOKO KITA",
            style: TextStyle(
              fontSize: 32,
              color: Color(0xFF1C1C1C),
              height: 1,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          Text(
            "Please Login to Continue",
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF1C1C1C),
              height: 1,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          TextFormField(
            controller: emailController,
            validator: (value) => EmailValidator.validate(value)
                ? null
                : "Please enter a valid email",
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
                color: Color(0xFF45D1FD),
                fontWeight: FontWeight.bold,
                fontSize: 16),
            decoration: InputDecoration(
                hintText: "Email",
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF45D1FD),
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    )),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: Color(0xFF45D1FD), width: 2),
                ),
                prefixIcon:
                    Icon(Icons.email_outlined, color: Color(0xFF45D1FD)),
                filled: true,
                fillColor: Color(0xFF1B5163),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 0,
                )),
            onChanged: (value) {},
          ),
          SizedBox(
            height: 16,
          ),
          //Password
          TextFormField(
            controller: passwordController,
            keyboardType: TextInputType.text,
            obscureText: !passwordVisible,
            style: TextStyle(
                color: Color(0xFF45D1FD),
                fontWeight: FontWeight.bold,
                fontSize: 16),
            decoration: InputDecoration(
                hintText: "Password",
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF45D1FD),
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    )),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: Color(0xFF45D1FD), width: 2),
                ),
                prefixIcon: Icon(Icons.lock, color: Color(0xFF45D1FD)),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                  child: Icon(
                    passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color:
                        passwordVisible ? Color(0xFF45D1FD) : Color(0xFFE6E6E6),
                  ),
                ),
                filled: true,
                fillColor: Color(0xFF1B5163),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 0,
                )),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          SizedBox(
            height: 24,
          ),
          isLoading == false
              ? Container(
                  width: double.infinity,
                  height: 50,
                  child: RaisedButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        signInWithEmailAndPassword(
                                emailController.text, passwordController.text)
                            .then((result) {
                          if (result != null) {
                            _loadingbutton();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return HomeScreen();
                                },
                              ),
                            );
                          }
                        });
                      } else {
                        setState(() {
                          errorMessageLogin = errorMessageLogin;
                        });
                      }
                    },
                    color: Color(0xFF1C1C1C),
                    elevation: 9.0,
                    splashColor: Colors.blue[200],
                    child: Center(
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF45D1FD),
                        ),
                      ),
                    ),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
          SizedBox(
            height: 50,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Column(
          //       children: [
          //         SizedBox(
          //           height: 20,
          //         ),
          //         Text(
          //           "or Sign in With",
          //           textAlign: TextAlign.center,
          //           style: TextStyle(
          //             fontSize: 16,
          //             color: Color(0xFF1C1C1C),
          //             height: 1,
          //           ),
          //         ),
          //
          //         // Row(
          //         //   mainAxisAlignment: MainAxisAlignment.center,
          //         //   children: [
          //         //     GestureDetector(
          //         //       onTap: () {
          //         //         signInWithGoogle().then((result) {
          //         //           if (result != null) {
          //         //             Navigator.of(context).push(
          //         //               MaterialPageRoute(
          //         //                 builder: (context) {
          //         //                   return HomeScreen();
          //         //                 },
          //         //               ),
          //         //             );
          //         //           }
          //         //         });
          //         //       },
          //         //       child: Container(
          //         //         margin: EdgeInsets.symmetric(
          //         //             horizontal: getProportionateScreenWidth(10)),
          //         //         padding:
          //         //             EdgeInsets.all(getProportionateScreenWidth(12)),
          //         //         height: getProportionateScreenHeight(50),
          //         //         width: getProportionateScreenWidth(50),
          //         //         decoration: BoxDecoration(
          //         //           color: Color(0xFFF5F6F9),
          //         //           shape: BoxShape.circle,
          //         //         ),
          //         //         child:
          //         //             SvgPicture.asset("assets/icons/google-icon.svg"),
          //         //       ),
          //         //     ),
          //         //   ],
          //         // ),
          //         // IconButton(
          //         //   onPressed: () {
          //         //     signInWithGoogle().then((result) {
          //         //       if (result != null) {
          //         //         Navigator.of(context).push(
          //         //           MaterialPageRoute(
          //         //             builder: (context) {
          //         //               return HomeScreen();
          //         //             },
          //         //           ),
          //         //         );
          //         //       }
          //         //     });
          //         //   },
          //         //   icon: Icon(
          //         //     Entypo.google__with_circle,
          //         //     size: 40,
          //         //     color: Color(0xFF45D1FD),
          //         //   ),
          //         // ),
          //       ],
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  Widget showAlert() {
    setState(() {
      errorMessageLogin = errorMessageLogin;
    });
    if (errorMessageLogin != null) {
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(
              child: AutoSizeText(
                errorMessageLogin,
                maxLines: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      errorMessageLogin = null;
                    });
                  }),
            )
          ],
        ),
      );
    }
    return SizedBox(
      height: 0,
    );
  }
}
