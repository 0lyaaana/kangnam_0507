import 'package:flutter/material.dart';
import 'package:my_app/models/schedule.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  bool _isGoogleConnected = false;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('스케줄'),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Google 캘린더 연동',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Switch(
                      value: _isGoogleConnected,
                      onChanged: (value) {
                        setState(() {
                          _isGoogleConnected = value;
                        });
                        if (value) {
                          _connectGoogleCalendar();
                        } else {
                          _disconnectGoogleCalendar();
                        }
                      },
                    ),
                  ],
                ),
                Text(
                  _isGoogleConnected
                      ? '연동된 계정: user@gmail.com'
                      : '캘린더 연동 시 자동으로 일정이 동기화됩니다.',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          if (_isGoogleConnected)
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: schedules.length,
                itemBuilder: (context, index) {
                  final schedule = schedules[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            schedule.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_today,
                                size: 16,
                                color: Colors.blue,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _formatDate(schedule.dateTime),
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 16,
                                color: Colors.red,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                schedule.location,
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          else
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Google 캘린더와 연동하여\n할인 일정을 관리해보세요.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _isGoogleConnected = true;
                        });
                        _connectGoogleCalendar();
                      },
                      child: const Text(
                        'Google 계정 연동하기',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}년 ${date.month}월 ${date.day}일';
  }

  void _connectGoogleCalendar() {
    // TODO: Implement Google Calendar connection
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Google 캘린더가 연동되었습니다.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _disconnectGoogleCalendar() {
    // TODO: Implement Google Calendar disconnection
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Google 캘린더 연동이 해제되었습니다.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
