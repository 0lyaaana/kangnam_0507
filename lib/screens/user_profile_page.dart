import 'package:flutter/material.dart';
import '../widgets/custom_header.dart';

class UserProfilePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  UserProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            CustomHeader(
              onMenuTap: () {
                _scaffoldKey.currentState?.openEndDrawer();
              },
            ),
            const Expanded(
              child: Center(
                child: Text('프로필 페이지', style: TextStyle(fontSize: 24)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
