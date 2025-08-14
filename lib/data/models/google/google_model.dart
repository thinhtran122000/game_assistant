class GoogleModel {
  String? kind;
  String? title;
  String? htmlTitle;
  String? link;
  String? displayLink;
  String? snippet;
  String? htmlSnippet;
  String? formattedUrl;
  String? htmlFormattedUrl;
  Pagemap? pagemap;

  GoogleModel({
    this.kind,
    this.title,
    this.htmlTitle,
    this.link,
    this.displayLink,
    this.snippet,
    this.htmlSnippet,
    this.formattedUrl,
    this.htmlFormattedUrl,
    this.pagemap,
  });

  factory GoogleModel.fromJson(Map<String, dynamic> json) => GoogleModel(
        kind: json['kind'],
        title: json['title'],
        htmlTitle: json['htmlTitle'],
        link: json['link'],
        displayLink: json['displayLink'],
        snippet: json['snippet'],
        htmlSnippet: json['htmlSnippet'],
        formattedUrl: json['formattedUrl'],
        htmlFormattedUrl: json['htmlFormattedUrl'],
        pagemap: json['pagemap'] == null ? null : Pagemap.fromJson(json['pagemap']),
      );

  Map<String, dynamic> toJson() => {
        'kind': kind,
        'title': title,
        'htmlTitle': htmlTitle,
        'link': link,
        'displayLink': displayLink,
        'snippet': snippet,
        'htmlSnippet': htmlSnippet,
        'formattedUrl': formattedUrl,
        'htmlFormattedUrl': htmlFormattedUrl,
        'pagemap': pagemap?.toJson(),
      };
}

class Pagemap {
  List<CseThumbnail> cseThumbnail;
  List<CseImage> cseImage;

  Pagemap({
    this.cseThumbnail = const [],
    this.cseImage = const [],
  });

  factory Pagemap.fromJson(Map<String, dynamic> json) => Pagemap(
        cseThumbnail: json['cse_thumbnail'] == null ? [] : List<CseThumbnail>.from(json['cse_thumbnail'].map((x) => CseThumbnail.fromJson(x))),
        cseImage: json['cse_thumbnail'] == null ? [] : List<CseImage>.from(json['cse_image'].map((x) => CseImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'cse_thumbnail': List<dynamic>.from(cseThumbnail.map((x) => x.toJson())),
        'cse_image': List<dynamic>.from(cseImage.map((x) => x.toJson())),
      };
}

class CseImage {
  String? src;

  CseImage({
    this.src,
  });

  factory CseImage.fromJson(Map<String, dynamic> json) => CseImage(
        src: json['src'],
      );

  Map<String, dynamic> toJson() => {
        'src': src,
      };
}

class CseThumbnail {
  String? src;
  String? width;
  String? height;

  CseThumbnail({
    this.src,
    this.width,
    this.height,
  });

  factory CseThumbnail.fromJson(Map<String, dynamic> json) => CseThumbnail(
        src: json['src'],
        width: json['width'],
        height: json['height'],
      );

  Map<String, dynamic> toJson() => {
        'src': src,
        'width': width,
        'height': height,
      };
}
