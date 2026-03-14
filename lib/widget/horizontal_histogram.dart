import 'package:flutter/material.dart';

class HorizontalHistogram extends StatelessWidget {
  final List<MapEntry<String, int>> characterCount;

  const HorizontalHistogram({super.key, required this.characterCount});

  @override
  Widget build(BuildContext context) {
    final int maxCount = characterCount.isNotEmpty
        ? characterCount.map((e) => e.value).reduce((a, b) => a > b ? a : b)
        : 1;

    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: characterCount.length,
        itemBuilder: (context, index) {
          final entry = characterCount[index];
          final double barWidthFactor = entry.value / maxCount;

          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 4.0,
              horizontal: 16.0,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 30,
                  child: Text(
                    entry.key,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      // Bar Aktif
                      FractionallySizedBox(
                        widthFactor: barWidthFactor,
                        child: Container(
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 30,
                  child: Text(
                    '${entry.value}',
                    style: const TextStyle(color: Colors.black54),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
