class Pokemon {
  final int id;
  final String name;
  final String? urlImageFront;
  final String? urlImageBack;
  final double? height;
  final double? weight;
  final List? types;

  Pokemon({
    required this.id,
    required this.name,
    this.urlImageFront,
    this.urlImageBack,
    this.height,
    this.weight,
    this.types,
  });

  factory Pokemon.fromPokemonEntry(Map<String, dynamic> json) {
    return Pokemon(
      id: json['entry_number'],
      name: json['pokemon_species']['name'],
    );
  }

  factory Pokemon.fromApi(Map<String, dynamic> json) {
    List<String>? types = [];
    for (var type in json["types"]) {
      types.add(type['type']['name']);
    }
    return Pokemon(
      id: json['id'],
      name: json['name'],
      urlImageFront: json['sprites']['front_default'],
      urlImageBack: json['sprites']['back_default'],
      height: double.tryParse(json['height'].toString()),
      weight: double.tryParse(json['weight'].toString()),
      types: types,
    );
  }

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name'],
      urlImageFront: json['urlImageFront'],
      urlImageBack: json['urlImageBack'],
      height: json['height'],
      weight: json['weight'],
      types: json['types'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'urlImageFront': urlImageFront,
        'urlImageBack': urlImageBack,
        'height': height,
        'weight': weight,
        'types': types,
      };
}
