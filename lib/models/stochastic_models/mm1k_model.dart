// ignore_for_file: non_constant_identifier_names

import 'dart:math' as math;

import 'package:queue_system/models/stochastic_models/stochastic_model.dart';

class MM1KModel extends StochasticModel {
  MM1KModel(
      double arrivalRate, double serviceRate, int serversNumber, int capacity)
      : super(
          arrivalRate: arrivalRate,
          capacity: capacity,
          serviceRate: serviceRate,
          serversNumber: serversNumber,
          modelType: "M/M/1/K",
        );
  double calcRo() {
    return (arrivalRate / serviceRate);
  }

  double calcPk() {
    double Pk = 0;
    double ro = calcRo();
    if (ro == 1) {
      Pk = 1 / (1 + capacity);
    } else {
      double f1 = 1 - ro;
      double f2 = 1 - (math.pow(ro, capacity + 1)).toDouble();
      Pk = (f1 * f2) * (math.pow(ro, capacity));
    }
    return Pk;
  }

  double lamdaDash() {
    return arrivalRate * (1 - calcPk());
  }

  @override
  double getL() {
    double ro = calcRo();

    if (ro == 1) {
      L = capacity / 2;
    } else {
      double f1 = (1 -
          ((capacity + 1) * (math.pow(ro, capacity))).toDouble() +
          (capacity * math.pow(ro, capacity + 1)));
      double f2 = ((1 - ro) * (1 - (math.pow(ro, capacity + 1))));
      L = (ro * (f1 / f2));
    }
    return L;
  }

  @override
  double getLq() {
    Lq = getWq() * lamdaDash();
    return Lq;
  }

  @override
  double getW() {
    W = ((getL()) / lamdaDash());
    return W;
  }

  @override
  double getWq() {
    Wq = (getW() - (1 / serviceRate));
    return Wq;
  }
}
