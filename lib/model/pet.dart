class Pet {
  String? petId;
  String? name;
  int? age;
  String? breed;
  String? type;
  String? imageUrl;
  String? gender;
  String? personalize;
  List<String>? clinicInfo;

  Pet(
      {this.petId,
      this.name,
      this.age,
      this.breed,
      this.type,
      this.imageUrl,
      this.gender,
      this.personalize,
      this.clinicInfo});

  Pet.fromJson(Map<String, dynamic> json) {
    petId = json['petId'];
    name = json['name'];
    age = json['age'];
    breed = json['breed'];
    type = json['type'];
    imageUrl = json['image_url'];
    gender = json['gender'];
    personalize = json['personalize'];
    clinicInfo = json['clinic_info'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['petId'] = this.petId;
    data['name'] = this.name;
    data['age'] = this.age;
    data['breed'] = this.breed;
    data['type'] = this.type;
    data['image_url'] = this.imageUrl;
    data['gender'] = this.gender;
    data['personalize'] = this.personalize;
    data['clinic_info'] = this.clinicInfo;
    return data;
  }
}
