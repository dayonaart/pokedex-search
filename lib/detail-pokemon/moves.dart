import 'dart:ui';

import 'package:dex/model/pokemon_model.dart';
import 'package:dex/style.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart' as col;
import 'dart:math' as math;

class PokemonMoves extends StatelessWidget {
  PokemonSearchModel pokemon;
  PokemonMoves({@required this.pokemon});
  List<Ability> _moves() {
    // var _q = col.groupBy(
    //     pokemon.moves
    //         .where(
    //             (w) => w.versionGroupDetails.map((e) => e.versionGroup.name == "gold-silver").first)
    //         .map((e) => e.move.name),
    //     (a) => a);
    // print(_q.length);
    return pokemon.moves
        .where((e) =>
            e.versionGroupDetails.map((e) => e.versionGroup.name == "sun-moon").contains(true))
        .map((e) => e.move)
        .toList();
  }

  Color _randomColor({int rand}) =>
      Color(((rand != null ? (math.Random().nextDouble() * rand) : math.Random().nextDouble()) *
                  0xFFFFFF)
              .toInt())
          .withOpacity(1.0);
  @override
  Widget build(BuildContext context) {
    if (pokemon?.moves?.length == null) {
      return Container(
        color: Colors.white,
        child: Center(
          child: Text("Not Found"),
        ),
      );
    } else {
      return Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                    "MOVES BASED SUN-MOON VERSION",
                    style:
                        TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: _randomColor()),
                  )),
                ),
                GridView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, childAspectRatio: 3),
                  children: List.generate(_moves().length, (i) {
                    return Card(
                      color: _randomColor(rand: i),
                      shape: roundedCard,
                      child: Center(
                          child: Text(
                        "${_moves()[i].name}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 10, color: Colors.white),
                      )),
                    );
                  }),
                ),
              ],
            ),
          ));
    }
  }
}
