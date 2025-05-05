import 'package:flutter/material.dart';
import 'package:my_app/models/discount.dart';
import '../../widgets/custom_header.dart';
import '../../widgets/custom_drawer.dart';

class DiscountDetailsPage extends StatefulWidget {
  final String mainCategory;
  final String? initialStore;

  const DiscountDetailsPage({
    super.key,
    required this.mainCategory,
    this.initialStore,
  });

  @override
  State<DiscountDetailsPage> createState() => _DiscountDetailsPageState();
}

class _DiscountDetailsPageState extends State<DiscountDetailsPage> {
  late String selectedCategory;
  late List<String> categories;

  final Map<String, List<String>> categoryMap = {
    '음식': ['버거킹', '국수나무', '역전우동', '쿵푸마라'],
    '카페': ['스타벅스', '투썸플레이스', '이디야', '메가커피'],
    '문화': ['CGV', '메가박스', '롯데시네마', '예스24'],
    '쇼핑': ['올리브영', '다이소', '이마트', '홈플러스'],
  };

  final Map<String, List<Discount>> discountsByCategory = {
    // 음식 카테고리 할인
    '버거킹': [
      Discount(
        title: '와퍼 1+1',
        description: '와퍼 구매시 1개 추가 증정',
        expiryDate: '2024-12-31',
        discountAmount: 8000,
        conditions: '매장 방문 주문시에만 적용',
        category: '버거킹',
        cardColor: Colors.red.shade100,
      ),
      Discount(
        title: '스탬프 2배 적립',
        description: '주문 시 스탬프 2배 적립',
        expiryDate: '2024-10-31',
        discountAmount: 0,
        conditions: '모든 메뉴 적용',
        category: '버거킹',
        cardColor: Colors.green.shade100,
      ),
    ],
    '국수나무': [
      Discount(
        title: '전 메뉴 15% 할인',
        description: '모든 메뉴 15% 할인',
        expiryDate: '2024-12-31',
        discountAmount: 15,
        conditions: '중복 할인 불가',
        category: '국수나무',
        isPercentage: true,
        cardColor: Colors.red.shade100,
      ),
    ],
    '역전우동': [
      Discount(
        title: '우동 사이드 무료',
        description: '우동 주문시 사이드 무료',
        expiryDate: '2024-11-30',
        discountAmount: 3000,
        conditions: '평일 점심시간에만 적용',
        category: '역전우동',
        cardColor: Colors.green.shade100,
      ),
    ],
    '쿵푸마라': [
      Discount(
        title: '마라탕 30% 할인',
        description: '마라탕 주문시 30% 할인',
        expiryDate: '2024-12-31',
        discountAmount: 30,
        conditions: '매장 방문 주문시에만 적용',
        category: '쿵푸마라',
        isPercentage: true,
        cardColor: Colors.red.shade100,
      ),
    ],
    // 카페 카테고리 할인
    '스타벅스': [
      Discount(
        title: '아메리카노 1+1',
        description: '아메리카노 주문시 1잔 추가',
        expiryDate: '2024-12-31',
        discountAmount: 4500,
        conditions: '오후 2시~5시 사이 주문 가능',
        category: '스타벅스',
        cardColor: Colors.green.shade100,
      ),
    ],
    '투썸플레이스': [
      Discount(
        title: '케이크 30% 할인',
        description: '모든 케이크 30% 할인',
        expiryDate: '2024-11-30',
        discountAmount: 30,
        conditions: '평일에만 적용',
        category: '투썸플레이스',
        isPercentage: true,
        cardColor: Colors.red.shade100,
      ),
    ],
    '이디야': [
      Discount(
        title: '음료 2잔 이상 구매시 20% 할인',
        description: '전 음료 메뉴 적용',
        expiryDate: '2024-12-31',
        discountAmount: 20,
        conditions: '2잔 이상 주문시',
        category: '이디야',
        isPercentage: true,
        cardColor: Colors.green.shade100,
      ),
    ],
    '메가커피': [
      Discount(
        title: '시즌 음료 1,000원 할인',
        description: '신메뉴 할인',
        expiryDate: '2024-10-31',
        discountAmount: 1000,
        conditions: '매장별 상이',
        category: '메가커피',
        cardColor: Colors.red.shade100,
      ),
    ],
    // 문화 카테고리 할인
    'CGV': [
      Discount(
        title: '영화 2인 패키지',
        description: '팝콘 + 음료 + 영화 2인 티켓',
        expiryDate: '2024-12-31',
        discountAmount: 10000,
        conditions: '주중에만 사용 가능',
        category: 'CGV',
        cardColor: Colors.red.shade100,
      ),
    ],
    '메가박스': [
      Discount(
        title: '조조 영화 50% 할인',
        description: '오전 영화 상영 할인',
        expiryDate: '2024-12-31',
        discountAmount: 50,
        conditions: '오전 11시 이전 상영작만 적용',
        category: '메가박스',
        isPercentage: true,
        cardColor: Colors.green.shade100,
      ),
    ],
    '롯데시네마': [
      Discount(
        title: '학생 할인 30%',
        description: '학생증 소지자 할인',
        expiryDate: '2024-12-31',
        discountAmount: 30,
        conditions: '학생증 필수',
        category: '롯데시네마',
        isPercentage: true,
        cardColor: Colors.red.shade100,
      ),
    ],
    '예스24': [
      Discount(
        title: '신간도서 20% 할인',
        description: '모든 신간 도서 할인',
        expiryDate: '2024-10-31',
        discountAmount: 20,
        conditions: '온라인 주문만 가능',
        category: '예스24',
        isPercentage: true,
        cardColor: Colors.green.shade100,
      ),
    ],
    // 쇼핑 카테고리 할인
    '올리브영': [
      Discount(
        title: '전 품목 10% 할인',
        description: '2만원 이상 구매시',
        expiryDate: '2024-12-31',
        discountAmount: 10,
        conditions: '일부 품목 제외',
        category: '올리브영',
        isPercentage: true,
        cardColor: Colors.red.shade100,
      ),
    ],
    '다이소': [
      Discount(
        title: '5000원 할인',
        description: '2만원 이상 구매시',
        expiryDate: '2024-11-30',
        discountAmount: 5000,
        conditions: '매장 방문 구매만 가능',
        category: '다이소',
        cardColor: Colors.green.shade100,
      ),
    ],
    '이마트': [
      Discount(
        title: '신선식품 20% 할인',
        description: '과일, 채소, 정육 대상',
        expiryDate: '2024-12-31',
        discountAmount: 20,
        conditions: '신세계 포인트 회원 대상',
        category: '이마트',
        isPercentage: true,
        cardColor: Colors.red.shade100,
      ),
    ],
    '홈플러스': [
      Discount(
        title: '첫 주문 15,000원 할인',
        description: '온라인 첫 주문 할인',
        expiryDate: '2024-12-31',
        discountAmount: 15000,
        conditions: '5만원 이상 구매시',
        category: '홈플러스',
        cardColor: Colors.green.shade100,
      ),
    ],
  };

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    categories = categoryMap[widget.mainCategory] ?? [];
    selectedCategory =
        widget.initialStore ?? (categories.isNotEmpty ? categories[0] : '');
  }

  void _showDiscountDetails(BuildContext context, Discount discount) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '혜택 이름',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(discount.title, style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 10),
                Text('혜택 조건', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 10),
                Text(discount.conditions, style: const TextStyle(fontSize: 14)),
                const SizedBox(height: 20),
                Text(
                  '유효 기간: ${discount.expiryDate}',
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${discount.title} 혜택이 적용되었습니다.'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    child: const Text('확인', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(
                    widget.mainCategory == '음식'
                        ? Icons.restaurant
                        : widget.mainCategory == '카페'
                        ? Icons.coffee
                        : widget.mainCategory == '문화'
                        ? Icons.movie
                        : Icons.shopping_bag,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.mainCategory,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = category == selectedCategory;
                  return Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                      child: Text(
                        category,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                          decoration:
                              isSelected
                                  ? TextDecoration.underline
                                  : TextDecoration.none,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: discountsByCategory[selectedCategory]?.length ?? 0,
                itemBuilder: (context, index) {
                  final discounts = discountsByCategory[selectedCategory];
                  if (discounts == null || discounts.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.info_outline,
                            size: 48,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            '현재 정보가 없습니다.',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  }

                  final discount = discounts[index];
                  final isEvenIndex = index % 2 == 0;
                  return GestureDetector(
                    onTap: () => _showDiscountDetails(context, discount),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color:
                            isEvenIndex
                                ? Colors.red.shade100
                                : Colors.green.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '할인 금액',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            discount.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '유효 기간: ${discount.expiryDate}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
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
        ),
      ),
    );
  }
}
