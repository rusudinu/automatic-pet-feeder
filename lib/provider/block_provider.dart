import 'package:flutter/cupertino.dart';
import 'package:iotproject/blocs/settings_bloc.dart';


class BlocProvider extends InheritedWidget {
  final SettingsBloc settingsBloc;

  BlocProvider({Key? key, required Widget child, SettingsBloc? setBloc})
      : settingsBloc = setBloc ?? SettingsBloc(),
        super(key: key, child: child) {
    settingsBloc.init();
  }

  @override
  bool updateShouldNotify(BlocProvider oldWidget) => true;

  static of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<BlocProvider>();
}
