import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:developer' as dev;

typedef VoidCallback = void Function();

class GeolocatorHandler {
  Position? _currentPosition;
  PermissionStatus? _permissionStatus;
  bool _isLocationEnabled = false;
  final VoidCallback _afterInitCallBack;


  Position? get currentPosition => _currentPosition;
  PermissionStatus? get permissionStatus => _permissionStatus;
  bool get isLocationEnabled => _isLocationEnabled;

  GeolocatorHandler(VoidCallback afterInitCallBack) : _afterInitCallBack = afterInitCallBack {
    dev.log("GeolocatorHandler constructor");
    try {
      _determinePosition().then((value) => { 
        _currentPosition = value,
        _afterInitCallBack()
      });
    } catch(e) {
      dev.log("GeohandlerInitError : ${e.toString()}");
    }
  }

  Future<PermissionStatus> getPermission() async {
    return await Permission.location.status;
  }

  String showPosition() {
    if (_currentPosition != null) {
      Position position = _currentPosition!;
      return "lat : ${position.latitude} , lon : ${position.longitude}";
    }
    return "";
  }

  // Public ---------------------------------------------------------

  void determinePosition() async {
    try {
      _currentPosition = await _determinePosition();
    } catch (e) {
        dev.log("GeohandlerError : ${e.toString()}");
    }
  }


  // Private ---------------------------------------------------------
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    PermissionStatus permission;
    // LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Permission.location.status;
    if (permission == PermissionStatus.denied) {
      permission = await Permission.location.request();
      if (permission == PermissionStatus.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == PermissionStatus.permanentlyDenied) {
      return Future.error('Location permissions permanently denied.');
    }
    
    _permissionStatus = permission;
    _isLocationEnabled = permission == PermissionStatus.granted;
    _afterInitCallBack();

    return await Geolocator.getCurrentPosition();
  }

}