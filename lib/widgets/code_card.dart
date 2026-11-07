import 'package:flutter/material.dart';
import '../models/mobile_code.dart';

class CodeCard extends StatelessWidget {
  const CodeCard({super.key, required this.item, required this.favorite, required this.onFavorite, required this.onDial, required this.onCopy});
  final MobileCode item;
  final bool favorite;
  final VoidCallback onFavorite;
  final VoidCallback onDial;
  final VoidCallback onCopy;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Expanded(child: Text(item.title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800))),
            IconButton(onPressed: onFavorite, icon: Icon(favorite ? Icons.star_rounded : Icons.star_border_rounded, color: favorite ? Colors.amber : null)),
          ]),
          Text('${item.providerName}  •  ${item.category}', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: color.onSurfaceVariant)),
          const SizedBox(height: 12),
          Container(width: double.infinity, padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12), decoration: BoxDecoration(color: color.surfaceContainerHighest.withValues(alpha: .55), borderRadius: BorderRadius.circular(14)), child: SelectableText(item.code, textAlign: TextAlign.center, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold, letterSpacing: 1.2))),
          if (item.description.isNotEmpty) ...[const SizedBox(height: 8), Text(item.description, style: Theme.of(context).textTheme.bodySmall)],
          if (!item.verified) ...[const SizedBox(height: 8), const Row(children: [Icon(Icons.info_outline, size: 15, color: Colors.orange), SizedBox(width: 5), Text('كود تجريبي – لم يتم التحقق منه رسمياً', style: TextStyle(fontSize: 11, color: Colors.orange))])],
          const SizedBox(height: 10),
          Row(children: [
            Expanded(child: FilledButton.icon(onPressed: onDial, icon: const Icon(Icons.call), label: const Text('فتح الاتصال'))),
            const SizedBox(width: 8),
            OutlinedButton.icon(onPressed: onCopy, icon: const Icon(Icons.copy), label: const Text('نسخ')),
          ]),
        ]),
      ),
    );
  }
}
