import 'package:flutter/cupertino.dart';

import 'enums_device.dart';

DeviceType getDeviceTyp(MediaQueryData mediaQueryData) {
  Orientation orientation = mediaQueryData.orientation;
  double width = 0;
  if (orientation == Orientation.landscape) {
    width = mediaQueryData.size.height;
  } else {
    width = mediaQueryData.size.width;
  }

  if (width >= 950) {
    return DeviceType.web;
  } else if (width >= 600) {
    return DeviceType.tablet;
  }
  return DeviceType.mobile;
}
