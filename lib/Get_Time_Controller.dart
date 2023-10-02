import 'package:get/get.dart';

class CitiesUrls extends GetxController{
  dynamic citiesUrl = {
    'Berlin':'Europe/London',
    'Athens':'America/Chicago',
    'Cairo':'Europe/Berlin',
    'Nairobi':'Africa/Cairo',
    'Chicago':'Africa/Nairobi',
    'New York':'America/New_York',
    'Seoul':'Asia/Seoul',
    'Jakarta':'Asia/Jakarta'
  };
  dynamic urls = [].obs;
  dynamic time = [].obs;

}