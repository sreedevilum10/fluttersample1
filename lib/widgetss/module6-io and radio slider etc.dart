import 'package:flutter/material.dart';

class WidgetsHome extends StatefulWidget {
  @override
  State<WidgetsHome> createState() => _WidgetsHomeState();
}

class _WidgetsHomeState extends State<WidgetsHome> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          FormValidationPage(),
          ButtonsPage(),
          CheckboxRadioSwitchPage(),
          DateTimeSliderPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'Forms'),
          BottomNavigationBarItem(
            icon: Icon(Icons.touch_app),
            label: 'Buttons',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: 'Toggle',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.date_range),
            label: 'Date/Time',
          ),
        ],
      ),
    );
  }
}

// ============ PAGE 1: FORM & VALIDATION ============
class FormValidationPage extends StatefulWidget {
  @override
  State<FormValidationPage> createState() => _FormValidationPageState();
}

class _FormValidationPageState extends State<FormValidationPage> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String password = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Widgets & Validation'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Text Input Field
              Text(
                'Full Name *',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 6),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter your name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 11,
                  ),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Name is required';
                  }
                  if ((value?.length ?? 0) < 3) {
                    return 'Min 3 characters required';
                  }
                  return null;
                },
                onSaved: (value) => name = value ?? '',
              ),
              SizedBox(height: 20),

              // Email Field with Validation
              Text(
                'Email *',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 6),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'example@email.com',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.green, width: 2),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 11,
                  ),
                  suffixIcon: Icon(Icons.check_circle, color: Colors.green),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Email is required';
                  }
                  if (!value!.contains('@')) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
                onSaved: (value) => email = value ?? '',
              ),
              SizedBox(height: 8),
              Text(
                '✓ Valid email',
                style: TextStyle(fontSize: 11, color: Colors.green),
              ),
              SizedBox(height: 20),

              // Password Field with Error State
              Text(
                'Password *',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 6),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: '••••••••',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.red, width: 2),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 11,
                  ),
                  suffixIcon: Icon(Icons.error, color: Colors.red),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Password is required';
                  }
                  if ((value?.length ?? 0) < 8) {
                    return 'Must be 8+ characters';
                  }
                  return null;
                },
                onSaved: (value) => password = value ?? '',
              ),
              SizedBox(height: 8),
              Text(
                '✗ Must be 8+ characters',
                style: TextStyle(fontSize: 11, color: Colors.red),
              ),
              SizedBox(height: 20),

              // MultiLine Text Field
              Text(
                'Description',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 6),
              TextFormField(
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Enter description...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 11,
                  ),
                ),
                onSaved: (value) => description = value ?? '',
              ),
              SizedBox(height: 24),

              // Submit Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Form submitted!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  backgroundColor: Colors.blue,
                ),
                child: Text(
                  'Submit Form',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============ PAGE 2: ALL BUTTON TYPES ============
class ButtonsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Button Types'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. ELEVATED BUTTON
            Text(
              'ELEVATED BUTTON',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () =>
                  _showSnackBar(context, 'Elevated Button Pressed'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text('Elevated Button'),
            ),
            SizedBox(height: 20),

            // 2. TEXT BUTTON
            Text(
              'TEXT BUTTON',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 8),
            TextButton(
              onPressed: () => _showSnackBar(context, 'Text Button Pressed'),
              child: Text('Text Button'),
            ),
            SizedBox(height: 20),

            // 3. OUTLINED BUTTON
            Text(
              'OUTLINED BUTTON',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 18),
            OutlinedButton(
              onPressed: () =>
                  _showSnackBar(context, 'Outlined Button Pressed'),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 22),
              ),
              child: Text('Outlined Button'),
            ),
            SizedBox(height: 20),

            // 4. ICON BUTTONS
            Text(
              'ICON BUTTONS',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: IconButton(
                    icon: Icon(Icons.favorite, color: Colors.white),
                    onPressed: () => _showSnackBar(context, 'Heart clicked'),
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.green,
                  child: IconButton(
                    icon: Icon(Icons.check, color: Colors.white),
                    onPressed: () => _showSnackBar(context, 'Check clicked'),
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.red,
                  child: IconButton(
                    icon: Icon(Icons.close, color: Colors.white),
                    onPressed: () => _showSnackBar(context, 'Close clicked'),
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.purple,
                  child: IconButton(
                    icon: Icon(Icons.settings, color: Colors.white),
                    onPressed: () => _showSnackBar(context, 'Settings clicked'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // 5. BUTTON STATES
            Text(
              'BUTTON STATES',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => _showSnackBar(context, 'Normal state'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12),
                backgroundColor: Colors.blue,
              ),
              child: Text('Normal State'),
            ),
            SizedBox(height: 8),
            ElevatedButton(onPressed: null, child: Text('Disabled State')),
            SizedBox(height: 20),

            // 6. DIFFERENT SIZES
            Text(
              'DIFFERENT SIZES',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 8),
            SizedBox(
              height: 30,
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Small Button'),
              ),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text('Medium Button'),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 26),
              ),
              child: Text('Large Button', style: TextStyle(fontSize: 16)),
            ),

            // 7. GRADIENT BUTTON
            SizedBox(height: 20),
            Text(
              'GRADIENT BUTTON',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.purple, Colors.black],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(
                  'Gradient Button',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            // 8. BUTTON WITH ICON
            SizedBox(height: 20),
            Text(
              'BUTTON WITH ICON',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.download),
              label: Text('Download'),
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}

// ============ PAGE 3: CHECKBOX, RADIO, SWITCH ============
class CheckboxRadioSwitchPage extends StatefulWidget {
  @override
  State<CheckboxRadioSwitchPage> createState() =>
      _CheckboxRadioSwitchPageState();
}

class _CheckboxRadioSwitchPageState extends State<CheckboxRadioSwitchPage> {
  bool checkbox1 = true;
  bool checkbox2 = false;
  String? radioValue ;
  bool switch1 = true;
  bool switch2 = false;
  String dropdownValue = 'Select an option';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkbox, Radio, Switch & Dropdown'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ===== CHECKBOXES =====
            Text(
              'CHECKBOXES',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 12),
            CheckboxListTile(
              title: Text('Option 1 (Checked)'),
              value: checkbox1,
              onChanged: (value) => setState(() => checkbox1 = value!),
            ),
            CheckboxListTile(
              title: Text('Option 2 (Unchecked)'),
              value: checkbox2,
              onChanged: (value) => setState(() => checkbox2 = value!),
            ),
            CheckboxListTile(
              title: Text('Option 3 (Disabled)'),
              value: false,
              onChanged: null,
            ),
            SizedBox(height: 24),

            // ===== RADIO BUTTONS =====
            Text(
              'RADIO BUTTONS',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 12),
            RadioGroup(
              groupValue: radioValue,
              onChanged: (value) {
                setState(() {
                  radioValue = value;
                });
              },
              child: Column(
                children: [
                  RadioListTile<String>(
                    title: Text('Option A'),
                    value: 'A',),
                  RadioListTile<String>(title: Text('Option B'), value: 'B'),
                  RadioListTile<String>(title: Text('Option C'), value: 'C')
                ],
              ),
            ),
            RadioListTile<String>(
              title: Text('Option D'),
              value: 'D',
              onChanged: null,
            ),

            SizedBox(height: 24),

            // ===== SWITCH / TOGGLE =====
            Text(
              'SWITCHES / TOGGLES',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 12),
            SwitchListTile(
              title: Text('Enable Notifications'),
              value: switch1,
              onChanged: (value) => setState(() => switch1 = value),
            ),
            SwitchListTile(
              title: Text('Dark Mode'),
              value: switch2,
              onChanged: (value) => setState(() => switch2 = value),
            ),
            SwitchListTile(
              title: Text('Disabled Toggle'),
              value: false,
              onChanged: null,
            ),
            SizedBox(height: 24),

            // ===== DROPDOWN BUTTON =====
            Text(
              'DROPDOWN BUTTON',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 8),
            DropdownButton<String>(
              isExpanded: true,
              value: dropdownValue,
              items: [
                DropdownMenuItem(value: 'Select an option',
                  child: Text('Select an option'),),
                DropdownMenuItem(value: 'Apple', child: Text('Apple')),
                DropdownMenuItem(value: 'Banana', child: Text('Banana')),
                DropdownMenuItem(value: 'Cherry', child: Text('Cherry')),
                DropdownMenuItem(value: 'Date', child: Text('Date')),
              ],
              onChanged: (value) => setState(() => dropdownValue = value!),
            ),
            SizedBox(height: 8),
            Text(
              'Selected: $dropdownValue',
              style: TextStyle(
                fontSize: 13,
                color: Colors.blue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============ PAGE 4: DATE, TIME & SLIDER ============
class DateTimeSliderPage extends StatefulWidget {
  @override
  State<DateTimeSliderPage> createState() => _DateTimeSliderPageState();
}

class _DateTimeSliderPageState extends State<DateTimeSliderPage> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  double volumeValue = 0;
  double brightnessValue = 75;
  double temperatureValue = 22;
  double priceValue = 250;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Date Picker, Time Picker & Slider'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
       // physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ===== DATE PICKER =====
            Text(
              'Select Date',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (picked != null && selectedDate != selectedDate) {
                  setState(() { selectedDate = picked;});
                }
              },
              child: Text('📅 ${selectedDate.toLocal().toString().split(' ')[0]}'),
            ),
            SizedBox(height: 8),
            Text(
              'Selected:  ${selectedDate.toLocal().toString().split(' ')[0]}                               ',
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(height: 24),

            // ===== TIME PICKER =====
            Text(
              'Select Time',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                final TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: selectedTime,
                );
                if (picked != null) {
                  setState(() => selectedTime = picked);
                }
              },
              child: Text('🕐 ${selectedTime.format(context)}'),
            ),
            SizedBox(height: 8),
            Text(
              'Selected: ${selectedTime.format(context)}',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            SizedBox(height: 24),

            // ===== SLIDERS =====
            Text(
              'VOLUME SLIDER',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.volume_off, color: Colors.red),
                Expanded(
                  child: Slider(
                    value: volumeValue,
                    min: 0,
                    max: 100,
                    onChanged: (value) => setState(() => volumeValue = value),
                  ),
                ),
                Icon(Icons.volume_up, color: Colors.red),
                SizedBox(width: 8),
                Text(
                  '${volumeValue.toStringAsFixed(0)}%',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(height: 24),

            // Brightness Slider
            Text(
              'BRIGHTNESS SLIDER',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.brightness_low, color: Colors.green),
                Expanded(
                  child: Slider(
                    value: brightnessValue,
                    min: 0,
                    max: 100,
                    onChanged: (value) =>
                        setState(() => brightnessValue = value),
                  ),
                ),
                Icon(Icons.brightness_high, color: Colors.green),
                SizedBox(width: 8),
                Text(
                  '${brightnessValue.toStringAsFixed(0)}%',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(height: 24),

            // Temperature Slider
            Text(
              'TEMPERATURE SLIDER',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 12),
            Slider(
              value: temperatureValue,
              min: 16,
              max: 30,
              divisions: 14,
              label: '${temperatureValue.toStringAsFixed(1)}°C',
              onChanged: (value) => setState(() => temperatureValue = value),
            ),
            SizedBox(height: 8),
            Text(
              'Current Temperature: ${temperatureValue.toStringAsFixed(1)}°C',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.orange,
              ),
            ),
            SizedBox(height: 24),

            // Price Range Slider
            Text(
              'PRICE RANGE SLIDER',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 12),
            Slider(
              value: priceValue,
              min: 0,
              max: 1000,
              divisions: 20,
              label: '\$${priceValue.toStringAsFixed(0)}',
              onChanged: (value) => setState(() => priceValue = value),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Price: \$${priceValue.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.purple,
                  ),
                ),
                Text(
                  'Range: \$0 - \$1000',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
