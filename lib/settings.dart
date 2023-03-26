import 'package:flutter/material.dart';
import 'package:iotproject/provider/block_provider.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final TextEditingController _socketURLController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    BlocProvider.of(context).settingsBloc.addListener(() {
      setState(() {});
    });

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              children: [
                const Text(
                  "Current server address:",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  BlocProvider.of(context).settingsBloc.socketURL,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            TextButton.icon(
              label: const Text(
                "Reset",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              icon: const Icon(Icons.refresh),
              onPressed: () {
                BlocProvider.of(context).settingsBloc.resetSocketURL();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        TextField(
          controller: _socketURLController,
          // text field to change the socket URL
          decoration: const InputDecoration(
            hintText: "Enter new server address",
          ),
        ),
        TextButton.icon(
          icon: const Icon(Icons.save),
          onPressed: () {
            BlocProvider.of(context).settingsBloc.setSocketURL(_socketURLController.text);
          },
          label: const Text("Save"),
        ),
      ],
    );
  }
}
