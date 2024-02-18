import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:menu_data/model.dart';
import 'package:menu_data/main.dart';

void main() {
  testWidgets('Test HomePage widget', (WidgetTester tester) async {
    // Create a mock MenuData object for testing
    final menuData = MenuData(
      success: true,
      data: [
        MenuDataDatum(
          menuCategory: MenuCategory(
            id: 1,
            name: 'Category 1',
          ),
          singleMenuData: SingleMenuData(
            success: true,
            data: [
              SingleMenuDataDatum(
                id: 1,
                menuId: 1,
                status: 1,
                menu: Menu(
                  id: 1,
                  name: 'Menu 1',
                  price: '10',
                ),
                singleMenuItemCategory: [
                  SingleMenuItemCategory(
                    id: 1,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );

    // Wrap the HomePage widget within a MaterialApp for testing
    await tester.pumpWidget(MaterialApp(
      home: ,
    ));

    // Verify that 'Category 1' text is displayed.
    expect(find.text('Category 1'), findsOneWidget);

    // Verify that 'Menu 1' text is displayed.
    expect(find.text('Menu 1'), findsOneWidget);
  });
}
