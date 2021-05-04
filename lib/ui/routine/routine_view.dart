import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:routine/constant/darkmode_switcher.dart';
import 'package:routine/database/database_helper.dart';
import 'package:routine/models/routine_model.dart';
import 'package:routine/ui/routine/add_routine_view.dart';
import 'package:routine/ui/timer/wavetimer_view.dart';

class RoutineView extends StatefulWidget {
  @override
  _RoutineViewState createState() => _RoutineViewState();
}

class _RoutineViewState extends State<RoutineView> {
  // ignore: unused_field
  String _routineTimeString;
  DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<List<RoutineModel>> _routines;

  @override
  void initState() {
    super.initState();

    _databaseHelper.initializeDatabase().then(
      (value) {
        print('-----database initialized');
        _routines = _databaseHelper.getRoutine();
        _updateRoutineList();
      },
    );
  }

  // TODO: Implement Riverpod and remove
  _updateRoutineList() {
    setState(
      () {
        _routines = _databaseHelper.getRoutine();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    void _showAddPanel() {
      showModalBottomSheet(
        clipBehavior: Clip.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              25.0,
            ),
            topRight: Radius.circular(
              25.0,
            ),
          ),
        ),
        //
        context: context,
        builder: (context) {
          return Container(
            // color: Colors.yellow,
            padding: EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 60.0,
            ),
            child: AddRoutineView(
              updateRoutineList: _updateRoutineList,
            ),
          );
        },
      );
    }

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 64,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Routine List',
              style: Theme.of(context).textTheme.headline1,
            ),
            DarkModeSwitcher(),
            Expanded(
              child: FutureBuilder<List<RoutineModel>>(
                future: _routines,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView(
                    padding: EdgeInsets.symmetric(
                      vertical: 80.0,
                    ),

                    // return each of the alarm element (List<alarmInfo>)
                    // specify <Widget> explicively so we can use DottedBorder
                    children: snapshot.data.map<Widget>(
                      (routine) {
                        return GestureDetector(
                          onTap: () {
                            print(routine.duration.toString());
                            if (routine.duration.contains('null')) {
                              return;
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WaveTimerView(
                                    routineModel: routine,
                                  ),
                                ),
                              );
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                              bottom: 32,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            // Decoration defines the listview theme color
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Theme.of(context).cardColor,
                                  Theme.of(context).accentColor,
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFF675e35).withOpacity(
                                    0.4,
                                  ),
                                  blurRadius: 8.0,
                                  spreadRadius: 2,
                                  offset: Offset(4, 4),
                                ),
                              ],
                              borderRadius: BorderRadius.all(
                                Radius.circular(24),
                              ),
                            ),
                            // Define Row/Column element
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // create 2 rows and treat as stack so we can separate
                                // those elements
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.label,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                          SizedBox(
                                            width: 4.0,
                                          ),
                                          Flexible(
                                            child: FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                routine.description,
                                                overflow: TextOverflow.clip,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => {
                                        _databaseHelper.delete(routine.id),
                                        _updateRoutineList(),
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                    )
                                  ],
                                ),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text(
                                        'Routine: ${routine.duration} sec',
                                        style: TextStyle(
                                          color: Colors.white54,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(
                                          Icons.keyboard_arrow_right_rounded,
                                          size: 30,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ).followedBy(
                      [
                        DottedBorder(
                          strokeWidth: 3.0,
                          color: Colors.white54,
                          borderType: BorderType.RRect,
                          radius: Radius.circular(24),
                          dashPattern: [5, 6],
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Theme.of(context).buttonColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(24),
                              ),
                            ),
                            child: FlatButton(
                              onPressed: () {
                                _showAddPanel();
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    'assets/plus_button.png',
                                    scale: 1.5,
                                    color: Theme.of(context).canvasColor,
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    'Add Routine',
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
