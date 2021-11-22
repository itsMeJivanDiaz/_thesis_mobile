import 'package:cimo_mobile/mobile_login.dart';
import 'package:cimo_mobile/mobile_sign_up.dart';
import 'package:cimo_mobile/sign_up.dart';
import 'package:flutter/material.dart';

class FinalSignUp extends StatefulWidget {
  String region = '';
  String province = '';
  String city = '';
  String brgy = '';
  FinalSignUp({
    required this.region,
    required this.province,
    required this.city,
    required this.brgy,
  });

  @override
  _FinalSignUpState createState() => _FinalSignUpState();
}

class _FinalSignUpState extends State<FinalSignUp> {
  final GlobalKey<FormFieldState> _formkey = GlobalKey();
  final _usertext = TextEditingController();
  final _userpass = TextEditingController();
  String username = '';
  String password = '';

  void signing() async {
    Signupquery signer = Signupquery(
      region: widget.region,
      province: widget.province,
      city: widget.city,
      brgy: widget.brgy,
      username: username,
      password: password,
    );
    await signer.postreq();
    if (signer.status == "Account creation success") {
      Future.delayed(Duration(seconds: 1), () {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(signer.status)));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MobileLogin()));
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(signer.status)));
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Some sign up logo'),
            Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _usertext,
                    onChanged: (value) {
                      setState(() {
                        username = value;
                      });
                    },
                    style: TextStyle(
                      fontFamily: 'Montserrat-R',
                      color: Color(0xff616161),
                      fontSize: 13,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Username',
                      hintStyle: TextStyle(
                        fontFamily: 'Montserrat-R',
                        color: Color(0xff616161),
                        fontSize: 13,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      filled: true,
                      fillColor: Color(0xffff5f5f5),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.perm_identity,
                        size: 16,
                        color: Color(0xffFF6E00),
                      ),
                    ),
                  ),
                  TextFormField(
                    obscureText: true,
                    autocorrect: false,
                    enableSuggestions: false,
                    controller: _userpass,
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    style: TextStyle(
                      fontFamily: 'Montserrat-R',
                      color: Color(0xff616161),
                      fontSize: 13,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        fontFamily: 'Montserrat-R',
                        color: Color(0xff616161),
                        fontSize: 13,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      filled: true,
                      fillColor: Color(0xffff5f5f5),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.lock_rounded,
                        size: 16,
                        color: Color(0xffFF6E00),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color(0xffff6e00),
                      ),
                      foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.white,
                      ),
                      minimumSize: MaterialStateProperty.all<Size>(
                        Size(MediaQuery.of(context).size.width / 2.2, 45),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (username.isEmpty || password.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.amber,
                            duration: Duration(seconds: 3),
                            content: Text('not good'),
                          ),
                        );
                      } else if (username.isNotEmpty && password.isNotEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.amber,
                            duration: Duration(seconds: 3),
                            content: Text('Process'),
                          ),
                        );
                        signing();
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2.2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(
                            Icons.badge_rounded,
                            size: 20,
                          ),
                          Text(
                            'SIGN UP',
                            style: TextStyle(
                              fontFamily: 'Montserrat-B',
                              fontSize: 12,
                            ),
                          ),
                          Icon(
                            Icons.edit_rounded,
                            size: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
