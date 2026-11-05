import 'package:flutter/material.dart';
import 'data/app_state.dart';
import 'screens/favorites_screen.dart';
import 'screens/home_screen.dart';
import 'screens/itinerary_screen.dart';
import 'screens/travel_quiz_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TravelGuideApp());
}

class TravelGuideApp extends StatefulWidget {
  const TravelGuideApp({super.key});

  @override
  State<TravelGuideApp> createState() => _TravelGuideAppState();
}

class _TravelGuideAppState extends State<TravelGuideApp> {
  final AppStateManager _appStateManager = AppStateManager();
  bool _hasStartedApp = false;

  @override
  void dispose() {
    _appStateManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppStateScope(
      notifier: _appStateManager,
      child: ListenableBuilder(
        listenable: _appStateManager,
        builder: (context, _) {
          return MaterialApp(
            title: 'Smart Travel Companion',
            debugShowCheckedModeBanner: false,
            themeMode: _appStateManager.themeMode,
            theme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.light,
              colorSchemeSeed: const Color(0xFF0D6E6E), // Elegant travel teal
              scaffoldBackgroundColor: const Color(0xFFF9FBFB),
              appBarTheme: const AppBarTheme(
                elevation: 0,
                scrolledUnderElevation: 1,
                centerTitle: false,
              ),
              cardTheme: CardThemeData(
                elevation: 1.5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.dark,
              colorSchemeSeed: const Color(0xFF26A69A),
              scaffoldBackgroundColor: const Color(0xFF121616),
              appBarTheme: const AppBarTheme(
                elevation: 0,
                scrolledUnderElevation: 1,
                centerTitle: false,
              ),
              cardTheme: CardThemeData(
                elevation: 1.5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            home: _hasStartedApp
                ? const MainNavigationHolder()
                : TravelQuizScreen(
                    onCompleteOrSkip: () {
                      setState(() {
                        _hasStartedApp = true;
                      });
                    },
                  ),
          );
        },
      ),
    );
  }
}

class MainNavigationHolder extends StatefulWidget {
  const MainNavigationHolder({super.key});

  @override
  State<MainNavigationHolder> createState() => _MainNavigationHolderState();
}

class _MainNavigationHolderState extends State<MainNavigationHolder> {
  int _currentIndex = 0;

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);
    final favCount = appState.favoritesCount;
    final itineraryCount = appState.itineraries.length;

    final screens = [
      const HomeScreen(),
      FavoritesScreen(
        onExploreTap: () => _onTabSelected(0),
      ),
      const ItineraryScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: _onTabSelected,
        elevation: 3,
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore_rounded),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Badge(
              isLabelVisible: favCount > 0,
              label: Text('$favCount'),
              child: const Icon(Icons.favorite_border_rounded),
            ),
            selectedIcon: Badge(
              isLabelVisible: favCount > 0,
              label: Text('$favCount'),
              child: const Icon(Icons.favorite_rounded),
            ),
            label: 'Favorites',
          ),
          NavigationDestination(
            icon: Badge(
              isLabelVisible: itineraryCount > 0,
              label: Text('$itineraryCount'),
              child: const Icon(Icons.calendar_month_outlined),
            ),
            selectedIcon: Badge(
              isLabelVisible: itineraryCount > 0,
              label: Text('$itineraryCount'),
              child: const Icon(Icons.calendar_month_rounded),
            ),
            label: 'My Trips',
          ),
        ],
      ),
    );
  }
}
