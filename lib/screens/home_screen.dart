import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/job_provider.dart';
import '../core/constants/app_colors.dart';
import 'home_tab.dart';
import 'favorites_tab.dart';
import 'all_jobs_tab.dart';
import 'welcome_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<JobProvider>(context, listen: false).fetchJobs();
    });
  }

  final List<Widget> _screens = [
    HomeTab(),
    FavoritesTab(),
    AllJobsTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _searchController.clear();
      _performSearch('');
    });
  }

  void _performSearch(String query) {
    final jobProvider = Provider.of<JobProvider>(context, listen: false);
    jobProvider.searchJobs(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: _buildSearchHeader(),
              ),
            ),
          ];
        },
        body: _screens[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'All Jobs',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: AppColors.primaryCoffee,
      ),
    );
  }

  Widget _buildSearchHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryCoffee.withOpacity(0.9),
            AppColors.primaryCoffee.withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => WelcomeScreen()),
                      );
                    },
                  ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20),  // Sesuaikan jarak atas di sini
                        child: Text(
                          'Job Finder',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: Colors.black45,
                                offset: Offset(2.0, 2.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        'Find your next remote job',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              CircleAvatar(
                backgroundColor: Colors.white24,
                child: Icon(
                  Icons.work_outline,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),  // Tambahkan jarak manual di sini
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for jobs...',
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColors.primaryCoffee,
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear, color: AppColors.primaryCoffee),
                        onPressed: () {
                          _searchController.clear();
                          _performSearch('');
                        },
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
              ),
              onChanged: (value) {
                _performSearch(value);
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
