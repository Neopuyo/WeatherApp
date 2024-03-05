import 'package:flutter/material.dart';
import 'dart:developer' as dev;

class BottomBarWidget extends StatelessWidget {
  const BottomBarWidget({
    required this.tabController,
    required this.timeScaleTabs,
    super.key
  });

  final TabController tabController;
  final List<Tab> timeScaleTabs;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        child: SizedBox(
          height: 56,
          child: TabBar(
            controller: tabController,
            onTap: (index) {
              dev.log("tab bar index: $index pressed");
            },
            tabs: timeScaleTabs.map((Tab tab) {
              return Tab(
                icon: tab.icon ?? const Icon(Icons.device_unknown),
                text: tab.text ?? "untitled tab",
              );
            }).toList(),
          ),
        ),
      );
  }

}