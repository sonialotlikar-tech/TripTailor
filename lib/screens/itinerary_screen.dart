import 'package:flutter/material.dart';
import '../data/app_state.dart';
import '../models/destination.dart';
import '../widgets/app_image.dart';
import 'destination_detail_screen.dart';

class ItineraryScreen extends StatelessWidget {
  const ItineraryScreen({super.key});

  void _showAddItineraryDialog(BuildContext context) {
    final appState = AppStateScope.of(context);
    Destination selectedDest = appState.allDestinations.first;
    DateTime startDate = DateTime.now().add(const Duration(days: 14));
    DateTime endDate = DateTime.now().add(const Duration(days: 18));
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
            final days = endDate.difference(startDate).inDays + 1;
            final nights = endDate.difference(startDate).inDays <= 0
                ? 1
                : endDate.difference(startDate).inDays;

            final roomCost = rooms * selectedDest.roomPricePerNight * nights;
            final activityCost = (adults * selectedDest.pricePerDay +
                    children * selectedDest.pricePerDay * 0.5) *
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
                    Text(
                      'Book Room & Schedule Trip',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Select a destination in India, choose guests, rooms & get budget',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                    const Divider(height: 24),

                    // Destination Dropdown
                    Text(
                      'Choose Destination',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).colorScheme.outlineVariant,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<Destination>(
                          isExpanded: true,
                          value: selectedDest,
                          items: appState.allDestinations.map((d) {
                            return DropdownMenuItem<Destination>(
                              value: d,
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: buildSmartImage(
                                      d.imageUrl,
                                      width: 36,
                                      height: 36,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          d.name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          d.location,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (newDest) {
                            if (newDest != null) {
                              setSheetState(() => selectedDest = newDest);
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Dates picker
                    Text(
                      'Travel Dates ($nights Nights, $days Days)',
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
                          lastDate:
                              DateTime.now().add(const Duration(days: 730)),
                          initialDateRange: DateTimeRange(
                            start: startDate,
                            end: endDate,
                          ),
                          helpText: 'Select Trip Dates',
                          cancelText: 'Cancel',
                          confirmText: 'Confirm',
                        );
                        if (picked != null) {
                          setSheetState(() {
                            startDate = picked.start;
                            endDate = picked.end;
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
                                    '${_formatDate(startDate)}  ➔  ${_formatDate(endDate)}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    '$nights nights in ${selectedDest.city}',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
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

                    // Guests & Rooms counter
                    Text(
                      'Guests & Room Booking',
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
                                '₹${selectedDest.roomPricePerNight.toStringAsFixed(0)}/night per room',
                            value: rooms,
                            minValue: 1,
                            maxValue: 10,
                            onChanged: (v) => setSheetState(() => rooms = v),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Approx Budget Calculation Card
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

                    // Travel Notes
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
                            'e.g. Flight booking details, family stay, tour guide needed...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.all(12),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Add Button
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
                          final newPlan = Itinerary(
                            id: 'plan_${DateTime.now().millisecondsSinceEpoch}',
                            destination: selectedDest,
                            startDate: startDate,
                            endDate: endDate,
                            adults: adults,
                            children: children,
                            rooms: rooms,
                            totalEstimatedBudget: totalBudget,
                            notes: notesController.text.trim().isEmpty
                                ? '$rooms Room(s) for $adults adults${children > 0 ? ", $children children" : ""}'
                                : notesController.text.trim(),
                          );
                          appState.addItinerary(newPlan);
                          Navigator.pop(sheetContext);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              content: Text(
                                '🎉 Trip to "${selectedDest.name}" scheduled successfully!',
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.check_circle_outline),
                        label: const Text(
                          'Save Trip to Itinerary',
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
    final theme = Theme.of(context);
    final itineraries = appState.itineraries;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My Trips & Bookings',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
            Text(
              '${itineraries.length} ${itineraries.length == 1 ? "trip planned" : "trips planned"}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddItineraryDialog(context),
        icon: const Icon(Icons.add_rounded),
        label: const Text('Book & Plan Trip'),
      ),
      body: itineraries.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.luggage_rounded,
                        size: 64,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'No Upcoming Trips Yet',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Select any destination in India to configure rooms, adults, children and book your journey.',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 24),
                    FilledButton.icon(
                      onPressed: () => _showAddItineraryDialog(context),
                      icon: const Icon(Icons.add_circle_outline),
                      label: const Text('Plan Your First Trip'),
                    ),
                  ],
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 88),
              itemCount: itineraries.length,
              itemBuilder: (context, index) {
                final item = itineraries[index];
                return Dismissible(
                  key: Key(item.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(
                      Icons.delete_sweep_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  onDismissed: (_) {
                    appState.removeItinerary(item.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        content: Text('Removed "${item.destination.name}" trip'),
                        action: SnackBarAction(
                          label: 'UNDO',
                          onPressed: () => appState.addItinerary(item),
                        ),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 1.5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => DestinationDetailScreen(
                              destination: item.destination,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: buildSmartImage(
                                    item.destination.imageUrl,
                                    width: 72,
                                    height: 72,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.destination.name,
                                        style: theme.textTheme.titleMedium
                                            ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 2),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on_rounded,
                                            size: 14,
                                            color: theme.colorScheme.primary,
                                          ),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              item.destination.location,
                                              style: theme.textTheme.bodySmall,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: theme
                                                  .colorScheme.primaryContainer,
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            child: Text(
                                              '${item.rooms} Room(s) • ${item.adults} Adults${item.children > 0 ? " • ${item.children} Kids" : ""}',
                                              style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w600,
                                                color: theme.colorScheme
                                                    .onPrimaryContainer,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Divider(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today_rounded,
                                      size: 15,
                                      color: theme.colorScheme.primary,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      item.formattedDateRange,
                                      style: theme.textTheme.bodySmall?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  '₹${item.totalEstimatedCost.toStringAsFixed(0)}',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                            if (item.notes.isNotEmpty) ...[
                              const SizedBox(height: 10),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.surfaceVariant
                                      .withOpacity(0.35),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  item.notes,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
