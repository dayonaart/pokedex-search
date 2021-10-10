import 'package:dex/model/pokemon_model.dart';
import 'package:dex/widget/widget.dart';
import 'package:flutter/material.dart';

class BaseStatPokemon extends StatelessWidget {
  PokemonSearchModel pokemon;
  BaseStatPokemon({@required this.pokemon});

  @override
  Widget build(BuildContext context) {
    var _barWidth = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width / 1.8;
    return Container(
        color: Colors.white,
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Builder(builder: (context) {
              if (pokemon?.stats?.length == null) {
                return Container(
                  color: Colors.white,
                  child: Center(
                    child: Text("Not Found"),
                  ),
                );
              } else {
                return ListView(
                    children: List.generate(
                        pokemon.stats.length,
                        (i) => textFlavor(convertSpecialString(pokemon.stats[i].stat.name),
                            customValue: pokemonAtributeBar(
                                _barWidth, pokemon.stats[i].stat.name, i, pokemon))));
              }
            })));
  }
}
