class Teacher {
  final String id;
  final String name;
  final List<String> languages;

  Teacher({
    required this.id,
    required this.name,
    required this.languages,
  });

  factory Teacher.fromMap(Map<String, dynamic> map, String docId) {
    return Teacher(
      id: docId,
      name: map['name'] ?? 'Unknown',
      languages: List<String>.from(map['languages'] ?? []),
    );
  }
}
