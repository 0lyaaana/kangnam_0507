import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text('프로필', style: TextStyle(color: Colors.black87)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '사용자 이름',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'user@email.com',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem('절약 금액', '50,000원'),
                  _buildStatItem('사용한 혜택', '15개'),
                  _buildStatItem('전체 혜택', '45개'),
                ],
              ),
            ),
            const Divider(),
            _buildMenuSection('결제 수단', [
              _buildMenuItem(Icons.credit_card, '카드 관리', () {}),
            ]),
            const Divider(),
            _buildMenuSection('멤버십', [
              _buildMenuItem(Icons.card_membership, '멤버십 관리', () {}),
            ]),
            const Divider(),
            _buildMenuSection('앱 설정', [
              _buildMenuItem(Icons.notifications, '알림 설정', () {}),
              _buildMenuItem(Icons.color_lens, '테마 설정', () {}),
              _buildMenuItem(Icons.calendar_today, '캘린더 연동', () {}),
            ]),
            const Divider(),
            _buildMenuSection('정보', [
              _buildMenuItem(Icons.info, '버전 정보', () {}),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildMenuSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ...items,
      ],
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
