import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/benefit_card.dart';
import '../widgets/category_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'SNAG THE DEAL',
        onMenuPressed: () {
          Scaffold.of(context).openEndDrawer();
        },
      ),
      endDrawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                '추천 혜택',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                children: const [
                  BenefitCard(
                    imagePath: 'assets/images/benefit1.jpg',
                    title: '스타벅스',
                    discount: '2,000원 할인',
                    description: '아메리카노 주문 시 즉시 할인',
                  ),
                  BenefitCard(
                    imagePath: 'assets/images/benefit2.jpg',
                    title: '교내 카페',
                    discount: '10% 할인',
                    description: '모든 음료 주문 시 학생 할인',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            CategorySection(
              categoryName: '식당',
              categoryIcon: Icons.restaurant,
              subCategories: const [
                '전체',
                '교내 식당',
                '한식',
                '중식',
                '일식',
                '양식',
                '카페',
              ],
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  DiscountCard(
                    storeName: '학생 식당',
                    discountInfo: '점심 메뉴 500원 할인',
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder:
                            (context) => const DiscountDetailModal(
                              storeName: '학생 식당',
                              discountInfo: '점심 메뉴 500원 할인',
                              additionalInfo: '평일 11:00-14:00 사이 이용 가능',
                            ),
                      );
                    },
                  ),
                  DiscountCard(
                    storeName: '교내 카페',
                    discountInfo: '아메리카노 1+1',
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder:
                            (context) => const DiscountDetailModal(
                              storeName: '교내 카페',
                              discountInfo: '아메리카노 1+1',
                              additionalInfo: '매일 14:00-17:00 사이 이용 가능',
                            ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
