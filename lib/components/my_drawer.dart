import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:spacex/pages/home_page.dart';

class MyDrawer extends StatefulWidget {
  final String title;
  final String image_url;
  final String email;
  const MyDrawer(
      {super.key,
      required this.title,
      required this.image_url,
      required this.email});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromRGBO(175, 51, 85, 1.0),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(widget.title),
              accountEmail: Text(widget.email),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.network(
                    widget.image_url,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              decoration: const BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://res.cloudinary.com/djhstgxgk/image/upload/v1681230663/drawer_bg_dzrp3o.jpg"),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Divider(
                thickness: 1,
                color: Colors.white,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(
                          title: widget.title,
                          image_url: widget.image_url,
                          email: widget.email),
                    ));
              },
              child: const ListTile(
                leading: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                title: Text(
                  "Home",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: const ListTile(
                leading: Icon(
                  Icons.info,
                  color: Colors.white,
                ),
                title: Text(
                  "About",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: const ListTile(
                leading: Icon(
                  Icons.share,
                  color: Colors.white,
                ),
                title: Text(
                  "Share",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () async {
            await GoogleSignIn().signOut();
            FirebaseAuth.instance.signOut();
          },
          child: const ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            title: Text(
              "Logout",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ]),
    );
  }
}
