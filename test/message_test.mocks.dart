// Mocks generated by Mockito 5.4.2 from annotations
// in camel/test/message_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:camel/message.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeMessageHeader_0 extends _i1.SmartFake implements _i2.MessageHeader {
  _FakeMessageHeader_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [Message].
///
/// See the documentation for Mockito's code generation for more information.
class MockMessage extends _i1.Mock implements _i2.Message {
  MockMessage() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MessageHeader get header => (super.noSuchMethod(
        Invocation.getter(#header),
        returnValue: _FakeMessageHeader_0(
          this,
          Invocation.getter(#header),
        ),
      ) as _i2.MessageHeader);
  @override
  set header(_i2.MessageHeader? _header) => super.noSuchMethod(
        Invocation.setter(
          #header,
          _header,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i3.Uint8List get body => (super.noSuchMethod(
        Invocation.getter(#body),
        returnValue: _i3.Uint8List(0),
      ) as _i3.Uint8List);
  @override
  set body(_i3.Uint8List? _body) => super.noSuchMethod(
        Invocation.setter(
          #body,
          _body,
        ),
        returnValueForMissingStub: null,
      );
  @override
  String get message => (super.noSuchMethod(
        Invocation.getter(#message),
        returnValue: '',
      ) as String);
}

/// A class which mocks [MessageHeader].
///
/// See the documentation for Mockito's code generation for more information.
class MockMessageHeader extends _i1.Mock implements _i2.MessageHeader {
  MockMessageHeader() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get command => (super.noSuchMethod(
        Invocation.getter(#command),
        returnValue: '',
      ) as String);
  @override
  set command(String? _command) => super.noSuchMethod(
        Invocation.setter(
          #command,
          _command,
        ),
        returnValueForMissingStub: null,
      );
  @override
  int get bodySize => (super.noSuchMethod(
        Invocation.getter(#bodySize),
        returnValue: 0,
      ) as int);
  @override
  set bodySize(int? _bodySize) => super.noSuchMethod(
        Invocation.setter(
          #bodySize,
          _bodySize,
        ),
        returnValueForMissingStub: null,
      );
  @override
  int get headerSize => (super.noSuchMethod(
        Invocation.getter(#headerSize),
        returnValue: 0,
      ) as int);
  @override
  set headerSize(int? _headerSize) => super.noSuchMethod(
        Invocation.setter(
          #headerSize,
          _headerSize,
        ),
        returnValueForMissingStub: null,
      );
  @override
  String get rawData => (super.noSuchMethod(
        Invocation.getter(#rawData),
        returnValue: '',
      ) as String);
  @override
  set rawData(String? _rawData) => super.noSuchMethod(
        Invocation.setter(
          #rawData,
          _rawData,
        ),
        returnValueForMissingStub: null,
      );
  @override
  String? parseHeaderSection(
    String? header,
    String? section,
  ) =>
      (super.noSuchMethod(Invocation.method(
        #parseHeaderSection,
        [
          header,
          section,
        ],
      )) as String?);
  @override
  String? parseHeaderSize(String? src) => (super.noSuchMethod(Invocation.method(
        #parseHeaderSize,
        [src],
      )) as String?);
}