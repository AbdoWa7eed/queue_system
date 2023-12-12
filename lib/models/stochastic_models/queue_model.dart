// ignore_for_file: non_constant_identifier_names

class QueueModel {
  double arrivalRate, serviceRate;
  int capacity, serversNumber;
  double L = 0;
  double Lq = 0;
  double W = 0;
  double Wq = 0;

  QueueModel(
      {required this.arrivalRate,
      required this.serviceRate,
      required this.capacity,
      required this.serversNumber});

  double getArrivalRate() {
    return arrivalRate;
  }

  void setArrivalRate(double arrivalRate) {
    this.arrivalRate = arrivalRate;
  }

  double getServiceRate() {
    return serviceRate;
  }

  void setServiceRate(double serviceRate) {
    this.serviceRate = serviceRate;
  }

  int getCapacity() {
    return capacity;
  }

  void setCapacity(int capacity) {
    this.capacity = capacity;
  }

  int getServersNumber() {
    return serversNumber;
  }

  void setServersNumber(int serversNumber) {
    this.serversNumber = serversNumber;
  }
}
