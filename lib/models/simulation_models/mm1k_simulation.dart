import 'dart:collection';
import 'package:queue_system/models/point.dart';
import 'package:queue_system/models/simulation_models/queue_simulation.dart';

class MM1KSimulation extends QueueSimulation {
 final int capacity;

  MM1KSimulation({
    required double lambda,
    required double mu,
    required int numSimulation,
    required this.capacity,
  }) : super(lambda: lambda, mu: mu, numSimulation: numSimulation);

  @override
  void runSimulation() {
    print("Serial , Clock , Event , #Arrival , #Departure , #InSystem , Wait");
    nextArrival.add(0);
    nextDeparture.add(double.infinity);
    for (int i = 1; i <= numSimulation; i++) {
      // it's an arrival
      if (nextArrival[0] <= nextDeparture[0]) {
        clock = nextArrival[0];
        handleArrivalEvent();
        points.add(Point(x: clock, y: numInSystem.toDouble()));
        print(
            "$i , $clock , Arrival , $numArrival , $numDeparture , $numInSystem , none");
      } // it's a departure
      else {
        clock = nextDeparture[0];
        handleDepartureEvent();
        points.add(Point(x: clock, y: numInSystem.toDouble()));
        print(
            "$i , $clock , Departure , $numArrival , $numDeparture , $numInSystem , $waitInSystem");
      }
    }
  }

  @override
  void handleArrivalEvent() {
    numArrival++;
    if (numInSystem < capacity) {
      numInSystem++;
      if (queue.isEmpty) {
        double serviceTime = randomExp(mu);
        nextDeparture[0] = nextArrival[0] + serviceTime;
      }
      queue.add(nextArrival[0]);
    } else {
      // Queue is full, ignore the arrival
    }
    double interArrivalTime = randomExp(lambda);
    nextArrival[0] = nextArrival[0] + interArrivalTime;
  }

  @override
  void handleDepartureEvent({int? serverIndex}) {
    numDeparture++;
    numInSystem--;
    waitInSystem = nextDeparture[0] - queue.removeFirst();

    totalWait += waitInSystem;
    if (queue.isEmpty) {
      nextDeparture[0] = double.infinity;
    } else {
      double serviceTime = randomExp(mu);
      nextDeparture[0] = nextDeparture[0] + serviceTime;
    }
  }
}
