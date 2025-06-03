class UpdateProfileModel {
  Data? data;
  String? message;
  List<Null>? error;
  int? status;

  UpdateProfileModel({this.data, this.message, this.error, this.status});

  UpdateProfileModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    if (json['error'] != null) {
      error = <Null>[];
      json['error'].forEach((v) {
        error!.add(v);
      });
    }
    status = json['status'];
  }


}

class Data {
  int? id;
  String? name;
  String? email;
  Null? address;
  String? city;
  String? phone;
  bool? emailVerified;
  String? image;

  Data(
      {this.id,
        this.name,
        this.email,
        this.address,
        this.city,
        this.phone,
        this.emailVerified,
        this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    city = json['city'];
    phone = json['phone'];
    emailVerified = json['email_verified'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['address'] = this.address;
    data['city'] = this.city;
    data['phone'] = this.phone;
    data['email_verified'] = this.emailVerified;
    data['image'] = this.image;
    return data;
  }
}