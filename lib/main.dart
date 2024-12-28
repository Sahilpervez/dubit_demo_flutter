import 'package:flutter/material.dart';
import 'package:dubit_adapter/dubit_adapter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  // Controller for the text field
  final TextEditingController _controller = TextEditingController();

  late final Dubit dubit;

  void _fireCode() {
    print('User input: ${_controller.text}');

    dubit.onEvent.listen((event) {
      print('Received event data: ${event.label} ${event.value}');
    });

    dubit.start(webCallUrl: "https://trydubit.daily.co/h89BxTvmErJzIQbT6sjw");

    _controller.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dubit = Dubit();
    dubit.onEvent.listen((event) {
      print(
          'Received event data: \n[Label:] ${event.label} \n[Value :] ${event.value}');
    });
  }

  void _startDubit() {
    dubit.start(webCallUrl: "https://trydubit.daily.co/1MRsWKawOVCtPQDZm8ad");
    setState(() {});
  }

  void _stopDubit() {
    dubit.stop();
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // if (dubit.isJoined) {
    //   dubit.stop();
    // }
    dubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 24),
                // Text Field for input
                TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter some text',
                  ),
                ),
                const SizedBox(height: 16),
                // Button to fire the code
                ElevatedButton(
                  onPressed: () {
                    _fireCode();
                  },
                  child: const Text('Fire Code'),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: FloatingActionButton(
              onPressed: _startDubit,
              tooltip: 'Start',
              child: const Icon(Icons.play_arrow),
            ),
          ),
          FloatingActionButton(
            onPressed: _stopDubit,
            tooltip: 'Stop',
            child: const Icon(Icons.stop),
          ),
        ],
      ),
    );
  }
}
