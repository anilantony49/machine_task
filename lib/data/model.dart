class Repository {
  final String id;
  final String repoName;
  final int stargazersCount;
  final String? description; // Make description nullable
  // final String? language; // Make language nullable
  final String? imageUrl; // Example field for image URL
  final String userName;

  Repository({
    required this.id,
    required this.userName,
    required this.repoName,
    required this.stargazersCount,
    this.description, // Nullable field
    // this.language, // Nullable field
    this.imageUrl, // Nullable field
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'repoName': repoName,
      'userName': userName,
      'imageUrl': imageUrl,
      'stargazersCount': stargazersCount,
      'description': description,
    };
  }

  factory Repository.fromJson(Map<String, dynamic> json) {
    return Repository(
      id: json['id'].toString(),
      repoName: json['name'] ?? 'Unknown', // Provide default value if null
      stargazersCount: json['stargazers_count'] ?? 0, // Default to 0 if null
      description: json['description'] as String?,
      userName: json['owner']?['login'] ?? 'Unknown',
      imageUrl:
          json['owner']?['avatar_url'] as String?, // Assume image URL is nested
    );
  }
}
