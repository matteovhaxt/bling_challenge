class Guess {
  Guess._({
    required this.age,
    required this.name,
  });

  final int age;
  final String name;

  factory Guess.fromJson(json) => Guess._(
        age: json['age'] as int,
        name: json['name'] as String,
      );

  Map<String, dynamic> toJson() => {
        'name': this.name,
        'age': this.age,
      };
}
