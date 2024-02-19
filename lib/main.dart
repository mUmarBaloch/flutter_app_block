import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter With Method Channel (kotlin)',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter With Method Channel (kotlin)'),
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

  final _platformBatteryPercentage  = MethodChannel('com.flutter.batteryPercentage');
  int batteryPercentage = 0;
getBatteryPercentage()async{
   final _batteryPercentage = await  _platformBatteryPercentage.invokeMethod('getBatteryPercentage');
  batteryPercentage =  _batteryPercentage;
  setState(() {
    
  });
}
  @override
  void initState() {
 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: getBatteryPercentage,child:Text('refresh')),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title,style: TextStyle(fontSize: 14),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              'your battery is $batteryPercentage %',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    
    );
  }
}
