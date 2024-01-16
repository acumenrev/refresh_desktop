class UnsplashResponse {
  final int total;
  final int totalPages;
  final List<UnsplashPhoto> results;

  UnsplashResponse({
    required this.total,
    required this.totalPages,
    required this.results,
  });

  factory UnsplashResponse.fromJson(Map<String, dynamic> json) {
    List<UnsplashPhoto> results = [];
    for (var result in json['results']) {
      results.add(UnsplashPhoto.fromJson(result));
    }
    return UnsplashResponse(
      total: json['total'],
      totalPages: json['total_pages'],
      results: results,
    );
  }
}

class UnsplashPhoto {
  final String id;
  final String description;
  final String altDescription;
  final UnsplashUrls urls;
  final UnsplashLinks links;

  UnsplashPhoto(
      {required this.id,
      required this.description,
      required this.altDescription,
      required this.urls,
      required this.links});

  factory UnsplashPhoto.fromJson(Map<String, dynamic> json) {
    return UnsplashPhoto(
        id: json['id'],
        description: json['description'] ?? "",
        altDescription: json['alt_description'] ?? "",
        urls: UnsplashUrls.fromJson(json['urls']),
        links: UnsplashLinks.fromJson(json['links']));
  }
}

class UnsplashUrls {
  final String raw;
  final String full;
  final String regular;
  final String small;
  final String thumb;
  final String smallS3;

  UnsplashUrls({
    required this.raw,
    required this.full,
    required this.regular,
    required this.small,
    required this.thumb,
    required this.smallS3,
  });

  factory UnsplashUrls.fromJson(Map<String, dynamic> json) {
    return UnsplashUrls(
      raw: json['raw'],
      full: json['full'],
      regular: json['regular'],
      small: json['small'],
      thumb: json['thumb'],
      smallS3: json['small_s3'],
    );
  }
}

class UnsplashLinks {
  final String self;
  final String html;
  final String download;
  final String downloadLocation;

  UnsplashLinks({
    required this.self,
    required this.html,
    required this.download,
    required this.downloadLocation,
  });

  factory UnsplashLinks.fromJson(Map<String, dynamic> json) {
    return UnsplashLinks(
      self: json['self'],
      html: json['html'],
      download: json['download'],
      downloadLocation: json['download_location'],
    );
  }
}
