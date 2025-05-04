import 'package:flutter/material.dart';
import 'package:rocket_finances/app/ui/modules/home/home.dart';
import 'package:rocket_finances/app/ui/shared/widgets/logged_app_bar_widget.dart';
import 'package:rocket_finances/routes/app_pages.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Widget> screens = [Home(), Container(), Container()];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(size.width, 70),
        child: LoggedAppBarWidget(
          onTapNotifications: () {},
          onTapSettings: () => Navigator.pushNamed(context, AppRoutes.settings),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _changeCurrent,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.transparent,
              ),
              label: 'Add'),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_outlined),
            label: 'Histórico',
          ),
        ],
      ),
      body: screens[currentIndex],
    );
  }

  void _changeCurrent(int newIndex) {
    if (newIndex == 1) return;
    setState(() {
      currentIndex = newIndex;
    });
  }
}
