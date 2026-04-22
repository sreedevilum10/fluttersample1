import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BottomSheetAlertsApp());
}

class BottomSheetAlertsApp extends StatelessWidget {
  const BottomSheetAlertsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bottom Sheet & Alerts Demo',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const BottomSheetAlertsScreen(),
    );
  }
}

// ==================== BOTTOM SHEET & ALERTS SCREEN ====================

class BottomSheetAlertsScreen extends StatefulWidget {
  const BottomSheetAlertsScreen({Key? key}) : super(key: key);

  @override
  State<BottomSheetAlertsScreen> createState() =>
      _BottomSheetAlertsScreenState();
}

class _BottomSheetAlertsScreenState extends State<BottomSheetAlertsScreen> {
  String _selectedOption = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bottom Sheet & Alerts'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ==================== ALERT DIALOGS ====================
              const Text(
                'Alert Dialogs',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Simple Alert
              ElevatedButton.icon(
                onPressed: () => _showSimpleAlert(context),
                icon: const Icon(Icons.info),
                label: const Text('Simple Alert'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
              const SizedBox(height: 12),

              // Confirmation Alert
              ElevatedButton.icon(
                onPressed: () => _showConfirmationAlert(context),
                icon: const Icon(Icons.question_mark),
                label: const Text('Confirmation Alert'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
              const SizedBox(height: 12),

              // Choice Alert
              ElevatedButton.icon(
                onPressed: () => _showChoiceAlert(context),
                icon: const Icon(Icons.list),
                label: const Text('Choice Alert'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
              const SizedBox(height: 12),

              // Input Alert
              ElevatedButton.icon(
                onPressed: () => _showInputAlert(context),
                icon: const Icon(Icons.edit),
                label: const Text('Input Alert'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),

              const SizedBox(height: 32),

              ElevatedButton.icon(
                onPressed: () => _showAwesomeDialoug(context),
                label: Text("alert from Dependency"),
              ),

              const SizedBox(height: 32),

              // ==================== SNACKBARS ====================
              const Text(
                'SnackBars',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Simple SnackBar
              ElevatedButton.icon(
                onPressed: () => _showSimpleSnackBar(context),
                icon: const Icon(Icons.notifications),
                label: const Text('Simple SnackBar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(
                      vertical: 12),
                ),
              ),
              const SizedBox(height: 12),

              // SnackBar with Action
              ElevatedButton.icon(
                onPressed: () => _showSnackBarWithAction(context),
                icon: const Icon(Icons.undo),
                label: const Text('SnackBar with Action'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan,
                  padding: const EdgeInsets.symmetric(
                      vertical: 12),
                ),
              ),

              const SizedBox(height: 32),

              // ==================== BOTTOM SHEETS ====================
              const Text(
                'Bottom Sheets',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Modal Bottom Sheet
              ElevatedButton.icon(
                onPressed: () => _showModalBottomSheet(context),
                icon: const Icon(Icons.open_in_new),
                label: const Text('Modal Bottom Sheet'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: const EdgeInsets.symmetric(
                      vertical: 12),
                ),
              ),
              const SizedBox(height: 12),

              // Persistent Bottom Sheet
              ElevatedButton.icon(
                onPressed: () => _showModalBottomSheetPersistant(context),
                icon: Icon(Icons.vertical_align_bottom),
                label: const Text('Persistent Bottom Sheet'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),

              const SizedBox(height: 32),

              // Selected Option Display
              if (_selectedOption.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Last Selection:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(_selectedOption),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // ==================== ALERT DIALOGS ====================
  void _showSimpleAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [const Icon(Icons.timelapse), const Text('Simple Alert')],
          ),
          content: const Text(
            'This is a simple alert dialog with just OK button.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showConfirmationAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Action'),
        content: const Text('Are you sure you want to proceed?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() => _selectedOption = 'Confirmed action');
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Action confirmed!')),
              );
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  void _showChoiceAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Option'),
        content: const Text('Select one option:'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() => _selectedOption = 'Option 1 selected');
              Navigator.pop(context);
            },
            child: const Text('Option 1'),
          ),
          TextButton(
            onPressed: () {
              setState(() => _selectedOption = 'Option 2 selected');
              Navigator.pop(context);
            },
            child: const Text('Option 2'),
          ),
          TextButton(
            onPressed: () {
              setState(() => _selectedOption = 'Option 3 selected');
              Navigator.pop(context);
            },
            child: const Text('Option 3'),
          ),
        ],
      ),
    );
  }

  void _showInputAlert(BuildContext context) {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter Your Name'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Type your name here',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                setState(() => _selectedOption = 'Name: ${controller.text}');
                Navigator.pop(context);
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  void _showAwesomeDialoug(BuildContext context) {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Dialog Title',
        desc: 'Dialog description here.............',
        btnCancelOnPress: () {},
    btnOkOnPress: () {},
    ).show();
  }


  // ==================== SNACKBARS ====================

  void _showSimpleSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('This is a simple SnackBar message'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSnackBarWithAction(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Item deleted'),
        duration: const Duration(seconds: 4),
        backgroundColor: Colors.grey[800],
        action: SnackBarAction(
          label: 'UNDO',
          textColor: Colors.yellow,
          onPressed: () {
            setState(() =>
            _selectedOption = 'Undo action performed');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Item restored!'),
                duration: Duration(seconds: 2),
              ),
            );
          },
        ),
      ),
    );
  }

  // ==================== BOTTOM SHEETS ====================

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
     shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const Text(
              'Share This App',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Share Options
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildShareOption('facebook', '👤'),
                _buildShareOption('twitter', '🐦'),
                _buildShareOption('whatsapp', '💬'),
                _buildShareOption('email', '📧'),
              ],
            ),
            const SizedBox(height: 16),

            // Close Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: const Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShareOption(String label, String icon) {
    return GestureDetector(
      onTap: () {
        setState(() => _selectedOption = 'Shared via $label');
        Navigator.pop(context);
      },
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 40)),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  void _showModalBottomSheetPersistant(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) => Container(
        color: Colors.grey[100],
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar (visual indicator)
            Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 16),

            // Title
            const Text(
              'Filter Options',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Filter Options
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFilterOption('Price: Low to High', () {
                  setState(() => _selectedOption = 'Price: Low to High');
                  Navigator.pop(context); // ✓ Closes modal
                }),
                _buildFilterOption('Price: High to Low', () {
                  setState(() => _selectedOption = 'Price: High to Low');
                  Navigator.pop(context);
                }),
                _buildFilterOption('Newest First', () {
                  setState(() => _selectedOption = 'Newest First');
                  Navigator.pop(context);
                }),
                _buildFilterOption('Best Rating', () {
                  setState(() => _selectedOption = 'Best Rating');
                  Navigator.pop(context);
                }),
              ],
            ),
            const SizedBox(height: 16),

            // Close Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context), // ✓ Works!
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterOption(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.blue),
            const SizedBox(width: 12),
            Text(label),
          ],
        ),
      ),
    );
  }
}
