class HowToReach {
  final String byAir;
  final String byTrain;
  final String byRoad;

  const HowToReach({
    required this.byAir,
    required this.byTrain,
    required this.byRoad,
  });
}

class Destination {
  final String id;
  final String name;
  final String city;
  final String country;
  final String category;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final double pricePerDay; // in INR (₹)
  final double roomPricePerNight; // base room cost per night
  final String description;
  final List<String> highlights;
  final String bestTimeToVisit;
  final String durationRecommendation;
  final double latitude;
  final double longitude;
  final String mapCoordinatesDisplay;
  final HowToReach howToReach;

  const Destination({
    required this.id,
    required this.name,
    required this.city,
    required this.country,
    required this.category,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.pricePerDay,
    this.roomPricePerNight = 2500.0,
    required this.description,
    required this.highlights,
    required this.bestTimeToVisit,
    required this.durationRecommendation,
    required this.latitude,
    required this.longitude,
    required this.mapCoordinatesDisplay,
    required this.howToReach,
  });

  String get location => '$city, $country';

  String get formattedPrice => '₹${pricePerDay.toStringAsFixed(0)}/day';

  bool matchesQuery(String query) {
    if (query.isEmpty) return true;
    final q = query.toLowerCase().trim();
    return name.toLowerCase().contains(q) ||
        city.toLowerCase().contains(q) ||
        country.toLowerCase().contains(q) ||
        category.toLowerCase().contains(q);
  }
}

class Itinerary {
  final String id;
  final Destination destination;
  final DateTime startDate;
  final DateTime endDate;
  final String notes;
  final int adults;
  final int children;
  final int rooms;
  final double totalEstimatedBudget;

  const Itinerary({
    required this.id,
    required this.destination,
    required this.startDate,
    required this.endDate,
    required this.notes,
    this.adults = 2,
    this.children = 0,
    this.rooms = 1,
    this.totalEstimatedBudget = 0.0,
  });

  int get numberOfDays {
    final diff = endDate.difference(startDate).inDays;
    return diff <= 0 ? 1 : diff + 1;
  }

  int get numberOfNights {
    final diff = endDate.difference(startDate).inDays;
    return diff <= 0 ? 1 : diff;
  }

  double calculateBudget() {
    if (totalEstimatedBudget > 0) return totalEstimatedBudget;
    final nights = numberOfNights;
    final days = numberOfDays;
    // Room cost
    final roomCost = rooms * destination.roomPricePerNight * nights;
    // Daily activities + meals: Adults at full rate, children at 50%
    final dailyCost = (adults * destination.pricePerDay +
            children * destination.pricePerDay * 0.5) *
        days;
    return roomCost + dailyCost;
  }

  double get totalEstimatedCost => calculateBudget();

  String get formattedDateRange {
    final startStr = _formatDateShort(startDate);
    final endStr = _formatDateShort(endDate);
    return '$startStr - $endStr ($numberOfDays ${numberOfDays == 1 ? 'day' : 'days'})';
  }

  static String _formatDateShort(DateTime date) {
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
    final m = months[date.month - 1];
    return '$m ${date.day}, ${date.year}';
  }
}
