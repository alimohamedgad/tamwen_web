// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:tamwen_web/Featurs/Core/Responsive/Device/device_function.dart';
import 'package:tamwen_web/Featurs/Core/Responsive/Device/device_model.dart';

class InfoWidget extends StatelessWidget {
  final Function(BuildContext context, DeviceInfoModel deviceInfo) widgetInfo;
  const InfoWidget({
    Key? key,
    required this.widgetInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        var mediaQuaryData = MediaQuery.of(context);
        var deviceInfo = DeviceInfoModel(
          orientation: mediaQuaryData.orientation,
          deviceType: getDeviceTyp(mediaQuaryData),
          localHigh: constraints.maxHeight,
          localWith: constraints.maxWidth,
          screenHight: mediaQuaryData.size.height,
          screenWith: mediaQuaryData.size.width,
        );

        return widgetInfo(context, deviceInfo);
      },
    );
  }
}
