import 'package:flutter/material.dart';
import 'package:my_app/models/discount.dart';

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
    Navigator.of(context).pop();
  }
}
