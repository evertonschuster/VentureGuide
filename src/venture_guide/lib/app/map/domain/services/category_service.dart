import 'package:injectable/injectable.dart';
import 'package:venture_guide/app/map/domain/models/category.dart';

abstract class CategoryService {
  String getIcon(String id);
}

@Singleton(as: CategoryService)
class CategoryServiceImpl implements CategoryService {
  final List<Category> _categories = [
    Category(
      name: 'Checkpoint',
      icon: 'lib/assets/images/icons/checkpoint.png',
      id: 'Ua0d247KNGnasVzwzSo1',
    ),
    Category(
      name: 'Consulate / Embassy',
      icon: 'lib/assets/images/icons/consulate.png',
      id: 'On1GXxCtkIWkM53jtbYg',
    ),
    Category(
      name: 'Customs and Immigration',
      icon: 'lib/assets/images/icons/border.png',
      id: 'EUQHDgRN8k6bBE0ydnAV',
    ),
    Category(
      name: 'Eco-Friendly',
      icon: 'lib/assets/images/icons/eco-friendly.png',
      id: 'm1OMARG1bJDUtGXRRwno',
    ),
    Category(
      name: 'Established Campground',
      icon: 'lib/assets/images/icons/camping.png',
      id: 'G2ki3RgIHI8CYIhb8hxg',
    ),
    Category(
      name: 'Financial',
      icon: 'lib/assets/images/icons/financial.png',
      id: 'hmLsMDN5UDRCxbcZmL2p',
    ),
    Category(
      name: 'Fuel Station',
      icon: 'lib/assets/images/icons/fuel-station.png',
      id: 'BZexaEx2kXEY94xNMDSs',
    ),
    Category(
      name: 'Hostel',
      icon: 'lib/assets/images/icons/hostel.png',
      id: '3UGO0s5XDqbiANvUbzxq',
    ),
    Category(
      name: 'Hotel',
      icon: 'lib/assets/images/icons/hotel.png',
      id: '3VshoPcnyAuETahEybGl',
    ),
    Category(
      name: 'Informal Campsite',
      icon: 'lib/assets/images/icons/informal-camp.png',
      id: 'qBi7FuoWE4fGP5a7nrzy',
    ),
    Category(
      name: 'Laundromat',
      icon: 'lib/assets/images/icons/laundry.png',
      id: 'RxbgVwe7lUbDgbAJF7n8',
    ),
    Category(
      name: 'Mechanic and Parts',
      icon: 'lib/assets/images/icons/mechanic.png',
      id: 'KYCUmJzw3Lo5iGukDSIa',
    ),
    Category(
      name: 'Medical',
      icon: 'lib/assets/images/icons/medical.png',
      id: '1zUO03kQ2R4WTCJM7dhG',
    ),
    Category(
      name: 'Other',
      icon: 'lib/assets/images/icons/other.png',
      id: 'sA87m1roS4mWFMoO7uUk',
    ),
    Category(
      name: 'Pet Services',
      icon: 'lib/assets/images/icons/pet-services.png',
      id: 'YLTXtz5vVAa0FZYWaIX6',
    ),
    Category(
      name: 'Propane',
      icon: 'lib/assets/images/icons/propane.png',
      id: 'zjsrVADQVDzWQYBNQtKM',
    ),
    Category(
      name: 'Restaurant',
      icon: 'lib/assets/images/icons/restaurant.png',
      id: 'P1RHUti8NSK1qCPYGPSb',
    ),
    Category(
      name: 'Sanitation Dump Station',
      icon: 'lib/assets/images/icons/sanitation.png',
      id: 'gNNdLoes8EgbZvA2drtU',
    ),
    Category(
      name: 'Shopping',
      icon: 'lib/assets/images/icons/shopping.png',
      id: 'iY1I9mqYfsFuO05Qlp0q',
    ),
    Category(
      name: 'Short-term Parking',
      icon: 'lib/assets/images/icons/shortterm-parking.png',
      id: 'PiOPj1WgmEE9PDeGIUnI',
    ),
    Category(
      name: 'Showers',
      icon: 'lib/assets/images/icons/showers.png',
      id: 'GumSqKCQLVQmiB3EsWZd',
    ),
    Category(
      name: 'Tourist Attraction',
      icon: 'lib/assets/images/icons/tourist.png',
      id: 'wJNvzTX0reZADmYG4RtR',
    ),
    Category(
      name: 'Vehicle Insurance',
      icon: 'lib/assets/images/icons/vehicle-insurance.png',
      id: 'EQqeFbc3tvCZ1Amxce08',
    ),
    Category(
      name: 'Vehicle Shipping',
      icon: 'lib/assets/images/icons/vehicle-shipping.png',
      id: '3gRZyc6JJOgcm3JRZONk',
    ),
    Category(
      name: 'Vehicle Storage',
      icon: 'lib/assets/images/icons/vehicle-storage.png',
      id: '95EsyAZRB3hmX3BdAWkM',
    ),
    Category(
      name: 'Warning',
      icon: 'lib/assets/images/icons/warning.png',
      id: 'sJjWuJw6fN9k11eaSXFW',
    ),
    Category(
      name: 'Water',
      icon: 'lib/assets/images/icons/water.png',
      id: 'pd3enOIaXeX2VYafXXyJ',
    ),
    Category(
      name: 'Wifi',
      icon: 'lib/assets/images/icons/wifi.png',
      id: 'tTUBncZGzaCiszCxlW18',
    ),
    Category(
      name: 'Wild Camping',
      icon: 'lib/assets/images/icons/wild-camp.png',
      id: 'ktaMdt10rNdeg8jaf9Wy',
    )
  ];
  
  @override
  String getIcon(String id) {
    return _categories.where((element) => element.id == id).first.icon ?? '';
  }
}
