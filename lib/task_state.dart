part of 'task_cubit.dart';

@immutable
abstract class TaskState {}

class TaskInitial extends TaskState {}

class GetPlayersState extends TaskState {}

class GetPlayersLoadingState extends TaskState {}

class ChangeIconState extends TaskState {}

class ChangeFocusState extends TaskState {}

class GetNewsLoadingState extends TaskState {}

class GetNewsSuccessState extends TaskState {}

class SearchNewsLoadingState extends TaskState {}

class SearchNewsSuccessState extends TaskState {}

class ChangeButtonState extends TaskState {}
