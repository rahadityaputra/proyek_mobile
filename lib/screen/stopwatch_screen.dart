import 'package:flutter/material.dart';

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  _StopwatchScreenState createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> with SingleTickerProviderStateMixin {
  late Stopwatch _stopwatch;
  late AnimationController _penggerakLayar;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
    
    _penggerakLayar = AnimationController(
      vsync: this,
      duration: const Duration(days: 365),
    )..addListener(() {
        if (_stopwatch.isRunning) {
          setState(() {}); 
        }
      });
  }

  void _mulaiStopwatch() {
    _stopwatch.start();
    _penggerakLayar.forward();
  }

  void _hentiStopwatch() {
    _stopwatch.stop();
    _penggerakLayar.stop();
    setState(() {});
  }

  void _resetStopwatch() {
    _hentiStopwatch();
    _stopwatch.reset();
    setState(() {});
  }

  String _formatWaktu() {
    var waktu = _stopwatch.elapsed.inMilliseconds;
    String milidetik = (waktu % 1000).toString().padLeft(3, "0").substring(0, 2);
    String detik = ((waktu ~/ 1000) % 60).toString().padLeft(2, "0");
    String menit = ((waktu ~/ 1000) ~/ 60).toString().padLeft(2, "0");
    
    return "$menit:$detik:$milidetik";
  }

  @override
  void dispose() {
    _penggerakLayar.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Stopwatch'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: const Color(0xFF6C63FF), width: 2),
              ),
              child: Text(
                _formatWaktu(),
                style: const TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6C63FF),
                ),
              ),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _stopwatch.isRunning ? null : _mulaiStopwatch,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text('Start', style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 15),
                ElevatedButton(
                  onPressed: _stopwatch.isRunning ? _hentiStopwatch : null,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text('Stop', style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 15),
                ElevatedButton(
                  onPressed: _resetStopwatch,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  child: const Text('Reset', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}