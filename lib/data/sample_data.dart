import '../models/destination.dart';

class SampleData {
  static const List<String> categories = [
    'All',
    'Beaches',
    'Mountains',
    'Historical',
    'Adventure',
    'City Life',
  ];

  static final List<Destination> destinations = [
    const Destination(
      id: 'dest_taj',
      name: 'Taj Mahal & Agra Fort',
      city: 'Agra, Uttar Pradesh',
      country: 'India',
      category: 'Historical',
      imageUrl: 'assets/images/taj_mahal.jpg',
      rating: 4.95,
      reviewCount: 12450,
      pricePerDay: 2200.0,
      roomPricePerNight: 3500.0,
      latitude: 27.1751,
      longitude: 78.0421,
      mapCoordinatesDisplay: '27.1751° N, 78.0421° E',
      description:
          'One of the Seven Wonders of the World, the Taj Mahal is an ivory-white marble mausoleum on the south bank of the Yamuna river. Experience timeless Mughal splendor, the colossal red sandstone Agra Fort, and romantic sunset views over the Yamuna.',
      highlights: [
        'Marvel at the sunrise illuminating the white marble dome of the Taj Mahal',
        'Explore the Mughal palaces, Diwan-i-Khas, and courtyards of Agra Fort',
        'Visit Mehtab Bagh for panoramic twilight views across the river',
        'Taste authentic Agra Petha and rich Mughlai cuisine in old bazaars'
      ],
      bestTimeToVisit: 'October to March',
      durationRecommendation: '2 - 3 Days',
      howToReach: HowToReach(
        byAir:
            'Indira Gandhi International Airport (DEL) in New Delhi (approx. 200 km) or Kheria Domestic Airport in Agra (12 km).',
        byTrain:
            'Agra Cantt Railway Station (AGC) connects with high-speed Gatimaan Express and Vande Bharat Express from New Delhi (1 hr 40 min).',
        byRoad:
            'Yamuna Expressway (6-lane access-controlled) connects New Delhi / Noida to Agra in just 3 hours via bus or private taxi.',
      ),
    ),
    const Destination(
      id: 'dest_goa',
      name: 'Goa Coastal Shores & Heritage',
      city: 'Goa',
      country: 'India',
      category: 'Beaches',
      imageUrl: 'assets/images/goa.jpg',
      rating: 4.88,
      reviewCount: 9870,
      pricePerDay: 2800.0,
      roomPricePerNight: 4000.0,
      latitude: 15.2993,
      longitude: 74.1240,
      mapCoordinatesDisplay: '15.2993° N, 74.1240° E',
      description:
          'India’s premier beach destination, blending vibrant golden coastlines, Portuguese colonial architecture, pulsating nightlife, swaying coconut palms, and world-famous coastal seafood curries.',
      highlights: [
        'Relax along the serene golden sands of Palolem and Morjim beaches',
        'Explore UNESCO-listed Basilica of Bom Jesus and Latin Quarter in Fontainhas',
        'Experience jet skiing, parasailing, and sunset catamaran cruises',
        'Savor traditional Goan fish curry thali with fresh coconut feni'
      ],
      bestTimeToVisit: 'November to February',
      durationRecommendation: '4 - 6 Days',
      howToReach: HowToReach(
        byAir:
            'Goa International Airport (GOI) at Dabolim or Manohar International Airport (GOX) at Mopa, with flights from all major Indian metros.',
        byTrain:
            'Madgaon (MAO) and Thivim (THVM) stations are connected via Konkan Railway with scenic routes from Mumbai, Pune, and Bangalore.',
        byRoad:
            'Connected via NH 66 from Mumbai (approx. 11 hrs) and NH 4A / NH 48 from Bangalore and Pune with overnight luxury sleeper buses.',
      ),
    ),
    const Destination(
      id: 'dest_manali',
      name: 'Manali & Solang Valley',
      city: 'Kullu, Himachal Pradesh',
      country: 'India',
      category: 'Mountains',
      imageUrl: 'assets/images/manali.jpg',
      rating: 4.91,
      reviewCount: 8430,
      pricePerDay: 2400.0,
      roomPricePerNight: 3200.0,
      latitude: 32.2432,
      longitude: 77.1892,
      mapCoordinatesDisplay: '32.2432° N, 77.1892° E',
      description:
          'A high-altitude Himalayan resort town surrounded by towering snow-clad peaks, whispering cedar forests, gushing Beas river streams, and thrilling winter adventure hubs.',
      highlights: [
        'Drive through the high-altitude Atal Tunnel to Sissu waterfall',
        'Paragliding, zorbing, and quad biking across Solang Valley',
        'Visit the ancient wooden pagoda of Hadimba Temple in cedar woods',
        'Unwind in natural sulfur hot springs at Vashisht village'
      ],
      bestTimeToVisit: 'October to June',
      durationRecommendation: '4 - 5 Days',
      howToReach: HowToReach(
        byAir:
            'Kullu-Manali Airport at Bhuntar (approx. 50 km from Manali). Flights operate from Delhi and Chandigarh.',
        byTrain:
            'Nearest broad gauge station is Chandigarh (310 km) or Pathankot (295 km), followed by cab or Volvo bus.',
        byRoad:
            'Well connected to Delhi (540 km) and Chandigarh (305 km) via NH 21 with overnight HPTDC / private Volvo buses.',
      ),
    ),
    const Destination(
      id: 'dest_jaipur',
      name: 'Jaipur Pink City & Amer Fort',
      city: 'Jaipur, Rajasthan',
      country: 'India',
      category: 'Historical',
      imageUrl: 'assets/images/jaipur.jpg',
      rating: 4.92,
      reviewCount: 7650,
      pricePerDay: 2500.0,
      roomPricePerNight: 3800.0,
      latitude: 26.9124,
      longitude: 75.7873,
      mapCoordinatesDisplay: '26.9124° N, 75.7873° E',
      description:
          'The royal capital of Rajasthan, famous for terracotta-pink palaces, majestic hilltop fortresses, bustling colorful gemstone bazaars, and opulent Rajput hospitality.',
      highlights: [
        'Explore the majestic hilltop Amer Fort with Sheesh Mahal mirror palace',
        'Photograph the honeycomb facade and 953 jharokhas of Hawa Mahal',
        'Tour the royal courtyards and astronomical instruments of Jantar Mantar',
        'Indulge in Dal Baati Churma and royal Rajasthani thali dinners'
      ],
      bestTimeToVisit: 'October to March',
      durationRecommendation: '3 - 4 Days',
      howToReach: HowToReach(
        byAir:
            'Jaipur International Airport (JAI) at Sanganer (12 km from city center) with daily flights from all Indian hubs.',
        byTrain:
            'Jaipur Junction (JP) is connected by Shatabdi, Vande Bharat, and superfast trains from Delhi (4 hrs), Mumbai, and Kolkata.',
        byRoad:
            'Delhi-Mumbai Expressway (NE-4) connects New Delhi to Jaipur in under 3.5 hours. Excellent AC state transport buses run hourly.',
      ),
    ),
    const Destination(
      id: 'dest_kerala',
      name: 'Kerala Backwaters & Alleppey',
      city: 'Alappuzha, Kerala',
      country: 'India',
      category: 'Beaches',
      imageUrl: 'assets/images/kerala.jpg',
      rating: 4.94,
      reviewCount: 8120,
      pricePerDay: 3000.0,
      roomPricePerNight: 4500.0,
      latitude: 9.4981,
      longitude: 76.3388,
      mapCoordinatesDisplay: '9.4981° N, 76.3388° E',
      description:
          'Known as "God’s Own Country", Alleppey is famous for tranquil emerald backwater canals, traditional thatched-roof houseboats, lush paddy fields, and rejuvenating Ayurvedic massages.',
      highlights: [
        'Overnight cruise on a traditional luxury kettuvallam houseboat',
        'Watch local village life and fishing nets along palm-fringed lagoons',
        'Experience authentic Ayurvedic massage and Panchakarma wellness therapy',
        'Savor fresh Karimeen Pollichathu served on banana leaves'
      ],
      bestTimeToVisit: 'September to March',
      durationRecommendation: '3 - 5 Days',
      howToReach: HowToReach(
        byAir:
            'Cochin International Airport (COK) is 85 km away (around 2 hours by cab or direct airport bus).',
        byTrain:
            'Alappuzha Railway Station (ALLP) is directly on the coastal rail line with connections to Kochi, Trivandrum, and Chennai.',
        byRoad:
            'National Highway 66 passes through Alleppey connecting Kochi (53 km, 1.5 hrs) and Thiruvananthapuram (150 km).',
      ),
    ),
    const Destination(
      id: 'dest_varanasi',
      name: 'Varanasi Ghats & Spiritual Heart',
      city: 'Varanasi, Uttar Pradesh',
      country: 'India',
      category: 'Historical',
      imageUrl: 'assets/images/varanasi.jpg',
      rating: 4.89,
      reviewCount: 9320,
      pricePerDay: 1800.0,
      roomPricePerNight: 2800.0,
      latitude: 25.3176,
      longitude: 82.9739,
      mapCoordinatesDisplay: '25.3176° N, 82.9739° E',
      description:
          'One of the oldest continuously inhabited cities in the world, Varanasi is the spiritual capital of India. Located along the sacred Ganges, it offers deep cultural traditions, mesmerizing rituals, and labyrinthine alleys.',
      highlights: [
        'Witness the grand evening Ganga Aarti ceremony at Dashashwamedh Ghat',
        'Early sunrise wooden boat ride along the 84 sacred riverfront ghats',
        'Visit the historic Kashi Vishwanath corridor and ancient Sarnath stupa',
        'Taste Banarasi kachori-jalebi and the famous Banarasi paan'
      ],
      bestTimeToVisit: 'October to March',
      durationRecommendation: '2 - 4 Days',
      howToReach: HowToReach(
        byAir:
            'Lal Bahadur Shastri International Airport (VNS) at Babatpur (26 km from city) connects directly to Delhi, Mumbai, Kolkata, etc.',
        byTrain:
            'Varanasi Junction (BSB) and Pt. Deen Dayal Upadhyaya Junction (DDU, 18 km) connect via Vande Bharat from New Delhi in 8 hours.',
        byRoad:
            'Well linked via NH 19 (Grand Trunk Road) with direct highways connecting Prayagraj (125 km), Lucknow, and Patna.',
      ),
    ),
    const Destination(
      id: 'dest_ladakh',
      name: 'Ladakh High Passes & Pangong Lake',
      city: 'Leh, Ladakh',
      country: 'India',
      category: 'Adventure',
      imageUrl: 'assets/images/ladakh.jpg',
      rating: 4.97,
      reviewCount: 6540,
      pricePerDay: 3200.0,
      roomPricePerNight: 4200.0,
      latitude: 34.1526,
      longitude: 77.5771,
      mapCoordinatesDisplay: '34.1526° N, 77.5771° E',
      description:
          'The Land of High Passes, Ladakh features dramatic stark cold desert landscapes, vibrant Tibetan monasteries, world’s highest motorable passes, and crystal-clear azure lakes that change colors with the sun.',
      highlights: [
        'Camp under millions of Milky Way stars beside Pangong Tso Lake',
        'Ride across Khardung La Pass into the dramatic Nubra sand dunes',
        'Visit the majestic Thiksey Monastery and Leh Royal Palace',
        'Experience the optical illusion hill at Magnetic Hill'
      ],
      bestTimeToVisit: 'May to September',
      durationRecommendation: '6 - 8 Days',
      howToReach: HowToReach(
        byAir:
            'Kushok Bakula Rimpochee Airport (IXL) in Leh with daily morning flights from Delhi, Srinagar, and Chandigarh (acclimatization rest required on Day 1).',
        byTrain:
            'Nearest major railway terminal is Jammu Tawi (700 km), followed by road trip through Srinagar and Kargil.',
        byRoad:
            'Two legendary mountain routes: Manali-Leh Highway (490 km) and Srinagar-Leh Highway (434 km) open June through October for road trips.',
      ),
    ),
    const Destination(
      id: 'dest_mumbai',
      name: 'Mumbai City of Dreams & Marine Drive',
      city: 'Mumbai, Maharashtra',
      country: 'India',
      category: 'City Life',
      imageUrl: 'assets/images/mumbai.jpg',
      rating: 4.90,
      reviewCount: 11200,
      pricePerDay: 3500.0,
      roomPricePerNight: 5500.0,
      latitude: 18.9220,
      longitude: 72.8347,
      mapCoordinatesDisplay: '18.9220° N, 72.8347° E',
      description:
          'The financial and entertainment capital of India. A dynamic melting pot where grand Victorian gothic heritage meets glittering Bollywood glamour, energetic street markets, and Arabian seaside promenades.',
      highlights: [
        'Walk along Marine Drive "Queen’s Necklace" at sunset',
        'Photograph the iconic Gateway of India and historic Taj Mahal Palace Hotel',
        'Ferry ride to the ancient rock-cut Elephanta Caves on Arabian Sea',
        'Feast on street delicacies: Vada Pav, Pav Bhaji, and coastal Bombay Duck'
      ],
      bestTimeToVisit: 'November to February',
      durationRecommendation: '3 - 5 Days',
      howToReach: HowToReach(
        byAir:
            'Chhatrapati Shivaji Maharaj International Airport (BOM) is one of India’s busiest hubs connecting to virtually every domestic & international city.',
        byTrain:
            'Chhatrapati Shivaji Maharaj Terminus (CSMT, UNESCO site) and Mumbai Central (MMCT) connect trains from all parts of India.',
        byRoad:
            'Mumbai-Pune Expressway, Samruddhi Mahamarg, and Western Express Highway connect Mumbai seamlessly with western and central India.',
      ),
    ),
    const Destination(
      id: 'dest_rishikesh',
      name: 'Rishikesh River Rafting & Yoga',
      city: 'Rishikesh, Uttarakhand',
      country: 'India',
      category: 'Adventure',
      imageUrl: 'assets/images/rishikesh.jpg',
      rating: 4.93,
      reviewCount: 7120,
      pricePerDay: 2100.0,
      roomPricePerNight: 2900.0,
      latitude: 30.0869,
      longitude: 78.2676,
      mapCoordinatesDisplay: '30.0869° N, 78.2676° E',
      description:
          'The Yoga Capital of the World nestled at the foothills of the Himalayas where the holy Ganges emerges into the plains. A premier adventure destination for whitewater rafting, bungee jumping, and spiritual ashrams.',
      highlights: [
        'Grade III and IV whitewater rafting down turbulent Ganges rapids',
        'India’s highest 83-meter bungee jumping and giant canyon swing',
        'Cross the suspension bridges of Lakshman Jhula and Ram Jhula',
        'Attend sunset meditation at Parmarth Niketan Ganga Aarti'
      ],
      bestTimeToVisit: 'September to November & March to May',
      durationRecommendation: '3 - 4 Days',
      howToReach: HowToReach(
        byAir:
            'Jolly Grant Airport (DED) in Dehradun is just 21 km away (35 minutes by taxi) with multiple flights daily from Delhi.',
        byTrain:
            'Yog Nagari Rishikesh (YNRK) & Haridwar Railway Station (25 km away) are connected with Shatabdi and Vande Bharat from Delhi.',
        byRoad:
            'Delhi-Dehradun Expressway / NH 334 connects Delhi to Rishikesh (240 km) in approximately 4 to 5 hours.',
      ),
    ),
    const Destination(
      id: 'dest_udaipur',
      name: 'Udaipur City of Lakes & Palaces',
      city: 'Udaipur, Rajasthan',
      country: 'India',
      category: 'Historical',
      imageUrl: 'assets/images/udaipur.jpg',
      rating: 4.94,
      reviewCount: 6890,
      pricePerDay: 2700.0,
      roomPricePerNight: 4500.0,
      latitude: 24.5854,
      longitude: 73.7125,
      mapCoordinatesDisplay: '24.5854° N, 73.7125° E',
      description:
          'Often hailed as the "Venice of the East", Udaipur captivates travelers with serene romantic lakes, magnificent marble palaces, royal gardens, and golden sunset reflections over Lake Pichola.',
      highlights: [
        'Boat cruise on Lake Pichola past the floating Taj Lake Palace',
        'Wander through the sprawling courtyards and museums of City Palace',
        'Watch traditional folk dance and puppet shows at Bagore Ki Haveli',
        'Enjoy candlelit rooftop dinners overlooking illuminated lakes'
      ],
      bestTimeToVisit: 'October to March',
      durationRecommendation: '3 - 4 Days',
      howToReach: HowToReach(
        byAir:
            'Maharana Pratap Airport (UDR) at Dabok (22 km from city center) has daily flights from Delhi, Mumbai, Bengaluru, and Jaipur.',
        byTrain:
            'Udaipur City Railway Station (UDZ) connects directly to Delhi (Mewar Express), Mumbai, and Ahmedabad.',
        byRoad:
            'Golden Quadrilateral NH 48 connects Udaipur with Ahmedabad (260 km, 4.5 hrs) and Jaipur (390 km, 6 hrs) via scenic four-lane highways.',
      ),
    ),
    const Destination(
      id: 'dest_ooty',
      name: 'Ooty & Nilgiri Mountain Railway',
      city: 'Nilgiris, Tamil Nadu',
      country: 'India',
      category: 'Mountains',
      imageUrl: 'assets/images/ooty.jpg',
      rating: 4.87,
      reviewCount: 5410,
      pricePerDay: 2000.0,
      roomPricePerNight: 3000.0,
      latitude: 11.4102,
      longitude: 76.6950,
      mapCoordinatesDisplay: '11.4102° N, 76.6950° E',
      description:
          'The "Queen of Hill Stations" in the Nilgiri Blue Mountains, famous for rolling green tea plantations, colonial bungalows, cool eucalyptus air, and the UNESCO heritage toy train.',
      highlights: [
        'Ride the historic UNESCO steam toy train across viaducts and tunnels',
        'Stroll through sprawling aromatic Nilgiri tea estates and factories',
        'Boating on Ooty Lake and panoramic views from Doddabetta Peak',
        'Visit the colorful Government Botanical Gardens with 1,000+ flora species'
      ],
      bestTimeToVisit: 'October to June',
      durationRecommendation: '3 - 4 Days',
      howToReach: HowToReach(
        byAir:
            'Coimbatore International Airport (CJB) is the nearest airport (88 km), around 3 hours away by scenic mountain road.',
        byTrain:
            'Mettupalayam (MTP, 52 km) connects with the broad-gauge network. From here, take the UNESCO Nilgiri Mountain Railway Toy Train up to Ooty.',
        byRoad:
            'Well connected with Coimbatore (88 km), Bangalore (270 km, 6 hrs via Mysore & Bandipur Forest), and Mysore (125 km) with regular KSRTC & TNSTC buses.',
      ),
    ),
    const Destination(
      id: 'dest_darjeeling',
      name: 'Darjeeling Hills & Kanchenjunga View',
      city: 'Darjeeling, West Bengal',
      country: 'India',
      category: 'Mountains',
      imageUrl: 'assets/images/darjeeling.jpg',
      rating: 4.91,
      reviewCount: 4980,
      pricePerDay: 2100.0,
      roomPricePerNight: 3100.0,
      latitude: 27.0410,
      longitude: 88.2663,
      mapCoordinatesDisplay: '27.0410° N, 88.2663° E',
      description:
          'Famed worldwide for champagne black tea and spectacular sunrise views over Mount Kanchenjunga—the third highest peak in the world. Enjoy Himalayan heritage, Buddhist monasteries, and vibrant Tibetan culture.',
      highlights: [
        'Golden sunrise over snow-capped Kanchenjunga from Tiger Hill',
        'Ride the vintage DHR Toy Train along Batasia Loop',
        'Tour Happy Valley Tea Estate and taste first-flush Darjeeling brew',
        'Visit Ghoom Monastery and the Himalayan Mountaineering Institute'
      ],
      bestTimeToVisit: 'March to May & October to December',
      durationRecommendation: '3 - 5 Days',
      howToReach: HowToReach(
        byAir:
            'Bagdogra Airport (IXB) near Siliguri (approx. 70 km away) is the nearest airport with frequent flights from Kolkata, Delhi, and Guwahati.',
        byTrain:
            'New Jalpaiguri (NJP) Railway Station is the main railhead (73 km away), connecting Rajdhani and Vande Bharat trains from Kolkata and Delhi.',
        byRoad:
            'Shared and private 4WD taxis (Sumo/Bolero) run regularly from Siliguri / NJP to Darjeeling via Hill Cart Road (3 to 3.5 hrs).',
      ),
    ),
    const Destination(
      id: 'dest_amritsar',
      name: 'Amritsar Golden Temple & Heritage',
      city: 'Amritsar, Punjab',
      country: 'India',
      category: 'Historical',
      imageUrl: 'assets/images/amritsar.jpg',
      rating: 4.96,
      reviewCount: 10340,
      pricePerDay: 1900.0,
      roomPricePerNight: 2700.0,
      latitude: 31.6200,
      longitude: 74.8765,
      mapCoordinatesDisplay: '31.6200° N, 74.8765° E',
      description:
          'The spiritual and cultural center of the Sikh community. The gleaming Golden Temple (Harmandir Sahib) sits in the center of the holy Amrit Sarovar pool, serving free community meals to over 100,000 visitors every single day.',
      highlights: [
        'Experience the serenity and illumination of the Golden Temple at night',
        'Volunteer or dine in the world’s largest free mega-kitchen (Guru ka Langar)',
        'Feel the patriotic energy of the Wagah Border Beating Retreat ceremony',
        'Relish authentic Amritsari Kulcha with melting butter and thick lassi'
      ],
      bestTimeToVisit: 'October to March',
      durationRecommendation: '2 - 3 Days',
      howToReach: HowToReach(
        byAir:
            'Sri Guru Ram Dass Jee International Airport (ATQ) is 11 km from the city center, offering both domestic and direct international flights.',
        byTrain:
            'Amritsar Junction (ASR) is a major rail hub with multiple Shatabdi, Shan-e-Punjab, and Vande Bharat expresses from New Delhi (6 hrs).',
        byRoad:
            'Grand Trunk (GT) Road connects Amritsar to Delhi (450 km) and Chandigarh (230 km). Frequent luxury AC buses operate on this corridor.',
      ),
    ),
  ];
}
