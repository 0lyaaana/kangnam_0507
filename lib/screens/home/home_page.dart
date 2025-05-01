import 'package:flutter/material.dart';
import 'package:my_app/models/category.dart';
import 'package:my_app/screens/subcategory/subcategory_page.dart';
import 'package:my_app/screens/profile/user_profile_page.dart';
import 'package:my_app/screens/schedule/schedule_page.dart';

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
