import 'package:flutter/material.dart';

import '../widgets/nav_drawer.dart';
import '../widgets/app_bar.dart';

class PasswordRecovery extends StatefulWidget {
  const PasswordRecovery({super.key});

  @override
  State<PasswordRecovery> createState() => _PasswordRecoveryState();
}

class _PasswordRecoveryState extends State<PasswordRecovery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      drawer: const NavDrawer(),
      body: Center(child: Container()),
    );
  }
}
