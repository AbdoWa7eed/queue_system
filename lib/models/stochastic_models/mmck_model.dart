// ignore_for_file: unnecessary_this

import 'package:queue_system/models/stochastic_models/stochastic_model.dart';
import 'dart:math' as math;

class MMCKModel extends StochasticModel {
  late final double r;
  late final double ro;

  MMCKModel(
      double arrivalRate, double serviceRate, int serversNumber, int capacity)
      : super(
            arrivalRate: arrivalRate,
            serviceRate: serviceRate,
            capacity: capacity,
            serversNumber: serversNumber,
            modelType: "M/M/C/K") {
    r = arrivalRate / serviceRate;
    ro = r / this.serversNumber;
  }

  double calculatePn(double r, int n, int c) {
    if (n >= 0 && n < c) {
      double f1 = math.pow(r, n) * calculateP0(r, c);
      double f2 = f1 / calculateFactorial(n.toDouble());
      return f2;
    } else if (n >= c && n <= this.capacity) {
      double f1 = math.pow(r, n) * calculateP0(r, c);
      double f2 =
          calculateFactorial(c.toDouble()) * (math.pow(serversNumber, n - c));
      double f3 = f1 / f2;
      return f3;
    } else {
      return 0;
    }
  }

  double calculateP0(double r, int c) {
    double res = 0;
    if (ro != 1) {
      res += calculateSummetion(0, serversNumber - 1);
      double f1 = (math.pow(this.r, serversNumber)).toDouble();
      double f2 = f1 / (calculateFactorial(serversNumber.toDouble()));
      double f3 = 1 - ((math.pow(ro, capacity - serversNumber + 1))).toDouble();
      double f4 = 1 - ro;
      double f5 = f2 * (f3 / f4);
      res += f5;
      res = 1 / res;
    } else {
      res += calculateSummetion(0, this.serversNumber - 1);
      double f1 = math.pow(this.r, this.serversNumber).toDouble();
      double f2 = f1 / (calculateFactorial(this.serversNumber.toDouble()));
      double f3 = this.capacity - this.serversNumber + 1;
      double f4 = f3 * f2;
      res += f4;
      res = 1 / res;
    }

    return res;
  }

  double calcSumForL(double first, double end) {
    double res = 0;
    for (; first <= end; first++) {
      res += ((math.pow(r, first)) / (calculateFactorial(first))) *
          (this.serversNumber - first);
    }
    return res;
  }

  double calculateSummetion(double first, double end) {
    double res = 0;
    for (; first <= end; first++) {
      res += (math.pow(r, first)) / (calculateFactorial(first));
    }
    return res;
  }

  double lamdaDash() {
    return arrivalRate *
        (1 - calculatePn(r, this.capacity, this.serversNumber));
  }

  @override
  double getL() {
    double f1 = getLq() + this.serversNumber;
    double f2 = 0;
    double res = calculateP0(r, this.serversNumber) *
        calcSumForL(0, this.serversNumber - 1);
    f2 = res;
    double f3 = f1 - f2;
    return f3;
  }

  @override
  double getLq() {
    double f0 = ro * (math.pow(r, this.serversNumber));
    double f1 = calculateP0(r, this.serversNumber) * (f0);

    double f2 = calculateFactorial(this.serversNumber.toDouble()) *
        (math.pow(1 - ro, 2));

    double f3 = f1 / f2;
    double f4 = 1 -
        (math.pow(ro, this.capacity - this.serversNumber + 1)) -
        ((1 - ro) *
            (this.capacity - this.serversNumber + 1) *
            (math.pow(ro, this.capacity - this.serversNumber)));
    double f5 = f4 * f3;
    return f5;
  }

  @override
  double getW() {
    return (getL() / lamdaDash());
  }

  @override
  double getWq() {
    return (getLq() / lamdaDash());
  }

  double calculateFactorial(double n) {
    double result = 1;
    for (double i = n; i > 0; i--) {
      result = result * (i);
    }
    return result;
  }
}
