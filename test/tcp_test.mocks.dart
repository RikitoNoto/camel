// Mocks generated by Mockito 5.4.2 from annotations
// in camel/test/tcp_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:convert' as _i3;
import 'dart:io' as _i2;
import 'dart:typed_data' as _i6;

import 'package:camel/command.dart' as _i8;
import 'package:camel/message.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i7;

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

class _FakeInternetAddress_0 extends _i1.SmartFake
    implements _i2.InternetAddress {
  _FakeInternetAddress_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEncoding_1 extends _i1.SmartFake implements _i3.Encoding {
  _FakeEncoding_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeStreamSubscription_2<T> extends _i1.SmartFake
    implements _i4.StreamSubscription<T> {
  _FakeStreamSubscription_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeFuture_3<T> extends _i1.SmartFake implements _i4.Future<T> {
  _FakeFuture_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSocket_4 extends _i1.SmartFake implements _i2.Socket {
  _FakeSocket_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeServerSocket_5 extends _i1.SmartFake implements _i2.ServerSocket {
  _FakeServerSocket_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeMessageHeader_6 extends _i1.SmartFake implements _i5.MessageHeader {
  _FakeMessageHeader_6(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [Socket].
///
/// See the documentation for Mockito's code generation for more information.
class MockSocket extends _i1.Mock implements _i2.Socket {
  MockSocket() {
    _i1.throwOnMissingStub(this);
  }

  @override
  int get port => (super.noSuchMethod(
        Invocation.getter(#port),
        returnValue: 0,
      ) as int);
  @override
  int get remotePort => (super.noSuchMethod(
        Invocation.getter(#remotePort),
        returnValue: 0,
      ) as int);
  @override
  _i2.InternetAddress get address => (super.noSuchMethod(
        Invocation.getter(#address),
        returnValue: _FakeInternetAddress_0(
          this,
          Invocation.getter(#address),
        ),
      ) as _i2.InternetAddress);
  @override
  _i2.InternetAddress get remoteAddress => (super.noSuchMethod(
        Invocation.getter(#remoteAddress),
        returnValue: _FakeInternetAddress_0(
          this,
          Invocation.getter(#remoteAddress),
        ),
      ) as _i2.InternetAddress);
  @override
  _i4.Future<dynamic> get done => (super.noSuchMethod(
        Invocation.getter(#done),
        returnValue: _i4.Future<dynamic>.value(),
      ) as _i4.Future<dynamic>);
  @override
  bool get isBroadcast => (super.noSuchMethod(
        Invocation.getter(#isBroadcast),
        returnValue: false,
      ) as bool);
  @override
  _i4.Future<int> get length => (super.noSuchMethod(
        Invocation.getter(#length),
        returnValue: _i4.Future<int>.value(0),
      ) as _i4.Future<int>);
  @override
  _i4.Future<bool> get isEmpty => (super.noSuchMethod(
        Invocation.getter(#isEmpty),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
  @override
  _i4.Future<_i6.Uint8List> get first => (super.noSuchMethod(
        Invocation.getter(#first),
        returnValue: _i4.Future<_i6.Uint8List>.value(_i6.Uint8List(0)),
      ) as _i4.Future<_i6.Uint8List>);
  @override
  _i4.Future<_i6.Uint8List> get last => (super.noSuchMethod(
        Invocation.getter(#last),
        returnValue: _i4.Future<_i6.Uint8List>.value(_i6.Uint8List(0)),
      ) as _i4.Future<_i6.Uint8List>);
  @override
  _i4.Future<_i6.Uint8List> get single => (super.noSuchMethod(
        Invocation.getter(#single),
        returnValue: _i4.Future<_i6.Uint8List>.value(_i6.Uint8List(0)),
      ) as _i4.Future<_i6.Uint8List>);
  @override
  _i3.Encoding get encoding => (super.noSuchMethod(
        Invocation.getter(#encoding),
        returnValue: _FakeEncoding_1(
          this,
          Invocation.getter(#encoding),
        ),
      ) as _i3.Encoding);
  @override
  set encoding(_i3.Encoding? _encoding) => super.noSuchMethod(
        Invocation.setter(
          #encoding,
          _encoding,
        ),
        returnValueForMissingStub: null,
      );
  @override
  void destroy() => super.noSuchMethod(
        Invocation.method(
          #destroy,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  bool setOption(
    _i2.SocketOption? option,
    bool? enabled,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #setOption,
          [
            option,
            enabled,
          ],
        ),
        returnValue: false,
      ) as bool);
  @override
  _i6.Uint8List getRawOption(_i2.RawSocketOption? option) =>
      (super.noSuchMethod(
        Invocation.method(
          #getRawOption,
          [option],
        ),
        returnValue: _i6.Uint8List(0),
      ) as _i6.Uint8List);
  @override
  void setRawOption(_i2.RawSocketOption? option) => super.noSuchMethod(
        Invocation.method(
          #setRawOption,
          [option],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i4.Future<dynamic> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i4.Future<dynamic>.value(),
      ) as _i4.Future<dynamic>);
  @override
  _i4.Stream<_i6.Uint8List> asBroadcastStream({
    void Function(_i4.StreamSubscription<_i6.Uint8List>)? onListen,
    void Function(_i4.StreamSubscription<_i6.Uint8List>)? onCancel,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #asBroadcastStream,
          [],
          {
            #onListen: onListen,
            #onCancel: onCancel,
          },
        ),
        returnValue: _i4.Stream<_i6.Uint8List>.empty(),
      ) as _i4.Stream<_i6.Uint8List>);
  @override
  _i4.StreamSubscription<_i6.Uint8List> listen(
    void Function(_i6.Uint8List)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #listen,
          [onData],
          {
            #onError: onError,
            #onDone: onDone,
            #cancelOnError: cancelOnError,
          },
        ),
        returnValue: _FakeStreamSubscription_2<_i6.Uint8List>(
          this,
          Invocation.method(
            #listen,
            [onData],
            {
              #onError: onError,
              #onDone: onDone,
              #cancelOnError: cancelOnError,
            },
          ),
        ),
      ) as _i4.StreamSubscription<_i6.Uint8List>);
  @override
  _i4.Stream<_i6.Uint8List> where(bool Function(_i6.Uint8List)? test) =>
      (super.noSuchMethod(
        Invocation.method(
          #where,
          [test],
        ),
        returnValue: _i4.Stream<_i6.Uint8List>.empty(),
      ) as _i4.Stream<_i6.Uint8List>);
  @override
  _i4.Stream<S> map<S>(S Function(_i6.Uint8List)? convert) =>
      (super.noSuchMethod(
        Invocation.method(
          #map,
          [convert],
        ),
        returnValue: _i4.Stream<S>.empty(),
      ) as _i4.Stream<S>);
  @override
  _i4.Stream<E> asyncMap<E>(_i4.FutureOr<E> Function(_i6.Uint8List)? convert) =>
      (super.noSuchMethod(
        Invocation.method(
          #asyncMap,
          [convert],
        ),
        returnValue: _i4.Stream<E>.empty(),
      ) as _i4.Stream<E>);
  @override
  _i4.Stream<E> asyncExpand<E>(
          _i4.Stream<E>? Function(_i6.Uint8List)? convert) =>
      (super.noSuchMethod(
        Invocation.method(
          #asyncExpand,
          [convert],
        ),
        returnValue: _i4.Stream<E>.empty(),
      ) as _i4.Stream<E>);
  @override
  _i4.Stream<_i6.Uint8List> handleError(
    Function? onError, {
    bool Function(dynamic)? test,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #handleError,
          [onError],
          {#test: test},
        ),
        returnValue: _i4.Stream<_i6.Uint8List>.empty(),
      ) as _i4.Stream<_i6.Uint8List>);
  @override
  _i4.Stream<S> expand<S>(Iterable<S> Function(_i6.Uint8List)? convert) =>
      (super.noSuchMethod(
        Invocation.method(
          #expand,
          [convert],
        ),
        returnValue: _i4.Stream<S>.empty(),
      ) as _i4.Stream<S>);
  @override
  _i4.Future<dynamic> pipe(_i4.StreamConsumer<_i6.Uint8List>? streamConsumer) =>
      (super.noSuchMethod(
        Invocation.method(
          #pipe,
          [streamConsumer],
        ),
        returnValue: _i4.Future<dynamic>.value(),
      ) as _i4.Future<dynamic>);
  @override
  _i4.Stream<S> transform<S>(
          _i4.StreamTransformer<_i6.Uint8List, S>? streamTransformer) =>
      (super.noSuchMethod(
        Invocation.method(
          #transform,
          [streamTransformer],
        ),
        returnValue: _i4.Stream<S>.empty(),
      ) as _i4.Stream<S>);
  @override
  _i4.Future<_i6.Uint8List> reduce(
          _i6.Uint8List Function(
            _i6.Uint8List,
            _i6.Uint8List,
          )? combine) =>
      (super.noSuchMethod(
        Invocation.method(
          #reduce,
          [combine],
        ),
        returnValue: _i4.Future<_i6.Uint8List>.value(_i6.Uint8List(0)),
      ) as _i4.Future<_i6.Uint8List>);
  @override
  _i4.Future<S> fold<S>(
    S? initialValue,
    S Function(
      S,
      _i6.Uint8List,
    )? combine,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #fold,
          [
            initialValue,
            combine,
          ],
        ),
        returnValue: _i7.ifNotNull(
              _i7.dummyValueOrNull<S>(
                this,
                Invocation.method(
                  #fold,
                  [
                    initialValue,
                    combine,
                  ],
                ),
              ),
              (S v) => _i4.Future<S>.value(v),
            ) ??
            _FakeFuture_3<S>(
              this,
              Invocation.method(
                #fold,
                [
                  initialValue,
                  combine,
                ],
              ),
            ),
      ) as _i4.Future<S>);
  @override
  _i4.Future<String> join([String? separator = r'']) => (super.noSuchMethod(
        Invocation.method(
          #join,
          [separator],
        ),
        returnValue: _i4.Future<String>.value(''),
      ) as _i4.Future<String>);
  @override
  _i4.Future<bool> contains(Object? needle) => (super.noSuchMethod(
        Invocation.method(
          #contains,
          [needle],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
  @override
  _i4.Future<void> forEach(void Function(_i6.Uint8List)? action) =>
      (super.noSuchMethod(
        Invocation.method(
          #forEach,
          [action],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<bool> every(bool Function(_i6.Uint8List)? test) =>
      (super.noSuchMethod(
        Invocation.method(
          #every,
          [test],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
  @override
  _i4.Future<bool> any(bool Function(_i6.Uint8List)? test) =>
      (super.noSuchMethod(
        Invocation.method(
          #any,
          [test],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
  @override
  _i4.Stream<R> cast<R>() => (super.noSuchMethod(
        Invocation.method(
          #cast,
          [],
        ),
        returnValue: _i4.Stream<R>.empty(),
      ) as _i4.Stream<R>);
  @override
  _i4.Future<List<_i6.Uint8List>> toList() => (super.noSuchMethod(
        Invocation.method(
          #toList,
          [],
        ),
        returnValue: _i4.Future<List<_i6.Uint8List>>.value(<_i6.Uint8List>[]),
      ) as _i4.Future<List<_i6.Uint8List>>);
  @override
  _i4.Future<Set<_i6.Uint8List>> toSet() => (super.noSuchMethod(
        Invocation.method(
          #toSet,
          [],
        ),
        returnValue: _i4.Future<Set<_i6.Uint8List>>.value(<_i6.Uint8List>{}),
      ) as _i4.Future<Set<_i6.Uint8List>>);
  @override
  _i4.Future<E> drain<E>([E? futureValue]) => (super.noSuchMethod(
        Invocation.method(
          #drain,
          [futureValue],
        ),
        returnValue: _i7.ifNotNull(
              _i7.dummyValueOrNull<E>(
                this,
                Invocation.method(
                  #drain,
                  [futureValue],
                ),
              ),
              (E v) => _i4.Future<E>.value(v),
            ) ??
            _FakeFuture_3<E>(
              this,
              Invocation.method(
                #drain,
                [futureValue],
              ),
            ),
      ) as _i4.Future<E>);
  @override
  _i4.Stream<_i6.Uint8List> take(int? count) => (super.noSuchMethod(
        Invocation.method(
          #take,
          [count],
        ),
        returnValue: _i4.Stream<_i6.Uint8List>.empty(),
      ) as _i4.Stream<_i6.Uint8List>);
  @override
  _i4.Stream<_i6.Uint8List> takeWhile(bool Function(_i6.Uint8List)? test) =>
      (super.noSuchMethod(
        Invocation.method(
          #takeWhile,
          [test],
        ),
        returnValue: _i4.Stream<_i6.Uint8List>.empty(),
      ) as _i4.Stream<_i6.Uint8List>);
  @override
  _i4.Stream<_i6.Uint8List> skip(int? count) => (super.noSuchMethod(
        Invocation.method(
          #skip,
          [count],
        ),
        returnValue: _i4.Stream<_i6.Uint8List>.empty(),
      ) as _i4.Stream<_i6.Uint8List>);
  @override
  _i4.Stream<_i6.Uint8List> skipWhile(bool Function(_i6.Uint8List)? test) =>
      (super.noSuchMethod(
        Invocation.method(
          #skipWhile,
          [test],
        ),
        returnValue: _i4.Stream<_i6.Uint8List>.empty(),
      ) as _i4.Stream<_i6.Uint8List>);
  @override
  _i4.Stream<_i6.Uint8List> distinct(
          [bool Function(
            _i6.Uint8List,
            _i6.Uint8List,
          )? equals]) =>
      (super.noSuchMethod(
        Invocation.method(
          #distinct,
          [equals],
        ),
        returnValue: _i4.Stream<_i6.Uint8List>.empty(),
      ) as _i4.Stream<_i6.Uint8List>);
  @override
  _i4.Future<_i6.Uint8List> firstWhere(
    bool Function(_i6.Uint8List)? test, {
    _i6.Uint8List Function()? orElse,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #firstWhere,
          [test],
          {#orElse: orElse},
        ),
        returnValue: _i4.Future<_i6.Uint8List>.value(_i6.Uint8List(0)),
      ) as _i4.Future<_i6.Uint8List>);
  @override
  _i4.Future<_i6.Uint8List> lastWhere(
    bool Function(_i6.Uint8List)? test, {
    _i6.Uint8List Function()? orElse,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #lastWhere,
          [test],
          {#orElse: orElse},
        ),
        returnValue: _i4.Future<_i6.Uint8List>.value(_i6.Uint8List(0)),
      ) as _i4.Future<_i6.Uint8List>);
  @override
  _i4.Future<_i6.Uint8List> singleWhere(
    bool Function(_i6.Uint8List)? test, {
    _i6.Uint8List Function()? orElse,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #singleWhere,
          [test],
          {#orElse: orElse},
        ),
        returnValue: _i4.Future<_i6.Uint8List>.value(_i6.Uint8List(0)),
      ) as _i4.Future<_i6.Uint8List>);
  @override
  _i4.Future<_i6.Uint8List> elementAt(int? index) => (super.noSuchMethod(
        Invocation.method(
          #elementAt,
          [index],
        ),
        returnValue: _i4.Future<_i6.Uint8List>.value(_i6.Uint8List(0)),
      ) as _i4.Future<_i6.Uint8List>);
  @override
  _i4.Stream<_i6.Uint8List> timeout(
    Duration? timeLimit, {
    void Function(_i4.EventSink<_i6.Uint8List>)? onTimeout,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #timeout,
          [timeLimit],
          {#onTimeout: onTimeout},
        ),
        returnValue: _i4.Stream<_i6.Uint8List>.empty(),
      ) as _i4.Stream<_i6.Uint8List>);
  @override
  void add(List<int>? data) => super.noSuchMethod(
        Invocation.method(
          #add,
          [data],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void write(Object? object) => super.noSuchMethod(
        Invocation.method(
          #write,
          [object],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void writeAll(
    Iterable<dynamic>? objects, [
    String? separator = r'',
  ]) =>
      super.noSuchMethod(
        Invocation.method(
          #writeAll,
          [
            objects,
            separator,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void writeln([Object? object = r'']) => super.noSuchMethod(
        Invocation.method(
          #writeln,
          [object],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void writeCharCode(int? charCode) => super.noSuchMethod(
        Invocation.method(
          #writeCharCode,
          [charCode],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void addError(
    Object? error, [
    StackTrace? stackTrace,
  ]) =>
      super.noSuchMethod(
        Invocation.method(
          #addError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i4.Future<dynamic> addStream(_i4.Stream<List<int>>? stream) =>
      (super.noSuchMethod(
        Invocation.method(
          #addStream,
          [stream],
        ),
        returnValue: _i4.Future<dynamic>.value(),
      ) as _i4.Future<dynamic>);
  @override
  _i4.Future<dynamic> flush() => (super.noSuchMethod(
        Invocation.method(
          #flush,
          [],
        ),
        returnValue: _i4.Future<dynamic>.value(),
      ) as _i4.Future<dynamic>);
}

/// A class which mocks [ServerSocket].
///
/// See the documentation for Mockito's code generation for more information.
class MockServerSocket extends _i1.Mock implements _i2.ServerSocket {
  MockServerSocket() {
    _i1.throwOnMissingStub(this);
  }

  @override
  int get port => (super.noSuchMethod(
        Invocation.getter(#port),
        returnValue: 0,
      ) as int);
  @override
  _i2.InternetAddress get address => (super.noSuchMethod(
        Invocation.getter(#address),
        returnValue: _FakeInternetAddress_0(
          this,
          Invocation.getter(#address),
        ),
      ) as _i2.InternetAddress);
  @override
  bool get isBroadcast => (super.noSuchMethod(
        Invocation.getter(#isBroadcast),
        returnValue: false,
      ) as bool);
  @override
  _i4.Future<int> get length => (super.noSuchMethod(
        Invocation.getter(#length),
        returnValue: _i4.Future<int>.value(0),
      ) as _i4.Future<int>);
  @override
  _i4.Future<bool> get isEmpty => (super.noSuchMethod(
        Invocation.getter(#isEmpty),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
  @override
  _i4.Future<_i2.Socket> get first => (super.noSuchMethod(
        Invocation.getter(#first),
        returnValue: _i4.Future<_i2.Socket>.value(_FakeSocket_4(
          this,
          Invocation.getter(#first),
        )),
      ) as _i4.Future<_i2.Socket>);
  @override
  _i4.Future<_i2.Socket> get last => (super.noSuchMethod(
        Invocation.getter(#last),
        returnValue: _i4.Future<_i2.Socket>.value(_FakeSocket_4(
          this,
          Invocation.getter(#last),
        )),
      ) as _i4.Future<_i2.Socket>);
  @override
  _i4.Future<_i2.Socket> get single => (super.noSuchMethod(
        Invocation.getter(#single),
        returnValue: _i4.Future<_i2.Socket>.value(_FakeSocket_4(
          this,
          Invocation.getter(#single),
        )),
      ) as _i4.Future<_i2.Socket>);
  @override
  _i4.Future<_i2.ServerSocket> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i4.Future<_i2.ServerSocket>.value(_FakeServerSocket_5(
          this,
          Invocation.method(
            #close,
            [],
          ),
        )),
      ) as _i4.Future<_i2.ServerSocket>);
  @override
  _i4.Stream<_i2.Socket> asBroadcastStream({
    void Function(_i4.StreamSubscription<_i2.Socket>)? onListen,
    void Function(_i4.StreamSubscription<_i2.Socket>)? onCancel,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #asBroadcastStream,
          [],
          {
            #onListen: onListen,
            #onCancel: onCancel,
          },
        ),
        returnValue: _i4.Stream<_i2.Socket>.empty(),
      ) as _i4.Stream<_i2.Socket>);
  @override
  _i4.StreamSubscription<_i2.Socket> listen(
    void Function(_i2.Socket)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #listen,
          [onData],
          {
            #onError: onError,
            #onDone: onDone,
            #cancelOnError: cancelOnError,
          },
        ),
        returnValue: _FakeStreamSubscription_2<_i2.Socket>(
          this,
          Invocation.method(
            #listen,
            [onData],
            {
              #onError: onError,
              #onDone: onDone,
              #cancelOnError: cancelOnError,
            },
          ),
        ),
      ) as _i4.StreamSubscription<_i2.Socket>);
  @override
  _i4.Stream<_i2.Socket> where(bool Function(_i2.Socket)? test) =>
      (super.noSuchMethod(
        Invocation.method(
          #where,
          [test],
        ),
        returnValue: _i4.Stream<_i2.Socket>.empty(),
      ) as _i4.Stream<_i2.Socket>);
  @override
  _i4.Stream<S> map<S>(S Function(_i2.Socket)? convert) => (super.noSuchMethod(
        Invocation.method(
          #map,
          [convert],
        ),
        returnValue: _i4.Stream<S>.empty(),
      ) as _i4.Stream<S>);
  @override
  _i4.Stream<E> asyncMap<E>(_i4.FutureOr<E> Function(_i2.Socket)? convert) =>
      (super.noSuchMethod(
        Invocation.method(
          #asyncMap,
          [convert],
        ),
        returnValue: _i4.Stream<E>.empty(),
      ) as _i4.Stream<E>);
  @override
  _i4.Stream<E> asyncExpand<E>(_i4.Stream<E>? Function(_i2.Socket)? convert) =>
      (super.noSuchMethod(
        Invocation.method(
          #asyncExpand,
          [convert],
        ),
        returnValue: _i4.Stream<E>.empty(),
      ) as _i4.Stream<E>);
  @override
  _i4.Stream<_i2.Socket> handleError(
    Function? onError, {
    bool Function(dynamic)? test,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #handleError,
          [onError],
          {#test: test},
        ),
        returnValue: _i4.Stream<_i2.Socket>.empty(),
      ) as _i4.Stream<_i2.Socket>);
  @override
  _i4.Stream<S> expand<S>(Iterable<S> Function(_i2.Socket)? convert) =>
      (super.noSuchMethod(
        Invocation.method(
          #expand,
          [convert],
        ),
        returnValue: _i4.Stream<S>.empty(),
      ) as _i4.Stream<S>);
  @override
  _i4.Future<dynamic> pipe(_i4.StreamConsumer<_i2.Socket>? streamConsumer) =>
      (super.noSuchMethod(
        Invocation.method(
          #pipe,
          [streamConsumer],
        ),
        returnValue: _i4.Future<dynamic>.value(),
      ) as _i4.Future<dynamic>);
  @override
  _i4.Stream<S> transform<S>(
          _i4.StreamTransformer<_i2.Socket, S>? streamTransformer) =>
      (super.noSuchMethod(
        Invocation.method(
          #transform,
          [streamTransformer],
        ),
        returnValue: _i4.Stream<S>.empty(),
      ) as _i4.Stream<S>);
  @override
  _i4.Future<_i2.Socket> reduce(
          _i2.Socket Function(
            _i2.Socket,
            _i2.Socket,
          )? combine) =>
      (super.noSuchMethod(
        Invocation.method(
          #reduce,
          [combine],
        ),
        returnValue: _i4.Future<_i2.Socket>.value(_FakeSocket_4(
          this,
          Invocation.method(
            #reduce,
            [combine],
          ),
        )),
      ) as _i4.Future<_i2.Socket>);
  @override
  _i4.Future<S> fold<S>(
    S? initialValue,
    S Function(
      S,
      _i2.Socket,
    )? combine,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #fold,
          [
            initialValue,
            combine,
          ],
        ),
        returnValue: _i7.ifNotNull(
              _i7.dummyValueOrNull<S>(
                this,
                Invocation.method(
                  #fold,
                  [
                    initialValue,
                    combine,
                  ],
                ),
              ),
              (S v) => _i4.Future<S>.value(v),
            ) ??
            _FakeFuture_3<S>(
              this,
              Invocation.method(
                #fold,
                [
                  initialValue,
                  combine,
                ],
              ),
            ),
      ) as _i4.Future<S>);
  @override
  _i4.Future<String> join([String? separator = r'']) => (super.noSuchMethod(
        Invocation.method(
          #join,
          [separator],
        ),
        returnValue: _i4.Future<String>.value(''),
      ) as _i4.Future<String>);
  @override
  _i4.Future<bool> contains(Object? needle) => (super.noSuchMethod(
        Invocation.method(
          #contains,
          [needle],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
  @override
  _i4.Future<void> forEach(void Function(_i2.Socket)? action) =>
      (super.noSuchMethod(
        Invocation.method(
          #forEach,
          [action],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<bool> every(bool Function(_i2.Socket)? test) =>
      (super.noSuchMethod(
        Invocation.method(
          #every,
          [test],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
  @override
  _i4.Future<bool> any(bool Function(_i2.Socket)? test) => (super.noSuchMethod(
        Invocation.method(
          #any,
          [test],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
  @override
  _i4.Stream<R> cast<R>() => (super.noSuchMethod(
        Invocation.method(
          #cast,
          [],
        ),
        returnValue: _i4.Stream<R>.empty(),
      ) as _i4.Stream<R>);
  @override
  _i4.Future<List<_i2.Socket>> toList() => (super.noSuchMethod(
        Invocation.method(
          #toList,
          [],
        ),
        returnValue: _i4.Future<List<_i2.Socket>>.value(<_i2.Socket>[]),
      ) as _i4.Future<List<_i2.Socket>>);
  @override
  _i4.Future<Set<_i2.Socket>> toSet() => (super.noSuchMethod(
        Invocation.method(
          #toSet,
          [],
        ),
        returnValue: _i4.Future<Set<_i2.Socket>>.value(<_i2.Socket>{}),
      ) as _i4.Future<Set<_i2.Socket>>);
  @override
  _i4.Future<E> drain<E>([E? futureValue]) => (super.noSuchMethod(
        Invocation.method(
          #drain,
          [futureValue],
        ),
        returnValue: _i7.ifNotNull(
              _i7.dummyValueOrNull<E>(
                this,
                Invocation.method(
                  #drain,
                  [futureValue],
                ),
              ),
              (E v) => _i4.Future<E>.value(v),
            ) ??
            _FakeFuture_3<E>(
              this,
              Invocation.method(
                #drain,
                [futureValue],
              ),
            ),
      ) as _i4.Future<E>);
  @override
  _i4.Stream<_i2.Socket> take(int? count) => (super.noSuchMethod(
        Invocation.method(
          #take,
          [count],
        ),
        returnValue: _i4.Stream<_i2.Socket>.empty(),
      ) as _i4.Stream<_i2.Socket>);
  @override
  _i4.Stream<_i2.Socket> takeWhile(bool Function(_i2.Socket)? test) =>
      (super.noSuchMethod(
        Invocation.method(
          #takeWhile,
          [test],
        ),
        returnValue: _i4.Stream<_i2.Socket>.empty(),
      ) as _i4.Stream<_i2.Socket>);
  @override
  _i4.Stream<_i2.Socket> skip(int? count) => (super.noSuchMethod(
        Invocation.method(
          #skip,
          [count],
        ),
        returnValue: _i4.Stream<_i2.Socket>.empty(),
      ) as _i4.Stream<_i2.Socket>);
  @override
  _i4.Stream<_i2.Socket> skipWhile(bool Function(_i2.Socket)? test) =>
      (super.noSuchMethod(
        Invocation.method(
          #skipWhile,
          [test],
        ),
        returnValue: _i4.Stream<_i2.Socket>.empty(),
      ) as _i4.Stream<_i2.Socket>);
  @override
  _i4.Stream<_i2.Socket> distinct(
          [bool Function(
            _i2.Socket,
            _i2.Socket,
          )? equals]) =>
      (super.noSuchMethod(
        Invocation.method(
          #distinct,
          [equals],
        ),
        returnValue: _i4.Stream<_i2.Socket>.empty(),
      ) as _i4.Stream<_i2.Socket>);
  @override
  _i4.Future<_i2.Socket> firstWhere(
    bool Function(_i2.Socket)? test, {
    _i2.Socket Function()? orElse,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #firstWhere,
          [test],
          {#orElse: orElse},
        ),
        returnValue: _i4.Future<_i2.Socket>.value(_FakeSocket_4(
          this,
          Invocation.method(
            #firstWhere,
            [test],
            {#orElse: orElse},
          ),
        )),
      ) as _i4.Future<_i2.Socket>);
  @override
  _i4.Future<_i2.Socket> lastWhere(
    bool Function(_i2.Socket)? test, {
    _i2.Socket Function()? orElse,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #lastWhere,
          [test],
          {#orElse: orElse},
        ),
        returnValue: _i4.Future<_i2.Socket>.value(_FakeSocket_4(
          this,
          Invocation.method(
            #lastWhere,
            [test],
            {#orElse: orElse},
          ),
        )),
      ) as _i4.Future<_i2.Socket>);
  @override
  _i4.Future<_i2.Socket> singleWhere(
    bool Function(_i2.Socket)? test, {
    _i2.Socket Function()? orElse,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #singleWhere,
          [test],
          {#orElse: orElse},
        ),
        returnValue: _i4.Future<_i2.Socket>.value(_FakeSocket_4(
          this,
          Invocation.method(
            #singleWhere,
            [test],
            {#orElse: orElse},
          ),
        )),
      ) as _i4.Future<_i2.Socket>);
  @override
  _i4.Future<_i2.Socket> elementAt(int? index) => (super.noSuchMethod(
        Invocation.method(
          #elementAt,
          [index],
        ),
        returnValue: _i4.Future<_i2.Socket>.value(_FakeSocket_4(
          this,
          Invocation.method(
            #elementAt,
            [index],
          ),
        )),
      ) as _i4.Future<_i2.Socket>);
  @override
  _i4.Stream<_i2.Socket> timeout(
    Duration? timeLimit, {
    void Function(_i4.EventSink<_i2.Socket>)? onTimeout,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #timeout,
          [timeLimit],
          {#onTimeout: onTimeout},
        ),
        returnValue: _i4.Stream<_i2.Socket>.empty(),
      ) as _i4.Stream<_i2.Socket>);
}

/// A class which mocks [Message].
///
/// See the documentation for Mockito's code generation for more information.
class MockMessage extends _i1.Mock implements _i5.Message {
  MockMessage() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.MessageHeader get header => (super.noSuchMethod(
        Invocation.getter(#header),
        returnValue: _FakeMessageHeader_6(
          this,
          Invocation.getter(#header),
        ),
      ) as _i5.MessageHeader);
  @override
  set header(_i5.MessageHeader? _header) => super.noSuchMethod(
        Invocation.setter(
          #header,
          _header,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i6.Uint8List get body => (super.noSuchMethod(
        Invocation.getter(#body),
        returnValue: _i6.Uint8List(0),
      ) as _i6.Uint8List);
  @override
  set body(_i6.Uint8List? _body) => super.noSuchMethod(
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

/// A class which mocks [CommandFactory].
///
/// See the documentation for Mockito's code generation for more information.
class MockCommandFactory extends _i1.Mock implements _i8.CommandFactory {
  MockCommandFactory() {
    _i1.throwOnMissingStub(this);
  }
}

/// A class which mocks [Command].
///
/// See the documentation for Mockito's code generation for more information.
class MockCommand extends _i1.Mock implements _i8.Command {
  MockCommand() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get command => (super.noSuchMethod(
        Invocation.getter(#command),
        returnValue: '',
      ) as String);
  @override
  void execute(_i6.Uint8List? data) => super.noSuchMethod(
        Invocation.method(
          #execute,
          [data],
        ),
        returnValueForMissingStub: null,
      );
}
