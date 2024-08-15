import 'package:flutter/material.dart';
import 'package:giveup/components/Circular_progress_bar_component.dart';
import 'package:giveup/components/Pie_chart_component.dart';

class StatistikPageContent extends StatefulWidget {
  const StatistikPageContent({super.key});

  @override
  State<StatistikPageContent> createState() => _StatistikPageContentState();
}

class _StatistikPageContentState extends State<StatistikPageContent> {
  final ValueNotifier<double> valueNotifier = ValueNotifier(50);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(7.0),
                ),
                child: const Text(
                  'Total Score',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              CircularProgressBarComponent(valueNotifier: valueNotifier),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 50),
                      Text(
                        'Current',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '1 Day',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 60),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        child: const Text(
                          'Streak',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: 50,
                        width: 1,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  const SizedBox(width: 60),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(height: 50),
                      Text(
                        'Best',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '1 Day',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(),
              Container(
                height: 300,
                padding: EdgeInsets.zero, // Remove padding
                child: const PieChartComponent(), // Ensure no decoration
              ),
            ],
          ),
        ),
      ),
    );
  }
}
