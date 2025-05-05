import 'package:flutter/material.dart';
import '../widgets/custom_header.dart';
import '../widgets/custom_drawer.dart';

class Schedule {
  final String title;
  final String description;
  final DateTime date;

  Schedule({
    required this.title,
    required this.description,
    required this.date,
  });
}

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime _selectedDate = DateTime.now();
  List<Schedule> _schedules = [];
  bool _showCalendar = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      endDrawer: const CustomDrawer(),
      floatingActionButton:
          _showCalendar
              ? FloatingActionButton(
                onPressed: () => _showAddScheduleDialog(context),
                backgroundColor: Colors.black87,
                child: const Icon(Icons.add, color: Colors.white),
              )
              : null,
      body: SafeArea(
        child: Column(
          children: [
            CustomHeader(
              onMenuTap: () {
                _scaffoldKey.currentState?.openEndDrawer();
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '스케줄',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (!_showCalendar)
                      _buildConnectPrompt()
                    else
                      Expanded(
                        child: Column(
                          children: [
                            _buildCalendar(),
                            const SizedBox(height: 16),
                            _buildScheduleList(),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConnectPrompt() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.calendar_today_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 24),
          const Text(
            '스케줄 관리를 시작하세요',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            '할인 일정을 효율적으로 관리하세요',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _showCalendar = true;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black87,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('시작하기', style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () {
                    setState(() {
                      _selectedDate = DateTime(
                        _selectedDate.year,
                        _selectedDate.month - 1,
                        1,
                      );
                    });
                  },
                ),
                Text(
                  '${_selectedDate.year}년 ${_selectedDate.month}월',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: () {
                    setState(() {
                      _selectedDate = DateTime(
                        _selectedDate.year,
                        _selectedDate.month + 1,
                        1,
                      );
                    });
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(color: Colors.grey[100]),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('일'),
                Text('월'),
                Text('화'),
                Text('수'),
                Text('목'),
                Text('금'),
                Text('토'),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 1,
              ),
              itemCount: _getDaysInMonth(),
              itemBuilder: (context, index) {
                final day = index + 1;
                final date = DateTime(
                  _selectedDate.year,
                  _selectedDate.month,
                  day,
                );
                final hasSchedule = _schedules.any(
                  (schedule) =>
                      schedule.date.year == date.year &&
                      schedule.date.month == date.month &&
                      schedule.date.day == day,
                );

                return GestureDetector(
                  onTap: () => _showDaySchedules(date),
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                      color: hasSchedule ? Colors.grey[200] : null,
                    ),
                    child: Center(
                      child: Text(
                        '$day',
                        style: const TextStyle(color: Colors.black87),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          _buildScheduleList(),
        ],
      ),
    );
  }

  Widget _buildScheduleList() {
    final todaySchedules =
        _schedules
            .where(
              (schedule) =>
                  schedule.date.year == _selectedDate.year &&
                  schedule.date.month == _selectedDate.month,
            )
            .toList();

    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '이번 달 일정',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => _showAddScheduleDialog(context),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child:
                todaySchedules.isEmpty
                    ? Center(
                      child: Text(
                        '등록된 일정이 없습니다',
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                    )
                    : ListView.builder(
                      itemCount: todaySchedules.length,
                      itemBuilder: (context, index) {
                        final schedule = todaySchedules[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            title: Text(schedule.title),
                            subtitle: Text(schedule.description),
                            trailing: Text('${schedule.date.day}일'),
                            onTap:
                                () =>
                                    _showEditScheduleDialog(context, schedule),
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }

  void _showAddScheduleDialog(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    DateTime selectedDate = _selectedDate;

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('일정 추가'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: '제목',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: '설명',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2024),
                      lastDate: DateTime(2026),
                    );
                    if (date != null) {
                      selectedDate = date;
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                  ),
                  child: const Text('날짜 선택'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  '취소',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (titleController.text.isNotEmpty) {
                    setState(() {
                      _schedules.add(
                        Schedule(
                          title: titleController.text,
                          description: descriptionController.text,
                          date: selectedDate,
                        ),
                      );
                    });
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87,
                ),
                child: const Text('추가'),
              ),
            ],
          ),
    );
  }

  void _showEditScheduleDialog(BuildContext context, Schedule schedule) {
    final titleController = TextEditingController(text: schedule.title);
    final descriptionController = TextEditingController(
      text: schedule.description,
    );
    DateTime selectedDate = schedule.date;

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('일정 수정'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: '제목',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: '설명',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2024),
                      lastDate: DateTime(2026),
                    );
                    if (date != null) {
                      selectedDate = date;
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                  ),
                  child: const Text('날짜 선택'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _schedules.remove(schedule);
                  });
                  Navigator.pop(context);
                },
                child: const Text('삭제', style: TextStyle(color: Colors.red)),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  '취소',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (titleController.text.isNotEmpty) {
                    setState(() {
                      _schedules.remove(schedule);
                      _schedules.add(
                        Schedule(
                          title: titleController.text,
                          description: descriptionController.text,
                          date: selectedDate,
                        ),
                      );
                    });
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87,
                ),
                child: const Text('수정'),
              ),
            ],
          ),
    );
  }

  void _showDaySchedules(DateTime date) {
    final daySchedules =
        _schedules
            .where(
              (schedule) =>
                  schedule.date.year == date.year &&
                  schedule.date.month == date.month &&
                  schedule.date.day == date.day,
            )
            .toList();

    showModalBottomSheet(
      context: context,
      builder:
          (context) => Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${date.month}월 ${date.day}일 일정',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                if (daySchedules.isEmpty)
                  const Text('일정이 없습니다.')
                else
                  ...daySchedules.map(
                    (schedule) => ListTile(
                      title: Text(schedule.title),
                      subtitle: Text(schedule.description),
                      onTap: () {
                        Navigator.pop(context);
                        _showEditScheduleDialog(context, schedule);
                      },
                    ),
                  ),
              ],
            ),
          ),
    );
  }

  int _getDaysInMonth() {
    return DateTime(_selectedDate.year, _selectedDate.month + 1, 0).day;
  }
}
