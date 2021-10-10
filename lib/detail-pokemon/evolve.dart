import 'package:dex/api.dart';
import 'package:dex/extension/colors.dart';
import 'package:dex/model/evolve_model.dart';
import 'package:dex/model/poke_species_model.dart';
import 'package:dex/model/pokemon_model.dart';
import 'package:dex/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class PokemonEvolve extends StatelessWidget {
  PokeSpecies pokeSpecies;
  PokemonEvolve({@required this.pokeSpecies});
  EvolvesTo _evolution(EvolvesTo evolvesTo) {
    try {
      return evolvesTo;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: ListView(
          children: [
            FutureBuilder<EvolveModel>(
                future: Api().getEvolve(pokeSpecies.evolutionChain.url),
                builder: (context, snap) {
                  if (snap.hasData) {
                    var _firstEvo = _evolution(snap?.data?.chain?.evolvesTo?.first);
                    var _lastEvo = _evolution(snap?.data?.chain?.evolvesTo?.map((e) {
                      if (e.evolvesTo.isNotEmpty) {
                        return e.evolvesTo.first;
                      } else {
                        return null;
                      }
                    })?.first);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          _evolutionUi(_firstEvo),
                          _evolutionUi((_lastEvo)),
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                })
          ],
        ));
  }

  Builder _evolutionUi(EvolvesTo evo) {
    return Builder(builder: (context) {
      if (evo != null) {
        return _pokeCard(evo.species.name, evo.evolutionDetails.first.minLevel);
      } else {
        return Container();
      }
    });
  }

  TextStyle _bold({double fontSize}) =>
      TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize ?? 16);
  TextStyle _italic = TextStyle(fontStyle: FontStyle.italic);
  var _randomColor = Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);

  FutureBuilder<PokemonSearchModel> _pokeCard(String _pokeName, int evolveLv) {
    return FutureBuilder<PokemonSearchModel>(
        future: Api().searchPokemon(_pokeName),
        builder: (context, pokeImage) {
          if (pokeImage.hasData) {
            return _evolveCard(pokeImage, evolveLv);
          } else {
            return Center();
          }
        });
  }

  Card _evolveCard(AsyncSnapshot<PokemonSearchModel> pokeImage, int evolveLv) {
    return Card(
      color: _randomColor,
      shape: roundedCard,
      child: Row(
        children: [
          Flexible(
            child: Image.network(
              pokeImage.data.sprites.other.officialArtwork.frontDefault,
              scale: 3,
            ),
          ),
          Flexible(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pokeImage.data.name.capitalize(),
                          style: _bold(),
                        ),
                        Text(
                          "Required Lv ${evolveLv ?? "not found"}",
                          style: _bold(fontSize: 14),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Ability",
                          style: _bold(fontSize: 14),
                        ),
                        Text(
                          "${pokeImage.data.abilities.map((e) => e.ability.name).join(", ")}",
                          style: _italic,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Type",
                          style: _bold(fontSize: 14),
                        ),
                        Text(
                          "${pokeImage.data.types.map((e) => e.type.name).join(", ")}",
                          style: _italic,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
