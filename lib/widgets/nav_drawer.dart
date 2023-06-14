import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../pages/auth.dart';
import '../pages/cart.dart';
import '../pages/my_account.dart';
import 'large_text.dart';
import 'medium_text.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          FutureBuilder(
              future: getToken(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  return const UserAccountsDrawerHeader(
                    accountName: Text("johndoe"),
                    accountEmail: Text("johndoe@email.com"),
                    currentAccountPicture: CircleAvatar(
                        backgroundImage: NetworkImage(
                      "https://images.unsplash.com/photo-1561131989-b8112bafbd43?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8Y2FydG9vbiUyMGZhY2V8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60",
                    )),
                    decoration: BoxDecoration(color: Colors.deepPurpleAccent),
                  );
                } else {
                  return const UserAccountsDrawerHeader(
                    accountName: Text("johndoe"),
                    accountEmail: Text("johndoe@email.com"),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.blueGrey,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    decoration: BoxDecoration(color: Colors.deepPurpleAccent),
                  );
                }
              }),
          FutureBuilder(
              future: getToken(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  return Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: Column(
                      children: [
                        ListTile(
                            titleAlignment: ListTileTitleAlignment.center,
                            leading: const Icon(Icons.home,
                                color: Colors.black54, size: 35),
                            onTap: () => Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const MyApp())),
                            minLeadingWidth: 0,
                            title: LargeText(text: "Home")),
                        const SizedBox(height: 10),
                        ListTile(
                            titleAlignment: ListTileTitleAlignment.center,
                            leading: const Icon(Icons.shopping_cart_checkout,
                                color: Colors.black54, size: 35),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const Cart()));
                            },
                            minLeadingWidth: 0,
                            title: LargeText(text: "Cart")),
                        const SizedBox(height: 10),
                        ListTile(
                            titleAlignment: ListTileTitleAlignment.center,
                            leading: const Icon(Icons.person,
                                color: Colors.black54, size: 35),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const MyAccount()));
                            },
                            minLeadingWidth: 0,
                            title: LargeText(text: "My Account")),
                        const SizedBox(height: 10),
                        ListTile(
                            titleAlignment: ListTileTitleAlignment.center,
                            leading: const Icon(Icons.logout,
                                color: Colors.black54, size: 35),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const AuthPage()));
                              removeToken();
                            },
                            minLeadingWidth: 0,
                            title: LargeText(text: "Logout")),
                      ],
                    ),
                  );
                } else {
                  return Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: Column(
                      children: [
                        ListTile(
                            titleAlignment: ListTileTitleAlignment.center,
                            leading: const Icon(Icons.home,
                                color: Colors.black54, size: 35),
                            onTap: () => Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const MyApp())),
                            minLeadingWidth: 0,
                            title: LargeText(text: "Home")),
                        const SizedBox(height: 10),
                        ListTile(
                            titleAlignment: ListTileTitleAlignment.center,
                            leading: const Icon(Icons.shopping_cart_checkout,
                                color: Colors.black54, size: 35),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const Cart()));
                            },
                            minLeadingWidth: 0,
                            title: LargeText(text: "Cart")),
                        const SizedBox(height: 10),
                        ListTile(
                            titleAlignment: ListTileTitleAlignment.center,
                            leading: const Icon(Icons.login,
                                color: Colors.black54, size: 35),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const AuthPage()));
                            },
                            minLeadingWidth: 0,
                            title: LargeText(text: "Login")),
                      ],
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }
}

Future getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString("jwtToken");
}

Future removeToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.remove("jwtToken");
}
