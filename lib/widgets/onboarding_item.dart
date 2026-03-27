import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../models/onboarding_model.dart';

class OnboardingItem extends StatelessWidget {
  final OnboardingModel item;

  const OnboardingItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(item.image, height: 250),

        Gap(30),

        Text(
          item.title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),

        Gap(10),

        Text(item.description, textAlign: TextAlign.center),
      ],
    );
  }
}
