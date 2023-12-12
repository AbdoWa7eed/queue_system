import 'package:flutter/material.dart';
import 'package:queue_system/models/simulation_models/queue_simulation.dart';
import 'package:queue_system/models/stochastic_models/stochastic_model.dart';
import 'package:queue_system/views/stochastic_view/simulation_view.dart';

class StochasticResult extends StatelessWidget {
  const StochasticResult(this._stochasticModel, this._queueSimulationModel,
      {super.key});
  final StochasticModel _stochasticModel;
  final QueueSimulation _queueSimulationModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${_stochasticModel.modelType} Reuslt'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildRowData("L", _stochasticModel.getL().toString()),
            const SizedBox(
              height: 20,
            ),
            _buildRowData("Lq", _stochasticModel.getLq().toString()),
            const SizedBox(
              height: 20,
            ),
            _buildRowData("W", _stochasticModel.getW().toString()),
            const SizedBox(
              height: 20,
            ),
            _buildRowData("Wq", _stochasticModel.getWq().toString()),
            const SizedBox(
              height: 20,
            ),
            Expanded(child: SimulationView(
              data: _queueSimulationModel.points,
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildRowData(String text, String result) {
    return Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.deepPurple),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center),
            const SizedBox(
              width: 10,
            ),
            const Text("=",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(result,
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center),
            ),
          ],
        ));
  }
}
