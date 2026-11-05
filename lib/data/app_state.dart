import 'package:flutter/material.dart';
import '../models/destination.dart';
import 'sample_data.dart';

class AppStateManager extends ChangeNotifier {
  final List<Destination> _allDestinations = SampleData.destinations;

  final Set<String> _favoriteIds = {'dest_taj', 'dest_kerala'};

  final List<Itinerary> _itineraries = [
    Itinerary(
      id: 'itin_sample_1',
      destination: SampleData.destinations[0], // Taj Mahal
      startDate: DateTime.now().add(const Duration(days: 14)),
      endDate: DateTime.now().add(const Duration(days: 17)),
      adults: 2,
      children: 0,
      rooms: 1,
      totalEstimatedBudget: 23600.0,
      notes: 'Book Taj Mahal sunrise entry tickets in advance & arrange hotel cab from Delhi.',
    ),
  ];

  ThemeMode _themeMode = ThemeMode.system;
  String _selectedCategory = 'All';
  String _searchQuery = '';

  // Getters
  List<Destination> get allDestinations => _allDestinations;
  Set<String> get favoriteIds => _favoriteIds;
  List<Itinerary> get itineraries => List.unmodifiable(_itineraries);
  ThemeMode get themeMode => _themeMode;
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;

  bool isFavorite(dynamic destinationOrId) {
    if (destinationOrId is Destination) {
      return _favoriteIds.contains(destinationOrId.id);
    }
    return _favoriteIds.contains(destinationOrId.toString());
  }

  int get favoritesCount => _favoriteIds.length;

  List<Destination> get favoriteDestinations {
    return _allDestinations
        .where((dest) => _favoriteIds.contains(dest.id))
        .toList();
  }

  List<Destination> get filteredDestinations {
    return _allDestinations.where((dest) {
      final matchesCategory = _selectedCategory == 'All' ||
          dest.category.toLowerCase() == _selectedCategory.toLowerCase();
      final matchesSearch = dest.matchesQuery(_searchQuery);
      return matchesCategory && matchesSearch;
    }).toList();
  }

  void setSelectedCategory(String category) {
    if (_selectedCategory != category) {
      _selectedCategory = category;
      notifyListeners();
    }
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void toggleThemeMode() {
    if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }
    notifyListeners();
  }

  bool toggleFavorite(Destination destination, {BuildContext? context}) {
    final isFavNow = _favoriteIds.contains(destination.id);
    if (isFavNow) {
      _favoriteIds.remove(destination.id);
    } else {
      _favoriteIds.add(destination.id);
    }
    notifyListeners();

    if (context != null && context.mounted) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          duration: const Duration(seconds: 2),
          content: Row(
            children: [
              Icon(
                !isFavNow ? Icons.favorite : Icons.favorite_border,
                color: !isFavNow ? Colors.redAccent : Colors.white,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  !isFavNow
                      ? 'Added "${destination.name}" to favorites'
                      : 'Removed "${destination.name}" from favorites',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          action: SnackBarAction(
            label: 'UNDO',
            textColor: Theme.of(context).colorScheme.primary,
            onPressed: () {
              if (isFavNow) {
                _favoriteIds.add(destination.id);
              } else {
                _favoriteIds.remove(destination.id);
              }
              notifyListeners();
            },
          ),
        ),
      );
    }

    return !isFavNow;
  }

  void addItinerary(Itinerary item) {
    _itineraries.insert(0, item);
    notifyListeners();
  }

  void removeItinerary(String id) {
    _itineraries.removeWhere((item) => item.id == id);
    notifyListeners();
  }
}

class AppStateScope extends InheritedNotifier<AppStateManager> {
  const AppStateScope({
    super.key,
    required AppStateManager super.notifier,
    required super.child,
  });

  static AppStateManager of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<AppStateScope>();
    assert(scope != null, 'No AppStateScope found in context');
    return scope!.notifier!;
  }
}
