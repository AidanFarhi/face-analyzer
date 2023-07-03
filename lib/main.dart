// import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

// late List<CameraDescription> _cameras;
// late CameraDescription frontCamera;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // _cameras = await availableCameras();
  // frontCamera =
  //     _cameras.firstWhere((c) => c.lensDirection == CameraLensDirection.front);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _AppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData.dark(
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}

class _AppState extends ChangeNotifier {
  Widget currentView = const HomeView();
  void updateView(Widget newView) {
    currentView = newView;
    notifyListeners();
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<_AppState>();
    return Scaffold(body: appState.currentView);
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<_AppState>();
    return Column(
      children: [
        SizedBox(
          height: (MediaQuery.of(context).size.height / 10) * 8.5, // 85%
          child: const Center(
            child: Text('Welcome to the app!'),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ElevatedButton(
            onPressed: () {
              appState.updateView(const SizedBox(
                height: 400,
                child: Text('hello'),
              ));
            },
            child: const Text('Get started'),
          ),
        ),
      ],
    );
  }
}

// class _AppState extends State<App> {
//   late CameraController controller;
//   @override
//   void initState() {
//     super.initState();
//     controller = CameraController(frontCamera, ResolutionPreset.max);
//     controller.initialize().then((_) {
//       if (!mounted) {
//         return;
//       }
//       setState(() {});
//     }).catchError((Object e) {
//       if (e is CameraException) {
//         switch (e.code) {
//           case 'CameraAccessDenied':
//             // Handle access errors here.
//             break;
//           default:
//             // Handle other errors here.
//             break;
//         }
//       }
//     });
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (!controller.value.isInitialized) {
//       return Container();
//     }
//     return MaterialApp(
//       home: CameraPreview(controller),
//     );
//   }
// }
