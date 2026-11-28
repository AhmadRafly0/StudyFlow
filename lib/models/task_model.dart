import 'package:cloud_firestore/cloud_firestore.dart';

class TaskPriority {
  TaskPriority._();

  static const String low = 'low';
  static const String medium = 'medium';
  static const String high = 'high';
}

/// Dokumen: users/{uid}/tasks/{taskId}
class TaskModel {
  final String id;
  final String title;
  final String subject;
  final DateTime deadline;

  // TaskPriority.low / medium / high
  final String priority; 
  final bool isDone;
  final DateTime createdAt;

  const TaskModel({
    required this.id,
    required this.title,
    required this.subject,
    required this.deadline,
    this.priority = TaskPriority.medium,
    this.isDone = false,
    required this.createdAt,
  });

  factory TaskModel.fromFirestore(DocumentSnapshot doc) {
    final data = (doc.data() as Map<String, dynamic>?) ?? {};
    return TaskModel(
      id: doc.id,
      title: data['title'] as String? ?? '',
      subject: data['subject'] as String? ?? '',
      deadline: (data['deadline'] as Timestamp?)?.toDate() ?? DateTime.now(),
      priority: data['priority'] as String? ?? TaskPriority.medium,
      isDone: data['isDone'] as bool? ?? false,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subject': subject,
      'deadline': Timestamp.fromDate(deadline),
      'priority': priority,
      'isDone': isDone,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  TaskModel copyWith({
    String? id,
    String? title,
    String? subject,
    DateTime? deadline,
    String? priority,
    bool? isDone,
    DateTime? createdAt,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subject: subject ?? this.subject,
      deadline: deadline ?? this.deadline,
      priority: priority ?? this.priority,
      isDone: isDone ?? this.isDone,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
