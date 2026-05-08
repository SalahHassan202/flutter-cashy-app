import 'package:cashy_app/cubit/fetchCubit/fetch_data_cubit.dart';
import 'package:cashy_app/models/finance_model.dart';
import 'package:cashy_app/screens/add/add_screen.dart';
import 'package:cashy_app/screens/see_all/see_all_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<FetchDataCubit>(context).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),

      body: SafeArea(
        child: BlocBuilder<FetchDataCubit, FetchDataState>(
          builder: (context, state) {
            if (state is FetchDataLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            List<FinanceModel> myList = BlocProvider.of<FetchDataCubit>(
              context,
            ).todayFinanceList.reversed.toList();

            return Padding(
              padding: const EdgeInsets.all(16),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      const Text(
                        "Welcome, Salah",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const Icon(Icons.settings),
                    ],
                  ),

                  Gap(20),

                  Container(
                    width: double.infinity,

                    padding: const EdgeInsets.all(16),

                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(16),
                    ),

                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          "My Balance",
                          style: TextStyle(color: Colors.white70),
                        ),

                        SizedBox(height: 10),

                        Text(
                          "698",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Gap(16),

                  Container(
                    width: double.infinity,

                    padding: const EdgeInsets.all(16),

                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(16),
                    ),

                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text("Today", style: TextStyle(color: Colors.white70)),

                        SizedBox(height: 10),

                        Text(
                          "0.00",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Gap(20),

                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const AddScreen(isPlus: true),
                              ),
                            );
                          },

                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14),

                            decoration: BoxDecoration(
                              color: Colors.green.shade200,

                              borderRadius: BorderRadius.circular(14),
                            ),

                            child: const Center(child: Text("+ Plus")),
                          ),
                        ),
                      ),

                      Gap(12),

                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const AddScreen(isPlus: false),
                              ),
                            );
                          },

                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14),

                            decoration: BoxDecoration(
                              color: Colors.red.shade200,

                              borderRadius: BorderRadius.circular(14),
                            ),

                            child: const Center(child: Text("- Minus")),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Gap(20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      const Text(
                        "Activity",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SeeAllScreen(),
                            ),
                          );
                        },

                        child: const Text("See All"),
                      ),
                    ],
                  ),

                  Gap(10),

                  Expanded(
                    child: ListView.builder(
                      itemCount: myList.length,

                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: myList[index].financeValue > 0
                                ? Colors.green
                                : Colors.red,
                          ),

                          title: Text(myList[index].details),

                          subtitle: Text(
                            DateFormat.yMMMEd().format(myList[index].date),
                          ),

                          trailing: Text(
                            myList[index].financeValue > 0
                                ? "+${myList[index].financeValue}"
                                : myList[index].financeValue.toString(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
