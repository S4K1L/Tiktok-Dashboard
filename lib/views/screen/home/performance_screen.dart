// ignore_for_file: unused_element_parameter

import 'package:flutter/material.dart';
import 'package:flutter_extension/controller/performance_controller.dart';
import 'package:flutter_extension/views/base/creating_video.dart';
import 'package:flutter_extension/views/base/creator_reward_section.dart';
import 'package:flutter_extension/views/base/reward_calculation.dart';
import 'package:flutter_extension/views/base/reward_criteria.dart';
import 'package:get/get.dart';

class PerformancePage extends StatelessWidget {
  final controller = Get.put(PerformanceController());

  PerformancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            const SizedBox(height: 10),

            const _Header(),

            const SizedBox(height: 16),

            CreatorRewardsSection(),

            const SizedBox(height: 16),

            RewardsCard(),

            const SizedBox(height: 16),

            const CreatingVideos(),

            const SizedBox(height: 16),

            const RewardCriteria(),

            const SizedBox(height: 16),

            _ViewMoreButton(),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
          const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Performance",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 2),
              Text(
                "Last update: Feb 15",
                style: TextStyle(color: Color(0xFF8E8E93), fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ViewMoreButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      decoration: BoxDecoration(
        color: const Color(0xff2c2c2c),
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: const Text(
        "View more",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 2, dashSpace = 2, startX = 0;
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..strokeWidth = 1;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
