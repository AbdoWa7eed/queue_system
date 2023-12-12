import 'package:flutter/material.dart';
import 'package:queue_system/app/extensions.dart';
import 'package:queue_system/models/simulation_models/mm1_simulation.dart';
import 'package:queue_system/models/simulation_models/mm1k_simulation.dart';
import 'package:queue_system/models/simulation_models/mmc_simuation.dart';
import 'package:queue_system/models/simulation_models/mmck_simulation.dart';
import 'package:queue_system/models/simulation_models/queue_simulation.dart';
import 'package:queue_system/models/stochastic_models/mm1_model.dart';
import 'package:queue_system/models/stochastic_models/mm1k_model.dart';
import 'package:queue_system/models/stochastic_models/mmc_model.dart';
import 'package:queue_system/models/stochastic_models/mmck_model.dart';
import 'package:queue_system/models/stochastic_models/stochastic_model.dart';
import 'package:queue_system/views/stochastic_view/stochastic_result.dart';

class StochasticView extends StatefulWidget {
  const StochasticView({super.key});

  @override
  State<StochasticView> createState() => _StochasticViewState();
}

class _StochasticViewState extends State<StochasticView> {
  final TextEditingController _arrivalRateController = TextEditingController();
  final TextEditingController _serviceRateController = TextEditingController();
  final TextEditingController _capacityController = TextEditingController();
  final TextEditingController _numberOfServersController =
      TextEditingController();
  final TextEditingController _numberOfSimulationsController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _capacityController.text = "Infinity";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stochastic System"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _arrivalRateController,
                    decoration: const InputDecoration(
                      labelText: 'Arrival rate ',
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _serviceRateController,
                    decoration: const InputDecoration(
                      labelText: 'Service Rate',
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _numberOfServersController,
                    validator: (value) {
                      if (value!.contains('.')) {
                        return "This field must contain an integer";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Servers number',
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _capacityController,
                    validator: (value) {
                      if (value!.contains('.')) {
                        return "This field must contain an integer";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Capacity ',
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _numberOfSimulationsController,
                    validator: (value) {
                      if (value!.contains('.') || value.isEmpty) {
                        return "This field must contain an integer";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Number of Simulations',
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              StochasticModel stochasticModel =
                              getStochasticModel();
                              QueueSimulation queueSimulationModel =
                              getQueueSimulationModel();
                              queueSimulationModel.runSimulation();
                              print(queueSimulationModel.points);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => StochasticResult(
                                      stochasticModel, queueSimulationModel)));
                            }
                          },
                          child: const Text('Simulate',
                              style: TextStyle(fontSize: 20)))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  StochasticModel getStochasticModel() {
    double lambda = _arrivalRateController.text.toDouble();
    double mu = _serviceRateController.text.toDouble();
    int numberOfServers = _numberOfServersController.text.toInt();

    if (_numberOfServersController.text.toInt() == 1) {
      if (_capacityController.text.contains("Infinity")) {
        return MM1Model(
          lambda,
          mu,
          numberOfServers,
          0,
        );
      } else {
        return MM1KModel(
          lambda,
          mu,
          numberOfServers,
          _capacityController.text.toInt(),
        );
      }
    } else {
      if (_capacityController.text.contains("Infinity")) {
        return MMCModel(
          lambda,
          mu,
          numberOfServers,
          0,
        );
      } else {
        return MMCKModel(
          lambda,
          mu,
          numberOfServers,
          _capacityController.text.toInt(),
        );
      }
    }
  }

  QueueSimulation getQueueSimulationModel() {
    double lambda = _arrivalRateController.text.toDouble();
    double mu = _serviceRateController.text.toDouble();
    int numOfSimulations = _numberOfSimulationsController.text.toInt();

    if (_numberOfServersController.text.toInt() == 1) {
      if (_capacityController.text.contains("Infinity")) {
        print('MM1');
        return MM1Simulation(
          lambda: lambda,
          mu:mu,
          numSimulation: numOfSimulations,
        );
      } else {
        print('MM1K');
        return MM1KSimulation(lambda: lambda, mu: mu, numSimulation: numOfSimulations,
            capacity: _capacityController.text.toInt());
      }
    } else {
      if (_capacityController.text.contains("Infinity")) {
        print('MMC');
        return MMCSimulation(lambda: lambda,
            mu: mu,
            numSimulation: numOfSimulations,
            numServers: _numberOfServersController.text.toInt());
      } else {
        print('MMCK');
        return MMCSKSimulation(lambda: lambda, mu: mu,
            numSimulation: numOfSimulations,
            numServers: _numberOfServersController.text.toInt(),
            capacity: _capacityController.text.toInt());
      }
    }
  }
}
