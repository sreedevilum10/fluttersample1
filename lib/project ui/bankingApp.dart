// ==================== BANKING APP - MVC ARCHITECTURE ====================
// Complete fintech app demonstrating professional MVC pattern

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ==================== MODELS ====================

class Account {
  final int id;
  final String accountNumber;
  final String holderName;
  final double balance;
  final String accountType;

  Account({
    required this.id,
    required this.accountNumber,
    required this.holderName,
    required this.balance,
    required this.accountType,
  });
}

class Cardd {
  final int id;
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;
  final String cardType;
  final double creditLimit;
  final double spent;
  final double cashback;

  Cardd({
    required this.id,
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
    required this.cardType,
    required this.creditLimit,
    required this.spent,
    required this.cashback,
  });

  double get availableCredit => creditLimit - spent;
}

class Transaction {
  final int id;
  final String description;
  final double amount;
  final DateTime date;
  final String category;
  final String icon;
  final String type; // income, expense, transfer

  Transaction({
    required this.id,
    required this.description,
    required this.amount,
    required this.date,
    required this.category,
    required this.icon,
    required this.type,
  });
}

class Bill {
  final int id;
  final String name;
  final double amount;
  final DateTime dueDate;
  final String category;
  final String icon;
  final bool isPaid;

  Bill({
    required this.id,
    required this.name,
    required this.amount,
    required this.dueDate,
    required this.category,
    required this.icon,
    required this.isPaid,
  });

  bool get isOverdue => dueDate.isBefore(DateTime.now()) && !isPaid;
  int get daysUntilDue => dueDate.difference(DateTime.now()).inDays;
}

class Recipient {
  final int id;
  final String name;
  final String accountNumber;
  final String icon;

  Recipient({
    required this.id,
    required this.name,
    required this.accountNumber,
    required this.icon,
  });
}

// ==================== CONTROLLERS ====================

class BankingController {
  // Data storage
  late Account _account;
  List<Cardd> _cards = [];
  List<Transaction> _transactions = [];
  List<Bill> _bills = [];
  List<Recipient> _recipients = [];

  // Getters
  Account get account => _account;
  List<Cardd> get cards => _cards;
  List<Transaction> get transactions => _transactions;
  List<Bill> get bills => _bills;
  List<Recipient> get recipients => _recipients;

  // Statistics
  double get totalIncome => _transactions
      .where((t) => t.type == 'income')
      .fold(0, (sum, t) => sum + t.amount);

  double get totalExpenses => _transactions
      .where((t) => t.type == 'expense')
      .fold(0, (sum, t) => sum + t.amount);

  double get totalTransfers => _transactions
      .where((t) => t.type == 'transfer')
      .fold(0, (sum, t) => sum + t.amount);

  double get totalBillsDue =>
      _bills.where((b) => !b.isPaid).fold(0, (sum, b) => sum + b.amount);

  // Constructor
  BankingController() {
    _initializeData();
  }

  void _initializeData() {
    // Initialize account
    _account = Account(
      id: 1,
      accountNumber: '4829',
      holderName: 'Alex Johnson',
      balance: 12450.50,
      accountType: 'Checking',
    );

    // Initialize cards
    _cards = [
      Cardd(
        id: 1,
        cardNumber: '4829 8374 9281 4829',
        cardHolderName: 'ALEX JOHNSON',
        expiryDate: '12/26',
        cardType: 'Premium Debit',
        creditLimit: 5000,
        spent: 2450,
        cashback: 98.50,
      ),
      Cardd(
        id: 2,
        cardNumber: '5928 1234 5678 7942',
        cardHolderName: 'ALEX JOHNSON',
        expiryDate: '08/25',
        cardType: 'Savings',
        creditLimit: 3000,
        spent: 850,
        cashback: 34.20,
      ),
      Cardd(
        id: 3,
        cardNumber: '3156 9876 5432 3156',
        cardHolderName: 'ALEX JOHNSON',
        expiryDate: '11/27',
        cardType: 'Business',
        creditLimit: 10000,
        spent: 5200,
        cashback: 156.00,
      ),
    ];

    // Initialize transactions
    _transactions = [
      Transaction(
        id: 1,
        description: 'Pizza Hut',
        amount: 24.50,
        date: DateTime.now(),
        category: 'Food & Dining',
        icon: '🍕',
        type: 'expense',
      ),
      Transaction(
        id: 2,
        description: 'Salary Deposit',
        amount: 3500.00,
        date: DateTime.now().subtract(const Duration(days: 1)),
        category: 'Income',
        icon: '💼',
        type: 'income',
      ),
      Transaction(
        id: 3,
        description: 'Netflix Subscription',
        amount: 15.99,
        date: DateTime.now().subtract(const Duration(days: 1)),
        category: 'Entertainment',
        icon: '🎬',
        type: 'expense',
      ),
      Transaction(
        id: 4,
        description: 'Transfer to Sarah W.',
        amount: 200.00,
        date: DateTime.now().subtract(const Duration(days: 2)),
        category: 'Transfer',
        icon: '✈️',
        type: 'transfer',
      ),
      Transaction(
        id: 5,
        description: 'Amazon Purchase',
        amount: 89.99,
        date: DateTime.now().subtract(const Duration(days: 3)),
        category: 'Shopping',
        icon: '🛍️',
        type: 'expense',
      ),
      Transaction(
        id: 6,
        description: 'Gym Membership',
        amount: 49.99,
        date: DateTime.now().subtract(const Duration(days: 4)),
        category: 'Health & Fitness',
        icon: '💪',
        type: 'expense',
      ),
    ];

    // Initialize bills
    _bills = [
      Bill(
        id: 1,
        name: 'Rent Payment',
        amount: 1200,
        dueDate: DateTime.now().add(const Duration(days: 5)),
        category: 'Housing',
        icon: '🏠',
        isPaid: false,
      ),
      Bill(
        id: 2,
        name: 'Electricity Bill',
        amount: 85.48,
        dueDate: DateTime.now().add(const Duration(days: 3)),
        category: 'Utilities',
        icon: '⚡',
        isPaid: false,
      ),
      Bill(
        id: 3,
        name: 'Phone Bill',
        amount: 100,
        dueDate: DateTime.now().add(const Duration(days: 10)),
        category: 'Utilities',
        icon: '📱',
        isPaid: false,
      ),
      Bill(
        id: 4,
        name: 'Internet Bill',
        amount: 60,
        dueDate: DateTime.now().subtract(const Duration(days: 2)),
        category: 'Utilities',
        icon: '📡',
        isPaid: false,
      ),
    ];

    // Initialize recipients
    _recipients = [
      Recipient(
        id: 1,
        name: 'Sarah Wilson',
        accountNumber: '5892',
        icon: '👤',
      ),
      Recipient(
        id: 2,
        name: 'Mike Thompson',
        accountNumber: '3421',
        icon: '👤',
      ),
      Recipient(
        id: 3,
        name: 'Emma Lewis',
        accountNumber: '7856',
        icon: '👤',
      ),
    ];
  }

  // Account methods
  Account getAccount() => _account;

  void updateBalance(double amount) {
    _account = Account(
      id: _account.id,
      accountNumber: _account.accountNumber,
      holderName: _account.holderName,
      balance: _account.balance + amount,
      accountType: _account.accountType,
    );
  }

  // Card methods
  List<Cardd> getCards() => _cards;

  Cardd? getPrimaryCard() {
    try {
      return _cards.firstWhere((c) => c.cardType.contains('Premium'));
    } catch (e) {
      return _cards.isNotEmpty ? _cards.first : null;
    }
  }

  // Transaction methods
  List<Transaction> getTransactions() => _transactions;

  List<Transaction> getTransactionsByCategory(String category) {
    return _transactions.where((t) => t.category == category).toList();
  }

  List<Transaction> getRecentTransactions({int limit = 10}) {
    final sorted = List<Transaction>.from(_transactions)
      ..sort((a, b) => b.date.compareTo(a.date));
    return sorted.take(limit).toList();
  }

  void addTransaction(Transaction transaction) {
    _transactions.insert(0, transaction);
    updateBalance(-transaction.amount);
  }

  // Bill methods
  List<Bill> getBills() => _bills;

  List<Bill> getUpcomingBills() {
    return _bills
        .where((b) => !b.isPaid)
        .toList()
      ..sort((a, b) => a.dueDate.compareTo(b.dueDate));
  }

  void payBill(int billId) {
    try {
      final bill = _bills.firstWhere((b) => b.id == billId);
      final index = _bills.indexOf(bill);
      _bills[index] = Bill(
        id: bill.id,
        name: bill.name,
        amount: bill.amount,
        dueDate: bill.dueDate,
        category: bill.category,
        icon: bill.icon,
        isPaid: true,
      );
      updateBalance(-bill.amount);
    } catch (e) {
      // Bill not found
    }
  }

  // Recipient methods
  List<Recipient> getRecipients() => _recipients;

  bool transferMoney({
    required int recipientId,
    required double amount,
    required String description,
  }) {
    try {
      if (amount <= 0 || amount > _account.balance) {
        return false;
      }

      final recipient =
      _recipients.firstWhere((r) => r.id == recipientId);

      final transaction = Transaction(
        id: _transactions.length + 1,
        description: 'Transfer to ${recipient.name}',
        amount: amount,
        date: DateTime.now(),
        category: 'Transfer',
        icon: '✈️',
        type: 'transfer',
      );

      addTransaction(transaction);
      return true;
    } catch (e) {
      return false;
    }
  }
}

// ==================== MAIN APP ====================

void main() {
  runApp(const BankingApp());
}

class BankingApp extends StatelessWidget {
  const BankingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SecureBank',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E40AF),
        ),
      ),
      home: BankingHome(controller: BankingController()),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ==================== MAIN HOME SCREEN ====================

class BankingHome extends StatefulWidget {
  final BankingController controller;

  const BankingHome({Key? key, required this.controller}) : super(key: key);

  @override
  State<BankingHome> createState() => _BankingHomeState();
}

class _BankingHomeState extends State<BankingHome> {
  int _currentIndex = 0;
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      DashboardView(controller: widget.controller),
      TransferView(controller: widget.controller),
      CardsView(controller: widget.controller),
      HistoryView(controller: widget.controller),
      BillsView(controller: widget.controller),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('🏦 SecureBank'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.send), label: 'Transfer'),
          BottomNavigationBarItem(icon: Icon(Icons.credit_card), label: 'Cards'),
          BottomNavigationBarItem(
              icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt), label: 'Bills'),
        ],
      ),
    );
  }
}

// ==================== DASHBOARD VIEW ====================

class DashboardView extends StatelessWidget {
  final BankingController controller;

  const DashboardView({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main Balance Card
          Container(
            color: const Color(0xFF1E40AF),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Welcome back,',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          controller.account.holderName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(Icons.settings, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Total Balance',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '\$${controller.account.balance.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Card Number',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '•••• •••• •••• ${controller.account.accountNumber}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  letterSpacing: 2,
                                ),
                              ),
                            ],
                          ),
                          const Text('💳', style: TextStyle(fontSize: 24)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Quick Actions
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Quick Actions',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                GridView.count(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildQuickAction('Send', '💸'),
                    _buildQuickAction('Pay', '📱'),
                    _buildQuickAction('Invest', '💰'),
                    _buildQuickAction('Rewards', '🎁'),
                  ],
                ),
              ],
            ),
          ),

          // Recent Transactions
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'Recent Transactions',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 12),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: controller.getRecentTransactions(limit: 3).length,
            itemBuilder: (context, index) {
              final transaction =
              controller.getRecentTransactions(limit: 3)[index];
              return _buildTransactionItem(transaction);
            },
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildQuickAction(String label, String icon) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(icon, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem(Transaction transaction) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: transaction.type == 'income'
                      ? const [Color(0xFFD1FAE5), Color(0xFFA7F3D0)]
                      : const [Color(0xFFFEE2E2), Color(0xFFFCA5A5)],
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Text(transaction.icon,
                    style: const TextStyle(fontSize: 24)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.description,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    transaction.category,
                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${transaction.type == 'income' ? '+' : '-'}\$${transaction.amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: transaction.type == 'income'
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  DateFormat('MMM d').format(transaction.date),
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== TRANSFER VIEW ====================

class TransferView extends StatefulWidget {
  final BankingController controller;

  const TransferView({Key? key, required this.controller}) : super(key: key);

  @override
  State<TransferView> createState() => _TransferViewState();
}

class _TransferViewState extends State<TransferView> {
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  int? _selectedRecipientId;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Send Money',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Amount Input
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Amount',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _amountController,
                      decoration: InputDecoration(
                        hintText: '\$0.00',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),

                    // Recipient Selection
                    const Text(
                      'Select Recipient',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButton<int>(
                        isExpanded: true,
                        underline: const SizedBox(),
                        hint: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text('Choose recipient'),
                        ),
                        value: _selectedRecipientId,
                        items: widget.controller.recipients.map((recipient) {
                          return DropdownMenuItem<int>(
                            value: recipient.id,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                  '${recipient.icon} ${recipient.name} (•••• ${recipient.accountNumber})'),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() => _selectedRecipientId = value);
                        },
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Description
                    const Text(
                      'Description (Optional)',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        hintText: 'Enter reason for transfer...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Fee Info
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          _buildFeeRow('Amount', '\$${_amountController.text.isEmpty ? '0.00' : _amountController.text}'),
                          const SizedBox(height: 8),
                          _buildFeeRow('Transfer Fee', 'FREE'),
                          const Divider(height: 16),
                          _buildFeeRow(
                            'Total',
                            '\$${_amountController.text.isEmpty ? '0.00' : _amountController.text}',
                            isBold: true,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Send Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1E40AF),
                        ),
                        onPressed: _sendMoney,
                        child: const Text(
                          'Send Money',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Recent Recipients
            const Text(
              'Recent Recipients',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: widget.controller.recipients.map((recipient) {
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    onTap: () {
                      setState(() => _selectedRecipientId = recipient.id);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFDBEAFE), Color(0xFFBAE6FD)],
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: Text(recipient.icon,
                                style: const TextStyle(fontSize: 24)),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          recipient.name.split(' ').first,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeeRow(String label, String amount, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: isBold ? const Color(0xFF1E40AF) : Colors.black,
          ),
        ),
      ],
    );
  }

  void _sendMoney() {
    if (_amountController.text.isEmpty || _selectedRecipientId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
      return;
    }

    final amount = double.tryParse(_amountController.text) ?? 0;
    final success = widget.controller.transferMoney(
      recipientId: _selectedRecipientId!,
      amount: amount,
      description: _descriptionController.text,
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✓ Transfer successful!'),
          backgroundColor: Colors.green,
        ),
      );
      _amountController.clear();
      _descriptionController.clear();
      setState(() => _selectedRecipientId = null);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Transfer failed. Check amount and try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}

// ==================== CARDS VIEW ====================

class CardsView extends StatelessWidget {
  final BankingController controller;

  const CardsView({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryCard = controller.getPrimaryCard();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My Cards',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Primary Card
            if (primaryCard != null)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1E40AF), Color(0xFF3B82F6)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Card Number',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 11,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${primaryCard.cardNumber.substring(0, 4)} •••• •••• ••••',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                        const Text('💳', style: TextStyle(fontSize: 32)),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Card Holder',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 10,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              primaryCard.cardHolderName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'Expires',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 10,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              primaryCard.expiryDate,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 20),

            // Card Stats
            Row(
              children: [
                Expanded(
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Spent This Month',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '\$${primaryCard?.spent.toStringAsFixed(0) ?? '0'}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'of \$${primaryCard?.creditLimit.toStringAsFixed(0) ?? '0'} limit',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Cash Back',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '\$${primaryCard?.cashback.toStringAsFixed(2) ?? '0'}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Available to claim',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Additional Cards
            const Text(
              'Additional Cards',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.cards.length - 1,
              itemBuilder: (context, index) {
                final card = controller.cards[index + 1];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              card.cardType,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '•••• •••• •••• ${card.cardNumber.substring(card.cardNumber.length - 4)}',
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          card.cardType.contains('Business') ? '💼' : '💳',
                          style: const TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== HISTORY VIEW ====================

class HistoryView extends StatefulWidget {
  final BankingController controller;

  const HistoryView({Key? key, required this.controller}) : super(key: key);

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    final transactions = widget.controller.getTransactions();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Transaction History',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Filter Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ['All', 'Income', 'Expenses', 'Transfers']
                    .map((filter) {
                  final isSelected = _selectedFilter == filter;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(filter),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() => _selectedFilter = filter);
                      },
                      backgroundColor: Colors.grey[200],
                      selectedColor: const Color(0xFF1E40AF),
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 16),

            // Transactions List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return _buildTransactionItem(transaction);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem(Transaction transaction) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: transaction.type == 'income'
                      ? const [Color(0xFFD1FAE5), Color(0xFFA7F3D0)]
                      : const [Color(0xFFFEE2E2), Color(0xFFFCA5A5)],
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Text(transaction.icon,
                    style: const TextStyle(fontSize: 24)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.description,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    transaction.category,
                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${transaction.type == 'income' ? '+' : '-'}\$${transaction.amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: transaction.type == 'income'
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  DateFormat('MMM d, yyyy').format(transaction.date),
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== BILLS VIEW ====================

class BillsView extends StatefulWidget {
  final BankingController controller;

  const BillsView({Key? key, required this.controller}) : super(key: key);

  @override
  State<BillsView> createState() => _BillsViewState();
}

class _BillsViewState extends State<BillsView> {
  @override
  Widget build(BuildContext context) {
    final upcomingBills = widget.controller.getUpcomingBills();
    final totalDue = widget.controller.totalBillsDue;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Upcoming Bills',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Bills Summary
            Row(
              children: [
                Expanded(
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Total Due',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '\$${totalDue.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${upcomingBills.length} bills this month',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Paid This Month',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '\$892.50',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            '5 payments',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Bills List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: upcomingBills.length,
              itemBuilder: (context, index) {
                final bill = upcomingBills[index];
                return _buildBillCard(bill);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBillCard(Bill bill) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFDBEAFE), Color(0xFFBAE6FD)],
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Text(bill.icon, style: const TextStyle(fontSize: 24)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bill.name,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Due ${DateFormat('MMM d, yyyy').format(bill.dueDate)}',
                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${bill.amount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E40AF),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  ),
                  onPressed: () {
                    widget.controller.payBill(bill.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('✓ ${bill.name} paid'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    setState(() {});
                  },
                  child: const Text(
                    'Pay',
                    style: TextStyle(fontSize: 10, color: Colors.white),
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