/// Post data model — represents a single post from the API.
/// Using a typed model instead of Map<String, dynamic> throughout the app
/// gives us autocompletion, type safety, and better readability.
class Post {
  final int id;
  final int userId;
  final String title;
  final String body;

  const Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  /// Named factory constructor — parses JSON from the API response.
  factory Post.fromJson(Map<String, dynamic> json) {   // json -> model
    return Post(
      id: json['id'] as int,
      userId: json['userId'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }

  /// Converts Post back to JSON (useful for create/update requests).
  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'title': title,
        'body': body,
      };

  @override
  String toString() => 'Post(id: $id, title: $title)';
}
