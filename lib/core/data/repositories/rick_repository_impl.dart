import 'package:dio/dio.dart';
import 'package:poc_demo/core/data/models/character_model.dart';
import 'package:poc_demo/core/data/repositories/rick_repository.dart';
import 'package:poc_demo/core/services/dio_client.dart';

class RickRepositoryImpl implements RickRepository {
  @override
  Future<CharacterModel> getCharacter() async {
    var dio = Dio();
    try {
      var response =
          await dio.get("https://rickandmortyapi.com/api/character/2");
      return CharacterModel.fromJson(response.data);
    } catch (e) {
      print(e);
      throw UnimplementedError(e.toString());
    }
  }
}
