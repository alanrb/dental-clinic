# dental_clinic

Dental clinic management system.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

##### [Equatable:](https://pub.dev/packages/equatable)
- Without Equatable
```kotlin
class Person {
  const Person(this.name);

  final String name;

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is Person &&
    runtimeType == other.runtimeType &&
    name == other.name;

  @override
  int get hashCode => name.hashCode;
}
```

- With Equatable
```kotlin
import 'package:equatable/equatable.dart';

class Person extends Equatable {
  const Person(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}
```
