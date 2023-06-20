import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:train/core/dio.dart';
import 'package:train/data/models/news_model.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());
  static TaskCubit get(context) => BlocProvider.of(context);

  IconData dropsearchSecondIcon = Icons.arrow_downward;
  FocusNode mysecondfocus = FocusNode();
  NewsModel? newsModel;
  List<Articles> articles = [];
  List<Articles> mainarticles = [];

  listenFocus() {
    mysecondfocus.addListener(() {
      if (mysecondfocus.hasFocus) {
        dropsearchSecondIcon = Icons.arrow_back;
        emit(ChangeButtonState());
      } else {
        dropsearchSecondIcon = Icons.arrow_downward;
        emit(ChangeButtonState());
      }
    });
  }

  iconseconddrop() {
    if (dropsearchSecondIcon == Icons.arrow_downward) {
      dropsearchSecondIcon = Icons.arrow_back;
      emit(ChangeIconState());
    } else {
      dropsearchSecondIcon = Icons.arrow_downward;
      emit(ChangeIconState());
    }
  }

  nodeFocus(FocusNode node) {
    if (node.hasFocus) {
      node.unfocus();
    } else {
      node.requestFocus();
    }
    emit(ChangeFocusState());
  }

  Future<void> getNews() async {
    emit(GetNewsLoadingState());
    Response? data = await Maindio.getdata(path: 'everything', query: {
      'q': 'tesla',
      'apiKey': '77a3713c0299485b8eee9f13aa6750e8',
      'pagesize': 10
    });
    newsModel = NewsModel.fromJson(data?.data);
    mainarticles = newsModel!.articles!;
    articles = mainarticles;
    emit(GetNewsSuccessState());
  }

  Future<void> searchNews(String query) async {
    emit(SearchNewsLoadingState());
    if (query == '') {
      articles = mainarticles;
    } else {
      Response? data = await Maindio.getdata(path: 'everything', query: {
        'q': query,
        'apiKey': '77a3713c0299485b8eee9f13aa6750e8',
        'pagesize': 20
      });
      newsModel = NewsModel.fromJson(data?.data);
      articles = newsModel!.articles!;
    }

    emit(SearchNewsSuccessState());
  }
}
