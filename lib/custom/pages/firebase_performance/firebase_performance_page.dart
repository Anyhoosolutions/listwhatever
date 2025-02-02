import 'dart:async';

import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class FirebasePerformancePage extends StatefulWidget {
  const FirebasePerformancePage({super.key});

  @override
  State<FirebasePerformancePage> createState() =>
      _FirebasePerformancePageState();
}

class _MetricHttpClient extends BaseClient {
  _MetricHttpClient(this._inner);

  final Client _inner;

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    // Custom network monitoring is not supported for web.
    // https://firebase.google.com/docs/perf-mon/custom-network-traces?platform=android
    final metric = FirebasePerformance.instance
        .newHttpMetric(request.url.toString(), HttpMethod.Get)
      ..requestPayloadSize = request.contentLength;
    await metric.start();

    StreamedResponse response;
    try {
      response = await _inner.send(request);

      metric
        ..responseContentType = 'text/html'
        ..httpResponseCode = response.statusCode
        ..responsePayloadSize = response.contentLength
        ..putAttribute('score', '15')
        ..putAttribute('to_be_removed', 'should_not_be_logged');
    } finally {
      metric.removeAttribute('to_be_removed');
      await metric.stop();
    }

    final attributes = metric.getAttributes();
    print('Http metric attributes: $attributes.');

    final score = metric.getAttribute('score');
    print('Http metric score attribute value: $score');

    return response;
  }
}

class _FirebasePerformancePageState extends State<FirebasePerformancePage> {
  final FirebasePerformance _performance = FirebasePerformance.instance;
  bool _isPerformanceCollectionEnabled = false;
  String _performanceCollectionMessage =
      'Unknown status of performance collection.';
  bool _trace1HasRan = false;
  bool _trace2HasRan = false;
  bool _customHttpMetricHasRan = false;

  @override
  void initState() {
    super.initState();
    _togglePerformanceCollection();
  }

  Future<void> _togglePerformanceCollection() async {
    // No-op for web.
    await _performance
        .setPerformanceCollectionEnabled(!_isPerformanceCollectionEnabled);

    // Always true for web.
    final isEnabled = await _performance.isPerformanceCollectionEnabled();
    setState(() {
      _isPerformanceCollectionEnabled = isEnabled;
      _performanceCollectionMessage = _isPerformanceCollectionEnabled
          ? 'Performance collection is enabled.'
          : 'Performance collection is disabled.';
    });
  }

  Future<void> _testTrace1() async {
    setState(() {
      _trace1HasRan = false;
    });

    final trace = _performance.newTrace('test_trace_3');
    await trace.start();
    trace
      ..putAttribute('favorite_color', 'blue')
      ..putAttribute('to_be_removed', 'should_not_be_logged')
      ..incrementMetric('sum', 200)
      ..incrementMetric('total', 342)
      ..removeAttribute('to_be_removed');
    await trace.stop();

    final sum = trace.getMetric('sum');
    print('test_trace_1 sum value: $sum');

    final attributes = trace.getAttributes();
    print('test_trace_1 attributes: $attributes');

    final favoriteColor = trace.getAttribute('favorite_color');
    print('test_trace_1 favorite_color: $favoriteColor');

    setState(() {
      _trace1HasRan = true;
    });
  }

  Future<void> _testTrace2() async {
    setState(() {
      _trace2HasRan = false;
    });

    final trace = FirebasePerformance.instance.newTrace('test_trace_2');
    await trace.start();

    trace
      ..setMetric('sum', 333)
      ..setMetric('sum_2', 895);
    await trace.stop();

    final sum2 = trace.getMetric('sum');
    print('test_trace_2 sum value: $sum2');

    setState(() {
      _trace2HasRan = true;
    });
  }

  Future<void> _testCustomHttpMetric() async {
    setState(() {
      _customHttpMetricHasRan = false;
    });

    final metricHttpClient = _MetricHttpClient(Client());

    final request = Request(
      'SEND',
      Uri.parse('https://www.bbc.co.uk'),
    );

    unawaited(metricHttpClient.send(request));

    setState(() {
      _customHttpMetricHasRan = true;
    });
  }

  Future<void> _testAutomaticHttpMetric() async {
    final response = await get(Uri.parse('https://www.google.com'));
    print('Called facebook, response code: ${response.statusCode}');
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(color: Colors.lightGreenAccent, fontSize: 25);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Performance Example'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(_performanceCollectionMessage),
            ElevatedButton(
              onPressed: _togglePerformanceCollection,
              child: const Text('Toggle Data Collection'),
            ),
            ElevatedButton(
              onPressed: _testTrace1,
              child: const Text('Run Trace One'),
            ),
            Text(
              _trace1HasRan ? 'Trace Ran!' : '',
              style: textStyle,
            ),
            ElevatedButton(
              onPressed: _testTrace2,
              child: const Text('Run Trace Two'),
            ),
            Text(
              _trace2HasRan ? 'Trace Ran!' : '',
              style: textStyle,
            ),
            ElevatedButton(
              onPressed: _testCustomHttpMetric,
              child: const Text('Run Custom HttpMetric'),
            ),
            Text(
              _customHttpMetricHasRan ? 'Custom HttpMetric Ran!' : '',
              style: textStyle,
            ),
            ElevatedButton(
              onPressed: _testAutomaticHttpMetric,
              child: const Text('Run Automatic HttpMetric'),
            ),
          ],
        ),
      ),
    );
  }
}
