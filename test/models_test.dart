import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:studyflow/models/models.dart';

void main() {
  test('TaskModel toMap/copyWith memakai nama field sesuai rancangan', () {
    final task = TaskModel(
      id: 't1',
      title: 'PR',
      subject: 'PKB',
      deadline: DateTime(2026, 5, 12),
      priority: TaskPriority.high,
      createdAt: DateTime(2026, 5, 1),
    );
    final map = task.toMap();
    expect(map.keys, containsAll(['title', 'subject', 'deadline', 'priority', 'isDone', 'createdAt']));
    expect(map.containsKey('id'), isFalse);
    expect(map['deadline'], isA<Timestamp>());
    expect(task.copyWith(isDone: true).isDone, isTrue);
  });

  test('Model lain menulis field sesuai rancangan', () {
    final schedule = const ScheduleModel(
      id: 's1', subject: 'PKB', day: 1, startTime: '08:00', endTime: '09:40', color: 0xFF2196F3, room: 'R1',
    );
    expect(schedule.toMap().keys, containsAll(['subject', 'day', 'startTime', 'endTime', 'color', 'room']));

    final note = NoteModel(
      id: 'n1', title: 'a', content: 'b', subject: 'c',
      createdAt: DateTime(2026), updatedAt: DateTime(2026),
    );
    expect(note.toMap().keys, containsAll(['title', 'content', 'subject', 'createdAt', 'updatedAt']));

    final session = SessionModel(id: 'x', date: DateTime(2026), durationMinutes: 25);
    expect(session.toMap(), containsPair('taskId', ''));
    expect(session.toMap(), containsPair('durationMinutes', 25));
  });
}
