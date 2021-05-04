import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:routine/database/database_helper.dart';
import 'package:routine/models/routine_model.dart';

class AddRoutineView extends StatefulWidget {
  final Function updateRoutineList;

  const AddRoutineView({Key key, this.updateRoutineList}) : super(key: key);
  @override
  _AddRoutineViewState createState() => _AddRoutineViewState();
}

class _AddRoutineViewState extends State<AddRoutineView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String description;
  String time;
  DatabaseHelper _databaseHelper = DatabaseHelper();
  final myController = TextEditingController();
  bool _validate = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myController.addListener(_assignValue);
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  void _assignValue() {
    description = myController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(
              'Add New Routine',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              height: 50,
              child: TextFormField(
                controller: myController,
                style: TextStyle(fontSize: 19.0),
                decoration: InputDecoration(
                  errorText: _validate ? 'Please enter something special' : null,
                  labelText: 'Title',
                  labelStyle: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ),
                  ),
                ),
                validator: (input) => input.trim().isEmpty ? '' : null,
                onSaved: (input) =>
                    (input != null) ? description = input : description = 'Snoopy',
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 12),
              height: 130,
              child: CupertinoTimerPicker(
                mode: CupertinoTimerPickerMode.ms,
                onTimerDurationChanged: (value) {
                  print(value);
                  print(description);
                  setState(
                    () {
                      time = value
                          .toString()
                          .substring(2, 7)
                          .replaceFirst(':', " min ")
                          .replaceAll(":", "")
                          .trimRight();
                    },
                  );
                  print(time);
                },
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              color: Colors.black54,
              onPressed: () async {
                setState(() {
                  myController.text.trim().isEmpty
                      ? _validate = false
                      : _validate = false;
                });
                // TODO:  insert to the DB
                var routinInfo = RoutineModel(
                  description:
                      (description != null) ? description : 'Brew Coffee!',
                  duration: time,
                );
                _databaseHelper.insertRoutine(routinInfo);
                widget.updateRoutineList();

                Navigator.pop(context);
              },
              child: Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
