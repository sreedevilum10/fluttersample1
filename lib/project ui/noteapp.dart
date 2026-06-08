// ════════════════════════════════════════════════════════════════════════════════
// FLUTTER SIMPLE NOTE APP - COMPLETE UI SCREENS
// A clean, minimalist note-taking app with categories, search, and more
// ════════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const NoteAppUI());
}

// ═══════════════════════════════════════════════════════════════════════════════
// MODELS
// ═══════════════════════════════════════════════════════════════════════════════

class Note {
  final String id;
  final String title;
  final String content;
  final DateTime createdDate;
  final DateTime lastModified;
  final String category;
  final Color color;
  bool isArchived;
  bool isDeleted;
  final List<String> tags;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.createdDate,
    required this.lastModified,
    required this.category,
    required this.color,
    this.isArchived = false,
    this.isDeleted = false,
    this.tags = const [],
  });

  factory Note.empty() {
    return Note(
      id: DateTime.now().toString(),
      title: '',
      content: '',
      createdDate: DateTime.now(),
      lastModified: DateTime.now(),
      category: 'Personal',
      color: Colors.blue,
    );
  }

  // Create a copy with modifications
  Note copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? createdDate,
    DateTime? lastModified,
    String? category,
    Color? color,
    bool? isArchived,
    bool? isDeleted,
    List<String>? tags,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdDate: createdDate ?? this.createdDate,
      lastModified: lastModified ?? this.lastModified,
      category: category ?? this.category,
      color: color ?? this.color,
      isArchived: isArchived ?? this.isArchived,
      isDeleted: isDeleted ?? this.isDeleted,
      tags: tags ?? this.tags,
    );
  }
}

// Sample notes data
final List<Note> sampleNotes = [
  Note(
    id: '1',
    title: 'Flutter Tips & Tricks',
    content:
    'Remember to use const constructors for performance optimization. Always dispose controllers and streams properly.',
    createdDate: DateTime.now().subtract(const Duration(days: 5)),
    lastModified: DateTime.now().subtract(const Duration(days: 1)),
    category: 'Programming',
    color: Colors.blue,
    tags: ['flutter', 'programming', 'tips'],
  ),
  Note(
    id: '2',
    title: 'Grocery List',
    content: 'Milk, Bread, Eggs, Cheese, Apples, Carrots, Chicken',
    createdDate: DateTime.now().subtract(const Duration(days: 2)),
    lastModified: DateTime.now(),
    category: 'Personal',
    color: Colors.orange,
    tags: ['shopping', 'grocery'],
  ),
  Note(
    id: '3',
    title: 'Project Meeting Notes',
    content:
    'Discussed Q4 roadmap. Need to finalize design by Friday. Action items: Review API specs, Update documentation.',
    createdDate: DateTime.now().subtract(const Duration(days: 3)),
    lastModified: DateTime.now().subtract(const Duration(hours: 2)),
    category: 'Work',
    color: Colors.green,
    tags: ['work', 'meeting', 'project'],
  ),
  Note(
    id: '4',
    title: 'Ideas for App',
    content:
    '1. Dark mode toggle\n2. Cloud sync\n3. Collaborative notes\n4. Voice notes\n5. Image attachments',
    createdDate: DateTime.now().subtract(const Duration(days: 7)),
    lastModified: DateTime.now().subtract(const Duration(days: 2)),
    category: 'Ideas',
    color: Colors.pink,
    tags: ['ideas', 'app', 'future'],
  ),
  Note(
    id: '5',
    title: 'Book Recommendations',
    content:
    'The Pragmatic Programmer - David Thomas, Andrew Hunt\nClean Code - Robert C. Martin\nDesign Patterns - Gang of Four',
    createdDate: DateTime.now().subtract(const Duration(days: 10)),
    lastModified: DateTime.now().subtract(const Duration(days: 5)),
    category: 'Reading',
    color: Colors.purple,
    tags: ['books', 'reading', 'learning'],
  ),
];

const List<String> categories = [
  'All',
  'Personal',
  'Work',
  'Programming',
  'Ideas',
  'Reading',
];

const List<Color> noteColors = [
  Colors.blue,
  Colors.orange,
  Colors.green,
  Colors.pink,
  Colors.purple,
  Colors.red,
  Colors.cyan,
  Colors.amber,
];

// ═══════════════════════════════════════════════════════════════════════════════
// MAIN APP
// ═══════════════════════════════════════════════════════════════════════════════

class NoteAppUI extends StatelessWidget {
  const NoteAppUI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Notes',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0066CC),
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0066CC),
          brightness: Brightness.dark,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(
          ThemeData(brightness: Brightness.dark).textTheme,
        ),
      ),
      themeMode: ThemeMode.system,
      home: const MainNavigation(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// BOTTOM NAVIGATION
// ═══════════════════════════════════════════════════════════════════════════════

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const CategoriesScreen(),
    const SearchScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.note_outlined),
            selectedIcon: Icon(Icons.note),
            label: 'Notes',
          ),
          NavigationDestination(
            icon: Icon(Icons.folder_outlined),
            selectedIcon: Icon(Icons.folder),
            label: 'Categories',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// SCREEN 1: HOME SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Note> _notes;
  String _selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    _notes = sampleNotes.where((note) => !note.isDeleted).toList();
  }

  List<Note> get _filteredNotes {
    if (_selectedCategory == 'All') {
      return _notes.where((note) => !note.isArchived).toList();
    }
    return _notes
        .where((note) => note.category == _selectedCategory && !note.isArchived)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notes',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => _buildAppBarMenu(context),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Category Filter
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(categories.length, (index) {
                  final category = categories[index];
                  final isSelected = _selectedCategory == category;

                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(category),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                    ),
                  );
                }),
              ),
            ),
          ),

          // Notes Grid
          if (_filteredNotes.isEmpty)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '📝',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No notes yet',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Create your first note to get started',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.85,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: _filteredNotes.length,
                itemBuilder: (context, index) {
                  return NoteCard(
                    note: _filteredNotes[index],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditNoteScreen(
                            note: _filteredNotes[index],
                            onSave: (updatedNote) {
                              setState(() {
                                final idx = _notes.indexWhere(
                                      (n) => n.id == updatedNote.id,
                                );
                                if (idx != -1) {
                                  _notes[idx] = updatedNote;
                                }
                              });
                            },
                          ),
                        ),
                      );
                    },
                    onDelete: () {
                      setState(() {
                        _notes = _notes
                            .map((n) => n.id == _filteredNotes[index].id
                            ? n.copyWith(isDeleted: true)
                            : n)
                            .toList();
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Note deleted'),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {
                              setState(() {
                                _notes = _notes
                                    .map((n) =>
                                n.id == _filteredNotes[index].id
                                    ? n.copyWith(isDeleted: false)
                                    : n)
                                    .toList();
                              });
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditNoteScreen(
                note: Note.empty(),
                onSave: (newNote) {
                  setState(() {
                    _notes.add(newNote);
                  });
                },
              ),
            ),
          );
        },
        tooltip: 'New Note',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildAppBarMenu(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.archive_outlined),
            title: const Text('Archived Notes'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to archived notes
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Archived notes feature')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete_outlined),
            title: const Text('Trash'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to trash
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Trash feature')),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// SCREEN 2: EDIT NOTE SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class EditNoteScreen extends StatefulWidget {
  final Note note;
  final Function(Note) onSave;

  const EditNoteScreen({
    required this.note,
    required this.onSave,
    super.key,
  });

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late String _selectedCategory;
  late Color _selectedColor;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
    _selectedCategory = widget.note.category;
    _selectedColor = widget.note.color;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _saveNote,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Color Selector
            Text(
              'Color',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: noteColors.map((color) {
                final isSelected = _selectedColor == color;
                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedColor = color);
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: isSelected
                          ? Border.all(
                        color: colorScheme.primary,
                        width: 3,
                      )
                          : null,
                    ),
                    child: isSelected
                        ? Icon(
                      Icons.check,
                      color: color.computeLuminance() > 0.5
                          ? Colors.black
                          : Colors.white,
                    )
                        : null,
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

            // Category Selector
            Text(
              'Category',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: categories.where((c) => c != 'All').map((category) {
                final isSelected = _selectedCategory == category;
                return ChoiceChip(
                  label: Text(category),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() => _selectedCategory = category);
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

            // Title
            TextField(
              controller: _titleController,
              style: Theme.of(context).textTheme.headlineMedium,
              decoration: InputDecoration(
                hintText: 'Note Title',
                border: InputBorder.none,
                hintStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Content
            TextField(
              controller: _contentController,
              maxLines: null,
              style: Theme.of(context).textTheme.bodyLarge,
              decoration: InputDecoration(
                hintText: 'Start typing...',
                border: InputBorder.none,
                hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Created',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    Text(
                      DateFormat('MMM d, yyyy').format(widget.note.createdDate),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Modified',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    Text(
                      DateFormat('MMM d, yyyy').format(widget.note.lastModified),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _saveNote() {
    if (_titleController.text.isEmpty && _contentController.text.isEmpty) {
      Navigator.pop(context);
      return;
    }

    final updatedNote = widget.note.copyWith(
      title: _titleController.text.isEmpty ? 'Untitled' : _titleController.text,
      content: _contentController.text,
      category: _selectedCategory,
      color: _selectedColor,
      lastModified: DateTime.now(),
    );

    widget.onSave(updatedNote);
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Note saved')),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// SCREEN 3: CATEGORIES SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late List<Note> _notes;

  @override
  void initState() {
    super.initState();
    _notes = sampleNotes.where((note) => !note.isDeleted).toList();
  }

  Map<String, int> _getCategoryCount() {
    final Map<String, int> counts = {};
    for (var category in categories) {
      if (category != 'All') {
        counts[category] =
            _notes.where((n) => n.category == category && !n.isArchived).length;
      }
    }
    return counts;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final counts = _getCategoryCount();
    final categoryList = categories.where((c) => c != 'All').toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: categoryList.length,
        itemBuilder: (context, index) {
          final category = categoryList[index];
          final count = counts[category] ?? 0;

          return GestureDetector(
            onTap: () {
              // Navigate to notes in this category
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$category: $count notes')),
              );
            },
            child: Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: _getCategoryColor(category),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          _getCategoryEmoji(category),
                          style: const TextStyle(fontSize: 28),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            category,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '$count note${count == 1 ? '' : 's'}',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Personal':
        return Colors.orange[100]!;
      case 'Work':
        return Colors.green[100]!;
      case 'Programming':
        return Colors.blue[100]!;
      case 'Ideas':
        return Colors.pink[100]!;
      case 'Reading':
        return Colors.purple[100]!;
      default:
        return Colors.grey[100]!;
    }
  }

  String _getCategoryEmoji(String category) {
    switch (category) {
      case 'Personal':
        return '👤';
      case 'Work':
        return '💼';
      case 'Programming':
        return '💻';
      case 'Ideas':
        return '💡';
      case 'Reading':
        return '📚';
      default:
        return '📝';
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// SCREEN 4: SEARCH SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _searchController;
  late List<Note> _notes;
  late List<Note> _searchResults;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _notes = sampleNotes.where((note) => !note.isDeleted).toList();
    _searchResults = [];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        _searchResults = [];
      } else {
        _searchResults = _notes
            .where((note) =>
        note.title.toLowerCase().contains(query.toLowerCase()) ||
            note.content.toLowerCase().contains(query.toLowerCase()) ||
            note.tags.any((tag) =>
                tag.toLowerCase().contains(query.toLowerCase())))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Notes'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              onChanged: _performSearch,
              decoration: InputDecoration(
                hintText: 'Search by title, content, or tags...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    _performSearch('');
                  },
                )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: colorScheme.surfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: _searchResults.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '🔍',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _searchController.text.isEmpty
                        ? 'Start searching'
                        : 'No notes found',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Try searching by title, content or tags',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final note = _searchResults[index];
                return NoteListItem(
                  note: note,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditNoteScreen(
                          note: note,
                          onSave: (updatedNote) {
                            // Update the note
                            _performSearch(_searchController.text);
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// SCREEN 5: SETTINGS SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  String _fontSize = 'Medium';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display Settings
            Text(
              'Display',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.dark_mode_outlined),
                    title: const Text('Dark Mode'),
                    subtitle: const Text('Use system theme'),
                    trailing: Switch.adaptive(
                      value: _darkModeEnabled,
                      onChanged: (value) {
                        setState(() => _darkModeEnabled = value);
                      },
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.text_fields),
                    title: const Text('Font Size'),
                    trailing: DropdownButton<String>(
                      value: _fontSize,
                      items: ['Small', 'Medium', 'Large']
                          .map((size) => DropdownMenuItem(
                        value: size,
                        child: Text(size),
                      ))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => _fontSize = value);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Notifications
            Text(
              'Notifications',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: const Icon(Icons.notifications_outlined),
                title: const Text('Enable Notifications'),
                subtitle: const Text('Get reminders for your notes'),
                trailing: Switch.adaptive(
                  value: _notificationsEnabled,
                  onChanged: (value) {
                    setState(() => _notificationsEnabled = value);
                  },
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Data & Storage
            Text(
              'Data & Storage',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.cloud_upload_outlined),
                    title: const Text('Backup to Cloud'),
                    subtitle: const Text('Sync your notes'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Backup feature')),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.download_outlined),
                    title: const Text('Export Notes'),
                    subtitle: const Text('Download as PDF or CSV'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Export feature')),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.storage_outlined),
                    title: const Text('Storage Usage'),
                    subtitle: const Text('1.2 MB of 15 GB'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Storage details')),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // About
            Text(
              'About',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.info_outlined),
                    title: const Text('About App'),
                    subtitle: const Text('Simple Notes v1.0.0'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      showAboutDialog(
                        context: context,
                        applicationName: 'Simple Notes',
                        applicationVersion: '1.0.0',
                        applicationLegalese: '© 2024 Simple Notes',
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.privacy_tip_outlined),
                    title: const Text('Privacy Policy'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Privacy policy')),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.help_outline),
                    title: const Text('Help & Support'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Help & support')),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Logout
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Logout'),
                      content: const Text('Are you sure you want to logout?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        FilledButton(
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Logged out')),
                            );
                          },
                          child: const Text('Logout'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// REUSABLE COMPONENTS
// ═══════════════════════════════════════════════════════════════════════════════

class NoteCard extends StatelessWidget {
  final Note note;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const NoteCard({
    required this.note,
    required this.onTap,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: note.color.withOpacity(0.1),
          border: Border.all(
            color: note.color.withOpacity(0.3),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: note.color,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          note.category,
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: note.color.computeLuminance() > 0.5
                                ? Colors.black
                                : Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        note.title.isEmpty ? 'Untitled' : note.title,
                        style:
                        Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        note.content,
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Text(
                    DateFormat('MMM d').format(note.lastModified),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 4,
              right: 4,
              child: PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: const Text('Edit'),
                    onTap: onTap,
                  ),
                  PopupMenuItem(
                    child: const Text('Delete'),
                    onTap: onDelete,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NoteListItem extends StatelessWidget {
  final Note note;
  final VoidCallback onTap;

  const NoteListItem({
    required this.note,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 12,
                height: 60,
                decoration: BoxDecoration(
                  color: note.color,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      note.title.isEmpty ? 'Untitled' : note.title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      note.content,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: note.color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            note.category,
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: note.color,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          DateFormat('MMM d, yyyy').format(note.lastModified),
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}