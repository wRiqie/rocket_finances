import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get_it/get_it.dart';
import 'package:rocket_finances/app/business_logic/cubits/bills/bills_cubit.dart';
import 'package:rocket_finances/app/business_logic/cubits/bills/bills_state.dart';
import 'package:rocket_finances/app/business_logic/cubits/receipts/receipts_cubit.dart';
import 'package:rocket_finances/app/business_logic/cubits/receipts/receipts_state.dart';
import 'package:rocket_finances/app/core/helpers/session_helper.dart';
import 'package:rocket_finances/app/ui/modules/analytics/ai_analytics.dart';
import 'package:rocket_finances/app/ui/modules/home/home.dart';
import 'package:rocket_finances/app/ui/shared/widgets/logged_app_bar_widget.dart';
import 'package:rocket_finances/routes/app_pages.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final sessionHelper = GetIt.I<SessionHelper>();

  late List<Widget> screens;

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    screens = [
      Home(),
      Container(),
      AiAnalytics(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final colorScheme = Theme.of(context).colorScheme;

    return MultiBlocListener(
      listeners: [
        BlocListener<BillsCubit, BillsState>(
          listener: (context, state) async {
            if (state.status.isDeleted) {
              await sessionHelper.loadActualSession();
              setState(() {});
              if (context.mounted) {
                BlocProvider.of<BillsCubit>(context)
                    .getAllByUserId(sessionHelper.currentUser?.id ?? '');
              }
            }
          },
        ),
        BlocListener<ReceiptsCubit, ReceiptsState>(
          listener: (context, state) async {
            if (state.status.isDeleted) {
              await sessionHelper.loadActualSession();
              setState(() {});
              if (context.mounted) {
                BlocProvider.of<ReceiptsCubit>(context)
                    .getAllByUserId(sessionHelper.currentUser?.id ?? '');
              }
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(size.width, 90),
          child: LoggedAppBarWidget(
            user: sessionHelper.currentUser,
            onTapNotifications: () {},
            onTapSettings: () =>
                Navigator.pushNamed(context, AppRoutes.settings),
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {},
        //   child: Icon(Icons.add),
        // ),
        floatingActionButton: SpeedDial(
          icon: Icons.add,
          activeIcon: Icons.close,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          children: [
            SpeedDialChild(
              child: Icon(Icons.arrow_downward, color: Colors.white),
              backgroundColor: const Color(0x6A4CAF4F),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 2,
                  color: Colors.green,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              label: 'Recebimento',
              labelStyle: TextStyle(fontSize: 16, color: Colors.white),
              labelBackgroundColor: const Color.fromARGB(82, 76, 175, 79),
              onTap: _addReceipt,
            ),
            SpeedDialChild(
              child: Icon(Icons.arrow_upward, color: Colors.white),
              backgroundColor: const Color(0x5AF44336),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 2,
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              label: 'Gasto',
              labelStyle: TextStyle(fontSize: 16, color: Colors.white),
              labelBackgroundColor: const Color.fromARGB(97, 244, 67, 54),
              onTap: _addBill,
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 14,
          unselectedFontSize: 14,
          selectedItemColor: colorScheme.primary,
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
              icon: Icon(Icons.analytics_outlined),
              label: 'Análise(IA)',
            ),
          ],
        ),
        body: screens[currentIndex],
      ),
    );
  }

  void _changeCurrent(int newIndex) {
    if (newIndex == 1) return;
    setState(() {
      currentIndex = newIndex;
    });
  }

  void _addBill() async {
    final result = await Navigator.pushNamed(context, AppRoutes.addBill);

    if (result == true) {
      await sessionHelper.loadActualSession();
      setState(() {});
      if (mounted) {
        BlocProvider.of<BillsCubit>(context)
            .getAllByUserId(sessionHelper.currentUser?.id ?? '');
      }
    }
  }

  void _addReceipt() async {
    final result = await Navigator.pushNamed(context, AppRoutes.addReceipt);

    if (result == true) {
      await sessionHelper.loadActualSession();
      setState(() {});
      if (mounted) {
        BlocProvider.of<ReceiptsCubit>(context)
            .getAllByUserId(sessionHelper.currentUser?.id ?? '');
      }
    }
  }
}
