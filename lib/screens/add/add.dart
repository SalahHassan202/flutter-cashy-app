import 'package:cashy_app/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AddScreen extends StatefulWidget {
  final bool isPlus;

  const AddScreen({super.key, required this.isPlus});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController detailsController = TextEditingController();

  String num = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.isPlus ? "Plus" : "Minus")),
      body: Padding(
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
                    onPressed: () {},
                    child: const Text("ADD"),
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
