import 'package:flutter/material.dart';

enum DeviceType { mobile, tablet, desktop, ultraWide }

DeviceType getDeviceType(double width) {
  if (width >= 1440) return DeviceType.ultraWide;
  if (width >= 1024) return DeviceType.desktop;
  if (width >= 600) return DeviceType.tablet;
  return DeviceType.mobile;
}

class ResponsiveBuilder extends StatelessWidget {
  final WidgetBuilder mobile;
  final WidgetBuilder? tablet;
  final WidgetBuilder? desktop;
  final WidgetBuilder? ultraWide;

  const ResponsiveBuilder({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
    this.ultraWide,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final deviceType = getDeviceType(width);

    switch (deviceType) {
      case DeviceType.ultraWide:
        if (ultraWide != null) return ultraWide!(context);
        continue desktop;
      desktop:
      case DeviceType.desktop:
        if (desktop != null) return desktop!(context);
        continue tablet;
      tablet:
      case DeviceType.tablet:
        if (tablet != null) return tablet!(context);
        continue mobile;
      mobile:
      case DeviceType.mobile:
        return mobile(context);
    }
  }
}
