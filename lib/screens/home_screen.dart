import 'package:flutter/material.dart';
import '../data/app_state.dart';
import '../data/sample_data.dart';
import '../widgets/destination_card.dart';
import 'travel_quiz_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);
    final theme = Theme.of(context);
    final destinations = appState.filteredDestinations;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header with App Title & Theme Mode Switcher
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              '🇮🇳',
                              style: TextStyle(fontSize: 24),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Explore India',
                              style: theme.textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Find places & book room stays across India',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton.filledTonal(
                          tooltip: 'Take Recommendation Quiz',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => const TravelQuizScreen(isModal: true),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.auto_awesome_rounded,
                            color: Colors.amber,
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton.filledTonal(
                          tooltip: 'Toggle Theme',
                          onPressed: () => appState.toggleThemeMode(),
                          icon: Icon(
                            theme.brightness == Brightness.dark
                                ? Icons.light_mode_rounded
                                : Icons.dark_mode_rounded,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Quiz Prompt Banner
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        theme.colorScheme.primaryContainer.withOpacity(0.85),
                        theme.colorScheme.tertiaryContainer.withOpacity(0.7),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: theme.colorScheme.primary.withOpacity(0.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.psychology_alt_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Unsure Where to Go?',
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onPrimaryContainer,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Answer 7 personalized questions for custom suggestions',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onPrimaryContainer
                                    .withOpacity(0.85),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      FilledButton(
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          visualDensity: VisualDensity.compact,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) =>
                                  const TravelQuizScreen(isModal: true),
                            ),
                          );
                        },
                        child: const Text('Start Quiz'),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Live Search Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: SearchBar(
                  controller: _searchController,
                  hintText: 'Search destinations, cities, countries...',
                  leading: const Icon(Icons.search),
                  trailing: [
                    if (_searchController.text.isNotEmpty)
                      IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          appState.setSearchQuery('');
                          setState(() {});
                        },
                      ),
                  ],
                  onChanged: (val) {
                    appState.setSearchQuery(val);
                    setState(() {});
                  },
                  elevation: const WidgetStatePropertyAll(1.5),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ),

            // Category Filter Chips
            SliverToBoxAdapter(
              child: SizedBox(
                height: 52,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: SampleData.categories.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final category = SampleData.categories[index];
                    final isSelected = appState.selectedCategory.toLowerCase() ==
                        category.toLowerCase();

                    return ChoiceChip(
                      selected: isSelected,
                      label: Text(category),
                      avatar: Icon(
                        _getCategoryIcon(category),
                        size: 16,
                        color: isSelected
                            ? theme.colorScheme.onPrimary
                            : theme.colorScheme.primary,
                      ),
                      labelStyle: TextStyle(
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                      onSelected: (selected) {
                        if (selected) {
                          appState.setSelectedCategory(category);
                        }
                      },
                    );
                  },
                ),
              ),
            ),

            // Results count banner
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${destinations.length} ${destinations.length == 1 ? "Destination" : "Destinations"} Available',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    if (appState.searchQuery.isNotEmpty ||
                        appState.selectedCategory != 'All')
                      TextButton.icon(
                        style: TextButton.styleFrom(
                          visualDensity: VisualDensity.compact,
                        ),
                        onPressed: () {
                          _searchController.clear();
                          appState.setSearchQuery('');
                          appState.setSelectedCategory('All');
                          setState(() {});
                        },
                        icon: const Icon(Icons.refresh, size: 16),
                        label: const Text('Reset'),
                      ),
                  ],
                ),
              ),
            ),

            // Destinations List / Grid (Responsive)
            if (destinations.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.travel_explore_rounded,
                          size: 72,
                          color: theme.colorScheme.outline,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No destinations found',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Try searching for another place, city, or reset your filters.',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 20),
                        FilledButton.tonal(
                          onPressed: () {
                            _searchController.clear();
                            appState.setSearchQuery('');
                            appState.setSelectedCategory('All');
                            setState(() {});
                          },
                          child: const Text('Reset Filters'),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
                sliver: SliverLayoutBuilder(
                  builder: (context, constraints) {
                    final width = constraints.crossAxisExtent;
                    if (width > 900) {
                      // 3 Columns on large screens / desktop
                      return SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.76,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => DestinationCard(
                            destination: destinations[index],
                          ),
                          childCount: destinations.length,
                        ),
                      );
                    } else if (width > 600) {
                      // 2 Columns on tablets
                      return SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.78,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => DestinationCard(
                            destination: destinations[index],
                          ),
                          childCount: destinations.length,
                        ),
                      );
                    } else {
                      // Single Column on mobile phones
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: DestinationCard(
                              destination: destinations[index],
                            ),
                          ),
                          childCount: destinations.length,
                        ),
                      );
                    }
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'all':
        return Icons.auto_awesome_rounded;
      case 'beaches':
        return Icons.beach_access_rounded;
      case 'mountains':
        return Icons.terrain_rounded;
      case 'historical':
        return Icons.account_balance_rounded;
      case 'adventure':
        return Icons.hiking_rounded;
      case 'city life':
        return Icons.location_city_rounded;
      default:
        return Icons.explore_rounded;
    }
  }
}
