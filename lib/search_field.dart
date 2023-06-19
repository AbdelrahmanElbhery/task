import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchfield/searchfield.dart';
import 'package:train/data/models/news_model.dart';
import 'package:train/task_cubit.dart';

import 'data/models/players_model.dart';

class Searching extends StatelessWidget {
  const Searching({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    bool show = false;
    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {
        if (state is GetNewsSuccessState) {
          show = true;
        }
      },
      builder: (context, state) {
        if (show) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * .07,
            width: MediaQuery.of(context).size.width * .75,
            child: SearchField<Articles>(
              onSubmit: (val) {
                TaskCubit.get(context).iconseconddrop();
              },
              onSearchTextChanged: (p0) {
                TaskCubit.get(context).searchNews(p0);
              },
              focusNode: TaskCubit.get(context).mysecondfocus,
              onSuggestionTap: (val) {
                print(val.item?.title);
              },
              itemHeight: 40,
              searchInputDecoration: InputDecoration(
                  hintText: 'Search Username',
                  prefixIcon: IconButton(
                    icon: Icon(TaskCubit.get(context).dropsearchSecondIcon),
                    onPressed: () {
                      TaskCubit.get(context)
                          .nodeFocus(TaskCubit.get(context).mysecondfocus);
                      TaskCubit.get(context).iconseconddrop();
                    },
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
              suggestions: TaskCubit.get(context)
                  .articles
                  .map(
                    (e) => SearchFieldListItem<Articles>(
                      e.title!,
                      item: e,
                      // Use child to show Custom Widgets in the suggestions
                      // defaults to Text widget
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                e.title!,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
