import 'package:flutter/material.dart';
import '../models/protein_data.dart';
import '../widgets/progress_gauge.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProteinData _proteinData = ProteinData(target: 100.0);

  void _updateTarget() {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController _targetController = TextEditingController();
        return AlertDialog(
          title: Text('Set Target'),
          content: TextField(
            controller: _targetController,
            decoration: InputDecoration(
              hintText: 'Enter new target',
            ),
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final target = double.tryParse(_targetController.text);
                if (target != null) {
                  setState(() {
                    _proteinData.target = target;
                    _proteinData.total = 0.0; // Reset progress
                  });
                }
                Navigator.pop(context);
              },
              child: Text('Set'),
            ),
          ],
        );
      },
    );
  }

  void _addProtein() {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController _inputController = TextEditingController();
        return AlertDialog(
          title: Text('Add Protein Intake'),
          content: TextField(
            controller: _inputController,
            decoration: InputDecoration(
              hintText: 'Enter protein amount',
            ),
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final intake = double.tryParse(_inputController.text);
                if (intake != null) {
                  setState(() {
                    _proteinData.total += intake;
                  });
                }
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _resetProgress() {
    setState(() {
      _proteinData.total = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Protein Tracker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Target',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: _updateTarget,
                  child: Text(
                    _proteinData.target.toStringAsFixed(1),
                    style: TextStyle(fontSize: 32, color: const Color.fromARGB(255, 58, 59, 60)),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ProgressGauge(
              total: _proteinData.total,
              target: _proteinData.target,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _addProtein,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 58, 59, 60), // Text color of the button
                  ),
                  child: Text('ADD'),
                ),
                ElevatedButton(
                  onPressed: _resetProgress,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 58, 59, 60), // Text color of the button
                  ),
                  child: Text('RESET'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}