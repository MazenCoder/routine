import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:intl/intl.dart';
import 'package:routine/models/enums.dart';
import 'package:routine/models/menubutton.dart';
import 'package:routine/provider/menu_info.dart';
import 'package:routine/ui/component/clock.dart';
import 'package:routine/ui/component/menu_button.dart';
import 'package:routine/ui/routine/routine_view.dart';

class ClockView extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final menuinfoProvider = useProvider(currentMenuInfoProvider);
    final _numberNotifier = useState(0);
    useEffect(() {
      final timer = Timer.periodic(Duration(seconds: 1), (time) {
        _numberNotifier.value = time.tick;
      });
      return timer.cancel;
    });
    // TODO: Create model class of times
    var currentTime = DateTime.now();
    var formattedTime = DateFormat('HH:mm').format(currentTime);
    var formattedDate = DateFormat('EEE, d MMM').format(currentTime);
    var timezoneAsString =
        currentTime.timeZoneOffset.toString().split('.').first;

    if (timezoneAsString.startsWith('-')) {
      timezoneAsString = timezoneAsString.substring(0, 5);
    } else {
      timezoneAsString = timezoneAsString.substring(0, 4);
      timezoneAsString = "+" + timezoneAsString;
    }

    //   return Scaffold(
    //     body: SafeArea(
    //       // This row builds the menu bar UI and clock UI
    //       // Each element are separated by Vertical Divider
    //       child: Row(
    //         children: <Widget>[
    //           Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             // get each element by mapping and convert it into list and
    //             // use as each element in the children tree
    //             children: menuItems
    //                 .map((currentMenuInfo) => MenuButton(currentMenuInfo))
    //                 .toList(),
    //           ),
    //           VerticalDivider(
    //             color: Colors.white54,
    //             width: 1,
    //           ),
    //           Expanded(
    //             child: bodyChoice(menuinfoProvider, context, formattedTime,
    //                 formattedDate, timezoneAsString),
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
    // }

    // Widget bodyChoice(MenuInfo menuInfoProvider, BuildContext context,
    //     String formattedTime, String formattedDate, String timezoneAsString) {
    //   if (menuInfoProvider.menuType == MenuType.routine) {
    //     return RoutineView();
    //   } else {
    return Container(
      padding: EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            flex: 2,
            fit: FlexFit.loose,
            child: Text(
              formattedDate,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Flexible(
            flex: 4,
            child: Column(
              children: <Widget>[
                Text(
                  formattedTime,
                  style: Theme.of(context).textTheme.headline2,
                ),
                // SizedBox(
                //   height: 16.0,
                // ),
                // Column(
                //   children: [
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Icon(
                //           Icons.wrong_location,
                //           color: Colors.white54,
                //           size: 17.0,
                //         ),
                //         SizedBox(
                //           width: 5.0,
                //         ),
                //         Text(
                //           'Timezone: UTC ' + timezoneAsString,
                //           style: Theme.of(context).textTheme.headline3,
                //         ),
                //       ],
                //     ),
                //     SizedBox(
                //       height: 3.0,
                //     ),
                //   ],
                // ),
                Flexible(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.center,
                    child: ClockPaint(
                      size: MediaQuery.of(context).size.height,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
