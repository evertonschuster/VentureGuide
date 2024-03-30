import 'package:reflectable/reflectable.dart';

class Reflector extends Reflectable {
  const Reflector() : super(
    invokingCapability, 
    typingCapability, 
    reflectedTypeCapability, 
    newInstanceCapability, 
    instanceInvokeCapability, 
    declarationsCapability, 
    typeRelationsCapability, 
    typeCapability
    );
}

const reflector = Reflector();
