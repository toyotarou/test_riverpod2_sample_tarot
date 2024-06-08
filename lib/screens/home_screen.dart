import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/tarot_all_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tarot List')),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.refresh(tarotAllProvider);
        },
        child: ref.watch(tarotAllProvider).when(
              data: (data) {
                return Card(
                  child: ListView(
                    children: data
                        .map(
                          (e) => ListTile(
                            title: Text(e.name),
                            subtitle: Text(e.image),
                          ),
                        )
                        .toList(),
                  ),
                );
              },
              error: (error, stackTrace) => Center(child: Text('$error')),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
      ),
    );
  }
}
