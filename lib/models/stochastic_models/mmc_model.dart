import 'dart:math' as math;

import 'package:queue_system/models/stochastic_models/stochastic_model.dart';

class MMCModel extends StochasticModel {
  late final double r;
  MMCModel(
    double arrivalRate,
    double serviceRate,
    int numberOfServers,
    int capacity,
  ) : super(
          arrivalRate: arrivalRate,
          serviceRate: serviceRate,
          capacity: capacity,
          serversNumber: numberOfServers,
          modelType: "M/M/C",
        ) {
    r = arrivalRate / serviceRate;
  }

  @override
  double getL() {
    L = getLq() + r;
    return L;
  }

  @override
  double getLq() {
    double f1 = ((math.pow(r, serversNumber)) * (arrivalRate * serviceRate));

    // Neomerator
    double f2 = (calculateFactorial(serversNumber - 1));

    double f3 =
        (math.pow((serversNumber * serviceRate) - arrivalRate, 2)).toDouble();
    // Denomenator
    double f4 = f2 * f3;

    double f5 = (f1 / f4);
    Lq = ((calculatep0() * f5) * 1000.0).round() / 1000.0;

    return Lq;
  }

  @override
  double getW() {
    Wq = getWq() + (1 / serviceRate);
    return Wq;
  }

  @override
  double getWq() {
    Wq = (getLq()) / (arrivalRate);

    return Wq;
  }

  double calculatep0() {
    double p0 = 0;
    if ((r / serversNumber) < 1) {
      double f1 = calculateSummetion(0, serversNumber - 1);

      double f2 = ((serversNumber) *
          (math.pow(r, serversNumber)) /
          ((calculateFactorial(serversNumber.toDouble())) *
              (serversNumber - r)));
      double f3 = f1 + f2;
      p0 = (1.0 / f3);
    } else {
      double f1 = calculateSummetion(0, serversNumber - 1);
      double f2 = (math.pow(r, serversNumber)).toDouble();
      double f3 = (1) / (calculateFactorial(serversNumber.toDouble()));
      double f4 = (serversNumber * serviceRate) /
          ((serversNumber * serviceRate) - arrivalRate);
      double f5 = f2 + f3 + f4;
      double f6 = f5 + f1;
      p0 = 1 / f6;
    }

    return p0;
  }

  double calculateFactorial(double n) {
    double result = 1;
    for (double i = n; i > 0; i--) {
      result = result * (i);
    }
    return result;
  }

  double calculateSummetion(double first, double end) {
    double res = 0;
    for (; first <= end; first++) {
      res += (math.pow(r, first)) / (calculateFactorial(first));
    }
    return res;
  }
}
