import 'package:clima/services/networking.dart';

import 'location.dart';

const baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
const apiKey = '2ea6d269cc08b3c6d92ac0fb82429a24';

class WeatherModel {
  Future<dynamic> getWeatherCity(String cityName) async {
    String url = '$baseUrl?q=$cityName&appid=$apiKey&units=metric';

    var weatherData = await NetworkHelper(url).getData();

    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    var location = Location();
    await location.getLocation();

    String url =
        '$baseUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric';

    var weatherData = await NetworkHelper(url).getData();

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
