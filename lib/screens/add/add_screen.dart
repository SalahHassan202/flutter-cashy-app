import 'package:cashy_app/colors/app_colors.dart';
import 'package:cashy_app/cubit/addCubit/add_data_cubit.dart';
import 'package:cashy_app/cubit/fetchCubit/fetch_data_cubit.dart';
import 'package:cashy_app/models/finance_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AddScreen extends StatefulWidget {
  final bool isPlus;

  final FinanceModel? financeModel;

  const AddScreen({super.key, required this.isPlus, this.financeModel});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController detailsController = TextEditingController();

  String num = "";

  @override
  void initState() {
    super.initState();

    if (widget.financeModel != null) {
      detailsController.text = widget.financeModel!.details;

      num = widget.financeModel!.financeValue < 0
          ? (widget.financeModel!.financeValue * -1).toString()
          : widget.financeModel!.financeValue.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.isPlus ? "Plus" : "Minus")),

      body: BlocProvider(
        create: (context) => AddDataCubit(),

        child: BlocBuilder<AddDataCubit, AddDataState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),

                    decoration: BoxDecoration(
                      color: kPrimaryOrange,
                      borderRadius: BorderRadius.circular(14),
                    ),

                    child: TextField(
                      controller: detailsController,

                      style: TextStyle(color: kWhiteColor),

                      decoration: InputDecoration(
                        border: InputBorder.none,

                        hintText: "Details...",

                        hintStyle: TextStyle(color: kWhiteColor),
                      ),
                    ),
                  ),

                  Gap(20),

                  Container(
                    width: double.infinity,

                    padding: const EdgeInsets.all(20),

                    decoration: BoxDecoration(
                      color: widget.isPlus ? kSeconderyGreen : kSeconderyRed,

                      borderRadius: BorderRadius.circular(14),
                    ),

                    child: Center(
                      child: Text(
                        widget.isPlus
                            ? (num.isEmpty ? "+ 0.0" : "+ $num")
                            : (num.isEmpty ? "- 0.0" : "- $num"),

                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,

                          color: widget.isPlus ? kPrimaryGreen : kPrimaryRed,
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),

                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                KeyPadItem(
                                  text: "7",
                                  onTap: () {
                                    setState(() {
                                      num += "7";
                                    });
                                  },
                                ),

                                KeyPadItem(
                                  text: "8",
                                  onTap: () {
                                    setState(() {
                                      num += "8";
                                    });
                                  },
                                ),

                                KeyPadItem(
                                  text: "9",
                                  onTap: () {
                                    setState(() {
                                      num += "9";
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),

                          Expanded(
                            child: Row(
                              children: [
                                KeyPadItem(
                                  text: "4",
                                  onTap: () {
                                    setState(() {
                                      num += "4";
                                    });
                                  },
                                ),

                                KeyPadItem(
                                  text: "5",
                                  onTap: () {
                                    setState(() {
                                      num += "5";
                                    });
                                  },
                                ),

                                KeyPadItem(
                                  text: "6",
                                  onTap: () {
                                    setState(() {
                                      num += "6";
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),

                          Expanded(
                            child: Row(
                              children: [
                                KeyPadItem(
                                  text: "1",
                                  onTap: () {
                                    setState(() {
                                      num += "1";
                                    });
                                  },
                                ),

                                KeyPadItem(
                                  text: "2",
                                  onTap: () {
                                    setState(() {
                                      num += "2";
                                    });
                                  },
                                ),

                                KeyPadItem(
                                  text: "3",
                                  onTap: () {
                                    setState(() {
                                      num += "3";
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),

                          Expanded(
                            child: Row(
                              children: [
                                KeyPadItem(
                                  text: ".",
                                  onTap: () {
                                    setState(() {
                                      if (!num.contains(".")) {
                                        num += ".";
                                      }
                                    });
                                  },
                                ),

                                KeyPadItem(
                                  text: "0",
                                  onTap: () {
                                    setState(() {
                                      num += "0";
                                    });
                                  },
                                ),

                                KeyPadItem(
                                  text: "<",
                                  onTap: () {
                                    setState(() {
                                      if (num.isNotEmpty) {
                                        num = num.substring(0, num.length - 1);
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryOrange,

                            foregroundColor: kWhiteColor,

                            padding: const EdgeInsets.all(18),

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),

                          onPressed: () async {
                            if (num.isEmpty || detailsController.text.isEmpty) {
                              return;
                            }

                            try {
                              if (widget.financeModel != null) {
                                widget.financeModel!.details =
                                    detailsController.text;

                                widget.financeModel!.financeValue =
                                    widget.isPlus
                                    ? double.parse(num)
                                    : double.parse(num) * -1;

                                await widget.financeModel!.save();
                              } else {
                                BlocProvider.of<AddDataCubit>(context).addData(
                                  FinanceModel(
                                    details: detailsController.text,

                                    financeValue: widget.isPlus
                                        ? double.parse(num)
                                        : double.parse(num) * -1,

                                    date: DateTime.now(),
                                  ),
                                );
                              }
                              if (!context.mounted) return;
                              BlocProvider.of<FetchDataCubit>(
                                context,
                              ).fetchData();

                              if (!context.mounted) {
                                return;
                              }
                              Navigator.pop(context);
                            } catch (e) {
                              debugPrint(e.toString());
                            }
                          },

                          child: Text(
                            widget.financeModel != null ? "SAVE" : "ADD",
                          ),
                        ),
                      ),

                      Gap(16),

                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kSeconderyRed,

                            foregroundColor: kPrimaryRed,

                            padding: const EdgeInsets.all(18),

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),

                          onPressed: () {
                            Navigator.pop(context);
                          },

                          child: const Text("CANCEL"),
                        ),
                      ),
                    ],
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

class KeyPadItem extends StatelessWidget {
  final String text;

  final VoidCallback onTap;

  const KeyPadItem({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4),

        child: GestureDetector(
          onTap: onTap,

          child: Container(
            padding: const EdgeInsets.all(20),

            decoration: BoxDecoration(
              color: kBlackColor,

              borderRadius: BorderRadius.circular(14),
            ),

            child: Center(
              child: Text(
                text,

                style: TextStyle(
                  color: kWhiteColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
