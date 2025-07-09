import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/log.dart';

class ViewLogsScreen extends StatefulWidget {
  const ViewLogsScreen({super.key});

  @override
  State<ViewLogsScreen> createState() => _ViewLogsScreenState();
}

class _ViewLogsScreenState extends State<ViewLogsScreen> {
  final dbHelper = DatabaseHelper();
  late Future<List<Log>> logsFuture;

  @override
  void initState() {
    super.initState();
    logsFuture = dbHelper.getLogs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('View Logs')),
      body: FutureBuilder<List<Log>>(
        future: logsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No logs found.'));
          } else {
            final logs = snapshot.data!;
            return ListView.builder(
              itemCount: logs.length,
              itemBuilder: (context, index) {
                final log = logs[index];
                return ListTile(
                  title: Text('${log.field} - ${log.crop}'),
                  subtitle: Text('${log.activity} on ${log.date}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
