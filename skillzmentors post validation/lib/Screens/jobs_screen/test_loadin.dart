import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() => runApp(SpinKitShowcase());

class SpinKitShowcase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SpinKitScreen(),
    );
  }
}

class SpinKitScreen extends StatelessWidget {
  final List<Map<String, dynamic>> animations = [
    // Circular Animations
    {
      'name': 'SpinKitCircle',
      'widget': SpinKitCircle(color: Colors.blue, size: 50.0)
    },
    {
      'name': 'SpinKitDualRing',
      'widget': SpinKitDualRing(color: Colors.red, size: 50.0)
    },
    {
      'name': 'SpinKitRipple',
      'widget': SpinKitRipple(color: Colors.green, size: 80.0)
    },
    {
      'name': 'SpinKitRing',
      'widget': SpinKitRing(color: Colors.orange, size: 60.0)
    },
    {
      'name': 'SpinKitPulse',
      'widget': SpinKitPulse(color: Colors.purple, size: 70.0)
    },

    {
      'name': 'SpinKitThreeBounce',
      'widget': SpinKitThreeBounce(color: Colors.blueGrey, size: 25.0)
    },
    {
      'name': 'SpinKitFadingFour',
      'widget': SpinKitFadingFour(color: Colors.cyan, size: 40.0)
    },
    {
      'name': 'SpinKitFadingGrid',
      'widget': SpinKitFadingGrid(color: Colors.teal, size: 60.0)
    },
    {
      'name': 'SpinKitWave',
      'widget': SpinKitWave(
          color: Colors.indigo, size: 50.0, type: SpinKitWaveType.start),
    },

    // Rotating Animations
    {
      'name': 'SpinKitRotatingCircle',
      'widget': SpinKitRotatingCircle(color: Colors.pink, size: 50.0)
    },
    {
      'name': 'SpinKitRotatingPlain',
      'widget': SpinKitRotatingPlain(color: Colors.amber, size: 50.0)
    },

    // Cube Animations
    {
      'name': 'SpinKitFadingCube',
      'widget': SpinKitFadingCube(color: Colors.deepOrange, size: 40.0)
    },
    {
      'name': 'SpinKitCubeGrid',
      'widget': SpinKitCubeGrid(color: Colors.deepPurple, size: 60.0)
    },
    {
      'name': 'SpinKitWanderingCubes',
      'widget': SpinKitWanderingCubes(color: Colors.blueAccent, size: 50.0)
    },

    // Unique Animations
    {
      'name': 'SpinKitChasingDots',
      'widget': SpinKitChasingDots(color: Colors.lime, size: 50.0)
    },
    {
      'name': 'SpinKitHourGlass',
      'widget': SpinKitHourGlass(color: Colors.brown, size: 60.0)
    },
    {
      'name': 'SpinKitPouringHourGlass',
      'widget': SpinKitPouringHourGlass(color: Colors.black, size: 60.0)
    },
    {
      'name': 'SpinKitPumpingHeart',
      'widget': SpinKitPumpingHeart(color: Colors.red, size: 80.0)
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SpinKit Animation Showcase'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        itemCount: animations.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    animations[index]['name'],
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10.0),
                  animations[index]['widget'], // Display the SpinKit animation
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


