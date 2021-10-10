import 'package:dex/model/evolve_model.dart';
import 'package:dex/model/poke_habitat_model.dart';
import 'package:dex/model/poke_species_model.dart';
import 'package:dex/model/pokemon_model.dart';
import 'package:dio/dio.dart';

class Api {
  final BaseOptions options = new BaseOptions(
    connectTimeout: 30000,
    receiveTimeout: 30000,
  );

  Future<PokemonSearchModel> searchPokemon(String params) async {
    try {
      Response _res = await Dio(options).get(
        BASE_URL + "/pokemon/$params/",
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );
      return PokemonSearchModel.fromJson(_res.data);
    } on DioError catch (e) {
      return PokemonSearchModel(
          sprites: Sprites(
              other: Other(
                  officialArtwork: DreamWorld(
                      frontDefault: "https://www.cloudconsult.ca/public/no-search-found.png"))));
    }
  }

  Future<PokeHabitat> getHabitat(String habitat) async {
    try {
      Response _res = await Dio(options).get(
        BASE_URL + HABITAT(habitat),
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );
      return PokeHabitat.fromJson(_res.data);
    } on DioError catch (e) {
      return null;
    }
  }

  Future<PokeSpecies> getSpecies(String url) async {
    try {
      Response _res = await Dio(options).get(
        url,
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );
      return PokeSpecies.fromJson(_res.data);
    } on DioError catch (e) {
      return null;
    }
  }

  Future<EvolveModel> getEvolve(String url) async {
    try {
      Response _res = await Dio(options).get(
        url,
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );
      return EvolveModel.fromJson(_res.data);
    } on DioError catch (e) {
      return null;
    }
  }
}

const String BASE_URL = "https://pokeapi.co/api/v2/";
String HABITAT(String params) => "pokemon-habitat/$params";
