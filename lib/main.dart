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
  
   timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {getIsCharging();getBatteryPercentage(); });
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
    
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
        
          Stack(
            alignment: Alignment.center,
            children: [
           
               if(isCharging==true)
           ...
           [
            Container(
              margin: EdgeInsets.only(top:140),
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
               
                image:  DecorationImage(
                
                image:
               NetworkImage('https://assets.awwwards.com/awards/external/2016/11/583eaee9a9f15.gif'),
               )),
            ),],
                 Text(
                   ' $batteryPercentage %',
                   style: const TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
                 
                 ),
            ],
          ),
          
          ],
        ),
      ),
    );
  }
}
