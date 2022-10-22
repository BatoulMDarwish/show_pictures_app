class SearchModel {
  late int total;
  late int totalPage;
  List<Results> result = [];
  SearchModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    totalPage = json['total_pages'];
    if (json['results'] != null) {
      json['results'].forEach((v) {
        result.add(Results.fromJson(v));
      });
    }
  }
}

class Results {
  String? id;
  String? description;
  String? altDescription;
  Urls? urls;
  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    altDescription = json['alt_description'];
    urls = json['urls'] != null ? Urls.fromJson(json['urls']) : null;
  }
}

class Urls {
  String? raw;
  String? full;
  String? regular;
  String? small;
  String? thumb;
  String? smallS3;

  Urls(
      {this.raw,
      this.full,
      this.regular,
      this.small,
      this.thumb,
      this.smallS3});

  Urls.fromJson(Map<String, dynamic> json) {
    raw = json['raw'];
    full = json['full'];
    regular = json['regular'];
    small = json['small'];
    thumb = json['thumb'];
    smallS3 = json['small_s3'];
  }
}
