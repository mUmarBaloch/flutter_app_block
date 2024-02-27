import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter With Method Channel (kotlin)',
      theme: ThemeData
      
      (

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),

        useMaterial3: true,

      )
      
      ,
      
      home: const MyHomePage
      (
        title
        :
        'Flutter With Method Channel (kotlin)'),

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

  final _platformBatteryPercentage  = const MethodChannel('samples.flutter.dev/battery');
  final _platformBatteryCharging = const MethodChannel('samples.flutter.dev/batteryCharging');
  int batteryPercentage = 0;
  bool isCharging = false;
  getIsCharging()async {
    final isBatteryCharging = await _platformBatteryCharging.invokeMethod('getIsCharging');
    isCharging = isBatteryCharging;
    setState((){});
  }
getBatteryPercentage()async{
   final batteryLevel = await  _platformBatteryPercentage.invokeMethod('getBatteryLevel');
  batteryPercentage =  batteryLevel;
  setState(() {
    
  });
}
late Timer timer;
  @override
  void initState() {
  
   timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {getIsCharging(); });
    super.initState();
  }

    @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed:(){ 
        getBatteryPercentage();
        getIsCharging();
        print(getIsCharging());
        },child:const Text('refresh')),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title,style:const TextStyle(fontSize: 14),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           
            Text(
              'your battery is $batteryPercentage %',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
           const SizedBox(height: 10,),
           if(isCharging==true)
           ...
           [
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(image:  DecorationImage(image:
               NetworkImage('https://assets.awwwards.com/awards/external/2016/11/583eaee9a9f15.gif'),
               )),
            ),]
          ],
        ),
      ),
    );
  }
}
