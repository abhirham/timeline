import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:timeline/constants.dart';
import 'package:timeline/data/settings.dart';
import 'package:timeline/screens/draggable_screen.dart';
import 'package:timeline/widgets/customSwitchListTile.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  static const String id = "settingsScreen";

  final ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeeeeee),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Settings',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: <Widget>[
          Section(
            heading: 'WALLPAPER',
            children: <Widget>[
              GestureDetector(
                onTap: () async {
                  PickedFile pickedImage =
                      await imagePicker.getImage(source: ImageSource.gallery);
                  if (pickedImage == null) return;
                  context.read<Settings>().setScreenShot(pickedImage.path);
                },
                child: CustomListTile(
                  center: Text('Set Screenshot'),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  PickedFile pickedImage =
                      await imagePicker.getImage(source: ImageSource.gallery);
                  if (pickedImage == null) return;
                  context
                      .read<Settings>()
                      .setClockDownScreenShot(pickedImage.path);
                },
                child: CustomListTile(
                  center: Text('Set Clock Down Screenshot'),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(DraggableScreen.id);
                },
                child: CustomListTile(
                  center: Text('Set Time Display Area'),
                ),
              )
            ],
          ),
          Section(
            heading: 'CONFIG',
            children: <Widget>[
              CustomSwitchListTile(
                title: 'Use Input Screen',
                onChanged: (bool val) {
                  context.read<Settings>().setUseInputScreen(val);
                },
                value: context.watch<Settings>().useInputScreen,
              ),
              CustomSwitchListTile(
                title: 'Hide Input Screen',
                onChanged: context.watch<Settings>().useInputScreen
                    ? (bool) {
                        context.read<Settings>().setHideInputScreen(bool);
                      }
                    : null,
                value: context.watch<Settings>().hideInputScreen,
              ),
              CustomListTile(
                leading: Text('Time Travel'),
                trailing: CupertinoSegmentedControl(
                  borderColor: kCupertinoSegmentedControlColor,
                  selectedColor: kCupertinoSegmentedControlColor,
                  onValueChanged: (val) {
                    context.read<Settings>().setMode(val);
                  },
                  groupValue: context.watch<Settings>().mode,
                  children: {
                    timeTravel.Backward: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text("Backwards"),
                    ),
                    timeTravel.Forward: Text('Forwards'),
                  },
                ),
              )
            ],
          ),
          CustomListTile(
            leading: Text('Add Extra Minutes'),
            trailing: SizedBox(
              width: 30.0,
              child: TextField(
//                controller: TextEditingController()
//                  ..text = context.read<Settings>().extraMins,
                onChanged: (val) {
                  print(val);
                  context.read<Settings>().setExtraMins(val);
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                cursorColor: kCupertinoSegmentedControlColor,
                textAlign: TextAlign.right,
                keyboardType: TextInputType.number,
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
            child: Text('Add an additional number of minutes to the total.'),
          ),
        ],
      ),
    );
  }
}

class Section extends StatelessWidget {
  final String heading;
  final List<Widget> children;

  Section({@required this.heading, @required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                child: Text(heading),
              ),
            ] +
            children,
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final Widget center, leading, trailing;

  CustomListTile({this.center, this.leading, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListTile(
        title: Center(child: center),
        leading: leading,
        trailing: trailing,
      ),
    );
  }
}
