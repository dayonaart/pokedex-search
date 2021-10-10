import 'package:dex/model/pokemon_model.dart';
import 'package:flutter/material.dart';
import 'package:dex/extension/colors.dart';
import 'package:intl/intl.dart';

TextStyle _titleStyle = TextStyle(fontWeight: FontWeight.bold, color: Colors.black38);
TextStyle _valueStyle = TextStyle(fontWeight: FontWeight.bold);

String pokemonHeight(PokemonSearchModel pokemon) {
  try {
    return "'${feet(pokemon.height / 10).round()} ${parsetoInc(feet(pokemon.height / 10)).round()}\" (${(pokemon.height / 10).toStringAsPrecision(2)} m) ";
  } catch (e) {
    return null;
  }
}

String parseToLbs(int value) {
  try {
    return "${NumberFormat("##,#").format(value * 2.205)} lbs ( ${parseToKg.format(value)} kg )";
  } catch (e) {
    return null;
  }
}

final parseToKg = NumberFormat("#,#");
String parseToHeight(double height) => "${NumberFormat("#,#").format(height)}";

double feet(double meter) {
  try {
    return (meter * 3.2808);
  } catch (e) {
    return 0;
  }
}

double parsetoInc(double feet) {
  try {
    return (double.parse(feet
            .toStringAsFixed(4)
            .replaceRange(0, double.parse(feet.toStringAsFixed(0)) > 10 ? 2 : 1, "0")) *
        12);
  } catch (e) {
    return 0;
  }
}

Row textFlavor(String title, {String value, Widget customValue}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: _titleStyle,
      ),
      SizedBox(height: 40),
      Builder(builder: (context) {
        if (customValue == null) {
          return Text(
            value ?? "not found",
            style: _valueStyle,
          );
        } else {
          return customValue;
        }
      })
    ],
  );
}

String convertSpecialString(String value) {
  try {
    return value.replaceAll("special-", "Sp.").capitalize();
  } catch (e) {
    return value.capitalize();
  }
}

int _attributSize(String statsName, PokemonSearchModel pokemon) {
  return pokemon.stats.where((e) => e.stat.name == statsName).first.baseStat;
}

List<double> _attributBar(double _barWidth, String statsName, PokemonSearchModel pokemon) {
  if (pokemon.stats.map((e) => e.baseStat > 100).contains(true)) {
    return pokemon.stats.map((e) => (e.baseStat / 1000) * _barWidth).toList();
  } else {
    return pokemon.stats.map((e) => (e.baseStat / 100) * _barWidth).toList();
  }
}

Future<double> _barAnimated(double value) async {
  return value;
}

Row pokemonAtributeBar(double _barWidth, String statsName, int index, PokemonSearchModel pokemon) {
  return Row(
    children: [
      Text(
        "${_attributSize(statsName, pokemon)}",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      SizedBox(width: 20),
      Stack(
        children: [
          Container(
            height: 8,
            width: _barWidth,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.grey[200]),
          ),
          // ignore: missing_return
          FutureBuilder<double>(
              future: _barAnimated(_attributBar(_barWidth, statsName, pokemon)[index]),
              builder: (context, snap) {
                return AnimatedContainer(
                  height: 8,
                  width: snap.data ?? 0,
                  duration: Duration(seconds: 1),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: _barColor(pokemon.stats[index].baseStat)),
                );
              }),
        ],
      )
    ],
  );
}

Color _barColor(int barSize) {
  if (barSize > 200) {
    return Colors.green;
  } else if (barSize >= 100 && barSize <= 200) {
    return Colors.lightGreen[300];
  } else if (barSize < 100 && barSize > 50) {
    return Colors.lightGreen[200];
  } else {
    return Colors.red;
  }
}
