import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../component/schedule_card.dart';

class TempDeleteScreen extends StatefulWidget {
  const TempDeleteScreen({super.key});

  @override
  State<TempDeleteScreen> createState() => _TempDeleteScreenState();
}

class _TempDeleteScreenState extends State<TempDeleteScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50.0,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                itemCount: 100,
                itemBuilder: (context, index) {
                  return ScheduleCard(
                      startTime: 791,
                      endTime: 800,
                      content: "공부하긔",
                      color: 0xFF0DB2B2
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 8.0,
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
