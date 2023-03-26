import 'package:flutter/material.dart';
import 'package:iotproject/provider/block_provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
            Text(
              BlocProvider.of(context).settingsBloc.connected ? "CONNECTED" : "DISCONNECTED",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: BlocProvider.of(context).settingsBloc.connected ? Colors.green : Colors.red,
              ),
            ),
            TextButton.icon(
              label: const Text("Retry"),
              onPressed: () {
                BlocProvider.of(context).settingsBloc.connect();
              },
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                  icon: const Icon(Icons.timer),
                  onPressed: () {
                    BlocProvider.of(context).settingsBloc.feedIn3Hours();
                  },
                  label: const Text("3H"),
                  style: TextButton.styleFrom(
                    backgroundColor: BlocProvider.of(context).settingsBloc.feedingInterval == 3 ? Colors.orange : Colors.transparent,
                    foregroundColor: BlocProvider.of(context).settingsBloc.feedingInterval == 3 ? Colors.white : Colors.orange,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                      ),
                      side: BorderSide(color: Colors.orange, width: 0.5),
                    ),
                  ),
                ),
                TextButton.icon(
                  icon: const Icon(Icons.timer),
                  onPressed: () {
                    BlocProvider.of(context).settingsBloc.feedIn6Hours();
                  },
                  label: const Text("6H"),
                  style: TextButton.styleFrom(
                    backgroundColor: BlocProvider.of(context).settingsBloc.feedingInterval == 6 ? Colors.orange : Colors.transparent,
                    foregroundColor: BlocProvider.of(context).settingsBloc.feedingInterval == 6 ? Colors.white : Colors.orange,
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.orange, width: 0.5),
                    ),
                  ),
                ),
                TextButton.icon(
                  icon: const Icon(Icons.timer),
                  onPressed: () {
                    BlocProvider.of(context).settingsBloc.feedIn12Hours();
                  },
                  label: const Text("12H"),
                  style: TextButton.styleFrom(
                    backgroundColor: BlocProvider.of(context).settingsBloc.feedingInterval == 12 ? Colors.orange : Colors.transparent,
                    foregroundColor: BlocProvider.of(context).settingsBloc.feedingInterval == 12 ? Colors.white : Colors.orange,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                      side: BorderSide(color: Colors.orange, width: 0.5),
                    ),
                  ),
                ),
              ],
            ),
            TextButton.icon(
              icon: const Icon(Icons.food_bank),
              onPressed: () {
                BlocProvider.of(context).settingsBloc.feedNow();
              },
              label: const Text("FEED NOW"),
            ),
          ],
        ),
      ],
    );
  }
}
