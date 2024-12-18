import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_uts_2301083018_b/main.dart'; 

void main() {
  testWidgets('Test Peminjaman Screen', (WidgetTester tester) async {
    
    await tester.pumpWidget(MyApp());

    
    expect(find.text('Selamat Datang di Aplikasi Peminjaman'), findsOneWidget);

    
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    
    await tester.tap(find.text('Peminjaman'));
    await tester.pumpAndSettle();

    
    expect(find.text('Detail Peminjaman'), findsOneWidget);
    expect(find.text('Jumlah Pinjaman:'), findsOneWidget);
    expect(find.text('Lama Pinjaman:'), findsOneWidget);
    expect(find.text('Angsuran Pokok:'), findsOneWidget);
    expect(find.text('Bunga Per Bulan:'), findsOneWidget);
    expect(find.text('Angsuran Per Bulan:'), findsOneWidget);
    expect(find.text('Total Hutang:'), findsOneWidget);
  });
}

