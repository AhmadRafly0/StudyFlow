import 'package:cloud_firestore/cloud_firestore.dart';

/// Dokumen: users/{uid}/notes/{noteId}
class NoteModel {
  final String id;
  final String title;
  final String content;
  final String subject;
  final DateTime createdAt;
  final DateTime updatedAt;

  const NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.subject,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NoteModel.fromFirestore(DocumentSnapshot doc) {
    final data = (doc.data() as Map<String, dynamic>?) ?? {};
    final created = (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now();
    return NoteModel(
      id: doc.id,
      title: data['title'] as String? ?? '',
      content: data['content'] as String? ?? '',
      subject: data['subject'] as String? ?? '',
      createdAt: created,
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? created,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'subject': subject,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  NoteModel copyWith({
    String? id,
    String? title,
    String? content,
    String? subject,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      subject: subject ?? this.subject,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
