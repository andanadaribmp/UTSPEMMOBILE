import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kantin_menu_app/main.dart';

void main() {
  testWidgets('menu awal membuka detail dan dapat kembali', (tester) async {
    await tester.pumpWidget(const AplikasiKantin());
    await tester.pumpAndSettle();

    expect(find.text('Nasi Goreng Kampung'), findsOneWidget);
    await tester.tap(find.text('Nasi Goreng Kampung'));
    await tester.pumpAndSettle();

    expect(find.text('Detail Menu'), findsOneWidget);
    expect(find.text('Rp 15.000'), findsOneWidget);
    expect(
      find.text('Nasi goreng wangi dengan bumbu rumahan dan telur mata sapi.'),
      findsOneWidget,
    );
    expect(find.text('Gurih'), findsOneWidget);
    expect(
      find.text('Nasi, telur, ayam suwir, kecap, bawang merah, bawang putih'),
      findsOneWidget,
    );

    await tester.tap(find.byTooltip('Kembali'));
    await tester.pumpAndSettle();
    expect(find.text('Menu Kantin'), findsOneWidget);
  });

  testWidgets('form validasi input dan menambahkan menu baru', (tester) async {
    tester.view.physicalSize = const Size(400, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const AplikasiKantin());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Tambah menu'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Simpan menu'));
    await tester.pumpAndSettle();
    expect(find.text('Nama menu tidak boleh kosong'), findsOneWidget);
    expect(find.text('Harga tidak boleh kosong'), findsOneWidget);

    final namaMenu = find.byType(TextFormField).at(0);
    final hargaMenu = find.byType(TextFormField).at(1);
    await tester.enterText(namaMenu, 'Bakso Urat');
    await tester.enterText(hargaMenu, '12a3');
    await tester.pump();
    expect(find.text('123'), findsOneWidget);

    await tester.enterText(hargaMenu, '12500');
    tester.testTextInput.hide();
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Simpan menu'));
    await tester.tap(find.text('Simpan menu'));
    await tester.pumpAndSettle();

    expect(find.text('Bakso Urat'), findsOneWidget);
    expect(find.text('Rp 12.500'), findsOneWidget);

    await tester.tap(find.text('Bakso Urat'));
    await tester.pumpAndSettle();
    expect(
      find.text(
        'Menu lezat pilihan kantin, dibuat segar untuk menemani harimu.',
      ),
      findsOneWidget,
    );
    expect(find.text('Bahan pilihan dan bumbu khas kantin.'), findsOneWidget);
  });
}
