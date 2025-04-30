// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:billing_app/main.dart';

void main() {
  testWidgets('Billing App Widget Test', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(const BillingApp());

    // Verify that the app title is displayed
    expect(find.text('GST Billing App'), findsOneWidget);

    // Verify that the initial widgets are present
    expect(find.text('Product Name'), findsOneWidget);
    expect(find.text('Price'), findsOneWidget);
    expect(find.text('GST Rate'), findsOneWidget);
    expect(find.text('Add Item'), findsOneWidget);

    // Enter product details
    await tester.enterText(find.byType(TextField).first, 'Test Product');
    await tester.enterText(find.byType(TextField).last, '100');

    // Tap the Add Item button
    await tester.tap(find.text('Add Item'));
    await tester.pump();

    // Verify that the product was added
    expect(find.text('Test Product'), findsOneWidget);
    expect(find.text('Price: ₹100 | GST: 5%'), findsOneWidget);
    expect(find.text('₹105.00'), findsOneWidget); // Price + 5% GST
  });
}
