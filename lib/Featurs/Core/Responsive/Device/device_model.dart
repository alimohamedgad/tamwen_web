import 'package:flutter/cupertino.dart';
import 'package:tamwen_web/Featurs/Core/Responsive/Device/enums_device.dart';

class DeviceInfoModel {
  final Orientation? orientation;
  final DeviceType? deviceType;
  final double? screenWith;
  final double? screenHight;
  final double? localWith;
  final double? localHigh;

  DeviceInfoModel({
    this.orientation,
    this.deviceType,
    this.screenWith,
    this.screenHight,
    this.localWith,
    this.localHigh,
  });
}
