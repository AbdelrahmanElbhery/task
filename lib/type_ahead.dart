import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:train/task_cubit.dart';

import 'data/models/players_model.dart';

class TypeHead extends StatelessWidget {
  const TypeHead({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is GetPlayersLoadingState) {
          return const CircularProgressIndicator();
        } else {
          return Container(
            width: MediaQuery.of(context).size.width * .8,
            padding: const EdgeInsets.all(16),
            child: TypeAheadField<Players?>(
              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * .2)),
              hideSuggestionsOnKeyboardHide: true,
              textFieldConfiguration: TextFieldConfiguration(
                focusNode: TaskCubit.get(context).myfocus,
                onTap: () {
                  TaskCubit.get(context).icondrop();
                },
                decoration: InputDecoration(
                  prefixIcon: IconButton(
                    icon: Icon(TaskCubit.get(context).dropsearchIcon),
                    onPressed: () {
                      TaskCubit.get(context)
                          .nodeFocus(TaskCubit.get(context).myfocus);
                      TaskCubit.get(context).icondrop();
                    },
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  hintText: 'Search Username',
                ),
              ),
              suggestionsCallback: (v) async {
                return TaskCubit.get(context).getSuggestions(v);
              },
              itemBuilder: (context, Players? suggestion) {
                final user = suggestion!;
                return ListTile(title: Text(user.name!));
              },
              noItemsFoundBuilder: (context) => Container(
                height: 40,
                child: const Center(
                  child: Text(
                    'No Users Found.',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
              onSuggestionSelected: (Players? suggestion) {},
            ),
          );
        }
      },
    );
  }
}
