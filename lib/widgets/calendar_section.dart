import 'package:flutter/material.dart';

class CalendarSection extends StatefulWidget {
  const CalendarSection({Key? key}) : super(key: key);

  @override
  State<CalendarSection> createState() => _CalendarSectionState();
}

class _CalendarSectionState extends State<CalendarSection> {
  bool _isCalendarConnected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          if (!_isCalendarConnected)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.calendar_month,
                    size: 48,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '캘린더와 일정을 동기화하고\n관련 혜택 정보를 받아보세요!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isCalendarConnected = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('구글 캘린더 연동하기'),
                  ),
                ],
              ),
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${DateTime.now().year}년 ${DateTime.now().month}월',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children:
                              ['일', '월', '화', '수', '목', '금', '토']
                                  .map(
                                    (day) => Text(
                                      day,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                            day == '일'
                                                ? Colors.red
                                                : Colors.black,
                                      ),
                                    ),
                                  )
                                  .toList(),
                        ),
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 7,
                              childAspectRatio: 1.0,
                            ),
                        itemCount: 35,
                        itemBuilder: (context, index) {
                          final day = index + 1;
                          final hasEvent = [5, 7, 14, 21, 28].contains(day);
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.shade200,
                                width: 0.5,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  day.toString(),
                                  style: TextStyle(
                                    color:
                                        hasEvent ? Colors.blue : Colors.black,
                                  ),
                                ),
                                if (hasEvent)
                                  Container(
                                    margin: const EdgeInsets.only(top: 4),
                                    width: 6,
                                    height: 6,
                                    decoration: const BoxDecoration(
                                      color: Colors.blue,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
