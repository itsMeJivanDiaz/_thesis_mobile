import 'dart:async';

import 'package:cimo_mobile/brgy_establishment.dart';
import 'package:cimo_mobile/brgy_search.dart';
import 'package:cimo_mobile/fetch_brgy_est.dart';
import 'package:cimo_mobile/fetch_req.dart';
import 'package:cimo_mobile/jwt_pref.dart';
import 'package:cimo_mobile/selection.dart';
import 'package:cimo_mobile/unsupported.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:cimo_mobile/ip.dart';
import 'package:cimo_mobile/log_out.dart';
import 'package:cimo_mobile/prefs.dart';
import 'package:badges/badges.dart';

class BrgyHome extends StatefulWidget {
  String? token = '';
  String? secretkey = '';
  List<dynamic> establishment = [];
  BrgyHome({
    required this.token,
    required this.secretkey,
    required this.establishment,
  });

  @override
  _BrgyHomeState createState() => _BrgyHomeState();
}

class _BrgyHomeState extends State<BrgyHome> {
  Timer? timer;
  bool isbadge = false;
  int req_count = 0;
  GetIp address = GetIp();
  List colors = [
    Color(0xffE0F1F0),
    Color(0xffFCF6ED),
  ];

  String _indexvalue = '';

  Random rand = new Random();
  int coloridx = 0;
  String current = 'None';
  colorchange(index) {
    if (index % 2 == 0) {
      coloridx = 1;
    } else {
      coloridx = 0;
    }
    return coloridx;
  }

  _senddatasearch(String search) async {
    BrgySearch brgsrch = BrgySearch(
      search: search,
      token: widget.token,
      secretkey: widget.secretkey,
    );
    await brgsrch.brgysrch();
    setState(() {
      widget.establishment = brgsrch.status;
    });
  }

  void getSpecific(String id, String tag) async {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(seconds: 1),
        pageBuilder: (context, __, _) => BrygEstablishmentInfo(
          id: id,
          hero_tag: tag,
          token: widget.token,
          secretkey: widget.secretkey,
        ),
      ),
    );
  }

  void fetchreq() async {
    FetchRequests fetch = FetchRequests(
      token: widget.token,
      key: widget.secretkey,
    );
    await fetch.fetchrequests();
    setState(() {
      req_count = fetch.data.length;
      if (req_count > 0) {
        isbadge = true;
      } else {
        isbadge = false;
      }
    });
  }

  void backto() async {
    JwtPrefs logout_token = JwtPrefs(setvar: 'jwt_brgy', setval: '');
    await logout_token.getjwt();
    JwtPrefs logout_key = JwtPrefs(setvar: 'key_brgy', setval: '');
    await logout_key.getjwt();
    LogOut brgy_log_out = LogOut(
      token: logout_token.res,
      key: logout_key.res,
    );
    await brgy_log_out.logout();
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Selection()),
      );
    });
  }

  final _searchcontroller = TextEditingController();

  Future<void> _refresh() async {
    BrygyFetch brgyfetch = BrygyFetch(
      token: widget.token,
      secretkey: widget.secretkey,
    );
    await brgyfetch.fetchest();
    setState(() {
      widget.establishment = brgyfetch.status;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchreq();
    timer = Timer.periodic(Duration(seconds: 40), (Timer t) => fetchreq());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  bool load = false;
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
          body: GestureDetector(
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Badge(
                          showBadge: isbadge == false ? false : true,
                          badgeColor: Color(0xffE0F1F0),
                          badgeContent: Text(
                            '$req_count',
                            style: TextStyle(
                              fontFamily: 'Montserrat-R',
                              color: Color(0xff606060),
                              fontSize: 12,
                            ),
                          ),
                          alignment: Alignment.center,
                          position: BadgePosition.topEnd(top: 2, end: 5),
                          child: Tooltip(
                            message: 'Requests',
                            waitDuration: Duration(microseconds: 1),
                            showDuration: Duration(seconds: 1),
                            textStyle: TextStyle(
                              fontFamily: 'Montserrat-R',
                              color: Color(0xffffffff),
                              fontSize: 13,
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.checklist_rtl_sharp,
                                size: 21,
                                color: Color(0xffFF6E00),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ),
                        Tooltip(
                          message: 'View Violations',
                          waitDuration: Duration(microseconds: 1),
                          showDuration: Duration(seconds: 1),
                          textStyle: TextStyle(
                            fontFamily: 'Montserrat-R',
                            color: Color(0xffffffff),
                            fontSize: 13,
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.warning_amber_sharp,
                              size: 20,
                              color: Color(0xffFF6E00),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Tooltip(
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
                      ],
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
                                    hintText: 'Find Establishment',
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
                                itemCount: widget.establishment.length,
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
                                          getSpecific(
                                              widget.establishment[index]
                                                  ['establishment-ID'],
                                              widget.establishment[index]
                                                  ['establishment-ID']);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
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
                                                    tag: widget.establishment[
                                                            index]
                                                        ['establishment-ID'],
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      child:
                                                          widget.establishment[
                                                                          index]
                                                                      [
                                                                      'logo'] ==
                                                                  "none"
                                                              ? Image(
                                                                  image: AssetImage(
                                                                      'assets/images/logo.png'),
                                                                )
                                                              : Image(
                                                                  image: NetworkImage(
                                                                      'http://${address.getip()}:80/cimo_desktop/uploads/${widget.establishment[index]['logo']}'),
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
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        '${widget.establishment[index]['establishment-name']}',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Montserrat-B',
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        '${widget.establishment[index]['branch']}, ${widget.establishment[index]['street']}',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Montserrat-R',
                                                          fontSize: 13,
                                                        ),
                                                      ),
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        '${widget.establishment[index]['barangay']}',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Montserrat-R',
                                                          fontSize: 13,
                                                        ),
                                                      ),
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        '${widget.establishment[index]['city']}, Philippines',
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
        );
      } else {
        return Scaffold();
      }
    }
  }
}
