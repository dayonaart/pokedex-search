import 'package:dex/model/poke_species_model.dart';
import 'package:dex/model/pokemon_model.dart';
import 'package:dex/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:dex/extension/colors.dart';
import 'package:intl/intl.dart';

class AboutPokemon extends StatelessWidget {
  PokemonSearchModel pokemon;
  PokeSpecies pokeSpecies;
  AboutPokemon({@required this.pokemon, @required this.pokeSpecies});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              textFlavor("Species",
                  value: pokeSpecies?.eggGroups?.map((e) => e?.name)?.first?.capitalize()),
              textFlavor("Height", value: pokemonHeight(pokemon)),
              textFlavor("Weight", value: parseToLbs(pokemon?.weight)),
              textFlavor("Abilities",
                  value: pokemon?.abilities?.map((e) => e?.ability?.name)?.join(", ")?.capitalize())
            ],
          ),
        ));
  }
}
