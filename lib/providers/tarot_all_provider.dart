import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repository/tarot_repository_provider.dart';

part 'tarot_all_provider.g.dart';

@riverpod
FutureOr<List<dynamic>> tarotAll(TarotAllRef ref) async {
  return ref.read(tarotRepositoryProvider).list();
}
