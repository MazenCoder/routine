import 'package:routine/models/enums.dart';
import 'package:routine/provider/menu_info.dart';

// data.dartに追加すると実際のUIに反映される
// tenporary data to get UI Image

List<MenuInfo> menuItems = [
  MenuInfo(MenuType.clock, title: 'Clock', imageSource: 'assets/clock.png'),
  MenuInfo(MenuType.routine,
      title: 'Routine', imageSource: 'assets/coffee.png'),
];
