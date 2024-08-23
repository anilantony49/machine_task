class Repository {
  final String name;
  // final String fullName;
  // final String htmlUrl;
  // final String description;
  final int stargazersCount;
  // final String language;
  // final DateTime createdAt;

  Repository({
    required this.name,
    // required this.fullName,
    // required this.htmlUrl,
    // required this.description,
    required this.stargazersCount,
    // required this.language,
    // required this.createdAt,
  });

  factory Repository.fromJson(Map<String, dynamic> json) {
    return Repository(
      name: json['name'],
      // fullName: json['full_name'],
      // htmlUrl: json['html_url'],
      // description: json['description'] ?? 'No description',
      stargazersCount: json['stargazers_count'],
      // language: json['language'] ?? 'Unknown',
      // createdAt: DateTime.parse(json['created_at']
      // ),
    );
  }
}
