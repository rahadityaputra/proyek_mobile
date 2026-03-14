import 'package:flutter/material.dart';
// import 'package:proyek_mobile/model/character_data.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:proyek_mobile/model/character_analysis_notifier.dart';
import 'package:proyek_mobile/widget/horizontal_histogram.dart';

class CharacterAnalysisScreen extends StatefulWidget {
  const CharacterAnalysisScreen({super.key});

  @override
  State<CharacterAnalysisScreen> createState() =>
      _CharacterAnalysisScreenState();
}

class _CharacterAnalysisScreenState extends State<CharacterAnalysisScreen> {
  late TextEditingController _textController;
  final CharacterAnalysisNotifier characterAnalysisNotifier =
      CharacterAnalysisNotifier();

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    characterAnalysisNotifier.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    characterAnalysisNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Character Map')),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (String newCharacter) {
                characterAnalysisNotifier.updateCharacter(newCharacter);
              },
              controller: _textController,
              maxLength: 2000,
              maxLines: 10,
              decoration: InputDecoration(
                labelText: 'Enter text to analyze',
                alignLabelWithHint: true,
                labelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 16),

            HorizontalHistogram(
              characterCount: characterAnalysisNotifier.characterCount,
            ),
          ],
        ),
      ),
    );
  }
}
