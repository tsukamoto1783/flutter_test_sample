// Mocks generated by Mockito 5.4.4 from annotations
// in static_test/test/static_ok_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i3;

import 'static_ok_test.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [CatWrapper].
///
/// See the documentation for Mockito's code generation for more information.
class MockCatWrapper extends _i1.Mock implements _i2.CatWrapper {
  @override
  String soundWrapper() => (super.noSuchMethod(
        Invocation.method(
          #soundWrapper,
          [],
        ),
        returnValue: _i3.dummyValue<String>(
          this,
          Invocation.method(
            #soundWrapper,
            [],
          ),
        ),
        returnValueForMissingStub: _i3.dummyValue<String>(
          this,
          Invocation.method(
            #soundWrapper,
            [],
          ),
        ),
      ) as String);
}

/// A class which mocks [FluttertoastWrapper].
///
/// See the documentation for Mockito's code generation for more information.
class MockFluttertoastWrapper extends _i1.Mock
    implements _i2.FluttertoastWrapper {
  @override
  _i4.Future<bool?> showToastWrapper() => (super.noSuchMethod(
        Invocation.method(
          #showToastWrapper,
          [],
        ),
        returnValue: _i4.Future<bool?>.value(),
        returnValueForMissingStub: _i4.Future<bool?>.value(),
      ) as _i4.Future<bool?>);
}