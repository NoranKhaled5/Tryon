class GetGovernmentModel{
  List<Data>? data;
  String? message;
  List<Null>? error;
  int? status;

  GetGovernmentModel({this.data, this.message, this.error, this.status});

  GetGovernmentModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
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
  String? governorateNameEn;

  Data({this.id, this.governorateNameEn});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    governorateNameEn = json['governorate_name_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['governorate_name_en'] = this.governorateNameEn;
    return data;
  }
}