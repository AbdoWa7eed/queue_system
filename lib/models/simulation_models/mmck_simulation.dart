import 'dart:collection';
import 'package:queue_system/models/point.dart';
import 'package:queue_system/models/simulation_models/queue_simulation.dart';

class MMCSKSimulation extends QueueSimulation {
  final int numServers;
  final int capacity;
  MMCSKSimulation({
    required lambda,
    required mu,
    required numSimulation,
    required this.numServers,
    required this.capacity
  }) : super(lambda: lambda, mu: mu, numSimulation: numSimulation);

  @override
  void runSimulation() {
    print("Serial , Clock , Event , #Arrival , #Departure , #InSystem , Wait");
    nextArrival = List.filled(numServers, 0);
    nextDeparture = List.filled(numServers, double.infinity);

    for (int i = 1; i <= numSimulation; i++) {
      int arrivalIndex = _getArrivalIndex();
      int departureIndex = _getDepartureIndex();
      if (nextArrival[arrivalIndex] <= nextDeparture[departureIndex]) {
        clock = nextArrival[arrivalIndex];
        handleArrivalEvent(serverIndex: arrivalIndex);
        points.add(Point(x: clock, y: numInSystem.toDouble()));
        print(
          "$i , $clock , Arrival , $numArrival , $numDeparture , $numInSystem , none",
        );
      } else {
        clock = nextDeparture[departureIndex];
        handleDepartureEvent(serverIndex: departureIndex);
        points.add(Point(x: clock, y: numInSystem.toDouble()));
        print(
          "$i , $clock , Departure , $numArrival , $numDeparture , $numInSystem , $waitInSystem",
        );
      }
    }
  }

  int _getArrivalIndex() {
    int minIndex = 0;
    for (int i = 1; i < numServers; i++) {
      if (nextArrival[i] < nextArrival[minIndex]) {
        minIndex = i;
      }
    }
    return minIndex;
  }
  int _getDepartureIndex() {
    int minIndex = 0;
    for (int i = 1; i < numServers; i++) {
      if (nextDeparture[i] < nextDeparture[minIndex]) {
        minIndex = i;
      }
    }
    return minIndex;
  }

  @override
  void handleArrivalEvent({int? serverIndex}) {
    numArrival++;
    if(numInSystem < capacity){
      numInSystem++;
      if (numInSystem <= numServers) {
        if (queue.isEmpty) {
          double serviceTime = randomExp(mu);
          nextDeparture[serverIndex!] = nextArrival[serverIndex] + serviceTime;
        }
      } else {
        // Customer has to wait in the queue
        queue.add(nextArrival[serverIndex!]);
      }
    }else{
      // Queue is full, ignore the arrival
    }

    double interArrivalTime = randomExp(lambda);
    nextArrival[serverIndex!] = nextArrival[serverIndex] + interArrivalTime;
  }

  @override
  void handleDepartureEvent({int? serverIndex}) {
    numDeparture++;
    numInSystem--;

    if (queue.isNotEmpty) {
      waitInSystem = nextDeparture[serverIndex!] - queue.removeFirst();
      totalWait += waitInSystem;
      double serviceTime = randomExp(mu);
      nextDeparture[serverIndex] = nextDeparture[serverIndex] + serviceTime;
    } else {
      nextDeparture[serverIndex!] = double.infinity;
    }
  }
}
