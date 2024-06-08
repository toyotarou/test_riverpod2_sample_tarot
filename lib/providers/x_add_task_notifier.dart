import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/tarot_all.dart';
import '../repository/tarot_repository_provider.dart';
import '../state/x_add_task_state.dart';

part 'x_add_task_notifier.g.dart';

@riverpod
class AddTaskNotifier extends _$AddTaskNotifier {
  @override
  AddTaskState build([TarotAll? tarotAll]) {
    return AddTaskState(
      tarotAll: tarotAll ??
          TarotAll(
            id: 0,
            name: '',
            image: '',
            prof1: '',
            prof2: '',
            wordJ: '',
            wordR: '',
            msgJ: '',
            msgR: '',
            msg2J: '',
            msg2R: '',
            msg3J: '',
            msg3R: '',
            drawNum: '',
            drawNumJ: [],
            drawNumR: [],
          ),
      loading: false,
    );
  }

  ///
  void nameChanged({required String name}) {
    state = state.copyWith(
//      tarotAll: state.tarotAll.copyWith(name: name),
        );
  }

  ///
  void imageChanged({required String image}) {
    state = state.copyWith(
//      tarotAll: state.tarotAll.copyWith(image: image),
        );
  }

  TarotRepository get _repository => ref.read(tarotRepositoryProvider);

  ///
  Future<void> add() async {
    state = state.copyWith(loading: true);

    try {
      if (state.tarotAll.id.toString().isEmpty) {
        await _repository.create(state.tarotAll);
      } else {
        await _repository.edit(state.tarotAll);
      }

//      await ref.refresh(tarotAllProvider.future);
    } catch (e) {
      state = state.copyWith(loading: false);
      return Future.error(e);
    }
  }
}
