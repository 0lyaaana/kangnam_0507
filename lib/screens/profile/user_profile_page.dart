import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  bool hasSKTMembership = false;
  bool hasKakaoPay = false;
  bool hasNaverPay = false;
  String selectedSKTGrade = 'VIP';

  final List<String> sktGrades = ['일반', 'VIP', 'VVIP'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('사용자 정보'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            '멤버십 정보',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            title: const Text('SKT 멤버십'),
            value: hasSKTMembership,
            onChanged: (value) {
              setState(() {
                hasSKTMembership = value;
              });
            },
          ),
          if (hasSKTMembership)
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: DropdownButton<String>(
                value: selectedSKTGrade,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedSKTGrade = newValue;
                    });
                  }
                },
                items:
                    sktGrades.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
              ),
            ),
          const Divider(),
          const Text(
            '결제 수단',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            title: const Text('카카오페이'),
            value: hasKakaoPay,
            onChanged: (value) {
              setState(() {
                hasKakaoPay = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('네이버페이'),
            value: hasNaverPay,
            onChanged: (value) {
              setState(() {
                hasNaverPay = value;
              });
            },
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('사용자 정보가 저장되었습니다.'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text('저장하기'),
          ),
        ],
      ),
    );
  }
}
