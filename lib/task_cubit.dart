import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:train/core/dio.dart';
import 'package:train/data/models/news_model.dart';

import 'data/models/players_model.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());
  static TaskCubit get(context) => BlocProvider.of(context);

  PlayersModel? playersModel;
  bool iconarrow = true;
  bool iconsecondarrow = true;
  IconData dropsearchIcon = Icons.arrow_downward;
  IconData dropsearchSecondIcon = Icons.arrow_downward;
  FocusNode myfocus = FocusNode();
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

  icondrop() {
    iconarrow = !iconarrow;
    if (iconarrow) {
      dropsearchIcon = Icons.arrow_downward;
      emit(ChangeIconState());
    } else {
      dropsearchIcon = Icons.arrow_back;
      emit(ChangeIconState());
    }
  }

  iconseconddrop() {
    iconsecondarrow = !iconsecondarrow;
    if (iconsecondarrow) {
      dropsearchSecondIcon = Icons.arrow_downward;
      emit(ChangeIconState());
    } else {
      dropsearchSecondIcon = Icons.arrow_back;
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

  Future<void> addPlayers() async {
    emit(GetPlayersLoadingState());
    final String response =
        await rootBundle.loadString('assets/players/players.json');
    final data = await jsonDecode(response);
    playersModel = PlayersModel.fromJson(data);
    emit(GetPlayersState());
  }

  Future<List<Players>> getSuggestions(String query) async {
    return await List.of(playersModel!.players!).where((user) {
      final userLower = user.name?.toLowerCase();
      final queryLower = query.toLowerCase();

      return userLower!.contains(queryLower);
    }).toList();
  }

  Future<void> getNews() async {
    emit(GetNewsLoadingState());
    Response? data = await Maindio.getdata(path: 'everything', query: {
      'q': 'tesla',
      'apiKey': 'f56ecd36e3e84ce3b5a50f4298e5f496',
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
        'apiKey': 'f56ecd36e3e84ce3b5a50f4298e5f496',
        'pagesize': 20
      });
      newsModel = NewsModel.fromJson(data?.data);
      articles = newsModel!.articles!;
    }

    emit(SearchNewsSuccessState());
  }
}
