import 'package:get/get.dart';
import '../model/counter.dart';

class CounterController extends GetxController {
  // Model object
  CounterModel counter = CounterModel();
  // Observable variable
  var count = 0.obs;

  void increment() {
    count++;
  }
  void decrement() {
    count--;
  }
}