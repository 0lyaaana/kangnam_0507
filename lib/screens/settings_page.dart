import 'package:flutter/material.dart';
import '../widgets/custom_header.dart';
import '../widgets/custom_drawer.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> _selectedCards = [];
  final List<String> _selectedMemberships = [];

  final List<String> _availableCards = [
    '신한카드',
    'KB국민카드',
    '삼성카드',
    '현대카드',
    '롯데카드',
  ];

  final List<String> _availableMemberships = [
    '네이버페이',
    '카카오페이',
    '토스',
    '페이코',
    '삼성페이',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      endDrawer: const CustomDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            CustomHeader(
              onMenuTap: () {
                _scaffoldKey.currentState?.openEndDrawer();
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildProfileSection(),
                      const SizedBox(height: 24),
                      _buildStatisticsSection(),
                      const SizedBox(height: 24),
                      _buildPaymentSection(),
                      const SizedBox(height: 24),
                      _buildSettingsSection(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey[300],
            child: const Icon(Icons.person, size: 36, color: Colors.black54),
          ),
          const SizedBox(width: 16),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '사용자님',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                '프로필 관리',
                style: TextStyle(color: Colors.black54, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '통계',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildStatCard('절약 금액', '50,000원', Icons.savings),
            const SizedBox(width: 12),
            _buildStatCard('사용한 혜택', '15회', Icons.local_offer),
            const SizedBox(width: 12),
            _buildStatCard('전체 혜택', '45개', Icons.card_giftcard),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.black54),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontSize: 12)),
            Text(
              value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '결제 수단',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _buildCardSelection(),
        const SizedBox(height: 16),
        _buildMembershipSelection(),
      ],
    );
  }

  Widget _buildCardSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '사용 카드',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              _availableCards.map((card) {
                final isSelected = _selectedCards.contains(card);
                return FilterChip(
                  label: Text(card),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedCards.add(card);
                      } else {
                        _selectedCards.remove(card);
                      }
                    });
                  },
                  selectedColor: Colors.grey[300],
                  checkmarkColor: Colors.black,
                );
              }).toList(),
        ),
      ],
    );
  }

  Widget _buildMembershipSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '사용 멤버십',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              _availableMemberships.map((membership) {
                final isSelected = _selectedMemberships.contains(membership);
                return FilterChip(
                  label: Text(membership),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedMemberships.add(membership);
                      } else {
                        _selectedMemberships.remove(membership);
                      }
                    });
                  },
                  selectedColor: Colors.grey[300],
                  checkmarkColor: Colors.black,
                );
              }).toList(),
        ),
      ],
    );
  }

  Widget _buildSettingsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '설정',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _buildSettingItem('알림 설정', Icons.notifications),
        _buildSettingItem('앱 정보', Icons.info),
        _buildSettingItem('문의하기', Icons.help),
      ],
    );
  }

  Widget _buildSettingItem(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.black54),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        // 각 설정 항목 탭 처리
      },
    );
  }
}
