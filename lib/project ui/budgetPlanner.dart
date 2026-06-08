import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(BudgetPlannerApp());
}

// ============ DATA MODELS ============
class Category {
  final String id;
  final String name;
  final String icon;
  final Color color;
  final double budget;

  Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.budget,
  });
}

class Transaction {
  final String id;
  final String category;
  final double amount;
  final String description;
  final DateTime date;
  final String icon;

  Transaction({
    required this.id,
    required this.category,
    required this.amount,
    required this.description,
    required this.date,
    required this.icon,
  });
}

class BudgetData {
  final double totalBudget;
  final List<Transaction> transactions;
  final List<Category> categories;

  BudgetData({
    required this.totalBudget,
    required this.transactions,
    required this.categories,
  });

  double get totalSpent =>
      transactions.fold(0, (sum, t) => sum + t.amount);

  double get remaining => totalBudget - totalSpent;

  double get spentPercentage => (totalSpent / totalBudget * 100).clamp(0, 100);

  double getSpentByCategory(String categoryName) {
    return transactions
        .where((t) => t.category == categoryName)
        .fold(0, (sum, t) => sum + t.amount);
  }
}

// ============ SAMPLE DATA ============
final List<Category> sampleCategories = [
  Category(
    id: '1',
    name: 'Food & Dining',
    icon: '🍔',
    color: Color(0xFFFFE5B4),
    budget: 600,
  ),
  Category(
    id: '2',
    name: 'Transportation',
    icon: '🚗',
    color: Color(0xFFB4E5FF),
    budget: 500,
  ),
  Category(
    id: '3',
    name: 'Shopping',
    icon: '🛍️',
    color: Color(0xFFFFB4D4),
    budget: 400,
  ),
  Category(
    id: '4',
    name: 'Entertainment',
    icon: '🎬',
    color: Color(0xFFD4B4FF),
    budget: 300,
  ),
  Category(
    id: '5',
    name: 'Utilities',
    icon: '💡',
    color: Color(0xFFB4FFD4),
    budget: 200,
  ),
];

final List<Transaction> sampleTransactions = [
  Transaction(
    id: '1',
    category: 'Food & Dining',
    amount: 28.50,
    description: 'Pizza Hut',
    date: DateTime.now(),
    icon: '🍕',
  ),
  Transaction(
    id: '2',
    category: 'Transportation',
    amount: 15.20,
    description: 'Uber',
    date: DateTime.now().subtract(Duration(hours: 3)),
    icon: '🚕',
  ),
  Transaction(
    id: '3',
    category: 'Shopping',
    amount: 65.00,
    description: 'H&M Store',
    date: DateTime.now().subtract(Duration(days: 1)),
    icon: '👕',
  ),
  Transaction(
    id: '4',
    category: 'Entertainment',
    amount: 12.99,
    description: 'Netflix',
    date: DateTime.now().subtract(Duration(days: 2)),
    icon: '🎬',
  ),
  Transaction(
    id: '5',
    category: 'Food & Dining',
    amount: 45.00,
    description: 'Restaurant',
    date: DateTime.now().subtract(Duration(days: 2)),
    icon: '🍽️',
  ),
];

// ============ MAIN APP ============
class BudgetPlannerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget Planner',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Color(0xFF667eea),
        colorScheme: ColorScheme.light(
          primary: Color(0xFF667eea),
          secondary: Color(0xFFFF6B6B),
        ),
      ),
      home: HomeScreen(),
    );
  }
}

// ============ HOME SCREEN ============
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late BudgetData budgetData;

  @override
  void initState() {
    super.initState();
    budgetData = BudgetData(
      totalBudget: 5000,
      transactions: sampleTransactions,
      categories: sampleCategories,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          DashboardScreen(budgetData: budgetData),
          StatisticsScreen(budgetData: budgetData),
          AddTransactionScreen(
            categories: sampleCategories,
            onAdd: (transaction) {
              setState(() {
                budgetData.transactions.insert(0, transaction);
              });
              Navigator.pop(context);
            },
          ),
          SettingsScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          if (index == 2) {
            // Show add transaction view
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => AddTransactionScreen(
                categories: sampleCategories,
                onAdd: (transaction) {
                  setState(() {
                    budgetData.transactions.insert(0, transaction);
                  });
                  Navigator.pop(context);
                },
              ),
            );
          } else {
            setState(() => _selectedIndex = index);
          }
        },
        destinations: [
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.bar_chart),
            icon: Icon(Icons.bar_chart_outlined),
            label: 'Stats',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.add_circle),
            icon: Icon(Icons.add_circle_outline),
            label: 'Add',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

// ============ DASHBOARD SCREEN ============
class DashboardScreen extends StatelessWidget {
  final BudgetData budgetData;

  DashboardScreen({required this.budgetData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('💰 Budget Planner'),
        centerTitle: true,
        backgroundColor: Color(0xFF667eea),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Balance Card
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Budget',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '\$${budgetData.totalBudget.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: budgetData.spentPercentage / 100,
                    minHeight: 6,
                    backgroundColor: Colors.white24,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Spent',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                            ),
                          ),
                          Text(
                            '\$${budgetData.totalSpent.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Remaining',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                            ),
                          ),
                          Text(
                            '\$${budgetData.remaining.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),

            // Categories
            Text(
              'Top Categories',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 12),

            ...budgetData.categories.take(3).map((category) {
              final spent = budgetData.getSpentByCategory(category.name);
              final percentage = (spent / category.budget * 100).clamp(0, 100);

              return _CategoryCard(
                category: category,
                spent: spent,
                budget: category.budget,
                percentage: percentage,
              );
            }).toList(),

            SizedBox(height: 24),

            // Recent Transactions
            Text(
              'Recent Transactions',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 12),

            ...budgetData.transactions.take(5).map((transaction) {
              return _TransactionItem(transaction: transaction);
            }).toList(),
          ],
        ),
      ),
    );
  }
}

// ============ STATISTICS SCREEN ============
class StatisticsScreen extends StatelessWidget {
  final BudgetData budgetData;

  StatisticsScreen({required this.budgetData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('📊 Statistics'),
        centerTitle: true,
        backgroundColor: Color(0xFF667eea),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Spending Distribution',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 16),

            // Pie Chart (Simplified)
            Center(
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                  ),
                ),
                child: Center(
                  child: Text(
                    '💰',
                    style: TextStyle(fontSize: 80),
                  ),
                ),
              ),
            ),

            SizedBox(height: 24),

            // Category Breakdown
            ...budgetData.categories.map((category) {
              final spent = budgetData.getSpentByCategory(category.name);
              final percentage =
              (spent / budgetData.totalSpent * 100).clamp(0, 100);

              return Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: category.color,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        category.name,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    Text(
                      '\$${spent.toStringAsFixed(2)} (${percentage.toStringAsFixed(0)}%)',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),

            SizedBox(height: 24),

            // Monthly Summary
            Text(
              'Monthly Summary',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _SummaryCard(
                    title: 'Total Income',
                    amount: budgetData.totalBudget,
                    color: Colors.green,
                    icon: '📈',
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _SummaryCard(
                    title: 'Total Spent',
                    amount: budgetData.totalSpent,
                    color: Colors.red,
                    icon: '📉',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ============ ADD TRANSACTION SCREEN ============
class AddTransactionScreen extends StatefulWidget {
  final List<Category> categories;
  final Function(Transaction) onAdd;

  AddTransactionScreen({
    required this.categories,
    required this.onAdd,
  });

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  late TextEditingController _amountController;
  late TextEditingController _descriptionController;
  String? _selectedCategory;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
    _descriptionController = TextEditingController();
    _selectedDate = DateTime.now();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('➕ Add Transaction'),
        centerTitle: true,
        backgroundColor: Color(0xFF667eea),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Amount Input
            Text(
              'Amount',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                prefixText: '\$ ',
                hintText: '0.00',
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF667eea), width: 2),
                ),
              ),
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 24),

            // Category Selection
            Text(
              'Category',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1.0,
              ),
              itemCount: widget.categories.length,
              itemBuilder: (context, index) {
                final category = widget.categories[index];
                final isSelected = _selectedCategory == category.name;

                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedCategory = category.name);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: category.color,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? Color(0xFF667eea)
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        category.icon,
                        style: TextStyle(fontSize: 28),
                      ),
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: 24),

            // Description
            Text(
              'Description',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                hintText: 'Enter transaction details',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

            SizedBox(height: 24),

            // Date Selection
            Text(
              'Date',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate ?? DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                );
                if (date != null) {
                  setState(() => _selectedDate = date);
                }
              },
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('MMM dd, yyyy').format(_selectedDate!),
                    ),
                    Icon(Icons.calendar_today, size: 18),
                  ],
                ),
              ),
            ),

            SizedBox(height: 32),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancel'),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: _addTransaction,
                    child: Text('Add'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _addTransaction() {
    if (_amountController.text.isEmpty ||
        _selectedCategory == null ||
        _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    final category = widget.categories
        .firstWhere((c) => c.name == _selectedCategory);

    final transaction = Transaction(
      id: DateTime.now().toString(),
      category: _selectedCategory!,
      amount: double.parse(_amountController.text),
      description: _descriptionController.text,
      date: _selectedDate!,
      icon: category.icon,
    );

    widget.onAdd(transaction);
  }
}

// ============ SETTINGS SCREEN ============
class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('⚙️ Settings'),
        centerTitle: true,
        backgroundColor: Color(0xFF667eea),
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Account'),
            subtitle: Text('Manage your profile'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.notification_important),
            title: Text('Notifications'),
            subtitle: Text('Enable/Disable alerts'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.backup),
            title: Text('Backup & Restore'),
            subtitle: Text('Backup your data'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            subtitle: Text('Version 1.0.0'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            textColor: Colors.red,
            iconColor: Colors.red,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

// ============ HELPER WIDGETS ============
class _CategoryCard extends StatelessWidget {
  final Category category;
  final double spent;
  final double budget;
  final num percentage;

  _CategoryCard({
    required this.category,
    required this.spent,
    required this.budget,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: category.color,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(category.icon, style: TextStyle(fontSize: 20)),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category.name,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '\$${spent.toStringAsFixed(0)} / \$${budget.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${percentage.toStringAsFixed(0)}%',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF667eea),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            LinearProgressIndicator(
              value: percentage / 100,
              minHeight: 4,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF667eea)),
            ),
          ],
        ),
      ),
    );
  }
}

class _TransactionItem extends StatelessWidget {
  final Transaction transaction;

  _TransactionItem({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Text(transaction.icon, style: TextStyle(fontSize: 20)),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.description,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    DateFormat('MMM dd, yyyy hh:mm a').format(transaction.date),
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '-\$${transaction.amount.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFFFF6B6B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final double amount;
  final Color color;
  final String icon;

  _SummaryCard({
    required this.title,
    required this.amount,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                icon,
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}