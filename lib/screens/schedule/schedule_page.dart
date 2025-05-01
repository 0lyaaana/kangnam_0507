import 'package:flutter/material.dart';
import 'package:my_app/models/schedule.dart';

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
