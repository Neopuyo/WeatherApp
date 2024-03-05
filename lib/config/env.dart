import 'package:envied/envied.dart';
part 'env.g.dart';

@Envied(path: '.env')
abstract class Env{
  @EnviedField(varName: 'WEATHER_ORG_API_KEY',obfuscate: true)
  static String weatherOrgApiKey =_Env.weatherOrgApiKey; 

}