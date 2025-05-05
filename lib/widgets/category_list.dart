import 'package:flutter/material.dart';
import '../screens/category_detail_page.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {'name': '카페', 'icon': Icons.coffee},
      {'name': '교통', 'icon': Icons.directions_car},
      {'name': '음식', 'icon': Icons.restaurant},
      {'name': '쇼핑', 'icon': Icons.shopping_bag},
      {'name': '기타', 'icon': Icons.more_horiz},
    ];

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => CategoryDetailPage(
                        categoryName: category['name'],
                        categoryIcon: category['icon'],
                      ),
                ),
              );
            },
            child: Container(
              width: 80,
              margin: EdgeInsets.only(
                right: index != categories.length - 1 ? 16 : 0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      category['icon'],
                      size: 32,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    category['name'],
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
    );
  }
}
