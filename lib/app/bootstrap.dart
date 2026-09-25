import 'package:flutter/material.dart';

import '../data/local/app_database.dart';
import '../data/local/carbase_repository.dart';
import 'app.dart';
import 'theme/app_colors.dart';
import 'theme/app_theme.dart';

class CarBaseBootstrap extends StatefulWidget {
  const CarBaseBootstrap({super.key});

  @override
  State<CarBaseBootstrap> createState() => _CarBaseBootstrapState();
}

class _CarBaseBootstrapState extends State<CarBaseBootstrap> {
  late Future<_StartupData> _startup;

  @override
  void initState() {
    super.initState();
    _startup = _initialize();
  }

  Future<_StartupData> _initialize() async {
    final repository = CarBaseRepository(AppDatabase());
    final initialData = await repository.initialize();
    return _StartupData(repository, initialData);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<_StartupData>(
      future: _startup,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return CarBaseApp(
            repository: snapshot.data!.repository,
            initialData: snapshot.data!.snapshot,
          );
        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          home: Scaffold(
            body: SafeArea(
              child: Center(
                child: snapshot.hasError
                    ? _StartupError(
                        onRetry: () => setState(() => _startup = _initialize()),
                      )
                    : const _StartupLoading(),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _StartupLoading extends StatelessWidget {
  const _StartupLoading();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 34,
          height: 34,
          child: CircularProgressIndicator(strokeWidth: 3),
        ),
        SizedBox(height: 18),
        Text('A preparar a sua garagem…'),
      ],
    );
  }
}

class _StartupError extends StatelessWidget {
  const _StartupError({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: AppColors.danger.withValues(alpha: .1),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.storage_rounded,
              color: AppColors.danger,
              size: 28,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'Não foi possível abrir os dados locais',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Os seus dados não foram alterados. Tente abrir novamente.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('Tentar novamente'),
          ),
        ],
      ),
    );
  }
}

class _StartupData {
  const _StartupData(this.repository, this.snapshot);

  final CarBaseRepository repository;
  final CarBaseSnapshot snapshot;
}
