import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/home_page.dart';
import 'screens/user_profile_page.dart';
import 'screens/schedule_page.dart';
import 'screens/category_detail_page.dart';
import 'screens/profile_screen.dart';
import 'screens/discount/discount_details_page.dart';
import 'widgets/custom_header.dart';
import 'widgets/custom_drawer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return MaterialApp(
      title: 'SNAG THE DEAL',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0.5,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/schedule': (context) => const SchedulePage(),
        '/discount-details':
            (context) => const DiscountDetailsPage(mainCategory: '음식'),
        '/category':
            (context) => const CategoryDetailPage(
              categoryName: '전체',
              categoryIcon: Icons.category,
            ),
        '/profile': (context) => const ProfileScreen(),
        '/settings':
            (context) => Scaffold(
              appBar: AppBar(title: const Text('설정')),
              body: const Center(child: Text('설정 페이지')),
            ),
        '/app-info':
            (context) => Scaffold(
              appBar: AppBar(title: const Text('앱 정보')),
              body: const Center(child: Text('앱 버전: 1.0.0')),
            ),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static final ValueNotifier<bool> isCalendarLinked = ValueNotifier<bool>(
    false,
  );

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Image.asset('assets/images/logo.png', height: 30),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              scaffoldKey.currentState?.openEndDrawer();
            },
          ),
        ],
      ),
      endDrawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRecommendedSection(),
            _buildCategorySection(),
            _buildCalendarSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendedSection() {
    final List<Map<String, dynamic>> recommendations = [
      {
        'image': 'assets/images/starbucks.png',
        'title': '스타벅스',
        'discount': '2,000원 즉시할인',
        'description': '아메리카노 주문 시',
        'category': '카페',
      },
      {
        'image': 'assets/images/burgerking.png',
        'title': '버거킹',
        'discount': '3,000원 즉시할인',
        'description': '와퍼 주문 시',
        'category': '음식',
      },
      {
        'image': 'assets/images/subway.png',
        'title': '서브웨이',
        'discount': '4,000원 즉시할인',
        'description': '15cm 샌드위치 주문 시',
        'category': '음식',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            '당신을 위한 추천 혜택',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: recommendations.length,
            itemBuilder: (context, index) {
              final recommendation = recommendations[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => DiscountDetailsPage(
                            mainCategory: recommendation['category'],
                            initialStore: recommendation['title'],
                          ),
                    ),
                  );
                },
                child: Container(
                  width: 160,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.store,
                            size: 40,
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              recommendation['title'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              recommendation['discount'],
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blue[700],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              recommendation['description'],
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategorySection() {
    final List<Map<String, dynamic>> categories = [
      {'icon': Icons.restaurant, 'label': '음식'},
      {'icon': Icons.coffee, 'label': '카페'},
      {'icon': Icons.local_taxi, 'label': '교통'},
      {'icon': Icons.shopping_bag, 'label': '쇼핑'},
      {'icon': Icons.movie, 'label': '문화'},
      {'icon': Icons.sports_basketball, 'label': '스포츠'},
      {'icon': Icons.spa, 'label': '뷰티'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            '카테고리별 맞춤 혜택',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 1,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => DiscountDetailsPage(
                          mainCategory: category['label'],
                        ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(category['icon'], size: 32, color: Colors.black87),
                    const SizedBox(height: 8),
                    Text(
                      category['label'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCalendarSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            '스케줄',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: ValueListenableBuilder<bool>(
            valueListenable: isCalendarLinked,
            builder: (context, isLinked, child) {
              if (!isLinked) {
                return Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 24),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '캘린더에 일정 등록하고',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[800],
                                ),
                              ),
                              Text(
                                '관련 할인 정보 알림 받자!',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          isCalendarLinked.value = true;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('구글 캘린더가 연동되었습니다.'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        child: const Text(
                          '구글 캘린더 연동하기',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return CalendarWidget();
              }
            },
          ),
        ),
      ],
    );
  }
}

class CategoryPage extends StatelessWidget {
  final String category;

  const CategoryPage({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category), centerTitle: true),
      body: Column(
        children: [_buildSubcategoryTabs(), Expanded(child: _buildStoreList())],
      ),
    );
  }

  Widget _buildSubcategoryTabs() {
    return Container(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _buildTabItem('전체', isSelected: true),
          _buildTabItem('한식'),
          _buildTabItem('중식'),
          _buildTabItem('일식'),
          _buildTabItem('양식'),
          _buildTabItem('카페'),
        ],
      ),
    );
  }

  Widget _buildTabItem(String label, {bool isSelected = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.grey.shade300,
        ),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildStoreList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: Colors.grey.shade300),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            title: Text('가게 ${index + 1}'),
            subtitle: const Text('할인 정보가 들어갑니다'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          ),
        );
      },
    );
  }
}

class CalendarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [_buildCalendarHeader(), _buildCalendarGrid()]);
  }

  Widget _buildCalendarHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(icon: const Icon(Icons.chevron_left), onPressed: () {}),
          const Text(
            '2025년 5월',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          IconButton(icon: const Icon(Icons.chevron_right), onPressed: () {}),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final List<String> days = ['일', '월', '화', '수', '목', '금', '토'];
    final int daysInMay2025 = 31;
    final int firstDayOfMay2025 = 4; // 2025년 5월 1일은 목요일

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1,
      ),
      itemCount: 7 + daysInMay2025 + firstDayOfMay2025,
      itemBuilder: (context, index) {
        if (index < 7) {
          // 요일 표시
          return Center(
            child: Text(
              days[index],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          );
        }

        // 첫 주 빈 칸
        if (index < 7 + firstDayOfMay2025) {
          return const Center(child: Text(''));
        }

        // 날짜 표시
        final date = index - 7 - firstDayOfMay2025 + 1;
        if (date > daysInMay2025) {
          return const Center(child: Text(''));
        }

        return Center(
          child: Text(
            date.toString(),
            style: const TextStyle(color: Colors.black),
          ),
        );
      },
    );
  }
}

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

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 간단한 일정 목록 (실제로는 DB에서 가져와야 함)
    final List<Schedule> schedules = [
      Schedule(
        '스타벅스 - SKT 멤버십 20% 할인',
        DateTime.now().add(const Duration(days: 1)),
        '강남점',
      ),
      Schedule(
        '아웃백 - 현대카드 30% 할인',
        DateTime.now().add(const Duration(days: 3)),
        '코엑스점',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('내 일정'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () {
              _showGoogleCalendarDialog(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 구글 캘린더 연동 상태 표시 배너
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.blue.shade50,
            child: Row(
              children: [
                const Icon(Icons.calendar_month, color: Colors.blue),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    '구글 캘린더와 연동하여 할인 일정을 자동으로 관리하세요!',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _showGoogleCalendarDialog(context);
                  },
                  child: const Text('연동하기'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: schedules.length,
              itemBuilder: (context, index) {
                final schedule = schedules[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    title: Text(schedule.title),
                    subtitle: Text(
                      '${schedule.dateTime.year}-${schedule.dateTime.month.toString().padLeft(2, '0')}-${schedule.dateTime.day.toString().padLeft(2, '0')} ${schedule.dateTime.hour.toString().padLeft(2, '0')}:${schedule.dateTime.minute.toString().padLeft(2, '0')}\n${schedule.location}',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.calendar_today, size: 20),
                          onPressed: () {
                            _showAddToGoogleCalendarDialog(context, schedule);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            // 일정 삭제 로직 구현
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showRecommendation(context);
        },
        child: const Icon(Icons.lightbulb),
      ),
    );
  }

  void _showGoogleCalendarDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('구글 캘린더 연동'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('구글 캘린더와 연동하면 다음과 같은 기능을 사용할 수 있습니다:'),
              const SizedBox(height: 12),
              _buildFeatureItem('할인 일정 자동 동기화'),
              _buildFeatureItem('알림 설정 관리'),
              _buildFeatureItem('일정 충돌 확인'),
              const SizedBox(height: 16),
              const Text(
                '연동을 위해 구글 계정 로그인이 필요합니다.',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('취소'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('구글 캘린더와 연동되었습니다.'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: const Text('연동하기'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 20),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }

  void _showAddToGoogleCalendarDialog(BuildContext context, Schedule schedule) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('구글 캘린더에 추가'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('일정: ${schedule.title}'),
              const SizedBox(height: 8),
              Text('날짜: ${schedule.dateTime.toString().split('.')[0]}'),
              Text('장소: ${schedule.location}'),
              const SizedBox(height: 16),
              const Text('알림 설정:'),
              const SizedBox(height: 8),
              _buildReminderOption('10분 전'),
              _buildReminderOption('30분 전'),
              _buildReminderOption('1시간 전'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('취소'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('구글 캘린더에 일정이 추가되었습니다.'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: const Text('추가'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildReminderOption(String text) {
    return Row(
      children: [
        Checkbox(value: true, onChanged: (bool? value) {}),
        Text(text),
      ],
    );
  }

  void _showRecommendation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('혜택 추천'),
          content: const Text(
            '오늘 점심시간 12시에 회의가 있습니다. 회의 장소 근처에 스타벅스에서 네이버페이 결제 시 10% 할인 혜택이 있습니다. 일정을 11시 30분으로 변경하여 혜택을 받으시겠습니까?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('아니오'),
            ),
            TextButton(
              onPressed: () {
                // 일정 변경 로직
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('일정이 변경되었습니다.'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: const Text('예'),
            ),
          ],
        );
      },
    );
  }
}

// 모델 클래스들
class Category {
  final String name;
  final IconData icon;
  final List<Subcategory> subcategories;

  Category(this.name, this.icon, this.subcategories);
}

class Subcategory {
  final String name;
  final List<Store> stores;

  Subcategory(this.name, this.stores);
}

class Store {
  final String name;
  final bool hasDiscount;

  Store(this.name, this.hasDiscount);
}

class Discount {
  final String title;
  final String description;
  final String expiryDate;

  Discount(this.title, this.description, this.expiryDate);
}

class Schedule {
  final String title;
  final DateTime dateTime;
  final String location;

  Schedule(this.title, this.dateTime, this.location);
}
