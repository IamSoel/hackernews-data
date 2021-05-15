import 'dart:async';

class Cake {}

class Order {
  String type;
  Order(this.type);
}

void main() {
  // ignore: close_sinks
  final controller = StreamController();
  final order = Order('chocolate');

  final baker = StreamTransformer.fromHandlers(handleData: (cakeType, sink) {
    if (cakeType == 'chocolate') {
      sink.add(Cake());
    } else {
      sink.addError('I can\'t bake $cakeType cake');
    }
  });

  controller.sink.add(order);

  controller.stream.map((order) => order.type).transform(baker).listen(
        (cake) => print('here is your $cake'),
        onError: (err) => print(err),
      );

}
