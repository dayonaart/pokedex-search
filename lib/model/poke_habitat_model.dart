class PokeHabitat {
  int id;
  String name;
  List<Names> names;
  List<PokeHabitatSpecies> pokemonSpecies;

  PokeHabitat({this.id, this.name, this.names, this.pokemonSpecies});

  PokeHabitat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['names'] != null) {
      names = <Names>[];
      json['names'].forEach((v) {
        names.add(new Names.fromJson(v));
      });
    }
    if (json['pokemon_species'] != null) {
      pokemonSpecies = <PokeHabitatSpecies>[];
      json['pokemon_species'].forEach((v) {
        pokemonSpecies.add(new PokeHabitatSpecies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.names != null) {
      data['names'] = this.names.map((v) => v.toJson()).toList();
    }
    if (this.pokemonSpecies != null) {
      data['pokemon_species'] = this.pokemonSpecies.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Names {
  Language language;
  String name;

  Names({this.language, this.name});

  Names.fromJson(Map<String, dynamic> json) {
    language = json['language'] != null ? new Language.fromJson(json['language']) : null;
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.language != null) {
      data['language'] = this.language.toJson();
    }
    data['name'] = this.name;
    return data;
  }
}

class Language {
  String name;
  String url;

  Language({this.name, this.url});

  Language.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}

class PokeHabitatSpecies {
  String name;
  String url;

  PokeHabitatSpecies({this.name, this.url});

  PokeHabitatSpecies.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}
