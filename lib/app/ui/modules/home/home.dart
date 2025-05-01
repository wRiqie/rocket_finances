import 'package:flutter/cupertino.dart';
import 'package:rocket_finances/app/ui/modules/home/home_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}
