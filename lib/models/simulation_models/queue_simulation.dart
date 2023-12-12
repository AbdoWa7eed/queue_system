import 'dart:collection';
import 'dart:math' as math;

import 'package:queue_system/models/point.dart';

abstract class QueueSimulation {
  final double lambda; // arrival rate
  final double mu; // service rate
  int numInSystem = 0;
  int numArrival = 0;
  int numDeparture = 0;
  int numSimulation;
  double totalWait = 0;
  double waitInSystem = 0;
  List<double> nextArrival = [];
  List<double> nextDeparture = [];
  double clock = 0;
  final List<Point> points = [];
  final Queue<double> queue = Queue<double>();
  QueueSimulation(
      {required this.lambda, required this.mu, required this.numSimulation});

  void runSimulation();

  void handleArrivalEvent();

  void handleDepartureEvent({int serverIndex});

  double randomExp(double value) {
    return -math.log(1 - math.Random().nextDouble()) / value;
  }
}
