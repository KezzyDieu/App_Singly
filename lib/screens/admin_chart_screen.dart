// admin_chart_screen.dart
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AdminChartScreen extends StatefulWidget {
  const AdminChartScreen({super.key});

  @override
  State<AdminChartScreen> createState() => _AdminChartScreenState();
}

class _AdminChartScreenState extends State<AdminChartScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse(
          'https://charts.mongodb.com/charts-traductormanos-ixbtwoz/embed/dashboards?id=b608a6e2-4f65-4176-8c7b-896da3850a60&theme=dark&autoRefresh=true&maxDataAge=3600&showTitleAndDesc=false&scalingWidth=fixed&scalingHeight=fixed',
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gráficas Administrador'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.amber,
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
