import 'package:flutter/material.dart';

import 'package:train/search_field.dart';

class Task extends StatelessWidget {
  const Task({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: Center(child: Searching()),
      );
}
