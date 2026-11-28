import 'package:cloud_firestore/cloud_firestore.dart';

/// Dokumen: users/{uid}/sessions/{sessionId}
class SessionModel {
  final String id;

  /// Waktu sesi belajar selesai.
  final DateTime date;

  /// Durasi fokus dalam menit.
  final int durationMinutes;

  /// ID tugas yang dikerjakan. Boleh kosong ("").
  final String taskId;

  const SessionModel({
    required this.id,
    required this.date,
    required this.durationMinutes,
    this.taskId = '',
  });

  factory SessionModel.fromFirestore(DocumentSnapshot doc) {
    final data = (doc.data() as Map<String, dynamic>?) ?? {};
    return SessionModel(
      id: doc.id,
      date: (data['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
      durationMinutes: (data['durationMinutes'] as num?)?.toInt() ?? 0,
      taskId: data['taskId'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': Timestamp.fromDate(date),
      'durationMinutes': durationMinutes,
      'taskId': taskId,
    };
  }

  SessionModel copyWith({
    String? id,
    DateTime? date,
    int? durationMinutes,
    String? taskId,
  }) {
    return SessionModel(
      id: id ?? this.id,
      date: date ?? this.date,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      taskId: taskId ?? this.taskId,
    );
  }
}
