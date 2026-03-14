import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyek_mobile/model/pyramid_notifier.dart';

class PiramidScreen extends StatefulWidget {
  const PiramidScreen({super.key});

  @override
  State<PiramidScreen> createState() => _PiramidScreenState();
}

class _PiramidScreenState extends State<PiramidScreen> {
  late TextEditingController _baseController;
  late TextEditingController _heightController;
  final PyramidNotifier _pyramidNotifier = PyramidNotifier();

  @override
  void initState() {
    super.initState();
    _baseController = TextEditingController();
    _heightController = TextEditingController();
    _pyramidNotifier.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _baseController.dispose();
    _heightController.dispose();
    _pyramidNotifier.dispose();
    super.dispose();
  }

  String _formatNumber(double value) {
    if (value == value.roundToDouble()) {
      return value.toStringAsFixed(0);
    }
    return value.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pyramid')),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF6C63FF), Color(0xFF4840BB)],
          ),
        ),
        child: Center(
          child: Container(
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
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonFormField<PyramidBaseType>(
                      value: _pyramidNotifier.baseType,
                      decoration: InputDecoration(
                        label: Text('Base shape', style: GoogleFonts.poppins()),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        prefixIcon: const Icon(
                          Icons.change_history,
                          color: Color(0xFF6C63FF),
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: PyramidBaseType.square,
                          child: Text('Square'),
                        ),
                        DropdownMenuItem(
                          value: PyramidBaseType.circle,
                          child: Text('Circle'),
                        ),
                        DropdownMenuItem(
                          value: PyramidBaseType.equilateralTriangle,
                          child: Text('Equilateral Triangle'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value == null) return;
                        _pyramidNotifier.updateBaseType(value);
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _baseController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      onChanged: _pyramidNotifier.updateBaseValue,
                      validator: validateDouble,
                      autovalidateMode: AutovalidateMode.always,
                      decoration: InputDecoration(
                        label: Text(
                          _pyramidNotifier.baseInputLabel,
                          style: GoogleFonts.poppins(),
                        ),
                        hintText: '0',
                        hintStyle: GoogleFonts.poppins(
                          color: Colors.grey.shade400,
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        prefixIcon: const Icon(
                          Icons.straighten,
                          color: Color(0xFF6C63FF),
                        ),
                      ),
                      style: GoogleFonts.poppins(),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _heightController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      onChanged: _pyramidNotifier.updateHeight,
                      validator: validateDouble,
                      autovalidateMode: AutovalidateMode.always,
                      decoration: InputDecoration(
                        label: Text('Height', style: GoogleFonts.poppins()),
                        hintText: '0',
                        hintStyle: GoogleFonts.poppins(
                          color: Colors.grey.shade400,
                        ),
                        prefixIcon: const Icon(
                          Icons.height,
                          color: Color(0xFF6C63FF),
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      style: GoogleFonts.poppins(),
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
                            'Volume: ${_formatNumber(_pyramidNotifier.volume)}',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Surface Area: ${_formatNumber(_pyramidNotifier.surfaceArea)}',
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
          ),
        ),
      ),
    );
  }

  String? validateDouble(text) {
    if (text == null || text.isEmpty) {
      return 'Cannot be empty';
    }
    if (double.tryParse(text) == null) {
      return 'Must be a number';
    }
    return null;
  }
}
