import 'package:carbase/app/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('apresenta o dashboard em português', (tester) async {
    await tester.pumpWidget(const CarBaseApp());
    await tester.pumpAndSettle();

    expect(find.text('Bom dia, Miguel'), findsOneWidget);
    expect(find.text('Registo rápido'), findsOneWidget);
    expect(find.text('Início'), findsOneWidget);
    expect(find.text('Veículos'), findsOneWidget);
  });

  testWidgets('permite navegar para a garagem', (tester) async {
    await tester.pumpWidget(const CarBaseApp());
    await tester.tap(find.text('Veículos'));
    await tester.pumpAndSettle();

    expect(find.text('A minha garagem'), findsOneWidget);
    expect(find.text('Volkswagen Golf'), findsOneWidget);
  });
}
