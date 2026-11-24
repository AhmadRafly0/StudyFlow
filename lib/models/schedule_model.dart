import 'package:cloud_firestore/cloud_firestore.dart';

/// Dokumen: users/{uid}/schedules/{scheduleId}
class ScheduleModel {
  final String id;
  final String subject;

  /// 1 = Senin ... 7 = Minggu
  final int day;

  /// Format 'HH:mm'
  final String startTime;
  final String endTime;

  /// Nilai int warna (Color.value / Color.toARGB32()).
  final int color;
  final String room;

  const ScheduleModel({
    required this.id,
    required this.subject,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.color,
    this.room = '',
  });

  factory ScheduleModel.fromFirestore(DocumentSnapshot doc) {
    final data = (doc.data() as Map<String, dynamic>?) ?? {};
    return ScheduleModel(
      id: doc.id,
      subject: data['subject'] as String? ?? '',
      day: (data['day'] as num?)?.toInt() ?? 1,
      startTime: data['startTime'] as String? ?? '',
      endTime: data['endTime'] as String? ?? '',
      color: (data['color'] as num?)?.toInt() ?? 0xFF2196F3,
      room: data['room'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'subject': subject,
      'day': day,
      'startTime': startTime,
      'endTime': endTime,
      'color': color,
      'room': room,
    };
  }

  ScheduleModel copyWith({
    String? id,
    String? subject,
    int? day,
    String? startTime,
    String? endTime,
    int? color,
    String? room,
  }) {
    return ScheduleModel(
      id: id ?? this.id,
      subject: subject ?? this.subject,
      day: day ?? this.day,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      color: color ?? this.color,
      room: room ?? this.room,
    );
  }
}
