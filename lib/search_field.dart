import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchfield/searchfield.dart';
import 'package:train/data/models/news_model.dart';
import 'package:train/task_cubit.dart';

class Searching extends StatelessWidget {
  const Searching({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskCubit()
        ..getNews()
        ..listenFocus(),
      child: BlocConsumer<TaskCubit, TaskState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is! GetNewsLoadingState) {
            return SizedBox(
              width: MediaQuery.of(context).size.width * .75,
              child: SearchField<Articles>(
                suggestionState: Suggestion.expand,
                onSubmit: (val) {
                  TaskCubit.get(context).iconseconddrop();
                },
                onSearchTextChanged: (p0) {
                  TaskCubit.get(context).searchNews(p0);
                },
                focusNode: TaskCubit.get(context).mysecondfocus,
                onSuggestionTap: (val) {},
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
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
