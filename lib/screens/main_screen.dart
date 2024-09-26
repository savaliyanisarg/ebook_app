import 'package:flutter/material.dart';
import 'book_details_screen.dart';
import '../models/book.dart';
import 'edit_profile_screen.dart';
import 'settings_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Book> books = [
    Book(
        title: 'Book 1',
        description: 'Description of book 1',
        category: 'Fiction',
        imagePath: 'assets/book1.jpg'),
    Book(
        title: 'Book 2',
        description: 'Description of book 2',
        category: 'Science',
        imagePath: 'assets/book2.jpg'),
    Book(
        title: 'Book 3',
        description: 'Description of book 3',
        category: 'History',
        imagePath: 'assets/book3.jpg'),
    Book(
        title: 'Book 4',
        description: 'Description of book 4',
        category: 'Fantasy',
        imagePath: 'assets/book4.jpg'),
    Book(
        title: 'Book 5',
        description: 'Description of book 5',
        category: 'Romance',
        imagePath: 'assets/book5.jpg'),
    Book(
        title: 'Book 6',
        description: 'Description of book 6',
        category: 'Technology',
        imagePath: 'assets/book6.jpg'),
    Book(
        title: 'Book 7',
        description: 'Description of book 7',
        category: 'Fiction',
        imagePath: 'assets/book7.jpg'),
    Book(
        title: 'Book 8',
        description: 'Description of book 8',
        category: 'Science',
        imagePath: 'assets/book8.jpg'),
    Book(
        title: 'Book 9',
        description: 'Description of book 9',
        category: 'History',
        imagePath: 'assets/book9.jpg'),
    Book(
        title: 'Book 10',
        description: 'Description of book 10',
        category: 'Fantasy',
        imagePath: 'assets/book10.jpg'),
    // Add more books as needed
  ];

  List<Book> filteredBooks = [];
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;
  int _selectedIndex = 0;
  String selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    filteredBooks = books;
  }

  void _filterBooks(String query) {
    setState(() {
      filteredBooks = books
          .where((book) =>
              (book.title.toLowerCase().contains(query.toLowerCase())) &&
              (selectedCategory == 'All' || book.category == selectedCategory))
          .toList();
    });
  }

  void _onBottomNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getSelectedScreen() {
    switch (_selectedIndex) {
      case 0:
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: DropdownButton<String>(
                value: selectedCategory,
                items: <String>[
                  'All',
                  'Fiction',
                  'Science',
                  'History',
                  'Fantasy',
                  'Romance',
                  'Technology',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newCategory) {
                  setState(() {
                    selectedCategory = newCategory!;
                    _filterBooks(searchController.text);
                  });
                },
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.75,
                ),
                itemCount: filteredBooks.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            BookDetailsScreen(book: filteredBooks[index]),
                      ));
                    },
                    child: Container(
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Display the book image
                          Image.asset(
                            filteredBooks[index].imagePath,
                            height: 100, // Set your desired height
                            width: double
                                .infinity, // Makes the image take the full width
                            fit: BoxFit
                                .cover, // Crop or stretch the image as needed
                          ),
                          SizedBox(height: 8),
                          Text(
                            filteredBooks[index].title,
                            style: TextStyle(fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4),
                          Text(
                            filteredBooks[index].description,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      case 1:
        return Center(child: Text('Explore Screen'));
      case 2:
        return Center(child: Text('Bookmarks Screen'));
      default:
        return Center(child: Text('Screen not found'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search books...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white70),
                ),
                style: TextStyle(color: Colors.white),
                onChanged: (value) {
                  _filterBooks(value);
                },
              )
            : Text('Books'),
        actions: [
          isSearching
              ? IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      isSearching = false;
                      searchController.clear();
                      filteredBooks = books;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      isSearching = true;
                    });
                  },
                ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EditProfileScreen(),
              ));
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SettingsScreen(),
                ));
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _getSelectedScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmarks',
          ),
        ],
      ),
    );
  }
}
