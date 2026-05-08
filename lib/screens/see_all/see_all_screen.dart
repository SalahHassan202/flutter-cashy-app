import 'package:cashy_app/colors/app_colors.dart';
import 'package:cashy_app/cubit/fetchCubit/fetch_data_cubit.dart';
import 'package:cashy_app/models/finance_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class SeeAllScreen extends StatefulWidget {
  const SeeAllScreen({super.key});

  @override
  State<SeeAllScreen> createState() => _SeeAllScreenState();
}

class _SeeAllScreenState extends State<SeeAllScreen> {
  CalendarFormat calendarFormat = CalendarFormat.week;

  DateTime mySelectedDay = DateTime.now();

  DateTime myFocusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();

    BlocProvider.of<FetchDataCubit>(
      context,
    ).fetchDateData(dateTime: mySelectedDay);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("All Activities")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: BlocBuilder<FetchDataCubit, FetchDataState>(
          builder: (context, state) {
            List<FinanceModel> myList = BlocProvider.of<FetchDataCubit>(
              context,
            ).dateFinanceList;

            return Column(
              children: [
                TableCalendar(
                  firstDay: DateTime(2023),

                  lastDay: DateTime.now(),

                  focusedDay: myFocusedDay,

                  calendarFormat: calendarFormat,

                  currentDay: mySelectedDay,

                  onFormatChanged: (format) {
                    setState(() {
                      calendarFormat = format;
                    });
                  },

                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      mySelectedDay = selectedDay;

                      myFocusedDay = focusedDay;
                    });

                    BlocProvider.of<FetchDataCubit>(
                      context,
                    ).fetchDateData(dateTime: mySelectedDay);
                  },
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: ListView.builder(
                    itemCount: myList.length,

                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),

                        decoration: BoxDecoration(
                          color: kWhiteColor,
                          borderRadius: BorderRadius.circular(14),
                        ),

                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: myList[index].financeValue > 0
                                  ? kSeconderyGreen
                                  : kSeconderyRed,
                            ),

                            const SizedBox(width: 12),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(myList[index].details),

                                Text(
                                  DateFormat.yMMMEd().format(
                                    myList[index].date,
                                  ),
                                ),
                              ],
                            ),

                            const Spacer(),

                            Text(
                              myList[index].financeValue > 0
                                  ? "+${myList[index].financeValue}"
                                  : myList[index].financeValue.toString(),

                              style: TextStyle(
                                color: myList[index].financeValue > 0
                                    ? kPrimaryGreen
                                    : kPrimaryRed,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
