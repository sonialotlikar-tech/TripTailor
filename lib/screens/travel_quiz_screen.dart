import 'package:flutter/material.dart';
import '../data/app_state.dart';
import '../data/sample_data.dart';
import '../models/destination.dart';
import '../widgets/app_image.dart';
import 'destination_detail_screen.dart';

class TravelQuizScreen extends StatefulWidget {
  final bool isModal;
  final VoidCallback? onCompleteOrSkip;

  const TravelQuizScreen({
    super.key,
    this.isModal = false,
    this.onCompleteOrSkip,
  });

  @override
  State<TravelQuizScreen> createState() => _TravelQuizScreenState();
}

class _TravelQuizScreenState extends State<TravelQuizScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  static const int _totalSteps = 7;

  // Selected Answers for 7 Questions
  String? _selectedCategory; // Q1: Vacation Vibe & Landscape
  String? _selectedClimate;  // Q2: Weather & Climate
  String? _selectedBudget;   // Q3: Daily Budget
  String? _selectedDuration; // Q4: Trip Duration
  String? _selectedActivity; // Q5: Pace & Activity Level
  String? _selectedDining;   // Q6: Dining & Food Culture
  String? _selectedVibe;     // Q7: Travel Companions

  bool _isCompleted = false;
  List<_ScoredDestination> _recommendations = [];

  // Q1: Vacation Theme & Landscape
  final List<Map<String, dynamic>> _themeOptions = [
    {
      'title': 'Coastal & Ocean Breezes',
      'subtitle': 'Sun-drenched beaches, azure waters & island cliffs',
      'icon': Icons.beach_access_rounded,
      'category': 'Beaches',
      'color': Colors.cyan,
    },
    {
      'title': 'Alpine Peaks & Nature',
      'subtitle': 'Glacial lakes, pine forests & fresh mountain air',
      'icon': Icons.terrain_rounded,
      'category': 'Mountains',
      'color': Colors.teal,
    },
    {
      'title': 'Ancient Heritage & History',
      'subtitle': 'Sacred temples, citadel ruins & imperial architecture',
      'icon': Icons.account_balance_rounded,
      'category': 'Historical',
      'color': Colors.amber,
    },
    {
      'title': 'High Adrenaline & Thrills',
      'subtitle': 'Bungee jumping, canyoning, skydiving & wild rivers',
      'icon': Icons.hiking_rounded,
      'category': 'Adventure',
      'color': Colors.orange,
    },
    {
      'title': 'Vibrant Metropolis & Culture',
      'subtitle': 'Neon skylines, world-class museums & 24/7 energy',
      'icon': Icons.location_city_rounded,
      'category': 'City Life',
      'color': Colors.indigo,
    },
  ];

  // Q2: Weather & Climate Preference
  final List<Map<String, dynamic>> _climateOptions = [
    {
      'title': 'Warm & Sunny',
      'subtitle': 'Clear blue skies, sunbathing, and tropical warmth (24°C - 32°C)',
      'icon': Icons.wb_sunny_rounded,
      'value': 'warm',
    },
    {
      'title': 'Crisp Alpine & Cool Breezes',
      'subtitle': 'Refreshing mountain breeze, snow-capped peaks & sweater weather',
      'icon': Icons.ac_unit_rounded,
      'value': 'cool',
    },
    {
      'title': 'Mild & Mediterranean',
      'subtitle': 'Comfortable walking weather, gentle breezes & pleasant evenings',
      'icon': Icons.air_rounded,
      'value': 'mild',
    },
    {
      'title': 'Any Weather Is Great',
      'subtitle': 'I pack for any climate — focus on the destination experience',
      'icon': Icons.thermostat_rounded,
      'value': 'any',
    },
  ];

  // Q3: Daily Budget
  final List<Map<String, dynamic>> _budgetOptions = [
    {
      'title': 'Budget Savvy Explorer',
      'subtitle': 'Under ₹2,200 / day — Great local value and authentic experiences',
      'icon': Icons.savings_outlined,
      'value': 'budget',
    },
    {
      'title': 'Balanced Comfort',
      'subtitle': '₹2,200 to ₹3,000 / day — Boutique stays and guided tour excursions',
      'icon': Icons.account_balance_wallet_outlined,
      'value': 'moderate',
    },
    {
      'title': 'Luxury & Royal Heritage',
      'subtitle': '₹3,000+ / day — Heritage palace hotels, fine dining & private houseboats',
      'icon': Icons.diamond_outlined,
      'value': 'luxury',
    },
    {
      'title': 'Flexible Budget',
      'subtitle': 'Show me the best experiences regardless of daily price',
      'icon': Icons.all_inclusive_rounded,
      'value': 'any',
    },
  ];

  // Q4: Trip Duration
  final List<Map<String, dynamic>> _durationOptions = [
    {
      'title': 'Quick Escape',
      'subtitle': '3 to 4 Days — Fast recharge packed with highlight tours',
      'icon': Icons.bolt_rounded,
      'value': 'short',
    },
    {
      'title': 'Classic Holiday',
      'subtitle': '5 to 7 Days — Ideal pace to immerse yourself and unwind',
      'icon': Icons.date_range_rounded,
      'value': 'medium',
    },
    {
      'title': 'Grand Expedition',
      'subtitle': '8+ Days — Deep exploration across scenic regions and trails',
      'icon': Icons.public_rounded,
      'value': 'long',
    },
  ];

  // Q5: Activity & Energy Level
  final List<Map<String, dynamic>> _activityOptions = [
    {
      'title': 'Relaxed & Scenic Leisure',
      'subtitle': 'Sunset sails, beach lounges, tranquil walks & cozy cafes',
      'icon': Icons.spa_rounded,
      'value': 'relaxed',
    },
    {
      'title': 'Balanced Cultural Sightseeing',
      'subtitle': 'Ancient ruins, panoramic lookouts, museums & photography',
      'icon': Icons.camera_alt_rounded,
      'value': 'sightseeing',
    },
    {
      'title': 'High Action & Extreme Adrenaline',
      'subtitle': 'Rafting rapids, canyoning, mountain climbs & skydiving',
      'icon': Icons.sports_motorsports_rounded,
      'value': 'adventure',
    },
  ];

  // Q6: Dining & Culinary Style
  final List<Map<String, dynamic>> _diningOptions = [
    {
      'title': 'Fine Dining, Wine & Seafood',
      'subtitle': 'Cliffside trattorias, local vineyard tastings & fresh catch',
      'icon': Icons.wine_bar_rounded,
      'value': 'fine',
    },
    {
      'title': 'Street Food Alleys & Markets',
      'subtitle': 'Authentic ramen counters, bustling night bazaars & food stalls',
      'icon': Icons.ramen_dining_rounded,
      'value': 'street',
    },
    {
      'title': 'Hearty Mountain Cuisine',
      'subtitle': 'Traditional fondue, lakeside taverns & fresh bakery treats',
      'icon': Icons.restaurant_menu_rounded,
      'value': 'hearty',
    },
  ];

  // Q7: Travel Companions
  final List<Map<String, dynamic>> _companionOptions = [
    {
      'title': 'Solo Explorer',
      'subtitle': 'Freedom to move at your own pace and meet global travelers',
      'icon': Icons.person_rounded,
      'value': 'solo',
    },
    {
      'title': 'Romantic Couple Getaway',
      'subtitle': 'Golden hour sunsets, candlelit dinners & scenic privacy',
      'icon': Icons.favorite_rounded,
      'value': 'couple',
    },
    {
      'title': 'Family with Children',
      'subtitle': 'Safe, memorable adventures with accessible family amenities',
      'icon': Icons.family_restroom_rounded,
      'value': 'family',
    },
    {
      'title': 'Friends & Group Crew',
      'subtitle': 'High energy nightlife, group excursions & shared memories',
      'icon': Icons.groups_rounded,
      'value': 'group',
    },
  ];

  void _nextPage() {
    if (_currentStep < _totalSteps - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOutCubic,
      );
      setState(() {
        _currentStep++;
      });
    } else {
      _calculateRecommendations();
    }
  }

  void _previousPage() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOutCubic,
      );
      setState(() {
        _currentStep--;
      });
    }
  }

  void _calculateRecommendations() {
    final all = SampleData.destinations;
    final List<_ScoredDestination> scored = [];

    for (final dest in all) {
      double score = 30.0;
      List<String> matchReasons = [];

      // Q1: Category Match
      if (_selectedCategory != null &&
          dest.category.toLowerCase() == _selectedCategory!.toLowerCase()) {
        score += 25;
        matchReasons.add('Matches your desire for ${dest.category} landscapes');
      }

      // Q2: Climate Match
      if (_selectedClimate == 'warm' &&
          (dest.category == 'Beaches' || dest.id == 'dest_1' || dest.id == 'dest_6')) {
        score += 15;
        matchReasons.add('Offers warm Mediterranean sunshine and coastal breeze');
      } else if (_selectedClimate == 'cool' &&
          (dest.category == 'Mountains' || dest.id == 'dest_2' || dest.id == 'dest_7')) {
        score += 15;
        matchReasons.add('Crisp alpine mountain air and scenic glacier peaks');
      } else if (_selectedClimate == 'mild' &&
          (dest.id == 'dest_3' || dest.id == 'dest_5' || dest.id == 'dest_8')) {
        score += 15;
        matchReasons.add('Pleasant sightseeing climate ideal for exploring');
      } else if (_selectedClimate == 'any') {
        score += 10;
      }

      // Q3: Budget Match
      if (_selectedBudget == 'budget' && dest.pricePerDay <= 2200) {
        score += 15;
        matchReasons.add('Comfortably within your under-₹2,200/day budget target');
      } else if (_selectedBudget == 'moderate' &&
          dest.pricePerDay >= 2000 &&
          dest.pricePerDay <= 3000) {
        score += 15;
        matchReasons.add('Hits your ideal ₹2,200-₹3,000/day comfort zone');
      } else if (_selectedBudget == 'luxury' && dest.pricePerDay >= 2800) {
        score += 15;
        matchReasons.add('Offers luxury stays and premier dining experiences');
      } else if (_selectedBudget == 'any') {
        score += 10;
      }

      // Q4: Duration Match
      if (_selectedDuration == 'short' &&
          (dest.durationRecommendation.contains('3') ||
              dest.durationRecommendation.contains('4'))) {
        score += 10;
        matchReasons.add('Ideal for your quick ${dest.durationRecommendation} getaway');
      } else if (_selectedDuration == 'medium' &&
          (dest.durationRecommendation.contains('5') ||
              dest.durationRecommendation.contains('6') ||
              dest.durationRecommendation.contains('7'))) {
        score += 10;
        matchReasons.add('Perfect pacing for a 5 to 7 day holiday');
      } else if (_selectedDuration == 'long') {
        score += 8;
        matchReasons.add('Endless sights and day-trips for an extended stay');
      }

      // Q5: Activity Level
      if (_selectedActivity == 'relaxed' &&
          (dest.category == 'Beaches' || dest.id == 'dest_1' || dest.id == 'dest_6')) {
        score += 12;
        matchReasons.add('Tailored for relaxing seaside lounges and sunset cruises');
      } else if (_selectedActivity == 'sightseeing' &&
          (dest.category == 'Historical' || dest.category == 'City Life')) {
        score += 12;
        matchReasons.add('Packed with historic monuments, ruins, and photo spots');
      } else if (_selectedActivity == 'adventure' &&
          (dest.category == 'Adventure' || dest.category == 'Mountains')) {
        score += 12;
        matchReasons.add('High-octane thrilling outdoor activities & trails');
      }

      // Q6: Dining Style
      if (_selectedDining == 'fine' &&
          (dest.id == 'dest_1' || dest.id == 'dest_6' || dest.id == 'dest_10')) {
        score += 10;
        matchReasons.add('Celebrated culinary dining and world-class wine cellars');
      } else if (_selectedDining == 'street' &&
          (dest.id == 'dest_5' || dest.id == 'dest_8' || dest.id == 'dest_3')) {
        score += 10;
        matchReasons.add('Renowned local street gastronomy and bustling markets');
      } else if (_selectedDining == 'hearty' &&
          (dest.id == 'dest_7' || dest.id == 'dest_2' || dest.id == 'dest_9')) {
        score += 10;
        matchReasons.add('Rich alpine tavern fare, fondue, and cozy mountain dining');
      }

      // Q7: Companions
      if (_selectedVibe == 'couple') {
        if (dest.id == 'dest_1' || dest.id == 'dest_6' || dest.id == 'dest_7') {
          score += 10;
        }
        matchReasons.add('Consistently voted one of the worlds most romantic destinations');
      } else if (_selectedVibe == 'solo') {
        if (dest.id == 'dest_5' || dest.id == 'dest_2' || dest.id == 'dest_8') {
          score += 10;
        }
        matchReasons.add('Highly safe, easy public transit, and welcoming for solo travelers');
      } else if (_selectedVibe == 'family') {
        if (dest.id == 'dest_2' || dest.id == 'dest_8' || dest.id == 'dest_5') {
          score += 10;
        }
        matchReasons.add('Family-friendly excursions with memorable sights for all ages');
      } else if (_selectedVibe == 'group') {
        if (dest.id == 'dest_4' || dest.id == 'dest_9' || dest.id == 'dest_10') {
          score += 10;
        }
        matchReasons.add('Lively group adventures, nightlife, and shared excursions');
      }

      // Rating bonus
      score += (dest.rating - 4.5) * 8;

      final percentage = score.clamp(68.0, 99.0).toInt();
      scored.add(_ScoredDestination(
        destination: dest,
        matchPercentage: percentage,
        reasons: matchReasons,
      ));
    }

    scored.sort((a, b) => b.matchPercentage.compareTo(a.matchPercentage));

    setState(() {
      _recommendations = scored;
      _isCompleted = true;
    });
  }

  void _resetQuiz() {
    setState(() {
      _currentStep = 0;
      _isCompleted = false;
      _selectedCategory = null;
      _selectedClimate = null;
      _selectedBudget = null;
      _selectedDuration = null;
      _selectedActivity = null;
      _selectedDining = null;
      _selectedVibe = null;
      _recommendations = [];
    });
    _pageController.jumpToPage(0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.auto_awesome, color: Colors.amber),
            const SizedBox(width: 8),
            Text(
              _isCompleted ? 'Your Curated Places' : 'Destination Matchmaker',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          if (!_isCompleted)
            TextButton(
              onPressed: () {
                if (widget.onCompleteOrSkip != null) {
                  widget.onCompleteOrSkip!();
                } else {
                  Navigator.pop(context);
                }
              },
              child: const Text('Skip to Explore'),
            )
          else
            IconButton(
              tooltip: 'Retake Quiz',
              icon: const Icon(Icons.refresh_rounded),
              onPressed: _resetQuiz,
            ),
        ],
      ),
      body: SafeArea(
        child: _isCompleted ? _buildResultsView(theme) : _buildQuizView(theme),
      ),
    );
  }

  Widget _buildQuizView(ThemeData theme) {
    return Column(
      children: [
        // Progress indicator with step label
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Step ${_currentStep + 1} of $_totalSteps',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${((_currentStep + 1) / _totalSteps * 100).toInt()}% completed',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: (_currentStep + 1) / _totalSteps,
                  minHeight: 6,
                ),
              ),
            ],
          ),
        ),

        // Questions PageView (7 questions)
        Expanded(
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              // Q1: Theme
              _buildStepPage(
                theme,
                title: 'What vibe are you craving?',
                subtitle: 'Pick the primary landscape or aesthetic for this journey.',
                options: _themeOptions.map((opt) {
                  final isSelected = _selectedCategory == opt['category'];
                  return _buildOptionCard(
                    theme,
                    title: opt['title'] as String,
                    subtitle: opt['subtitle'] as String,
                    icon: opt['icon'] as IconData,
                    color: opt['color'] as Color,
                    isSelected: isSelected,
                    onTap: () {
                      setState(() => _selectedCategory = opt['category'] as String);
                    },
                  );
                }).toList(),
              ),

              // Q2: Climate & Weather
              _buildStepPage(
                theme,
                title: 'What weather makes you happiest?',
                subtitle: 'Choose your ideal temperature and atmosphere.',
                options: _climateOptions.map((opt) {
                  final isSelected = _selectedClimate == opt['value'];
                  return _buildOptionCard(
                    theme,
                    title: opt['title'] as String,
                    subtitle: opt['subtitle'] as String,
                    icon: opt['icon'] as IconData,
                    isSelected: isSelected,
                    onTap: () {
                      setState(() => _selectedClimate = opt['value'] as String);
                    },
                  );
                }).toList(),
              ),

              // Q3: Budget
              _buildStepPage(
                theme,
                title: 'What is your daily budget per person?',
                subtitle: 'Includes accommodation, food, and sightseeing activities.',
                options: _budgetOptions.map((opt) {
                  final isSelected = _selectedBudget == opt['value'];
                  return _buildOptionCard(
                    theme,
                    title: opt['title'] as String,
                    subtitle: opt['subtitle'] as String,
                    icon: opt['icon'] as IconData,
                    isSelected: isSelected,
                    onTap: () {
                      setState(() => _selectedBudget = opt['value'] as String);
                    },
                  );
                }).toList(),
              ),

              // Q4: Trip Duration
              _buildStepPage(
                theme,
                title: 'How long would you like to travel?',
                subtitle: 'Pick the travel window that fits your schedule.',
                options: _durationOptions.map((opt) {
                  final isSelected = _selectedDuration == opt['value'];
                  return _buildOptionCard(
                    theme,
                    title: opt['title'] as String,
                    subtitle: opt['subtitle'] as String,
                    icon: opt['icon'] as IconData,
                    isSelected: isSelected,
                    onTap: () {
                      setState(() => _selectedDuration = opt['value'] as String);
                    },
                  );
                }).toList(),
              ),

              // Q5: Activity & Energy Level
              _buildStepPage(
                theme,
                title: 'What is your preferred activity pace?',
                subtitle: 'How energetic would you like each day to be?',
                options: _activityOptions.map((opt) {
                  final isSelected = _selectedActivity == opt['value'];
                  return _buildOptionCard(
                    theme,
                    title: opt['title'] as String,
                    subtitle: opt['subtitle'] as String,
                    icon: opt['icon'] as IconData,
                    isSelected: isSelected,
                    onTap: () {
                      setState(() => _selectedActivity = opt['value'] as String);
                    },
                  );
                }).toList(),
              ),

              // Q6: Dining & Food Culture
              _buildStepPage(
                theme,
                title: 'What dining style excites you most?',
                subtitle: 'Culinary moments make trips unforgettable.',
                options: _diningOptions.map((opt) {
                  final isSelected = _selectedDining == opt['value'];
                  return _buildOptionCard(
                    theme,
                    title: opt['title'] as String,
                    subtitle: opt['subtitle'] as String,
                    icon: opt['icon'] as IconData,
                    isSelected: isSelected,
                    onTap: () {
                      setState(() => _selectedDining = opt['value'] as String);
                    },
                  );
                }).toList(),
              ),

              // Q7: Companions
              _buildStepPage(
                theme,
                title: 'Who is traveling with you?',
                subtitle: 'We tailor our recommendations to your party.',
                options: _companionOptions.map((opt) {
                  final isSelected = _selectedVibe == opt['value'];
                  return _buildOptionCard(
                    theme,
                    title: opt['title'] as String,
                    subtitle: opt['subtitle'] as String,
                    icon: opt['icon'] as IconData,
                    isSelected: isSelected,
                    onTap: () {
                      setState(() => _selectedVibe = opt['value'] as String);
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ),

        // Bottom Navigation Controls
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            border: Border(
              top: BorderSide(
                color: theme.colorScheme.outlineVariant.withOpacity(0.3),
              ),
            ),
          ),
          child: Row(
            children: [
              if (_currentStep > 0)
                OutlinedButton.icon(
                  onPressed: _previousPage,
                  icon: const Icon(Icons.arrow_back, size: 16),
                  label: const Text('Back'),
                ),
              const Spacer(),
              FilledButton.icon(
                onPressed: _canProceed() ? _nextPage : null,
                icon: Icon(
                  _currentStep == _totalSteps - 1
                      ? Icons.auto_awesome
                      : Icons.arrow_forward_rounded,
                  size: 18,
                ),
                label: Text(
                  _currentStep == _totalSteps - 1 ? 'Find My Match' : 'Continue',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  bool _canProceed() {
    switch (_currentStep) {
      case 0:
        return _selectedCategory != null;
      case 1:
        return _selectedClimate != null;
      case 2:
        return _selectedBudget != null;
      case 3:
        return _selectedDuration != null;
      case 4:
        return _selectedActivity != null;
      case 5:
        return _selectedDining != null;
      case 6:
        return _selectedVibe != null;
      default:
        return false;
    }
  }

  Widget _buildStepPage(
    ThemeData theme, {
    required String title,
    required String subtitle,
    required List<Widget> options,
  }) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
          children: [
            Text(
              title,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 20),
            ...options,
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard(
    ThemeData theme, {
    required String title,
    required String subtitle,
    required IconData icon,
    Color? color,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final activeColor = color ?? theme.colorScheme.primary;

    return Card(
      elevation: isSelected ? 3 : 0.5,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isSelected
              ? activeColor
              : theme.colorScheme.outlineVariant.withOpacity(0.4),
          width: isSelected ? 2 : 1,
        ),
      ),
      color: isSelected
          ? activeColor.withOpacity(0.08)
          : theme.colorScheme.surface,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? activeColor
                      : theme.colorScheme.surfaceVariant.withOpacity(0.6),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: isSelected ? Colors.white : activeColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isSelected ? activeColor : null,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                isSelected
                    ? Icons.check_circle_rounded
                    : Icons.radio_button_unchecked_rounded,
                color: isSelected ? activeColor : theme.colorScheme.outline,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultsView(ThemeData theme) {
    final topMatch = _recommendations.isNotEmpty ? _recommendations.first : null;
    final otherMatches =
        _recommendations.length > 1 ? _recommendations.sublist(1, 4) : [];

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // Header Banner
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                theme.colorScheme.primary,
                theme.colorScheme.secondary,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.stars_rounded, color: Colors.amber, size: 28),
                  const SizedBox(width: 10),
                  Text(
                    'Personalized Recommendations',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Based on your vibe, climate, budget, pace, cuisine, and party style, here are your best-matching destinations:',
                style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // TOP RECOMMENDATION #1
        if (topMatch != null) ...[
          Row(
            children: [
              const Icon(Icons.military_tech_rounded,
                  color: Colors.amber, size: 22),
              const SizedBox(width: 6),
              Text(
                '#1 Best Match for You',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _buildTopMatchCard(theme, topMatch),
          const SizedBox(height: 28),
        ],

        // Other strong recommendations
        if (otherMatches.isNotEmpty) ...[
          Text(
            'Other Great Alternatives',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...otherMatches.map((m) => _buildAlternativeCard(theme, m)),
        ],

        const SizedBox(height: 24),
        Center(
          child: FilledButton.tonalIcon(
            onPressed: () {
              if (widget.onCompleteOrSkip != null) {
                widget.onCompleteOrSkip!();
              } else {
                Navigator.pop(context);
              }
            },
            icon: const Icon(Icons.explore_rounded),
            label: const Text('Browse All Destinations in App'),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildTopMatchCard(ThemeData theme, _ScoredDestination item) {
    final dest = item.destination;

    return Card(
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: theme.colorScheme.primary.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with badge
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: buildSmartImage(
                  dest.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 14,
                right: 14,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.green[700],
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.check_circle_rounded,
                          color: Colors.white, size: 16),
                      const SizedBox(width: 6),
                      Text(
                        '${item.matchPercentage}% Match',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 12,
                left: 14,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    dest.location,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        dest.name,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      '₹${dest.pricePerDay.toStringAsFixed(0)} / day',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  dest.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 14),

                // Match reasons list
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer.withOpacity(0.35),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.tips_and_updates_rounded,
                              size: 16, color: theme.colorScheme.primary),
                          const SizedBox(width: 6),
                          Text(
                            'Why this place was picked for you:',
                            style: theme.textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      ...item.reasons.take(4).map(
                            (r) => Padding(
                              padding: const EdgeInsets.only(top: 3.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(top: 2.0),
                                    child: Icon(Icons.done_all_rounded,
                                        size: 15, color: Colors.green),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      r,
                                      style: theme.textTheme.bodySmall?.copyWith(
                                        height: 1.3,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Action button
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => DestinationDetailScreen(
                            destination: dest,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.arrow_forward_rounded),
                    label: const Text('View Full Guide & Plan Trip'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlternativeCard(ThemeData theme, _ScoredDestination item) {
    final dest = item.destination;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: theme.colorScheme.outlineVariant.withOpacity(0.3),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: buildSmartImage(
            dest.imageUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          dest.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 2),
            Text('${dest.location} • ₹${dest.pricePerDay.toStringAsFixed(0)}/day'),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.15),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '${item.matchPercentage}% Match',
                style: TextStyle(
                  color: Colors.green[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => DestinationDetailScreen(destination: dest),
            ),
          );
        },
      ),
    );
  }
}

class _ScoredDestination {
  final Destination destination;
  final int matchPercentage;
  final List<String> reasons;

  _ScoredDestination({
    required this.destination,
    required this.matchPercentage,
    required this.reasons,
  });
}
