import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second/providers/user_provider.dart';
import 'package:second/widgets/snackbar.dart';
import '../main.dart';
import '../pages/auth.dart';
import '../pages/cart.dart';
import '../pages/my_account.dart';
import '../services/auth_service.dart';
import 'large_text.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({
    super.key,
  });

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user.username.toString()),
            accountEmail: Text(user.email.toString()),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person_4, size: 30),
            ),
            decoration: const BoxDecoration(color: Colors.blueAccent),
          ),
          Container(
            width: double.maxFinite,
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: Column(
              children: [
                ListTile(
                    titleAlignment: ListTileTitleAlignment.center,
                    leading:
                        const Icon(Icons.home, color: Colors.black54, size: 35),
                    onTap: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const MyApp())),
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
                      if (user.token.isNotEmpty) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const MyAccount()));
                      } else {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const MyApp()));
                        showSnackBar(context, "login to access your account");
                      }

                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) =>
                      //         Provider.of<UserProvider>(context)
                      //                 .user
                      //                 .token
                      //                 .isNotEmpty
                      //             ? const MyAccount()
                      //             : const MyApp()));
                    },
                    minLeadingWidth: 0,
                    title: LargeText(text: "My Account")),
                const SizedBox(height: 10),
                if (user.token.isNotEmpty)
                  ListTile(
                      titleAlignment: ListTileTitleAlignment.center,
                      leading: const Icon(Icons.logout,
                          color: Colors.black54, size: 35),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const MyApp()));
                      },
                      minLeadingWidth: 0,
                      title: LargeText(text: "Logout")),
                if (user.token.isEmpty)
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
          ),
        ],
      ),
    );
  }
}
