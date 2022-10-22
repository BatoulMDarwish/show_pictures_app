class PhotoModel {
  String? id;
  String? altDescription;
  String? color;
  Map<String, dynamic>? urls;

  PhotoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    altDescription = json['alt_description'];
    color = json['color'];
    urls = json['urls'];
  }
}
