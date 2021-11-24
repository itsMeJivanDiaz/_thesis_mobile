import 'package:cimo_mobile/establishment.dart';
import 'package:cimo_mobile/log_out.dart';
import 'package:cimo_mobile/prefs.dart';
import 'package:cimo_mobile/selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cimo_mobile/unsupported.dart';
import 'dart:math';
import 'package:cimo_mobile/search.dart';
import 'package:cimo_mobile/fetch_general.dart';
import 'package:cimo_mobile/specific_establishment.dart';
import 'package:cimo_mobile/ip.dart';

// ignore: must_be_immutable
class HomeView extends StatefulWidget {
  List data = [];
  List city = [];
  String? token = '';
  String? secretkey = '';
  String? id = '';
  HomeView({
    required this.data,
    required this.city,
    required this.token,
    required this.secretkey,
    required this.id,
  });
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List colors = [
    Color(0xffE0F1F0),
    Color(0xffFCF6ED),
  ];

  GetIp address = GetIp();

  Random rand = new Random();
  int coloridx = 0;
  bool load = false;

  final _searchcontroller = TextEditingController();

  Future<void> _refresh() async {
    // ignore: non_constant_identifier_names
    FetchGeneralData est_instance = FetchGeneralData(
      token: widget.token,
      key: widget.secretkey,
      id: widget.id,
    );
    await est_instance.getData();
    setState(() {
      widget.data = est_instance.data;
    });
  }

  void backto() async {
    Prefs logout_token = Prefs(value: '', key: '');
    await logout_token.getter('token');
    Prefs logout_key = Prefs(value: '', key: '');
    await logout_key.getter('key');
    LogOut lgout = LogOut(token: logout_token.res, key: logout_key.res);
    lgout.logout();
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Selection()),
      );
    });
  }

  void getSpecific(String id, String tag, String stats) async {
    if (stats == "Pending") {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
          elevation: 2,
          backgroundColor: Color(0xffFCF6ED),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.hourglass_top_sharp,
                size: 15,
                color: Color(0xffFF6E00),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Currently waiting for a barangay approval.',
                style: TextStyle(
                  fontFamily: 'Montserrat-R',
                  fontSize: 14,
                  color: Color(0xff583241),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(seconds: 1),
          pageBuilder: (context, __, _) => EstablishmentInfo(
            id: id,
            hero_tag: tag,
            token: widget.token,
            secretkey: widget.secretkey,
            devid: widget.id,
          ),
        ),
      );
    }
  }

  colorchange(index) {
    if (index % 2 == 0) {
      coloridx = 1;
    } else {
      coloridx = 0;
    }
    return coloridx;
  }

  String _indexvalue = '';

  String current = 'None';

  void _modalshow() {
    showModalBottomSheet(
        enableDrag: false,
        isScrollControlled: false,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, update) {
            return Container(
              padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_city_rounded,
                        size: 20,
                        color: Color(0xffFF6E00),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Cities',
                        style: TextStyle(
                          fontFamily: 'Montserrat-B',
                          fontSize: 15,
                          color: Color(0xff616161),
                        ),
                      ),
                      Spacer(),
                      Text(
                        ' ( Current : $current )',
                        style: TextStyle(
                          fontFamily: 'Montserrat-R',
                          fontSize: 13,
                          color: Color(0xff616161),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.city.length,
                      itemExtent: 50,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          update(() {
                            _indexvalue = index.toString();
                            current = widget.city[index]['city'];
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 15),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xffE1E1E1),
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_pin,
                                color: _indexvalue == index.toString()
                                    ? Color(0xffFF6E00)
                                    : Color(0xffdddddd),
                                size: 17,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${widget.city[index]['city']}',
                                style: TextStyle(
                                  fontFamily: 'Montserrat-R',
                                  fontSize: 14,
                                  color: Color(0xff616161),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xffA9D8D5),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.check,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }

  DateTime currentBackPressTime = new DateTime.now();

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
          elevation: 2,
          backgroundColor: Color(0xffFCF6ED),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.touch_app_rounded,
                size: 15,
                color: Color(0xffFF6E00),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Double Tap to exit.',
                style: TextStyle(
                  fontFamily: 'Montserrat-R',
                  fontSize: 14,
                  color: Color(0xff583241),
                ),
              ),
            ],
          ),
        ),
      );
      return Future.value(false);
    }
    backto();
    return Future.value(true);
  }

  _senddatasearch(String data) async {
    // ignore: unused_local_variable
    SearchEstablishment searchisntance = SearchEstablishment(
        search: data,
        city: current,
        token: widget.token,
        key: widget.secretkey,
        id: widget.id);
    await searchisntance.getsearch();
    setState(() {
      widget.data = searchisntance.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    if (MediaQuery.of(context).size.width < 300 ||
        MediaQuery.of(context).size.width > 768) {
      return buildunsupported(context);
    } else {
      if (load == false) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Color(0xffFDE5E3),
          body: WillPopScope(
            onWillPop: onWillPop,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: Image(
                      image: AssetImage('assets/images/image.jpg'),
                    ),
                  ),
                  SafeArea(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Text(
                        'Discover Establishments',
                        style: TextStyle(
                          fontFamily: 'Montserrat-B',
                          fontSize: 20,
                          color: Color(0xff573240),
                        ),
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Container(
                      alignment: Alignment.topRight,
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: Tooltip(
                        message: 'Log out',
                        waitDuration: Duration(microseconds: 1),
                        showDuration: Duration(seconds: 1),
                        textStyle: TextStyle(
                          fontFamily: 'Montserrat-R',
                          color: Color(0xffffffff),
                          fontSize: 13,
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.power_settings_new_sharp,
                            size: 20,
                            color: Color(0xffFF6E00),
                          ),
                          onPressed: () {
                            backto();
                          },
                        ),
                      ),
                    ),
                  ),
                  DraggableScrollableSheet(
                    initialChildSize: 0.68,
                    maxChildSize: 0.90,
                    minChildSize: 0.68,
                    builder: (context, controller) => Container(
                      padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(
                                    top: 15,
                                    bottom: 15,
                                    right: 10,
                                  ),
                                  child: TextField(
                                    controller: _searchcontroller,
                                    onChanged: (value) {
                                      _senddatasearch(value);
                                    },
                                    style: TextStyle(
                                      fontFamily: 'Montserrat-R',
                                      color: Color(0xff616161),
                                      fontSize: 13,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Find Place',
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
                                        Icons.search_rounded,
                                        size: 16,
                                        color: Color(0xffFF6E00),
                                      ),
                                      suffixIcon: Icon(
                                        Icons.location_pin,
                                        size: 16,
                                        color: Color(0xffFF6E00),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color(0xffFF6E00),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    _modalshow();
                                  },
                                  icon: Icon(
                                    Icons.tune_rounded,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 25),
                            height: 1,
                            color: Color(0xffFF6E00),
                          ),
                          Expanded(
                            child: Container(
                              child: RefreshIndicator(
                                onRefresh: _refresh,
                                child: ListView.builder(
                                  controller: controller,
                                  itemCount: widget.data.length,
                                  itemExtent: 120,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 15.0,
                                      ),
                                      child: Material(
                                        borderRadius: BorderRadius.circular(10),
                                        color: colors[colorchange(index)],
                                        child: InkWell(
                                          splashColor: Color(0xffA9D8D5),
                                          onTap: () {
                                            ScaffoldMessenger.of(context)
                                                .removeCurrentSnackBar();
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                            getSpecific(
                                              widget.data[index]
                                                  ['establishment-ID'],
                                              widget.data[index]
                                                  ['establishment-ID'],
                                              widget.data[index]
                                                  ['account-status'],
                                            );
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                30,
                                                0,
                                                30,
                                                0,
                                              ),
                                              child: Row(
                                                children: <Widget>[
                                                  Container(
                                                    height: 65,
                                                    width: 65,
                                                    decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                    ),
                                                    child: Hero(
                                                      tag: widget.data[index]
                                                          ['establishment-ID'],
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        child: widget.data[
                                                                        index]
                                                                    ['logo'] ==
                                                                "none"
                                                            ? Image(
                                                                image: AssetImage(
                                                                    'assets/images/logo.png'),
                                                              )
                                                            : Image(
                                                                image: NetworkImage(
                                                                    'http://${address.getip()}:80/cimo_desktop/uploads/${widget.data[index]['logo']}'),
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Flexible(
                                                        child: Row(
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      0,
                                                                      0,
                                                                      0,
                                                                      2),
                                                              child: Icon(
                                                                widget.data[index]
                                                                            [
                                                                            'account-status'] ==
                                                                        "Approved"
                                                                    ? Icons
                                                                        .check_circle_rounded
                                                                    : widget.data[index]['account-status'] ==
                                                                            "Pending"
                                                                        ? Icons
                                                                            .hourglass_bottom_rounded
                                                                        : Icons
                                                                            .warning_rounded,
                                                                size: 13,
                                                                color: widget.data[index]
                                                                            [
                                                                            'account-status'] ==
                                                                        "Approved"
                                                                    ? Colors
                                                                        .green
                                                                    : widget.data[index]['account-status'] ==
                                                                            "Pending"
                                                                        ? Colors
                                                                            .orange
                                                                        : Colors
                                                                            .red,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 2,
                                                            ),
                                                            Text(
                                                              '${widget.data[index]['establishment-name']}',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Montserrat-B',
                                                                fontSize: 15,
                                                                color: Color(
                                                                    0xff573240),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Flexible(
                                                        child: Text(
                                                          '${widget.data[index]['branch']}, ${widget.data[index]['street']}',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Montserrat-R',
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ),
                                                      Flexible(
                                                        child: Text(
                                                          '${widget.data[index]['barangay']}',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Montserrat-R',
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ),
                                                      Flexible(
                                                        child: Text(
                                                          '${widget.data[index]['city']}, Philippines',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Montserrat-R',
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
        return Scaffold(
          body: Text('hello'),
        );
      }
    }
  }
}
