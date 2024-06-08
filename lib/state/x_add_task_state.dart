import '../models/tarot_all.dart';

class AddTaskState {

  AddTaskState({required this.tarotAll, required this.loading});
  final TarotAll tarotAll;
  final bool loading;

  ///
  AddTaskState copyWith({
    TarotAll? tarotAll,
    bool? loading,
  }) {
    return AddTaskState(
      tarotAll: tarotAll ?? this.tarotAll,
      loading: loading ?? this.loading,
    );
  }
}
