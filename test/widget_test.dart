import 'package:carbase/app/app.dart';
import 'package:carbase/data/local/app_database.dart';
import 'package:carbase/data/local/carbase_repository.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('apresenta o dashboard em português', (tester) async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    final repository = CarBaseRepository(database);
    final initialData = await repository.initialize();
    await tester.pumpWidget(
      CarBaseApp(repository: repository, initialData: initialData),
    );
    await tester.pumpAndSettle();

    expect(find.text('Bom dia, Miguel'), findsOneWidget);
    expect(find.text('Registo rápido'), findsOneWidget);
    expect(find.text('Início'), findsOneWidget);
    expect(find.text('Veículos'), findsOneWidget);
  });

  testWidgets('permite navegar para a garagem', (tester) async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    final repository = CarBaseRepository(database);
    final initialData = await repository.initialize();
    await tester.pumpWidget(
      CarBaseApp(repository: repository, initialData: initialData),
    );
    await tester.tap(find.text('Veículos'));
    await tester.pumpAndSettle();

    expect(find.text('A minha garagem'), findsOneWidget);
    expect(find.text('Volkswagen Golf'), findsOneWidget);
  });
}
