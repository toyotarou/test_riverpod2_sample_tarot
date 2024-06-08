import 'dart:async';

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/tarot_all.dart';
import '../providers/dio_provider.dart';

final tarotRepositoryProvider = Provider(TarotRepository.new);

class TarotRepository {
  TarotRepository(this._ref);

  final Ref _ref;

  Dio get _dio => _ref.read(dioProvider);

  ///
  FutureOr<List<dynamic>> list() async {
    try {
      final response = await _dio.post('/getAllTarot');

      final data = response.data;

      final list = data['data']
          .map((e) => TarotAll.fromJson(e as Map<String, dynamic>))
          .toList() as List<dynamic>;

      return Future.value(list);
    } on DioException catch (e) {
      return Future.error(e.response?.data ?? e.error);
    }
  }

  //============================// dummy

  ///
  Future<void> create(TarotAll tarotAll) async {
    try {
      await _dio.post('/create', data: tarotAll.toJson());
    } on DioException catch (e) {
      return Future.error(e.response?.data ?? e.error);
    }
  }

  ///
  Future<void> edit(TarotAll tarotAll) async {
    try {
      await _dio.put('/edit/${tarotAll.id}', data: tarotAll.toJson());
    } on DioException catch (e) {
      return Future.error(e.response?.data ?? e.error);
    }
  }

  ///
  Future<void> delete(String id) async {
    try {
      await _dio.delete('/delete/$id');
    } on DioException catch (e) {
      return Future.error(e.response?.data ?? e.error);
    }
  }
}
