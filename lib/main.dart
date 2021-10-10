import 'dart:async';
import 'package:dex/api.dart';
import 'package:dex/extension/colors.dart';
import 'package:dex/model/poke_habitat_model.dart';
import 'package:dex/model/poke_species_model.dart';
import 'package:dex/model/pokemon_model.dart';
import 'package:dex/pokemon_detail.dart';
import 'package:dex/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => PokeData()),
    ],
    child: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<PokeData>().searchHabitat("cave");
    super.initState();
  }

  final snackBar = SnackBar(content: Text('Yay! A SnackBar!'));
  @override
  Widget build(BuildContext context) {
    PokemonSearchModel _pokemon = context.watch<PokeData>().pokemonSearchModel;
    PokeHabitat _pokeHabitat = context.watch<PokeData>().pokeHabitat;
    bool _loading = context.watch<PokeData>().loading;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
            top: true,
            bottom: true,
            child: Scaffold(body: LayoutBuilder(builder: (context, c) {
              return Stack(
                children: [
                  Container(
                    width: c.maxWidth,
                    height: c.maxHeight,
                    child: Card(
                      color: Colors.greenAccent,
                    ),
                  ),
                  Positioned(
                    right: -50,
                    top: -20,
                    child: Opacity(
                      opacity: 0.3,
                      child: Image.asset(
                        'assets/images/pokeball.png',
                        scale: 2,
                      ),
                    ),
                  ),
                  _mainUi(context, _loading, _pokeHabitat),
                ],
              );
            }))));
  }

  SingleChildScrollView _mainUi(BuildContext context, bool _loading, PokeHabitat _pokeHabitat) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "POKEDEX",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                ),
                SizedBox(height: 10),
                CupertinoTextField(
                  placeholder: "Habitat (eg. cave,mountain,grassland)",
                  onChanged: (val) => context.read<PokeData>().searchHabitat(val),
                ),
              ],
            ),
          ),
          // ignore: missing_return
          Builder(builder: (context) {
            switch (_loading) {
              case true:
                return CupertinoActivityIndicator();
                break;
              case false:
                if (_pokeHabitat == null) {
                  return Image.network(
                    "https://www.cloudconsult.ca/public/no-search-found.png",
                    errorBuilder: (context, o, s) {
                      return Text("not found");
                    },
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(left: 5, right: 20),
                    child: _gridView(_pokeHabitat),
                  );
                }
                break;
              default:
            }
          })
        ],
      ),
    );
  }

  GridView _gridView(PokeHabitat _pokeHabitat) {
    return GridView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 10, childAspectRatio: 1.4),
      children: List.generate(_pokeHabitat.pokemonSpecies.length, (i) {
        return FutureProvider<PokemonSearchModel>(
            create: (context) => Api().searchPokemon(_pokeHabitat.pokemonSpecies[i].name),
            initialData: null,
            child: FutureProvider(
              create: (context) => Api().getSpecies(_pokeHabitat.pokemonSpecies[i].url),
              initialData: null,
              child: PokemonCard(),
            ));
      }),
    );
  }
}

class PokemonCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _pokeSearch = context.watch<PokemonSearchModel>();
    final _pokeSpecies = context.watch<PokeSpecies>();
    // ignore: missing_return
    return Builder(builder: (context) {
      switch (_pokeSearch != null && _pokeSpecies != null) {
        case true:
          return ElevatedButton(
            style: buttonStyle(BCOLOR(_pokeSpecies.pokeColor.name).color),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PokemonDetailPage(_pokeSpecies, _pokeSearch)));
            },
            child: Stack(
              children: [
                Positioned(right: 10, top: 15, child: Text("## ${_pokeSpecies.id}")),
                _nameAndAbilities(_pokeSearch, _pokeSpecies),
                Positioned(
                    bottom: -20,
                    right: -15,
                    child: Opacity(
                      opacity: 0.3,
                      child: Image.asset(
                        'assets/images/pokeball.png',
                        scale: 4,
                        color: ACCENTCOLOR(_pokeSpecies.pokeColor.name).color,
                      ),
                    )),
                _pokeImage(_pokeSearch),
              ],
            ),
          );
          break;
        case false:
          return Text("Please wait..");
          break;
        default:
      }
    });
  }

  Positioned _nameAndAbilities(PokemonSearchModel _pokeSearch, PokeSpecies _pokeSpecies) {
    return Positioned(
        top: 15,
        left: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                _pokeSpecies.name,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(height: 5),
            if (_pokeSearch?.types?.length != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                    _pokeSearch.types.length,
                    (a) => Card(
                          color: ACCENTCOLOR(_pokeSpecies.pokeColor.name).color,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                            child: Text(
                              _pokeSearch.types[a].type.name.capitalize(),
                              style: TextStyle(
                                  fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        )),
              )
          ],
        ));
  }

  Positioned _pokeImage(PokemonSearchModel _pokeSearch) {
    return Positioned(
        right: 0,
        bottom: 10,
        child: Container(
          height: 75,
          width: 75,
          child: Image.network(
            _pokeSearch.sprites.other.officialArtwork.frontDefault,
          ),
        ));
  }
}

class PokeData with ChangeNotifier, DiagnosticableTreeMixin {
  PokemonSearchModel _pokemonSearchModel;
  Timer _debounce;
  bool _loading = false;
  bool get loading => _loading;
  PokeHabitat _pokeHabitat;
  PokemonSearchModel get pokemonSearchModel => _pokemonSearchModel;
  PokeHabitat get pokeHabitat => _pokeHabitat;
  Future<PokemonSearchModel> searchPokemon(String name) async {
    // if (_debounce?.isActive ?? false) _debounce.cancel();
    // _debounce = Timer(const Duration(milliseconds: 1000), () async {
    //   _loading = true;
    //   notifyListeners();
    //   _pokemonSearchModel = await Api().searchPokemon(name);
    //   _loading = false;
    //   notifyListeners();
    // });
    return await Api().searchPokemon(name);
  }

  void searchHabitat(String habitat) {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () async {
      if (habitat.isEmpty) {
        return;
      }
      _loading = true;
      notifyListeners();
      _pokeHabitat = await Api().getHabitat(habitat);
      _loading = false;
      notifyListeners();
    });
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    // properties.add(IntProperty('count', count));
  }
}
