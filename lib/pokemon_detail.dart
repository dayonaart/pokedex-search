import 'package:dex/api.dart';
import 'package:dex/detail-pokemon/about.dart';
import 'package:dex/detail-pokemon/base-stats.dart';
import 'package:dex/detail-pokemon/evolve.dart';
import 'package:dex/detail-pokemon/moves.dart';
import 'package:dex/extension/colors.dart';
import 'package:dex/model/poke_species_model.dart';
import 'package:dex/model/pokemon_model.dart';
import 'package:dex/style.dart';
import 'package:flutter/material.dart';

class PokemonDetailPage extends StatelessWidget {
  PokeSpecies pokeSpecies;
  PokemonSearchModel pokemon;
  PokemonDetailPage(this.pokeSpecies, this.pokemon);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        bottom: true,
        child: LayoutBuilder(builder: (context, c) {
          return NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    centerTitle: true,
                    backgroundColor: BCOLOR(pokeSpecies.pokeColor.name).color,
                    flexibleSpace: _header(),
                    title: Text(
                      pokeSpecies.name.toUpperCase(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    floating: true,
                    expandedHeight: c.maxHeight / 2.2,
                    forceElevated: innerBoxIsScrolled,
                  ),
                ];
              },
              body: DefaultTabController(
                length: 4,
                child: Scaffold(
                  backgroundColor: BCOLOR(pokeSpecies.pokeColor.name).color,
                  appBar: _appBarTab(),
                  body: _tabBarView(),
                ),
              ));
        }));
  }

  Stack _header() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        if (pokemon?.types?.length != null)
          Positioned(
              left: 10,
              top: 60,
              child: Row(
                children: List.generate(pokemon.types.length, (a) {
                  return Card(
                    color: ACCENTCOLOR(pokeSpecies.pokeColor.name).color,
                    shape:
                        RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      child: Text(
                        pokemon.types[a].type.name.capitalize(),
                        style: TextStyle(
                            fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                }),
              )),
        Positioned(
            right: -50,
            bottom: -20,
            child: Opacity(
              opacity: 0.6,
              child: Image.asset(
                'assets/images/pokeball.png',
                scale: 2,
                color: ACCENTCOLOR(pokeSpecies.pokeColor.name).color,
              ),
            )),
        Positioned(
            bottom: 5,
            child: Image.network(pokemon.sprites.other.officialArtwork.frontDefault, scale: 2)),
      ],
    );
  }

  AppBar _appBarTab() {
    return AppBar(
      backgroundColor: Colors.white,
      shape: roundedCardTopOnly,
      bottom: TabBar(
          labelPadding: EdgeInsets.symmetric(horizontal: 2),
          labelColor: Colors.black,
          unselectedLabelColor: Colors.black26,
          labelStyle: TextStyle(fontWeight: FontWeight.bold),
          tabs: [
            Tab(text: "About"),
            Tab(text: "Base Stats"),
            Tab(text: "Evolution"),
            Tab(text: "Moves"),
          ]),
    );
  }

  TabBarView _tabBarView() {
    return TabBarView(children: [
      AboutPokemon(pokeSpecies: pokeSpecies, pokemon: pokemon),
      BaseStatPokemon(pokemon: pokemon),
      PokemonEvolve(pokeSpecies: pokeSpecies),
      PokemonMoves(pokemon: pokemon)
    ]);
  }

}
