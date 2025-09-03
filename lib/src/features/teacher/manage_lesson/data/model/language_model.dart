class TeacherLanguage {
  final String id; // Firestore docId
  final String teacherId;
  final String language;

  TeacherLanguage({
    required this.id,
    required this.teacherId,
    required this.language,
  });

  factory TeacherLanguage.fromMap(Map<String, dynamic> map, String id) {
    return TeacherLanguage(
      id: id,
      teacherId: map['teacherId'] ?? '',
      language: map['language'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "teacherId": teacherId,
      "language": language,
    };
  }
}
