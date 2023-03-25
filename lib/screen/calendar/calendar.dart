import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ohana_care/constant.dart';
import 'package:ohana_care/model/event.dart';
import 'package:ohana_care/model/pregnancy_data.dart';
import 'package:ohana_care/model/pregnancy_phase.dart';
import 'package:ohana_care/model/symptoms_data.dart';
import 'package:ohana_care/model/weight_data.dart';
import 'package:ohana_care/provider/calendar_provider.dart';
import 'package:ohana_care/screen/calendar/calendarTool/event_push.dart';
import 'package:ohana_care/screen/calendar/calendarTool/period.dart';
import 'package:ohana_care/screen/calendar/calendarTool/pregnancy_calculation.dart';
import 'package:ohana_care/screen/calendar/calendarTool/symptoms.dart';
import 'package:ohana_care/screen/calendar/calendarTool/weight.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:intl/intl.dart';
import '../../model/period_data.dart';
import '../../provider/auth_provider.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime now = DateTime.now().toLocal();
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  CalendarFormat _calendarFormat = CalendarFormat.month;

  var weekdays = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];
  var weekmonths = [
    'Dec',
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov'
  ];

  Map<DateTime, List<dynamic>> _events = {};
  List<dynamic> _selectedEvents = [];

  List<WeightData> _futureUserWeight = [];
  List<SymptomsData> _futureUserSymptoms = [];
  List<EventData> _futureUserEvents = [];
  List<PeriodData> _futureUserPeriod = [];
  PregnancyData? _futurePregnancyDate;

  void encodeMapForPregnancy(PregnancyData map) {
    DateTime startDay = DateTime.parse(map.lastDayPeriod);
    startDay = DateTime.utc(startDay.year, startDay.month, startDay.day);
    DateTime lastDay = DateTime.parse(map.expectedDeliveryDate);
    Duration dur = lastDay.difference(startDay);

    for (int i = 0, j = 1; i <= dur.inDays + 1; i++) {
      if ((i + 1) % 7 == 0) j++;
      DateTime temp = startDay.add(Duration(days: i));
      String phase = "";

      if (j >= 1 && j <= 13) {
        phase = "first trimester";
      } else if (j >= 14 && j <= 27) {
        phase = "second trimester";
      } else if (j >= 28 && j <= 40) {
        phase = "third trimester";
      }

      PregnancyPhase pregnancyPhase =
          PregnancyPhase(phase: phase, week: j.toString());
      if (_events[temp] == null) {
        _events[temp] = [pregnancyPhase];
      } else {
        _events[temp]!.add(pregnancyPhase);
      }
    }
  }

  void encodeMapForPeriod(List<PeriodData> map) {
    for (var data in map) {
      DateTime startDay = DateTime.parse(data.startDayPeriod);
      startDay = DateTime.utc(startDay.year, startDay.month, startDay.day);
      DateTime lastDay = DateTime.parse(data.endDayPeriod);
      Duration dur = lastDay.difference(startDay);

      for (int i = 0; i <= dur.inDays + 1; i++) {
        DateTime temp = startDay.add(Duration(days: i));
        if (_events[temp] == null) {
          _events[temp] = ['Period Day ${i + 1}'];
        } else {
          _events[temp]!.add('Period Day ${i + 1}');
        }
      }
    }
  }

  void encodeMapForEvent(List<EventData> map) {
    for (var data in map) {
      DateTime date = DateTime.parse(data.startDate);
      date = DateTime.utc(date.year, date.month, date.day);
      if (_events[date] == null) {
        _events[date] = [data];
      } else {
        _events[date]!.add(data);
      }
    }
  }

  void encodeMapForSymptoms(List<SymptomsData> map) {
    for (var data in map) {
      DateTime date = DateTime.parse(data.symptomsDate);
      date = DateTime.utc(date.year, date.month, date.day);
      if (_events[date] == null) {
        _events[date] = [data];
      } else {
        _events[date]!.add(data);
      }
    }
  }

  void encodeMapForWeight(List<WeightData> map) {
    for (var data in map) {
      DateTime date = DateTime.parse(data.start);
      date = DateTime.utc(date.year, date.month, date.day);
      if (_events[date] == null) {
        _events[date] = [data];
      } else {
        _events[date]!.add(data);
      }
    }
  }

  List<dynamic> _getEventsForDay(DateTime day) {
    // Implementation example
    return _events[day] ?? [];
  }

  @override
  void initState() {
    super.initState();
    _events = {};

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final calendarProvider =
        Provider.of<CalendarProvider>(context, listen: false);
    Future.wait([
      calendarProvider
          .fetchUserPeriod(authProvider.getUserData.id)
          .then((value) {
        if (!mounted) return;
        setState(() {
          _futureUserPeriod = value;
          encodeMapForPeriod(_futureUserPeriod);
        });
      }),
      calendarProvider
          .fetchUserEvent(authProvider.getUserData.id)
          .then((value) {
        if (!mounted) return;    
        setState(() {
          _futureUserEvents = value;
          encodeMapForEvent(_futureUserEvents);
        });
      }),
      calendarProvider
          .fetchUserWeight(authProvider.getUserData.id)
          .then((value) {
        if (!mounted) return;
        setState(() {
          _futureUserWeight = value;
          encodeMapForWeight(_futureUserWeight);
        });
      }),
      calendarProvider
          .fetchUserSymptoms(authProvider.getUserData.id)
          .then((value) {
        if (!mounted) return;
        setState(() {
          _futureUserSymptoms = value;
          print(_futureUserSymptoms);
          encodeMapForSymptoms(_futureUserSymptoms);
        });
      }),
      calendarProvider
          .fetchUserPregnancy(authProvider.getUserData.id)
          .then((value) {
        if (value == null) return;
        if (!mounted) return;
        setState(() {
          _futurePregnancyDate = value;
          encodeMapForPregnancy(_futurePregnancyDate!);
        });
      })
    ]).then((value) {
      print(_events);
    });
  }

  void onRefresh() async {
    _events = {};

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final calendarProvider =
        Provider.of<CalendarProvider>(context, listen: false);
    Future.wait([
      calendarProvider
          .fetchUserPeriod(authProvider.getUserData.id)
          .then((value) {
        if (!mounted) return;
        setState(() {
          _futureUserPeriod = value;
          encodeMapForPeriod(_futureUserPeriod);
        });
      }),
      calendarProvider
          .fetchUserEvent(authProvider.getUserData.id)
          .then((value) {
        if (!mounted) return;
        setState(() {
          _futureUserEvents = value;
          encodeMapForEvent(_futureUserEvents);
        });
      }),
      calendarProvider
          .fetchUserWeight(authProvider.getUserData.id)
          .then((value) {
        if (!mounted) return;
        setState(() {
          _futureUserWeight = value;
          encodeMapForWeight(_futureUserWeight);
        });
      }),
      calendarProvider
          .fetchUserSymptoms(authProvider.getUserData.id)
          .then((value) {
        if (!mounted) return;
        setState(() {
          _futureUserSymptoms = value;
          encodeMapForSymptoms(_futureUserSymptoms);
        });
      }),
      calendarProvider
          .fetchUserPregnancy(authProvider.getUserData.id)
          .then((value) {
        if (value == null) return;
        if (!mounted) return;
        setState(() {
          _futurePregnancyDate = value;
          encodeMapForPregnancy(_futurePregnancyDate!);
        });
      })
    ]).then((value) {
      print(_events);
    });
  }

  _showToolsForCalendar() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: Colors.white,
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.25,
                child: authProvider.getUserData.role == 'Wife'
                  ? Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () async {
                            final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Period()));
                            if (result == 'success') {
                              onRefresh();
                            }
                          },
                          child: const CalendarWorkSelection(
                            imageAddress: 'assets/icons/period.png',
                            title: 'Period',
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PregnancyCalculation()));
                            if (result == 'success') {
                              onRefresh();
                            }
                          },
                          child: const CalendarWorkSelection(
                            imageAddress: 'assets/icons/pregnant.png',
                            title: 'Pregnancy',
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const EventPush()));
                            if (result == 'success') {
                              onRefresh();
                            }
                          },
                          child: const CalendarWorkSelection(
                            imageAddress: 'assets/icons/event.png',
                            title: 'Event',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () async {
                            final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Symptoms()));
                            if (result == 'success') {
                              onRefresh();
                            }
                          },
                          child: const CalendarWorkSelection(
                            imageAddress: 'assets/icons/symptoms.png',
                            title: 'Symptoms',
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Weight()));
                            if (result == 'success') {
                              onRefresh();
                            }
                          },
                          child: const CalendarWorkSelection(
                            imageAddress: 'assets/icons/weight.png',
                            title: 'Weight',
                          ),
                        ),
                      ],
                    ),
                  ],
                ) : Center(
                  child: InkWell(
                    onTap: () async {
                      final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EventPush()));
                      if (result == 'success') {
                        onRefresh();
                      }
                    },
                    child: const CalendarWorkSelection(
                      imageAddress: 'assets/icons/event.png',
                      title: 'Event',
                    ),
                  ),
                ),
              ),
            ));
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents = _getEventsForDay(_selectedDay!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kRed,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Image(
            image: authProvider.getUserData.role == "Husband"
                ? const AssetImage('assets/male_stitch.png')
                : const AssetImage('assets/female_stitch.png'),
          ),
        ),
        actions: <Widget>[
          Row(
            children: [
              Text(
                '${now.day}',
                style: const TextStyle(color: Colors.black, fontSize: 36),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    weekdays[now.weekday % 7],
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  Text(
                    '${weekmonths[now.month % 12]} ${now.year}',
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  )
                ],
              ),
              const SizedBox(width: 20),
            ],
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: kRedBackground,
                    borderRadius: BorderRadius.circular(20)),
                child: TableCalendar(
                  locale: 'en_US',
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  rangeStartDay: _rangeStart,
                  rangeEndDay: _rangeEnd,
                  onDaySelected: _onDaySelected,
                  onRangeSelected: _onRangeSelected,
                  calendarFormat: _calendarFormat,
                  onFormatChanged: (format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                  eventLoader: _getEventsForDay,
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: _focusedDay,
                  calendarStyle: CalendarStyle(
                    tablePadding: const EdgeInsets.all(10),
                    canMarkersOverflow: true,
                    todayDecoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey[500]),
                    selectedDecoration: const BoxDecoration(
                        shape: BoxShape.circle, color: kRed),
                  ),
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (BuildContext context, date, events) {
                      if (events.isEmpty) return const SizedBox();
                      return ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: events.length > 4 ? 4 : events.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(top: 30),
                              padding: const EdgeInsets.all(1),
                              child: Container(
                                width: 7,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: events[index] is EventData
                                        ? Colors.black
                                        : events[index] is PregnancyPhase
                                            ? Colors.deepPurple
                                            : events[index] is WeightData
                                                ? Colors.brown.shade500
                                                : events[index] is SymptomsData
                                                    ? Colors.red[800]
                                                    : Colors.orange[800]),
                              ),
                            );
                          });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              ..._selectedEvents.map((event) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              width: 1.8,
                              color: event is EventData
                                  ? Colors.black
                                  : event is PregnancyPhase
                                      ? Colors.deepPurple
                                      : event is WeightData
                                          ? Colors.brown.shade500
                                          : event is SymptomsData
                                              ? const Color.fromRGBO(
                                                  198, 40, 40, 1)
                                              : const Color.fromRGBO(
                                                  239, 108, 0, 1))),
                      child: event is WeightData
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Weight : ${event.weight}',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14)),
                            )
                          : event is SymptomsData
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Symptoms : ${event.symptomsDetail}',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14)),
                                      const SizedBox(height: 5),
                                      Text(
                                          'Start Time : ${DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.parse(event.symptomsDate))}',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14)),
                                    ],
                                  ),
                                )
                              : event is PregnancyPhase
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Pregnancy : Week ${event.week}',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14)),
                                          const SizedBox(height: 5),
                                          Text('Phase: ${event.phase}',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 13)),
                                        ],
                                      ),
                                    )
                                  : event is EventData
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  'By : ${event.role}',
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14)),
                                              const SizedBox(height: 5),
                                              Text(
                                                  'Event Detail : ${event.eventName}',
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14)),
                                              const SizedBox(height: 5),
                                              Text(
                                                  'Event Location: ${event.location}',
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14)),
                                              const SizedBox(height: 5),
                                              Text(
                                                  'Start Time : ${DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.parse(event.startDate))}',
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 13)),
                                              const SizedBox(height: 5),
                                              Text(
                                                  'End Time : ${DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.parse(event.endDate))}',
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 13)),
                                            ],
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(event,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14)),
                                        ),
                    ),
                  )),
              const SizedBox(height: 50.0),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kRed,
        child: const Icon(Icons.add),
        onPressed: () {
          _showToolsForCalendar();
        },
      ),
    );
  }
}

class CalendarWorkSelection extends StatelessWidget {
  final String imageAddress;
  final String title;

  const CalendarWorkSelection({
    required this.imageAddress,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Image(image: AssetImage(imageAddress)),
      const SizedBox(height: 5),
      Text(title,
          style: const TextStyle(
              color: kRed, fontSize: 12, fontWeight: FontWeight.w500))
    ]);
  }
}
