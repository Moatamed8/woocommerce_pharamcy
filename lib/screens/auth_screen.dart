import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:pharmacypk/constant/c_color.dart';
import 'package:pharmacypk/constant/config.dart';
import 'package:woocommerce/woocommerce.dart';

import 'homepage.dart';

class AuthScreen extends StatefulWidget {

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  WooCommerce woocommerce = WooCommerce(
      baseUrl: Config.url,
      consumerKey: Config.key,
      consumerSecret: Config.secret);

  final GlobalKey<FormState> _formKey = GlobalKey();
  bool hidePassword = true;
  bool _isLoading = false;
  bool isSignupScreen = true;
  bool isRememberMe = false;

  String _userName = "";
  String _email = "";
  String _password = "";

  void _submit() async {
    final isValid = _formKey.currentState.validate();
    //for close keyboard
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
      if (isSignupScreen) {
        setState(() {
          _isLoading = true;
        });
        WooCustomer user = WooCustomer(
            username: _userName, password: _password, email: _email);
        final result =
        woocommerce.createCustomer(user).then(
                (_) {
              setState(() {
                _isLoading = false;
              });
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => HomePage()));
            },).catchError((e)=>print(e));
      }
      else {
        setState(() {
          _isLoading = true;
        });

        final token = woocommerce.authenticateViaJWT(
            username: _userName, password: _password);

        final customer = woocommerce.loginCustomer(
            username: _userName, password: _password);

        bool isLoggedIn = await woocommerce.isCustomerLoggedIn();

        if (isLoggedIn) {

          setState(() {
            _isLoading = false;
          });

          print("SUCCESS");

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => HomePage()));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: PColor.backgroundColor,
          body: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/auth_background.jpg"),
                          fit: BoxFit.fill)),
                  child: Container(
                    padding: EdgeInsets.only(top: 90, left: 20),
                    color: Color(0xFF28afb1).withOpacity(.85),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                              text: "Welcome to",
                              style: TextStyle(
                                fontSize: 25,
                                letterSpacing: 2,
                                color: Colors.yellow[700],
                              ),
                              children: [
                                TextSpan(
                                  text:
                                  isSignupScreen ? " myPharmacy.Pk," : " Back,",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.yellow[700],
                                  ),
                                )
                              ]),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          isSignupScreen
                              ? "Sign Up to Continue"
                              : "Sign In to Continue",
                          style: TextStyle(
                            letterSpacing: 1,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              buildBottomHalfContainer(true),
              //Main Contianer for Login and Signup
              AnimatedPositioned(
                duration: Duration(milliseconds: 700),
                curve: Curves.bounceInOut,
                top: isSignupScreen ? 200 : 230,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 700),
                  curve: Curves.bounceInOut,
                  height: isSignupScreen ? 350 : 250,
                  padding: EdgeInsets.all(20),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width - 40,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 15,
                            spreadRadius: 5),
                      ]),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSignupScreen = false;
                                });
                              },
                              child: Column(
                                children: [
                                  Text(
                                    "LOGIN",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: !isSignupScreen
                                            ? PColor.activeColor
                                            : PColor.textColor1),
                                  ),
                                  if (!isSignupScreen)
                                    Container(
                                      margin: EdgeInsets.only(top: 3),
                                      height: 2,
                                      width: 55,
                                      color: Colors.orange,
                                    )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSignupScreen = true;
                                });
                              },
                              child: Column(
                                children: [
                                  Text(
                                    "SIGNUP",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: isSignupScreen
                                            ? PColor.activeColor
                                            : PColor.textColor1),
                                  ),
                                  if (isSignupScreen)
                                    Container(
                                      margin: EdgeInsets.only(top: 3),
                                      height: 2,
                                      width: 55,
                                      color: Colors.orange,
                                    )
                                ],
                              ),
                            )
                          ],
                        ),

                        //for sign in and up
                        Container(
                          child: Form(
                            key: _formKey,
                            child: SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  if (isSignupScreen)

                                    Padding(
                                    padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                    child: TextFormField(
                                      key: ValueKey('email'),
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.mail_outline,
                                          color: PColor.iconColor,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide:
                                          BorderSide(color: PColor.textColor1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(35.0)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                          BorderSide(color: PColor.textColor1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(35.0)),
                                        ),
                                        contentPadding: EdgeInsets.all(10),
                                        hintText: 'please enter your email...',
                                        labelText: 'Email',
                                        labelStyle: TextStyle(
                                            fontSize: 18,
                                            color: PColor.activeColor),
                                        hintStyle: TextStyle(
                                            fontSize: 14, color: PColor.textColor1),
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Invalid email!';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        _email = value;
                                      },
                                    ),
                                  ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                      child: TextFormField(
                                        key: ValueKey('username'),
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            MaterialCommunityIcons.account,
                                            color: PColor.iconColor,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: PColor.textColor1),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(35.0)),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: PColor.textColor1),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(35.0)),
                                          ),
                                          contentPadding: EdgeInsets.all(10),
                                          labelText: 'User Name',
                                          labelStyle: TextStyle(
                                              fontSize: 18,
                                              color: PColor.activeColor),
                                          hintText: 'please enter your name...',
                                          hintStyle: TextStyle(
                                              fontSize: 14,
                                              color: PColor.textColor1),
                                        ),
                                        validator: (value) {
                                          if (value.isEmpty || value.length < 4) {
                                            return 'please enter at least 4 characters';
                                          }
                                          return null;
                                        },
                                        onSaved: (val) => _userName = val,
                                      ),
                                    ),
                                  /*if (isSignupScreen)
                                    Padding(
                                      padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                      child: TextFormField(
                                        enabled: isSignupScreen,
                                        key: ValueKey('phone'),
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            MaterialCommunityIcons.phone,
                                            color: PColor.iconColor,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: PColor.textColor1),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(35.0)),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: PColor.textColor1),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(35.0)),
                                          ),
                                          contentPadding: EdgeInsets.all(10),
                                          labelText: 'Phone Number',
                                          labelStyle: TextStyle(
                                              fontSize: 18,
                                              color: PColor.activeColor),
                                          hintText:
                                          'please enter your phone Number...',
                                          hintStyle: TextStyle(
                                              fontSize: 14,
                                              color: PColor.textColor1),
                                        ),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'please enter a vaild phone number';
                                          }
                                          return null;
                                        },
                                        onSaved: (val) => _phoneNumber = val,
                                      ),
                                    ),*/
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                    child: TextFormField(
                                      key: ValueKey('password'),
                                      decoration: InputDecoration(
                                        suffixIcon:IconButton(
                                          icon:hidePassword?Icon(Icons.visibility):Icon(Icons.visibility_off),
                                          color: PColor.primaryColor,
                                          onPressed: (){
                                            setState(() {
                                              hidePassword=!hidePassword;
                                            });
                                          },
                                        ),
                                        prefixIcon: Icon(
                                          MaterialCommunityIcons.lock_outline,
                                          color: PColor.iconColor,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide:
                                          BorderSide(color: PColor.textColor1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(35.0)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                          BorderSide(color: PColor.textColor1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(35.0)),
                                        ),
                                        contentPadding: EdgeInsets.all(10),
                                        labelText: 'Password',
                                        labelStyle: TextStyle(
                                            fontSize: 18,
                                            color: PColor.activeColor),
                                        hintText: 'please enter your password...',
                                        hintStyle: TextStyle(
                                            fontSize: 14, color: PColor.textColor1),
                                      ),
                                      obscureText: hidePassword,
                                      validator: (value) {
                                        if (value.isEmpty || value.length < 7) {
                                          return 'Password is too short!';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        _password = value;
                                      },
                                    ),
                                  ),
                                  if (!isSignupScreen)
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Checkbox(
                                                value: isRememberMe,
                                                activeColor: PColor.textColor2,
                                                onChanged: (value) {
                                                  setState(() {
                                                    isRememberMe = !isRememberMe;
                                                  });
                                                },
                                              ),
                                              Text("Remember me",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: PColor.textColor1))
                                            ],
                                          ),
                                          TextButton(
                                            onPressed: () {},
                                            child: Text("Forgot Password?",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: PColor.textColor1)),
                                          )
                                        ],
                                      ),
                                    ),
                                  if (isSignupScreen)
                                    Container(
                                      width: 200,
                                      margin: EdgeInsets.only(top: 20),
                                      child: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                            text:
                                            "By pressing 'Submit' you agree to our ",
                                            style:
                                            TextStyle(color: PColor.textColor2),
                                            children: [
                                              TextSpan(
                                                //recognizer: ,
                                                text: "term & conditions",
                                                style:
                                                TextStyle(color: Colors.orange),
                                              ),
                                            ]),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Trick to add the submit button
              buildBottomHalfContainer(false),
              // Bottom buttons
              Positioned(
                top: MediaQuery
                    .of(context)
                    .size
                    .height - 100,
                right: 0,
                left: 0,
                child: Column(
                  children: [
                    Text(isSignupScreen ? "Or SignUp with" : "Or SignIn with"),
                    Container(
                      margin: EdgeInsets.only(right: 20, left: 20, top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildTextButton(MaterialCommunityIcons.facebook,
                              "Facebook", PColor.facebookColor),
                          buildTextButton(MaterialCommunityIcons.google_plus,
                              "Google", PColor.googleColor),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),

      ),
    );
  }

  TextButton buildTextButton(IconData icon, String title,
      Color backgroundColor) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
          side: BorderSide(width: 1, color: Colors.grey),
          minimumSize: Size(145, 40),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          primary: Colors.white,
          backgroundColor: backgroundColor),
      child: Row(
        children: [
          Icon(
            icon,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            title,
          )
        ],
      ),
    );
  }

  Widget buildBottomHalfContainer(bool showShadow) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 700),
      curve: Curves.bounceInOut,
      top: isSignupScreen ? 510: 430,
      right: 0,
      left: 0,
      child: Center(
        child: Container(
          height: 90,
          width: 90,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                if (showShadow)
                  BoxShadow(
                    color: Colors.black.withOpacity(.3),
                    spreadRadius: 1.5,
                    blurRadius: 10,
                  )
              ]),
          child: !showShadow
              ? Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [PColor.primaryColor, PColor.primaryColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(.3),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 1))
                ]),
            child: _isLoading
                ? CircularProgressIndicator()
                : IconButton(
              icon: Icon(Icons.arrow_forward),
              color: Colors.white,
              onPressed: _submit,
            ),
          )
              : Center(),
        ),
      ),
    );
  }
}
