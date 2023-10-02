// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:for_testing_purpose/provider_class.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/intl.dart';
import 'CitiesList.dart';
import 'Get_Time_Controller.dart';

void main() {
  tz.initializeTimeZones();
  runApp(const MyApp2());
}

class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
    MultiProvider(providers: [
        ChangeNotifierProvider(create:(context) => CounterProvider()),
      ChangeNotifierProvider(create:(context) => timerProvider()),


    ], child:  MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter Demo',
    // we are using dark theme and we modify it as our need

    home:TimerProvider(),

    // MyApp2()
    ));


  }
}

class Counter extends StatefulWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CounterProvider>(context);
    return Scaffold(body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('${provider.count}'),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(onPressed:(){
          provider.increment();
        }, child: const Text('Push Counter'))
      ],
    ));
  }
}
 class TimerProvider extends StatefulWidget {
   const TimerProvider({Key? key}) : super(key: key);

   @override
   State<TimerProvider> createState() => _TimerProviderState();
 }

 class _TimerProviderState extends State<TimerProvider> {
   @override
   Widget build(BuildContext context) {
     final provider = Provider.of<timerProvider>(context);

     return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
               'Time: ${provider.countdown.toString()} Seconds',
               style: const TextStyle(
                 fontSize: 20,
                 fontWeight: FontWeight.w500,
               ),
             ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onPressed: provider.isActive
                  ?  provider.stop
                  : provider.startCountdown,
              child: Text( provider.isActive ? 'Stop' : 'Start'),
            ),
          ],
        )
     );
   }
 }









class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ForTimezone(),
    );
  }
}

class ForTimezone extends StatefulWidget {
  const ForTimezone({Key? key}) : super(key: key);

  @override
  State<ForTimezone> createState() => _ForTimezoneState();
}

class _ForTimezoneState extends State<ForTimezone> {
  CitiesUrls setTime = Get.put(CitiesUrls());
  DateTime? time;
  Timer? _timer;
  String? formattedTime;
  dynamic citiesUrl = {
    'Berlin': 'Europe/London',
    'Athens': 'America/Chicago',
    'Cairo': 'Europe/Berlin',
    'Nairobi': 'Africa/Cairo',
    'Chicago': 'Africa/Nairobi',
    'New York': 'America/New_York',
    'Seoul': 'Asia/Seoul',
    'Jakarta': 'Asia/Jakarta'
  };
  var data = Get.arguments;

  var forTime = true;
  @override
  void initState() {
    setup();
    super.initState();
    // Start a timer to update the time every 1 minute (you can adjust the duration as needed)
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      log('initState');

      setState(() {}); // Trigger a rebuild of the widget to update the time
    });
  }

  Future<void> setup() async {
    tz.initializeTimeZones();
    var istanbulTimeZone = tz.getLocation(citiesUrl[data]);
    time = tz.TZDateTime.now(istanbulTimeZone);
    formattedTime = DateFormat.Hms().format(time!);
    print('$formattedTime This is the Time');
    // time = DateFormat.jm().format(time);
    setTime.time.add(formattedTime);
  }

  @override
  Widget build(BuildContext context) {
    print('$data ======?');
    print('${setTime.time} This is time');
    print('${time} =====Time ');

    var mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, right: 10),
              child: Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                    onPressed: () {
                      Get.to(const CitiesList());
                    },
                    child: const Text('ADD')),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            if (forTime)
              SingleChildScrollView(
                child: ListView.builder(
                    key: UniqueKey(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: setTime.urls.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          SizedBox(
                            height: mediaQuery.size.height / 12,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Obx(
                                    () => Text(
                                      '${setTime.urls[index]}',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Obx(
                                    () => (Text('${setTime.time[index]}',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold))),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Divider(
                            thickness: 2,
                          ),
                        ],
                      );
                    }),
              )
            else
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  'add your city whose which you want  see time...',
                  style: GoogleFonts.montserrat(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            Center(
              child: ElevatedButton(
                  onPressed: () async {
                    dynamic locations = tz.timeZoneDatabase.locations;
                    dynamic timeZone = await tz.getLocation(locations);
                    log(' $timeZone This is called');

                    // setup();
                  },
                  child: const Text('ADD')),
            ),
          ],
        ),
      ),
    );
  }
}
