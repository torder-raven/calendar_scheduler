import 'package:flutter/material.dart';

import '../../component/schedule_register_bottom_sheet.dart';
import '../../const/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      floatingActionButton: renderFloatingActionButton(),
      body: Column(
        children: [],
      ),
    ));
  }

  FloatingActionButton renderFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          backgroundColor: Colors.white,
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
          ),
          builder: (_) {
            return ScheduleRegisterBottomSheet(
              selectedDate: DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day,
              ),
            );
          },
        );
      },
      backgroundColor: ColorResource.PRIMARY_COLOR,
      child: Icon(Icons.add),
    );
  }
}
