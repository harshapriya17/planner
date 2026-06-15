import 'package:flutter/material.dart';
import 'dart:math';

import '../../../core/constants/app_colors.dart';

class ProgressCard extends StatelessWidget {
  final double completedHours;
  final double targetHours;

  const ProgressCard({
    super.key,
    required this.completedHours,
    required this.targetHours,
  });

  @override
  Widget build(BuildContext context) {
    double progress = completedHours / targetHours;
    int percentage = (progress * 100).toInt();

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Daily Goal",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "You've completed $percentage% of your daily study goal!",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "$completedHours / $targetHours Hours",
                      style: const TextStyle(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 10,
                    backgroundColor: Colors.grey.shade200,
                    color: AppColors.secondary,
                    strokeCap: StrokeCap.round,
                  ),
                ),
                Text(
                  "$percentage%",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
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
