import 'package:queue_system/models/stochastic_models/queue_model.dart';

abstract class StochasticModel extends QueueModel {
  final String modelType;
  StochasticModel({
    required super.arrivalRate,
    required super.serviceRate,
    required super.capacity,
    required super.serversNumber,
    required this.modelType,
  });

  get myModelType => modelType;
  double getL();

  double getLq();

  double getW();

  double getWq();
}
