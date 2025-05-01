import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '혜택 검색',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Category> categories = [
    Category('음식', Icons.restaurant, [
      Subcategory('한식', [
        Store('본죽', true),
        Store('명동찌개마을', true),
        Store('김밥천국', false),
      ]),
      Subcategory('중식', [Store('홍콩반점', true), Store('교동짬뽕', false)]),
      Subcategory('양식', [
        Store('아웃백', true),
        Store('빕스', true),
        Store('맥도날드', false),
      ]),
      Subcategory('일식', [Store('스시로', true), Store('미소야', false)]),
    ]),
    Category('카페', Icons.coffee, [
      Subcategory('프랜차이즈', [
        Store('스타벅스', true),
        Store('투썸플레이스', true),
        Store('이디야', false),
      ]),
      Subcategory('개인카페', [Store('동네카페', false)]),
    ]),
    Category('교통', Icons.directions_car, [
      Subcategory('버스', [Store('시내버스', true), Store('고속버스', false)]),
      Subcategory('택시', [Store('카카오택시', true), Store('일반택시', false)]),
      Subcategory('비행기', [
        Store('대한항공', true),
        Store('아시아나', true),
        Store('제주항공', false),
      ]),
    ]),
    Category('쇼핑', Icons.shopping_bag, [
      Subcategory('마트', [
        Store('이마트', true),
        Store('홈플러스', true),
        Store('롯데마트', false),
      ]),
      Subcategory('백화점', [
        Store('롯데백화점', true),
        Store('신세계백화점', true),
        Store('현대백화점', false),
      ]),
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('혜택 검색'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserProfilePage(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.calendar_month),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SchedulePage()),
              );
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return _buildCategoryCard(category);
        },
      ),
    );
  }

  Widget _buildCategoryCard(Category category) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubcategoryPage(category: category),
          ),
        );
      },
      child: Card(
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(category.icon, size: 48, color: Colors.blue),
            const SizedBox(height: 8),
            Text(
              category.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class SubcategoryPage extends StatelessWidget {
  final Category category;

  const SubcategoryPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${category.name} 카테고리'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        itemCount: category.subcategories.length,
        itemBuilder: (context, index) {
          final subcategory = category.subcategories[index];
          return ExpansionTile(
            title: Text(
              subcategory.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            children:
                subcategory.stores.map((store) {
                  return ListTile(
                    title: Text(store.name),
                    enabled: store.hasDiscount,
                    textColor: store.hasDiscount ? null : Colors.grey,
                    trailing:
                        store.hasDiscount
                            ? const Icon(Icons.arrow_forward_ios, size: 16)
                            : const Text(
                              '혜택 없음',
                              style: TextStyle(color: Colors.grey),
                            ),
                    onTap:
                        store.hasDiscount
                            ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => DiscountDetailsPage(
                                        storeName: store.name,
                                        categoryName: category.name,
                                      ),
                                ),
                              );
                            }
                            : null,
                  );
                }).toList(),
          );
        },
      ),
    );
  }
}

class DiscountDetailsPage extends StatefulWidget {
  final String storeName;
  final String categoryName;

  const DiscountDetailsPage({
    super.key,
    required this.storeName,
    required this.categoryName,
  });

  @override
  State<DiscountDetailsPage> createState() => _DiscountDetailsPageState();
}

class _DiscountDetailsPageState extends State<DiscountDetailsPage> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  List<Discount> discounts = [];

  @override
  void initState() {
    super.initState();
    _loadDiscounts();
  }

  void _loadDiscounts() {
    // 실제로는 서버나 DB에서 가져와야 하지만, 샘플로 더미 데이터 사용
    setState(() {
      if (widget.storeName == '스타벅스') {
        discounts = [
          Discount('SKT 멤버십 20% 할인', '매일 1회, 최대 4,000원', '2024-12-31'),
          Discount('네이버페이 결제 시 5% 적립', '결제 금액의 5% 적립', '2024-10-31'),
          Discount('아메리카노 1+1', '오후 2시~5시', '2024-09-30'),
        ];
      } else if (widget.storeName == '아웃백') {
        discounts = [
          Discount('현대카드 30% 할인', '월 1회, 최대 15,000원', '2024-12-31'),
          Discount('SK멤버십 15% 할인', '최대 10,000원', '2024-11-30'),
        ];
      } else {
        discounts = [
          Discount('기본 10% 할인', '모든 결제 시 적용', '2024-12-31'),
          Discount('카카오페이 5% 추가 할인', '결제 금액의 5%', '2024-10-31'),
        ];
      }
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.storeName} 혜택'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => _selectDate(context),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: '날짜',
                        border: OutlineInputBorder(),
                      ),
                      child: Text(
                        '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}',
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: InkWell(
                    onTap: () => _selectTime(context),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: '시간',
                        border: OutlineInputBorder(),
                      ),
                      child: Text(
                        '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: discounts.length,
              itemBuilder: (context, index) {
                final discount = discounts[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    title: Text(
                      discount.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(discount.description),
                        Text('유효기간: ${discount.expiryDate}'),
                      ],
                    ),
                    trailing: ElevatedButton(
                      child: const Text('사용하기'),
                      onPressed: () {
                        _scheduleDiscount(discount);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _scheduleDiscount(Discount discount) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.storeName}의 ${discount.title} 일정이 추가되었습니다.'),
        duration: const Duration(seconds: 2),
      ),
    );

    // 여기서 실제로는 일정 저장 로직이 들어가야 함
    // 마운트 상태 체크 추가
    Navigator.of(context).pop();
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
      ),
      body: Column(
        children: [
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
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        // 일정 삭제 로직 구현
                      },
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
          // 추천 혜택 팝업 표시
          _showRecommendation(context);
        },
        child: const Icon(Icons.lightbulb),
      ),
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
