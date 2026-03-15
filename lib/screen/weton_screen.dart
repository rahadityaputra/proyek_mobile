import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:proyek_mobile/model/neptu.dart';
import 'package:proyek_mobile/model/pyramid_notifier.dart';
import 'package:proyek_mobile/model/weton.dart';

class WetonScreen extends StatefulWidget {
  const WetonScreen({super.key});

  @override
  State<WetonScreen> createState() => _WetonScreenState();
}

class _WetonScreenState extends State<WetonScreen> {
  DateTime _dateTime = DateTime.now();
  final _dateFormat = DateFormat("EEEE, dd MMMM yyyy");
  ConversionResult? _conversionResult;

  @override
  void initState() {
    _processDate();
    super.initState();
  }

  void _changeDate() async {
    final selected = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime(2099),
      currentDate: _dateTime,
    );
    if (selected != null) {
      setState(() {
        _dateTime = selected;
        _processDate();
      });
    }
  }

  void _processDate() {
    _conversionResult = getWeton(_dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weton')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF6C63FF), Color(0xFF4840BB)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            _dateFormat.format(_dateTime),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _changeDate,
                          child: Text("Change Date"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5FA),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dino: $_dino ($_neptuSaptawara)',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Pasaran: $pasaran ($_neptuPancawara)',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Neptu: ${_neptuPancawara + _neptuSaptawara}',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }

  int get _neptuPancawara => getNeptuPancawara(_conversionResult?.wetonNumber.pancawara ?? 0);

  String get pasaran => _conversionResult?.wetonName.pancawara ?? "";

  String get _dino => getDinoSaptawara(_conversionResult?.wetonNumber.saptawara ?? 0);

  int get _neptuSaptawara => getNeptuSaptawara(_conversionResult?.wetonNumber.saptawara ?? 0);
}
