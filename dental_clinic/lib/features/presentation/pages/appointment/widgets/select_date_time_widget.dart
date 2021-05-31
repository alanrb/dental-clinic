import 'package:dental_clinic/features/presentation/styles.dart';
import 'package:dental_clinic/features/presentation/widgets/widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:table_calendar/table_calendar.dart';

class SelectDateTimeWidget extends StatefulWidget {
  SelectDateTimeWidget({required this.onTimeSelected});

  final void Function(DateTime time) onTimeSelected;

  @override
  _SelectDateTimeWidgetState createState() => _SelectDateTimeWidgetState();
}

class _SelectDateTimeWidgetState extends State<SelectDateTimeWidget> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(children: [
          Padding(padding: Styles.space_m, child: Header('Select Time')),
          TableCalendar(
              firstDay: DateTime.now(),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              })
        ]),
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                margin: Styles.space_m,
                width: double.infinity,
                child: StyledButton(
                  onPressed: () => {
                    if (_selectedDay != null)
                      {widget.onTimeSelected(_selectedDay!)}
                  },
                  child: Text('NEXT'),
                )))
      ],
    );
  }
}
