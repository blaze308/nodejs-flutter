import 'package:flutter/material.dart';
import 'package:second/widgets/app_bar.dart';

import '../widgets/nav_drawer.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  int _page = 0;

  List<Widget> pages = [
    Container(
      child: Text("one"),
    ),
    Container(
        child: ListView(
      children: [
        Form(
            child: Column(
          children: [TextFormField(), Text("yay")],
        ))
      ],
    )),
    Container(
      child: Text("three"),
    )
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      drawer: const NavDrawer(),
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
          onTap: updatePage,
          currentIndex: _page,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag), label: "My Products"),
            BottomNavigationBarItem(
                icon: Icon(Icons.assignment), label: "My Orders"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Settings"),
          ]),
    );
  }
}
