class Guess {
  Guess._({
    required this.age,
    required this.name,
  });

  final int age;
  final String name;

  factory Guess.fromJson(Map<String, dynamic> json) => Guess._(
        age: json['age'],
        name: json['name'],
      );
}
