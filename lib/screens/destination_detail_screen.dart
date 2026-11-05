import 'package:flutter/material.dart';
import '../data/app_state.dart';
import '../models/destination.dart';
import '../utils/map_launcher.dart';
import '../widgets/app_image.dart';

class DestinationDetailScreen extends StatefulWidget {
  final Destination destination;

  const DestinationDetailScreen({
    super.key,
    required this.destination,
  });

  @override
  State<DestinationDetailScreen> createState() => _DestinationDetailScreenState();
}

class _DestinationDetailScreenState extends State<DestinationDetailScreen> {
  void _openPlanTripDialog(BuildContext context) {
    DateTime selectedStart = DateTime.now().add(const Duration(days: 7));
    DateTime selectedEnd = DateTime.now().add(const Duration(days: 10));
    final notesController = TextEditingController();

    int adults = 2;
    int children = 0;
    int rooms = 1;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (dialogCtx, setSheetState) {
            final days = selectedEnd.difference(selectedStart).inDays + 1;
            final nights = selectedEnd.difference(selectedStart).inDays <= 0
                ? 1
                : selectedEnd.difference(selectedStart).inDays;

            final roomCost = rooms * widget.destination.roomPricePerNight * nights;
            final activityCost = (adults * widget.destination.pricePerDay +
                    children * widget.destination.pricePerDay * 0.5) *
                days;
            final totalBudget = roomCost + activityCost;

            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 24,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer,
                          child: Icon(
                            Icons.hotel_rounded,
                            color:
                                Theme.of(context).colorScheme.onPrimaryContainer,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Book Room & Plan Trip',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                widget.destination.name,
                                style: Theme.of(context).textTheme.bodySmall,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 24),

                    // Travel Dates selector
                    Text(
                      'Select Dates ($nights Nights, $days Days)',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () async {
                        final picked = await showDateRangePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(const Duration(days: 730)),
                          initialDateRange: DateTimeRange(
                            start: selectedStart,
                            end: selectedEnd,
                          ),
                          helpText: 'Select Trip Dates',
                          cancelText: 'Cancel',
                          confirmText: 'Confirm',
                        );
                        if (picked != null) {
                          setSheetState(() {
                            selectedStart = picked.start;
                            selectedEnd = picked.end;
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.outlineVariant,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_month_rounded,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${_formatDate(selectedStart)}  ➔  ${_formatDate(selectedEnd)}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    '$nights nights stay in ${widget.destination.city}',
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Room & Guest Selection Section
                    Text(
                      'Guests & Room Selection',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).colorScheme.outlineVariant,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          _buildCounterTile(
                            context: context,
                            icon: Icons.person_rounded,
                            title: 'Adults',
                            subtitle: 'Age 12+ years',
                            value: adults,
                            minValue: 1,
                            maxValue: 10,
                            onChanged: (v) {
                              setSheetState(() {
                                adults = v;
                                final recommendedRooms = (adults / 3).ceil();
                                if (rooms < recommendedRooms) {
                                  rooms = recommendedRooms;
                                }
                              });
                            },
                          ),
                          const Divider(height: 1),
                          _buildCounterTile(
                            context: context,
                            icon: Icons.child_care_rounded,
                            title: 'Children',
                            subtitle: 'Age 2 - 11 years (50% day cost)',
                            value: children,
                            minValue: 0,
                            maxValue: 8,
                            onChanged: (v) => setSheetState(() => children = v),
                          ),
                          const Divider(height: 1),
                          _buildCounterTile(
                            context: context,
                            icon: Icons.meeting_room_rounded,
                            title: 'Rooms',
                            subtitle:
                                '₹${widget.destination.roomPricePerNight.toStringAsFixed(0)}/night per room',
                            value: rooms,
                            minValue: 1,
                            maxValue: 10,
                            onChanged: (v) => setSheetState(() => rooms = v),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Dynamic Approx Budget Breakdown Card
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context)
                                .colorScheme
                                .primaryContainer
                                .withOpacity(0.65),
                            Theme.of(context)
                                .colorScheme
                                .secondaryContainer
                                .withOpacity(0.45),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Approx Estimated Budget',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '₹${totalBudget.toStringAsFixed(0)}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.w900,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '• $rooms Room(s) × $nights Nights:',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              Text(
                                '₹${roomCost.toStringAsFixed(0)}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '• $adults Adults${children > 0 ? " + $children Children" : ""} ($days Days):',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              Text(
                                '₹${activityCost.toStringAsFixed(0)}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Travel Notes field
                    Text(
                      'Trip Notes & Preferences',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: notesController,
                      maxLines: 2,
                      decoration: InputDecoration(
                        hintText:
                            'e.g. Need king-sized bed, high floor, airport cab...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.all(12),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Confirm and Add to Itinerary Button
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          final appState = AppStateScope.of(context);
                          final newPlan = Itinerary(
                            id: 'plan_${DateTime.now().millisecondsSinceEpoch}',
                            destination: widget.destination,
                            startDate: selectedStart,
                            endDate: selectedEnd,
                            adults: adults,
                            children: children,
                            rooms: rooms,
                            totalEstimatedBudget: totalBudget,
                            notes: notesController.text.trim().isEmpty
                                ? '$rooms Room(s) booked for $adults adults${children > 0 ? ", $children children" : ""}.'
                                : notesController.text.trim(),
                          );
                          appState.addItinerary(newPlan);
                          Navigator.pop(sheetContext);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              content: Text(
                                '🎉 Trip to "${widget.destination.name}" booked successfully!',
                              ),
                              action: SnackBarAction(
                                label: 'VIEW TRIPS',
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.check_circle_outline),
                        label: const Text(
                          'Confirm Booking & Save Itinerary',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  static Widget _buildCounterTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required int value,
    required int minValue,
    required int maxValue,
    required ValueChanged<int> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 22, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 11),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.remove_circle_outline),
            visualDensity: VisualDensity.compact,
            onPressed: value > minValue ? () => onChanged(value - 1) : null,
          ),
          Text(
            '$value',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            visualDensity: VisualDensity.compact,
            onPressed: value < maxValue ? () => onChanged(value + 1) : null,
          ),
        ],
      ),
    );
  }

  static String _formatDate(DateTime d) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${months[d.month - 1]} ${d.day}, ${d.year}';
  }

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);
    final isFavorite = appState.isFavorite(widget.destination);
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with Hero Image
          SliverAppBar(
            expandedHeight: 320,
            pinned: true,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              title: Text(
                widget.destination.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(color: Colors.black87, blurRadius: 10),
                  ],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: 'dest_img_${widget.destination.id}',
                    child: buildSmartImage(
                      widget.destination.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black87,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.5, 1.0],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  color: isFavorite ? Colors.redAccent : Colors.white,
                ),
                onPressed: () => appState.toggleFavorite(widget.destination),
              ),
            ],
          ),

          // Content body
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Location and Category chips
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 18, color: Colors.redAccent),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          widget.destination.location,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Chip(
                        label: Text(widget.destination.category),
                        backgroundColor: theme.colorScheme.primaryContainer,
                        labelStyle: TextStyle(
                          color: theme.colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Rating & Price Metrics
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.star_rounded, color: Colors.amber, size: 24),
                          const SizedBox(width: 4),
                          Text(
                            widget.destination.rating.toString(),
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '(${widget.destination.reviewCount} reviews)',
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '₹${widget.destination.pricePerDay.toStringAsFixed(0)}/day',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          Text(
                            'Room from ₹${widget.destination.roomPricePerNight.toStringAsFixed(0)}/night',
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(height: 32),

                  // Google Maps Location Section
                  _buildGoogleMapsSection(context),
                  const SizedBox(height: 24),

                  // Ways to Reach that Location Section
                  _buildWaysToReachSection(context),
                  const SizedBox(height: 24),

                  // Description
                  Text(
                    'About this Destination',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.destination.description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      height: 1.5,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Best Time & Duration Info Cards
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoCard(
                          context: context,
                          icon: Icons.wb_sunny_outlined,
                          title: 'Best Season',
                          value: widget.destination.bestTimeToVisit,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildInfoCard(
                          context: context,
                          icon: Icons.timer_outlined,
                          title: 'Suggested Stay',
                          value: widget.destination.durationRecommendation,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Highlights List
                  Text(
                    'Must-Experience Highlights',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...widget.destination.highlights.map(
                    (highlight) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            size: 20,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              highlight,
                              style: theme.textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Book Room & Plan Trip Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: FilledButton.icon(
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () => _openPlanTripDialog(context),
                      icon: const Icon(Icons.hotel_rounded),
                      label: const Text(
                        'Book Room & Calculate Budget',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Google Maps Location UI Widget
  Widget _buildGoogleMapsSection(BuildContext context) {
    final theme = Theme.of(context);
    final dest = widget.destination;

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant.withOpacity(0.35),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withOpacity(0.6),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.redAccent.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.map_rounded,
                  color: Colors.redAccent,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Google Maps Location',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      dest.mapCoordinatesDisplay,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            'Explore ${dest.name} pin, live traffic, satellite imagery, and nearby sights directly on Google Maps.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: FilledButton.tonalIcon(
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () {
                    MapLauncher.openGoogleMaps(
                      latitude: dest.latitude,
                      longitude: dest.longitude,
                      label: dest.name,
                    );
                  },
                  icon: const Icon(Icons.open_in_new_rounded, size: 18),
                  label: const Text('View on Map'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () {
                    MapLauncher.openDirections(
                      latitude: dest.latitude,
                      longitude: dest.longitude,
                    );
                  },
                  icon: const Icon(Icons.directions_rounded, size: 18),
                  label: const Text('Directions'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Ways to Reach Section Widget
  Widget _buildWaysToReachSection(BuildContext context) {
    final theme = Theme.of(context);
    final reach = widget.destination.howToReach;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.commute_rounded,
                color: theme.colorScheme.onPrimaryContainer,
                size: 20,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Ways to Reach Here',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildReachCard(
          context: context,
          icon: Icons.flight_takeoff_rounded,
          iconColor: Colors.blueAccent,
          mode: 'By Air (Flight)',
          details: reach.byAir,
        ),
        const SizedBox(height: 10),
        _buildReachCard(
          context: context,
          icon: Icons.train_rounded,
          iconColor: Colors.orangeAccent[700]!,
          mode: 'By Train (Rail)',
          details: reach.byTrain,
        ),
        const SizedBox(height: 10),
        _buildReachCard(
          context: context,
          icon: Icons.directions_bus_filled_rounded,
          iconColor: Colors.teal,
          mode: 'By Road (Bus / Taxi / Self-Drive)',
          details: reach.byRoad,
        ),
      ],
    );
  }

  Widget _buildReachCard({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String mode,
    required String details,
  }) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withOpacity(0.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mode,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  details,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String value,
  }) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant.withOpacity(0.4),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withOpacity(0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 22, color: theme.colorScheme.primary),
          const SizedBox(height: 8),
          Text(
            title,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
