import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/tarot_all.dart';
import '../providers/x_add_task_notifier.dart';

class XAddTaskScreen extends ConsumerWidget {
  XAddTaskScreen({super.key, this.initial});

  final TarotAll? initial;

  final formKey = GlobalKey<FormState>();

  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = addTaskNotifierProvider(initial);
    final state = ref.watch(provider);
    final notifier = ref.watch(provider.notifier);

    return LoadingLayer(
      loading: state.loading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('add task screen'),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20).copyWith(top: 0),
            child: FilledButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  try {
                    await notifier.add();

                    Navigator.pop(context);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('add error'),
                      ),
                    );
                  }
                }
              },
              child: const Text('Save'),
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('name'),
                const SizedBox(height: 10),
                TextFormField(
                  initialValue: state.tarotAll.name,
                  textCapitalization: TextCapitalization.sentences,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }

                    return '';
                  },
//                  onChanged: notifier.nameChanged(name: name),
                ),
                const SizedBox(height: 24),
                const Text('description'),
                const SizedBox(height: 8),
                TextFormField(
                  initialValue: state.tarotAll.image,
                  maxLines: 5,
                  minLines: 3,
                  textCapitalization: TextCapitalization.sentences,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }

                    return '';
                  },
//                  onChanged: notifier.imageChanged(image: image),
                ),
                Row(
                  children: [
                    Checkbox(value: false, onChanged: (value) {}),
                    const Text('Done'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//==============

class LoadingLayer extends StatelessWidget {
  const LoadingLayer({
    super.key,
    this.loading = false,
    required this.child,
  });

  final bool loading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (loading) ...[
          Material(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ],
    );
  }
}
