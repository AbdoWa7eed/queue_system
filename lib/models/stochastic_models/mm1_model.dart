import 'package:queue_system/models/stochastic_models/stochastic_model.dart';

class MM1Model extends StochasticModel {
  MM1Model(
      double arrivalRate, double serviceRate, int serversNumber, int capacity)
      : super(
          arrivalRate: arrivalRate,
          capacity: capacity,
          serversNumber: serversNumber,
          serviceRate: serviceRate,
          modelType: "M/M/1",
        );
  @override
  double getL() {
    return (arrivalRate / (serviceRate - arrivalRate));
  }

  @override
  double getLq() {
    return ((arrivalRate * arrivalRate) /
        (serviceRate * (serviceRate - arrivalRate)));
  }

  @override
  double getW() {
    return (1 / (serviceRate - arrivalRate));
  }

  @override
  double getWq() {
    return ((arrivalRate) / (serviceRate * (serviceRate - arrivalRate)));
  }
}
