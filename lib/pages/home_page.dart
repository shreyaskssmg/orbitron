import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:spacex/components/my_nav_bar.dart';
import 'package:spacex/pages/api_APOD_page.dart';
import 'package:spacex/pages/api_blogs_page.dart';
import 'package:spacex/pages/api_planets_page.dart';
import 'package:spacex/pages/planets_page.dart';

class HomePage extends StatefulWidget {
  final String title;
  final String image_url;
  final String email;
  const HomePage(
      {super.key,
      required this.title,
      required this.image_url,
      required this.email});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    super.initState();
    getConnectivity();
    // Call showDialogBox() method here
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!isDeviceConnected && !isAlertSet) {
        showDialogBox();
        setState(() {
          isAlertSet = true;
        });
      }
    });
  }

  getConnectivity() => subscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) async {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        if (!isDeviceConnected && isAlertSet == false) {
          showDialogBox();
          setState(() {
            isAlertSet = true;
          });
        }
      });

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  // index of the selected page
  int _selectedIndex = 0;

  // function to select the pages with the given index
  void _changeIndex(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // list of pages to navigate b/w

  @override
  Widget build(BuildContext context) {
    final List _pages = [
      ApiPlanetsPage(
          title: widget.title,
          image_url: widget.image_url,
          email: widget.email),
      ApiAPODPage(
          title: widget.title,
          image_url: widget.image_url,
          email: widget.email),
      ApiBlogsPage(
          title: widget.title,
          image_url: widget.image_url,
          email: widget.email),
    ];
    return Scaffold(
      bottomNavigationBar: MyNavBar(
        onTabChange: (index) => _changeIndex(index),
      ),
      body: _pages[_selectedIndex],
    );
  }

  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text("No Connection"),
          content: const Text("Please check your internet connectivity"),
          actions: <Widget>[
            TextButton(
                onPressed: () async {
                  Navigator.pop(context, "Cancle");
                  setState(() {
                    isAlertSet = false;
                  });
                  isDeviceConnected =
                      await InternetConnectionChecker().hasConnection;
                  if (!isDeviceConnected) {
                    showDialogBox();
                    setState(() {
                      isAlertSet = true;
                    });
                  }
                },
                child: const Text("retry"))
          ],
        ),
      );
}
