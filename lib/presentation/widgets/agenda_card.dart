import 'package:flutter/material.dart';
import '../../data/models/agenda_item.dart';

class AgendaCard extends StatelessWidget {
  const AgendaCard({super.key, required this.item});

  final AgendaItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.title, style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Text('${item.speaker}  |  ${item.room}'),
          const SizedBox(height: 4),
          Text(
            '${item.startAt.day}/${item.startAt.month}/${item.startAt.year} ${item.startAt.hour.toString().padLeft(2, '0')}:${item.startAt.minute.toString().padLeft(2, '0')}',
          ),
          if (item.description.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(item.description),
          ],
        ],
      ),
    );
  }
}
