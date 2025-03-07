class UserModel {
  final String name;
  final int age;
  final String email;
  final String imageUrl;
  final String date;
  final String location;

  UserModel({
    required this.name,
    required this.age,
    required this.email,
    required this.imageUrl,
    required this.date,
    required this.location,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: "${json['name']['first']} ${json['name']['last']}",
      age: DateTime.now().year - DateTime.parse(json['dob']['date']).year,
      email: json['email'],
      imageUrl: json['picture']['medium'],
      date: json['dob']
          ['date'], // Raw format, we will format it when displaying
      location: "${json['location']['city']}, ${json['location']['country']}",
    );
  }
}
