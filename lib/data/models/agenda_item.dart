class AgendaItem {
  const AgendaItem({
    required this.title,
    required this.speaker,
    required this.room,
    required this.startAt,
    this.description = '',
  });

  factory AgendaItem.fromMap(Map<String, dynamic> map) {
    final parsed = DateTime.tryParse('${map['start_at'] ?? ''}');
    return AgendaItem(
      title: '${map['title'] ?? 'Session'}',
      speaker: '${map['speaker'] ?? 'TBA'}',
      room: '${map['room'] ?? 'Main Hall'}',
      startAt: parsed ?? DateTime.now(),
      description: '${map['description'] ?? ''}',
    );
  }

  final String title;
  final String speaker;
  final String room;
  final DateTime startAt;
  final String description;
}
