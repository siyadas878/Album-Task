class UserModel {
  int? id;
  String? name;
  String? username;
  String? email;
  Address? address;
  String? phone;
  String? website;
  Company? company;

  UserModel(
      {this.id,
      this.name,
      this.username,
      this.email,
      this.address,
      this.phone,
      this.website,
      this.company});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    username = json["username"];
    email = json["email"];
    address =
        json["address"] == null ? null : Address.fromJson(json["address"]);
    phone = json["phone"];
    website = json["website"];
    company =
        json["company"] == null ? null : Company.fromJson(json["company"]);
  }

  static List<UserModel> fromList(List<dynamic> list) {
    return list.map((map) => UserModel.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["username"] = username;
    data["email"] = email;
    if (address != null) {
      data["address"] = address?.toJson();
    }
    data["phone"] = phone;
    data["website"] = website;
    if (company != null) {
      data["company"] = company?.toJson();
    }
    return data;
  }

  UserModel copyWith({
    int? id,
    String? name,
    String? username,
    String? email,
    Address? address,
    String? phone,
    String? website,
    Company? company,
  }) =>
      UserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        username: username ?? this.username,
        email: email ?? this.email,
        address: address ?? this.address,
        phone: phone ?? this.phone,
        website: website ?? this.website,
        company: company ?? this.company,
      );
}

class Company {
  String? name;
  String? catchPhrase;
  String? bs;

  Company({this.name, this.catchPhrase, this.bs});

  Company.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    catchPhrase = json["catchPhrase"];
    bs = json["bs"];
  }

  static List<Company> fromList(List<dynamic> list) {
    return list.map((map) => Company.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["catchPhrase"] = catchPhrase;
    data["bs"] = bs;
    return data;
  }

  Company copyWith({
    String? name,
    String? catchPhrase,
    String? bs,
  }) =>
      Company(
        name: name ?? this.name,
        catchPhrase: catchPhrase ?? this.catchPhrase,
        bs: bs ?? this.bs,
      );
}

class Address {
  String? street;
  String? suite;
  String? city;
  String? zipcode;
  Geo? geo;

  Address({this.street, this.suite, this.city, this.zipcode, this.geo});

  Address.fromJson(Map<String, dynamic> json) {
    street = json["street"];
    suite = json["suite"];
    city = json["city"];
    zipcode = json["zipcode"];
    geo = json["geo"] == null ? null : Geo.fromJson(json["geo"]);
  }

  static List<Address> fromList(List<dynamic> list) {
    return list.map((map) => Address.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["street"] = street;
    data["suite"] = suite;
    data["city"] = city;
    data["zipcode"] = zipcode;
    if (geo != null) {
      data["geo"] = geo?.toJson();
    }
    return data;
  }

  Address copyWith({
    String? street,
    String? suite,
    String? city,
    String? zipcode,
    Geo? geo,
  }) =>
      Address(
        street: street ?? this.street,
        suite: suite ?? this.suite,
        city: city ?? this.city,
        zipcode: zipcode ?? this.zipcode,
        geo: geo ?? this.geo,
      );
}

class Geo {
  String? lat;
  String? lng;

  Geo({this.lat, this.lng});

  Geo.fromJson(Map<String, dynamic> json) {
    lat = json["lat"];
    lng = json["lng"];
  }

  static List<Geo> fromList(List<dynamic> list) {
    return list.map((map) => Geo.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["lat"] = lat;
    data["lng"] = lng;
    return data;
  }

  Geo copyWith({
    String? lat,
    String? lng,
  }) =>
      Geo(
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
      );
}
