import 'package:flutter/material.dart';
import '../data/app_state.dart';
import '../widgets/destination_card.dart';

class FavoritesScreen extends StatelessWidget {
  final VoidCallback? onExploreTap;

  const FavoritesScreen({
    super.key,
    this.onExploreTap,
  });

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);
    final theme = Theme.of(context);
    final favorites = appState.favoriteDestinations;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.favorite_rounded, color: Colors.redAccent),
            const SizedBox(width: 8),
            const Text(
              'My Favorites',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 8),
            Badge(
              label: Text('${favorites.length}'),
              backgroundColor: theme.colorScheme.primary,
            ),
          ],
        ),
        actions: [
          IconButton(
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
      body: favorites.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.redAccent.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite_border_rounded,
                        size: 64,
                        color: Colors.redAccent,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'No saved favorites yet',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tap the heart icon on any destination card to bookmark your dream getaways here.',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 24),
                    FilledButton.icon(
                      onPressed: onExploreTap,
                      icon: const Icon(Icons.travel_explore_rounded),
                      label: const Text('Explore Destinations'),
                    ),
                  ],
                ),
              ),
            )
          : LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                if (width > 900) {
                  return GridView.builder(
                    padding: const EdgeInsets.all(20),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.76,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: favorites.length,
                    itemBuilder: (context, index) => DestinationCard(
                      destination: favorites[index],
                    ),
                  );
                } else if (width > 600) {
                  return GridView.builder(
                    padding: const EdgeInsets.all(20),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.78,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: favorites.length,
                    itemBuilder: (context, index) => DestinationCard(
                      destination: favorites[index],
                    ),
                  );
                } else {
                  return ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: favorites.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: DestinationCard(
                        destination: favorites[index],
                      ),
                    ),
                  );
                }
              },
            ),
    );
  }
}
