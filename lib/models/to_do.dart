import 'dart:convert';

class TODO {
  final String key;
  final String tid;
  final String title;
  final bool completed;

  TODO({
    required this.tid,
    required this.key,
    required this.title,
    required this.completed,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'tid': tid});
    result.addAll({'key': key});
    result.addAll({'title': title});
    result.addAll({'completed': completed});

    return result;
  }

  String toJson() => json.encode(toMap());

  static TODO fromJson(String jsonStr) {
    final myMap = jsonDecode(jsonStr);
    return TODO(
      tid: myMap["tid"],
      key: myMap["key"],
      title: myMap["title"],
      completed: myMap["completed"],
    );
  }

  TODO copyWith({
    String? tid,
    String? key,
    String? title,
    bool? completed,
  }) {
    return TODO(
      tid: tid ?? this.tid,
      key: key ?? this.key,
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }

  factory TODO.fromMap(Map<String, dynamic> map) {
    return TODO(
      tid: map['tid'] ?? '',
      key: map['key'] ?? '',
      title: map['title'] ?? '',
      completed: map['completed'] ?? false,
    );
  }
}
