import 'package:cimo_mobile/get_json_addr.dart';
import 'package:cimo_mobile/mobile_final_sign_up.dart';
import 'package:cimo_mobile/mobile_login.dart';
import 'package:cimo_mobile/selection.dart';
import 'package:cimo_mobile/sign_up.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SignUp extends StatefulWidget {
  Map<String, dynamic> data = Map();
  SignUp({required this.data});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();
  String _user = '';
  String _pass = '';
  Map<String, dynamic> jsonaddr = Map();
  String _selectedRegion = 'Select region';
  String _selectedProvince = 'Select province';
  String _selectedCity = 'Select city';
  String _selectedBrgy = 'Select barangay';
  List<String> provinces = [];
  List<String> province_list = [];
  List<String> city_list = [];
  List<dynamic> brgy_list = [];
  List<String> cvt_List = [];
  List<String> region = [
    'REGION I',
    'REGION II',
    'REGION III',
    'REGION IV-A',
    'REGION IV-B',
    'REGION V',
    'REGION VI',
    'REGION VII',
    'REGION VIII',
    'REGION IX',
    'REGION X',
    'REGION XI',
    'REGION XII',
    'REGION XIII',
    'BARMM',
    'CAR',
    'NCR',
  ];
  final _formsPageViewController = PageController();

  void sign() async {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.hourglass_bottom,
              size: 15,
              color: Color(0xffff6e00),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              'Processing',
              style: TextStyle(
                fontFamily: 'Montserrat-R',
                color: Color(0xff573240),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        behavior: SnackBarBehavior.floating,
      ),
    );
    Signupquery signup = Signupquery(
      region: _selectedRegion,
      province: _selectedProvince,
      city: _selectedCity,
      brgy: _selectedBrgy,
      username: _user,
      password: _pass,
    );
    await signup.postreq();
    Future.delayed(Duration(seconds: 1), () {
      if (signup.status == 'Account creation success') {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 2),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.check_rounded,
                  size: 15,
                  color: Color(0xffff6e00),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Sign up success',
                  style: TextStyle(
                    fontFamily: 'Montserrat-R',
                    color: Color(0xff573240),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.white,
            behavior: SnackBarBehavior.floating,
          ),
        );
        Future.delayed(Duration(seconds: 1), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MobileLogin(),
            ),
          );
        });
      } else {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 2),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.bug_report_rounded,
                  size: 15,
                  color: Color(0xffff6e00),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  signup.status,
                  style: TextStyle(
                    fontFamily: 'Montserrat-R',
                    color: Color(0xff573240),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.white,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    jsonaddr = widget.data;
  }

  List _forms = [];

  @override
  Widget build(BuildContext context) {
    _forms = [
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          WillPopScope(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                children: <Widget>[
                  SafeArea(
                    child: Container(
                      height: 35,
                      padding: EdgeInsets.zero,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: () {
                            onWillpop();
                          },
                          icon: Icon(
                            Icons.keyboard_backspace_rounded,
                            color: Color(0xff573240),
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Let\'s get started!',
                        style: TextStyle(
                          fontFamily: 'Montserrat-B',
                          color: Color(0xff573240),
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Please answer the following input fields.',
                        style: TextStyle(
                          fontFamily: 'Montserrat-R',
                          color: Color(0xff616161),
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    child: Image(
                      image: AssetImage(
                        'assets/images/region.png',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
                      height: MediaQuery.of(context).size.height / 3.3,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Sign up Form',
                              style: TextStyle(
                                fontFamily: 'Montserrat-B',
                                color: Color(0xffFF6E00),
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5, bottom: 5),
                            height: 1,
                            width: MediaQuery.of(context).size.width,
                            color: Color(0xffFF6E00),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          DropdownButtonFormField(
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 15,
                              color: Color(0xff616161),
                            ),
                            isExpanded: true,
                            items: region.map(
                              (String value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                      fontFamily: 'Montserrat-R',
                                      fontSize: 13,
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                            onChanged: (value) {
                              setState(
                                () {
                                  _selectedBrgy = 'Selected barangay';
                                  _selectedCity = 'Selected city';
                                  _selectedProvince = 'Select province';
                                  _selectedRegion = value.toString();
                                  province_list = (jsonaddr[value]
                                          ['province_list']
                                      .keys
                                      .toList());
                                },
                              );
                            },
                            decoration: InputDecoration(
                              hintText: _selectedRegion,
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
                              prefixIcon: Container(
                                width: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                  ),
                                  color: Colors.transparent,
                                ),
                                height: 45,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          bottomLeft: Radius.circular(15),
                                        ),
                                        color: Color(0xffA9D8D5),
                                      ),
                                      height: 47,
                                      width: 47,
                                      child: Icon(
                                        Icons.place_rounded,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 130),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Color(0xffff6e00),
                                  ),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Colors.white,
                                  ),
                                  minimumSize: MaterialStateProperty.all<Size>(
                                    Size(MediaQuery.of(context).size.width / 2,
                                        45),
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  _nextFormStep();
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.2,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Icon(
                                        Icons.run_circle,
                                        size: 20,
                                      ),
                                      Text(
                                        'Next Step',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat-B',
                                          fontSize: 15,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_rounded,
                                        size: 15,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: 20,
                                  height: 3,
                                  decoration: BoxDecoration(
                                    color: Color(0xffff6e00),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: 20,
                                  height: 3,
                                  decoration: BoxDecoration(
                                    color: Color(0xff616161),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: 20,
                                  height: 3,
                                  decoration: BoxDecoration(
                                    color: Color(0xff616161),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: 20,
                                  height: 3,
                                  decoration: BoxDecoration(
                                    color: Color(0xff616161),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: 20,
                                  height: 3,
                                  decoration: BoxDecoration(
                                    color: Color(0xff616161),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            onWillPop: () => Future.sync(this.onWillpop),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: 'Montserrat-R',
                        color: Color(0xff616161),
                        fontSize: 13,
                      ),
                      children: [
                        TextSpan(
                          text: 'Already have an account? Please, log in ',
                        ),
                        TextSpan(
                          text: 'HERE',
                          style: TextStyle(
                            color: Color(0xffFF6E00),
                            fontFamily: 'Montserrat-B',
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MobileLogin(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          WillPopScope(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                children: <Widget>[
                  SafeArea(
                    child: Container(
                      height: 35,
                      padding: EdgeInsets.zero,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: () {
                            onWillpop();
                          },
                          icon: Icon(
                            Icons.keyboard_backspace_rounded,
                            color: Color(0xff573240),
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Just a few more steps',
                        style: TextStyle(
                          fontFamily: 'Montserrat-B',
                          color: Color(0xff573240),
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'This will help us in finding your location.',
                        style: TextStyle(
                          fontFamily: 'Montserrat-R',
                          color: Color(0xff616161),
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    child: Image(
                      height: MediaQuery.of(context).size.height / 3,
                      image: AssetImage(
                        'assets/images/province.png',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
                      height: MediaQuery.of(context).size.height / 3.3,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Sign up Form',
                              style: TextStyle(
                                fontFamily: 'Montserrat-B',
                                color: Color(0xffFF6E00),
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5, bottom: 5),
                            height: 1,
                            width: MediaQuery.of(context).size.width,
                            color: Color(0xffFF6E00),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          DropdownButtonFormField(
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 15,
                              color: Color(0xff616161),
                            ),
                            isExpanded: true,
                            items: _selectedRegion == 'Select region'
                                ? ['Select region first'].map(
                                    (String value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                            fontFamily: 'Montserrat-R',
                                            fontSize: 13,
                                          ),
                                        ),
                                      );
                                    },
                                  ).toList()
                                : province_list.map(
                                    (String value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                            fontFamily: 'Montserrat-R',
                                            fontSize: 13,
                                          ),
                                        ),
                                      );
                                    },
                                  ).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedBrgy = 'Selected barangay';
                                _selectedCity = 'Selected city';
                                _selectedProvince = value.toString();
                                city_list = jsonaddr[_selectedRegion]
                                            ['province_list'][_selectedProvince]
                                        ['municipality_list']
                                    .keys
                                    .toList();
                              });
                            },
                            decoration: InputDecoration(
                              hintText: _selectedProvince,
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
                              prefixIcon: Container(
                                width: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                  ),
                                  color: Colors.transparent,
                                ),
                                height: 45,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          bottomLeft: Radius.circular(15),
                                        ),
                                        color: Color(0xffA9D8D5),
                                      ),
                                      height: 47,
                                      width: 47,
                                      child: Icon(
                                        Icons.place_rounded,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 130),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Color(0xffff6e00),
                                  ),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Colors.white,
                                  ),
                                  minimumSize: MaterialStateProperty.all<Size>(
                                    Size(MediaQuery.of(context).size.width / 2,
                                        45),
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  _nextFormStep();
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.2,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Icon(
                                        Icons.run_circle,
                                        size: 20,
                                      ),
                                      Text(
                                        'Next Step',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat-B',
                                          fontSize: 15,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_rounded,
                                        size: 15,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: 20,
                                  height: 3,
                                  decoration: BoxDecoration(
                                    color: Color(0xff616161),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: 20,
                                  height: 3,
                                  decoration: BoxDecoration(
                                    color: Color(0xffff6e00),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: 20,
                                  height: 3,
                                  decoration: BoxDecoration(
                                    color: Color(0xff616161),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: 20,
                                  height: 3,
                                  decoration: BoxDecoration(
                                    color: Color(0xff616161),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: 20,
                                  height: 3,
                                  decoration: BoxDecoration(
                                    color: Color(0xff616161),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            onWillPop: () => Future.sync(this.onWillpop),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: 'Montserrat-R',
                        color: Color(0xff616161),
                        fontSize: 13,
                      ),
                      children: [
                        TextSpan(
                          text: 'Already have an account? Please, log in ',
                        ),
                        TextSpan(
                          text: 'HERE',
                          style: TextStyle(
                            color: Color(0xffFF6E00),
                            fontFamily: 'Montserrat-B',
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MobileLogin(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          WillPopScope(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                children: <Widget>[
                  SafeArea(
                    child: Container(
                      height: 35,
                      padding: EdgeInsets.zero,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: () {
                            onWillpop();
                          },
                          icon: Icon(
                            Icons.keyboard_backspace_rounded,
                            color: Color(0xff573240),
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Almost There!',
                        style: TextStyle(
                          fontFamily: 'Montserrat-B',
                          color: Color(0xff573240),
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Tell us more about where you’re from..',
                        style: TextStyle(
                          fontFamily: 'Montserrat-R',
                          color: Color(0xff616161),
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    child: Image(
                      height: MediaQuery.of(context).size.height / 3,
                      image: AssetImage(
                        'assets/images/city.png',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
                      height: MediaQuery.of(context).size.height / 3.3,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Sign up Form',
                              style: TextStyle(
                                fontFamily: 'Montserrat-B',
                                color: Color(0xffFF6E00),
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5, bottom: 5),
                            height: 1,
                            width: MediaQuery.of(context).size.width,
                            color: Color(0xffFF6E00),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          DropdownButtonFormField(
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 15,
                              color: Color(0xff616161),
                            ),
                            isExpanded: true,
                            items: _selectedProvince == 'Select province'
                                ? ['Select region first'].map(
                                    (String value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                            fontFamily: 'Montserrat-R',
                                            fontSize: 13,
                                          ),
                                        ),
                                      );
                                    },
                                  ).toList()
                                : city_list.map(
                                    (String value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                            fontFamily: 'Montserrat-R',
                                            fontSize: 13,
                                          ),
                                        ),
                                      );
                                    },
                                  ).toList(),
                            onChanged: (value) {
                              setState(
                                () {
                                  _selectedBrgy = 'Selected barangay';
                                  cvt_List = [];
                                  _selectedCity = value.toString();
                                  brgy_list = jsonaddr[_selectedRegion]
                                                  ['province_list']
                                              [_selectedProvince]
                                          ['municipality_list'][_selectedCity]
                                      ['barangay_list'];
                                  brgy_list.forEach((value) {
                                    cvt_List.add(value);
                                  });
                                },
                              );
                            },
                            decoration: InputDecoration(
                              hintText: _selectedCity,
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
                              prefixIcon: Container(
                                width: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                  ),
                                  color: Colors.transparent,
                                ),
                                height: 45,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          bottomLeft: Radius.circular(15),
                                        ),
                                        color: Color(0xffA9D8D5),
                                      ),
                                      height: 47,
                                      width: 47,
                                      child: Icon(
                                        Icons.place_rounded,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 130),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Color(0xffff6e00),
                                  ),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Colors.white,
                                  ),
                                  minimumSize: MaterialStateProperty.all<Size>(
                                    Size(MediaQuery.of(context).size.width / 2,
                                        45),
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  _nextFormStep();
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.2,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Icon(
                                        Icons.run_circle,
                                        size: 20,
                                      ),
                                      Text(
                                        'Next Step',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat-B',
                                          fontSize: 15,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_rounded,
                                        size: 15,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: 20,
                                  height: 3,
                                  decoration: BoxDecoration(
                                    color: Color(0xff616161),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: 20,
                                  height: 3,
                                  decoration: BoxDecoration(
                                    color: Color(0xff616161),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: 20,
                                  height: 3,
                                  decoration: BoxDecoration(
                                    color: Color(0xffff6e00),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: 20,
                                  height: 3,
                                  decoration: BoxDecoration(
                                    color: Color(0xff616161),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: 20,
                                  height: 3,
                                  decoration: BoxDecoration(
                                    color: Color(0xff616161),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            onWillPop: () => Future.sync(this.onWillpop),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: 'Montserrat-R',
                        color: Color(0xff616161),
                        fontSize: 13,
                      ),
                      children: [
                        TextSpan(
                          text: 'Already have an account? Please, log in ',
                        ),
                        TextSpan(
                          text: 'HERE',
                          style: TextStyle(
                            color: Color(0xffFF6E00),
                            fontFamily: 'Montserrat-B',
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MobileLogin(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          WillPopScope(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                children: <Widget>[
                  SafeArea(
                    child: Container(
                      height: 35,
                      padding: EdgeInsets.zero,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: () {
                            onWillpop();
                          },
                          icon: Icon(
                            Icons.keyboard_backspace_rounded,
                            color: Color(0xff573240),
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'A little bit more.',
                        style: TextStyle(
                          fontFamily: 'Montserrat-B',
                          color: Color(0xff573240),
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'We’re almost done.',
                        style: TextStyle(
                          fontFamily: 'Montserrat-R',
                          color: Color(0xff616161),
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    child: Image(
                      height: MediaQuery.of(context).size.height / 3,
                      image: AssetImage(
                        'assets/images/barangay.png',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
                      height: MediaQuery.of(context).size.height / 3.3,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Sign up Form',
                              style: TextStyle(
                                fontFamily: 'Montserrat-B',
                                color: Color(0xffFF6E00),
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5, bottom: 5),
                            height: 1,
                            width: MediaQuery.of(context).size.width,
                            color: Color(0xffFF6E00),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          DropdownButtonFormField(
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 15,
                              color: Color(0xff616161),
                            ),
                            isExpanded: true,
                            items: _selectedCity == 'Selected barangay'
                                ? ['Select city first'].map(
                                    (String value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                            fontFamily: 'Montserrat-R',
                                            fontSize: 13,
                                          ),
                                        ),
                                      );
                                    },
                                  ).toList()
                                : cvt_List.map(
                                    (String value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                            fontFamily: 'Montserrat-R',
                                            fontSize: 13,
                                          ),
                                        ),
                                      );
                                    },
                                  ).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedBrgy = value.toString();
                              });
                            },
                            decoration: InputDecoration(
                              hintText: _selectedBrgy,
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
                              prefixIcon: Container(
                                width: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                  ),
                                  color: Colors.transparent,
                                ),
                                height: 45,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          bottomLeft: Radius.circular(15),
                                        ),
                                        color: Color(0xffA9D8D5),
                                      ),
                                      height: 47,
                                      width: 47,
                                      child: Icon(
                                        Icons.place_rounded,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 130),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Color(0xffff6e00),
                                  ),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Colors.white,
                                  ),
                                  minimumSize: MaterialStateProperty.all<Size>(
                                    Size(MediaQuery.of(context).size.width / 2,
                                        45),
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  _nextFormStep();
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.2,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Icon(
                                        Icons.run_circle,
                                        size: 20,
                                      ),
                                      Text(
                                        'Next Step',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat-B',
                                          fontSize: 15,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_rounded,
                                        size: 15,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: 20,
                                  height: 3,
                                  decoration: BoxDecoration(
                                    color: Color(0xff616161),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: 20,
                                  height: 3,
                                  decoration: BoxDecoration(
                                    color: Color(0xff616161),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: 20,
                                  height: 3,
                                  decoration: BoxDecoration(
                                    color: Color(0xff616161),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: 20,
                                  height: 3,
                                  decoration: BoxDecoration(
                                    color: Color(0xffff6e00),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: 20,
                                  height: 3,
                                  decoration: BoxDecoration(
                                    color: Color(0xff616161),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            onWillPop: () => Future.sync(this.onWillpop),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: 'Montserrat-R',
                        color: Color(0xff616161),
                        fontSize: 13,
                      ),
                      children: [
                        TextSpan(
                          text: 'Already have an account? Please, log in ',
                        ),
                        TextSpan(
                          text: 'HERE',
                          style: TextStyle(
                            color: Color(0xffFF6E00),
                            fontFamily: 'Montserrat-B',
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MobileLogin(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          WillPopScope(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                children: <Widget>[
                  SafeArea(
                    child: Container(
                      height: 35,
                      padding: EdgeInsets.zero,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: () {
                            onWillpop();
                          },
                          icon: Icon(
                            Icons.keyboard_backspace_rounded,
                            color: Color(0xff573240),
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Now, we’re on the last one!',
                        style: TextStyle(
                          fontFamily: 'Montserrat-B',
                          color: Color(0xff573240),
                          fontSize: 27,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Thank you for helping us.',
                        style: TextStyle(
                          fontFamily: 'Montserrat-R',
                          color: Color(0xff616161),
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    child: Image(
                      height: MediaQuery.of(context).size.height / 3,
                      image: AssetImage(
                        'assets/images/userpass.png',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
                      height: MediaQuery.of(context).size.height / 2.8,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Sign up Form',
                              style: TextStyle(
                                fontFamily: 'Montserrat-B',
                                color: Color(0xffFF6E00),
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5, bottom: 5),
                            height: 1,
                            width: MediaQuery.of(context).size.width,
                            color: Color(0xffFF6E00),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextField(
                            controller: user,
                            onChanged: (value) {
                              setState(() {
                                _user = value;
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
                              prefixIcon: Container(
                                width: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                  ),
                                  color: Colors.transparent,
                                ),
                                height: 45,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          bottomLeft: Radius.circular(15),
                                        ),
                                        color: Color(0xffA9D8D5),
                                      ),
                                      height: 47,
                                      width: 47,
                                      child: Icon(
                                        Icons.assignment_ind,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: pass,
                            obscureText: true,
                            autocorrect: false,
                            enableSuggestions: false,
                            onChanged: (value) {
                              setState(() {
                                _pass = value;
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
                              contentPadding: EdgeInsets.only(
                                  top: 0, bottom: 0, left: 0, right: 0),
                              filled: true,
                              fillColor: Color(0xffff5f5f5),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              prefixIcon: Container(
                                width: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                  ),
                                  color: Colors.transparent,
                                ),
                                height: 45,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          bottomLeft: Radius.circular(15),
                                        ),
                                        color: Color(0xffA9D8D5),
                                      ),
                                      height: 47,
                                      width: 47,
                                      child: Icon(
                                        Icons.lock_rounded,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 130),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Color(0xffff6e00),
                                  ),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Colors.white,
                                  ),
                                  minimumSize: MaterialStateProperty.all<Size>(
                                    Size(MediaQuery.of(context).size.width / 2,
                                        45),
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  if (_selectedRegion == 'Select region' ||
                                      _selectedProvince == 'Select region' ||
                                      _selectedCity == 'Select city' ||
                                      _selectedBrgy == 'Select barangay' ||
                                      _user == '' ||
                                      _pass == '') {
                                    ScaffoldMessenger.of(context)
                                        .removeCurrentSnackBar();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration: Duration(seconds: 2),
                                        content: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              Icons.error_rounded,
                                              size: 15,
                                              color: Color(0xffff6e00),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              'Empty fields are not allowed',
                                              style: TextStyle(
                                                fontFamily: 'Montserrat-R',
                                                color: Color(0xff573240),
                                              ),
                                            ),
                                          ],
                                        ),
                                        backgroundColor: Colors.white,
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  } else {
                                    sign();
                                  }
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.2,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Icon(
                                        Icons.check_circle_rounded,
                                        size: 20,
                                      ),
                                      Text(
                                        'Submit',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat-B',
                                          fontSize: 15,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_rounded,
                                        size: 15,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: 20,
                                  height: 3,
                                  decoration: BoxDecoration(
                                    color: Color(0xff616161),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: 20,
                                  height: 3,
                                  decoration: BoxDecoration(
                                    color: Color(0xff616161),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: 20,
                                  height: 3,
                                  decoration: BoxDecoration(
                                    color: Color(0xff616161),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: 20,
                                  height: 3,
                                  decoration: BoxDecoration(
                                    color: Color(0xff616161),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: 20,
                                  height: 3,
                                  decoration: BoxDecoration(
                                    color: Color(0xffff6e00),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            onWillPop: () => Future.sync(this.onWillpop),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: 'Montserrat-R',
                        color: Color(0xff616161),
                        fontSize: 13,
                      ),
                      children: [
                        TextSpan(
                          text: 'Already have an account? Please, log in ',
                        ),
                        TextSpan(
                          text: 'HERE',
                          style: TextStyle(
                            color: Color(0xffFF6E00),
                            fontFamily: 'Montserrat-B',
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MobileLogin(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ];

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Color(0xffFDF6EE),
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xffFDF6EE),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: PageView.builder(
            controller: _formsPageViewController,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return _forms[index];
            },
          ),
        ),
      ),
    );
  }

  void _nextFormStep() {
    _formsPageViewController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  bool onWillpop() {
    if (_formsPageViewController.page!.round() ==
        _formsPageViewController.initialPage) return true;

    _formsPageViewController.previousPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );

    return false;
  }
}
