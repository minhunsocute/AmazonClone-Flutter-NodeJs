import 'package:amazon_clone/features/account/screens/account_screen.dart';
import 'package:amazon_clone/features/admin/screens/post_scree.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';

class AdminScreen extends StatefulWidget {
  static const String routeName = '/admin_screen';
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _page = 0;
  double bottomBarWidh = 42;
  List<Widget> pages = [
    const PostScreen(),
    const Center(child: Text('Analytics Page')),
    const Center(child: Text('Cart Page')),
  ];
  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              width: bottomBarWidh,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 0
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: 5,
                  ),
                ),
              ),
              child: const Icon(Icons.home_outlined),
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              width: bottomBarWidh,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 1
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: 5,
                  ),
                ),
              ),
              child: const Icon(Icons.analytics_outlined),
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              width: bottomBarWidh,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 2
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: 5,
                  ),
                ),
              ),
              child: const Icon(Icons.all_inbox_outlined),
            ),
          )
        ],
      ),
    );
  }
}
