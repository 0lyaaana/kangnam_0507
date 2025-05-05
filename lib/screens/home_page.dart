import 'package:flutter/material.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/custom_header.dart';
import '../widgets/recommended_deals.dart';
import '../widgets/category_list.dart';
import '../widgets/calendar_section.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      endDrawer: const CustomDrawer(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomHeader(
              onMenuTap: () {
                _scaffoldKey.currentState?.openEndDrawer();
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    RecommendedDeals(),
                    CategoryList(),
                    SizedBox(height: 20),
                    CalendarSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
