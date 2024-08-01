import 'package:rive/rive.dart';

class RiveUtils {
  static StateMachineController getRiveController(Artboard artboard,
      {stateMachineName = "State Machine 1"}) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, stateMachineName);
     if (controller != null) {
      artboard.addController(controller);
    } else {
      print('Available state machines: ${artboard.stateMachines.map((sm) => sm.name).join(', ')}');

      throw Exception('StateMachineController not found for stateMachineName: $stateMachineName');
    }
    return controller;
  }
}
