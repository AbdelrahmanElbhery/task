import 'package:flutter/material.dart';

import 'package:train/search_field.dart';
import 'package:train/type_ahead.dart';

class Task extends StatelessWidget {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) => const Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              TypeHead(),
              Searching(),
            ],
          ),
        ),
      );
}
