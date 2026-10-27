import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const AplikasiKantin());
}

class AplikasiKantin extends StatelessWidget {
  const AplikasiKantin({super.key});

  @override
  Widget build(BuildContext context) {
    const warnaUtama = Color(0xFFE53935);
    const warnaAksen = Color(0xFFFF8A00);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Menu Kantin',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: warnaUtama,
          primary: warnaUtama,
          secondary: warnaAksen,
          surface: const Color(0xFFFFF8F2),
        ),
        scaffoldBackgroundColor: const Color(0xFFFFF8F2),
        appBarTheme: const AppBarTheme(
          backgroundColor: warnaUtama,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFF1DED3)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFF1DED3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: warnaUtama, width: 1.5),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: warnaAksen,
          foregroundColor: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: const HalamanDaftarMenu(),
    );
  }
}

// Poppins dipilih agar informasi menu terasa ramah dan mudah dibaca di layar kecil.
// Aksen merah-oranye memberi kesan hangat dan menggugah selera tanpa mengganggu keterbacaan.
class TeksKantin extends StatelessWidget {
  const TeksKantin(
    this.teks, {
    super.key,
    this.ukuran = 16,
    this.ketebalan = FontWeight.w400,
    this.warna = const Color(0xFF3B2924),
    this.maksimalBaris,
    this.overflow,
  });

  final String teks;
  final double ukuran;
  final FontWeight ketebalan;
  final Color warna;
  final int? maksimalBaris;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      teks,
      maxLines: maksimalBaris,
      overflow: overflow,
      style: GoogleFonts.poppins(
        fontSize: ukuran,
        fontWeight: ketebalan,
        color: warna,
      ),
    );
  }
}

class MenuKantin {
  const MenuKantin({
    required this.nama,
    required this.harga,
    required this.deskripsi,
    required this.rasa,
    required this.bahan,
    this.emoji = '🍽️',
  });

  final String nama;
  final int harga;
  final String deskripsi;
  final String rasa;
  final String bahan;
  final String emoji;
}

String formatRupiah(int nilai) {
  final angka = nilai.toString();
  final hasil = StringBuffer();

  for (var indeks = 0; indeks < angka.length; indeks++) {
    if (indeks > 0 && (angka.length - indeks) % 3 == 0) {
      hasil.write('.');
    }
    hasil.write(angka[indeks]);
  }

  return 'Rp $hasil';
}

class HalamanDaftarMenu extends StatefulWidget {
  const HalamanDaftarMenu({super.key});

  @override
  State<HalamanDaftarMenu> createState() => _HalamanDaftarMenuState();
}

class _HalamanDaftarMenuState extends State<HalamanDaftarMenu> {
  final List<MenuKantin> _daftarMenu = [
    const MenuKantin(
      nama: 'Nasi Goreng Kampung',
      harga: 15000,
      deskripsi: 'Nasi goreng wangi dengan bumbu rumahan dan telur mata sapi.',
      rasa: 'Gurih',
      bahan: 'Nasi, telur, ayam suwir, kecap, bawang merah, bawang putih',
      emoji: '🍛',
    ),
    const MenuKantin(
      nama: 'Ayam Bakar Madu',
      harga: 22000,
      deskripsi: 'Ayam bakar empuk berbalut olesan madu manis gurih.',
      rasa: 'Manis & Gurih',
      bahan: 'Ayam, madu, kecap manis, bawang putih, jeruk nipis',
      emoji: '🍗',
    ),
    const MenuKantin(
      nama: 'Mie Goreng Spesial',
      harga: 17000,
      deskripsi: 'Mie kenyal dengan sayuran segar dan bumbu tumis pilihan.',
      rasa: 'Pedas & Gurih',
      bahan: 'Mie, sawi, telur, bakso, cabai, kecap',
      emoji: '🍜',
    ),
    const MenuKantin(
      nama: 'Soto Ayam',
      harga: 18000,
      deskripsi: 'Soto ayam hangat dengan kuah kuning segar dan taburan koya.',
      rasa: 'Gurih',
      bahan: 'Ayam, soun, kol, kunyit, serai, jeruk nipis',
      emoji: '🥣',
    ),
    const MenuKantin(
      nama: 'Es Teh Lemon',
      harga: 7000,
      deskripsi: 'Teh dingin yang menyegarkan dengan perasan lemon asli.',
      rasa: 'Manis & Asam',
      bahan: 'Teh, lemon, gula, es batu',
      emoji: '🍋',
    ),
  ];

  Future<void> _bukaFormTambah() async {
    final menuBaru = await Get.to<MenuKantin>(() => const HalamanTambahMenu());

    if (!mounted || menuBaru == null) {
      return;
    }

    setState(() {
      _daftarMenu.add(menuBaru);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.local_dining_rounded, size: 25),
            const SizedBox(width: 9),
            const TeksKantin(
              'Menu Kantin',
              ukuran: 22,
              ketebalan: FontWeight.w700,
              warna: Colors.white,
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFE53935), Color(0xFFFF8A00)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TeksKantin(
                          'Lagi lapar?',
                          ukuran: 21,
                          ketebalan: FontWeight.w700,
                          warna: Colors.white,
                        ),
                        SizedBox(height: 4),
                        TeksKantin(
                          'Temukan menu favoritmu hari ini.',
                          ukuran: 12,
                          warna: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  const TeksKantin('🍱', ukuran: 44),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 12),
            child: TeksKantin(
              'Menu pilihan',
              ukuran: 18,
              ketebalan: FontWeight.w700,
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              itemCount: _daftarMenu.length,
              itemBuilder: (context, indeks) {
                final menu = _daftarMenu[indeks];

                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  color: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(color: Color(0xFFF1E6DE)),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    leading: Container(
                      width: 52,
                      height: 52,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF0E2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TeksKantin(menu.emoji, ukuran: 29),
                    ),
                    title: TeksKantin(
                      menu.nama,
                      ukuran: 15,
                      ketebalan: FontWeight.w600,
                    ),
                    subtitle: TeksKantin(
                      formatRupiah(menu.harga),
                      ukuran: 13,
                      ketebalan: FontWeight.w600,
                      warna: const Color(0xFFE53935),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right_rounded,
                      color: Color(0xFFFF8A00),
                    ),
                    onTap: () {
                      Get.to<void>(() => HalamanDetailMenu(menu: menu));
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _bukaFormTambah,
        icon: const Icon(Icons.add),
        label: const TeksKantin(
          'Tambah menu',
          ukuran: 14,
          ketebalan: FontWeight.w600,
          warna: Colors.white,
        ),
      ),
    );
  }
}

class HalamanDetailMenu extends StatelessWidget {
  const HalamanDetailMenu({required this.menu, super.key});

  final MenuKantin menu;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Kembali',
          onPressed: Get.back,
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: const TeksKantin(
          'Detail Menu',
          ukuran: 20,
          ketebalan: FontWeight.w700,
          warna: Colors.white,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 30),
        children: [
          Container(
            height: 210,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFFE0C2), Color(0xFFFFF2E5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(26),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Icon(Icons.circle, size: 152, color: Color(0xFFFFC078)),
                TeksKantin(menu.emoji, ukuran: 92),
                Positioned(
                  right: 14,
                  bottom: 14,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.star_rounded,
                          color: Color(0xFFFF8A00),
                          size: 18,
                        ),
                        SizedBox(width: 4),
                        TeksKantin(
                          'Favorit kantin',
                          ukuran: 11,
                          ketebalan: FontWeight.w600,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          TeksKantin(
            menu.nama,
            ukuran: 24,
            ketebalan: FontWeight.w700,
            maksimalBaris: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 7),
          TeksKantin(
            formatRupiah(menu.harga),
            ukuran: 20,
            ketebalan: FontWeight.w700,
            warna: const Color(0xFFE53935),
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _LabelInfoMenu(
                ikon: Icons.local_fire_department_rounded,
                label: menu.rasa,
              ),
              const _LabelInfoMenu(
                ikon: Icons.thumb_up_alt_rounded,
                label: 'Dibuat fresh',
              ),
            ],
          ),
          const SizedBox(height: 22),
          _BagianDetailMenu(
            judul: 'Tentang menu',
            isi: menu.deskripsi,
            ikon: Icons.notes_rounded,
          ),
          const SizedBox(height: 18),
          _BagianDetailMenu(
            judul: 'Bahan-bahan',
            isi: menu.bahan,
            ikon: Icons.eco_outlined,
          ),
        ],
      ),
    );
  }
}

class _LabelInfoMenu extends StatelessWidget {
  const _LabelInfoMenu({required this.ikon, required this.label});

  final IconData ikon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE9D4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(ikon, size: 16, color: const Color(0xFFE65B16)),
          const SizedBox(width: 5),
          TeksKantin(
            label,
            ukuran: 12,
            ketebalan: FontWeight.w600,
            warna: const Color(0xFF9A421F),
          ),
        ],
      ),
    );
  }
}

class _BagianDetailMenu extends StatelessWidget {
  const _BagianDetailMenu({
    required this.judul,
    required this.isi,
    required this.ikon,
  });

  final String judul;
  final String isi;
  final IconData ikon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFF1E6DE)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(ikon, color: const Color(0xFFE53935)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TeksKantin(judul, ukuran: 14, ketebalan: FontWeight.w700),
                const SizedBox(height: 6),
                TeksKantin(isi, ukuran: 13, warna: const Color(0xFF75665F)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HalamanTambahMenu extends StatefulWidget {
  const HalamanTambahMenu({super.key});

  @override
  State<HalamanTambahMenu> createState() => _HalamanTambahMenuState();
}

class _HalamanTambahMenuState extends State<HalamanTambahMenu> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _hargaController = TextEditingController();
  final _deskripsiController = TextEditingController();
  final _bahanController = TextEditingController();
  String _rasaPilihan = 'Gurih';

  @override
  void dispose() {
    _namaController.dispose();
    _hargaController.dispose();
    _deskripsiController.dispose();
    _bahanController.dispose();
    super.dispose();
  }

  void _simpanMenu() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    Get.back(
      result: MenuKantin(
        nama: _namaController.text.trim(),
        harga: int.parse(_hargaController.text),
        deskripsi: _deskripsiController.text.trim().isEmpty
            ? 'Menu lezat pilihan kantin, dibuat segar untuk menemani harimu.'
            : _deskripsiController.text.trim(),
        rasa: _rasaPilihan,
        bahan: _bahanController.text.trim().isEmpty
            ? 'Bahan pilihan dan bumbu khas kantin.'
            : _bahanController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Kembali',
          onPressed: Get.back,
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: const TeksKantin(
          'Tambah Menu',
          ukuran: 20,
          ketebalan: FontWeight.w700,
          warna: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _namaController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Nama menu',
                  hintText: 'Contoh: Nasi ayam rica-rica',
                  prefixIcon: Icon(Icons.restaurant_outlined),
                ),
                validator: (nilai) {
                  if (nilai == null || nilai.trim().isEmpty) {
                    return 'Nama menu tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _hargaController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: 'Harga',
                  hintText: 'Contoh: 15000',
                  prefixIcon: Icon(Icons.payments_outlined),
                  prefixText: 'Rp ',
                ),
                validator: (nilai) {
                  if (nilai == null || nilai.trim().isEmpty) {
                    return 'Harga tidak boleh kosong';
                  }
                  if (int.tryParse(nilai) == null) {
                    return 'Harga harus berupa angka';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _rasaPilihan,
                decoration: const InputDecoration(
                  labelText: 'Jenis rasa',
                  prefixIcon: Icon(Icons.local_fire_department_outlined),
                ),
                items: const [
                  DropdownMenuItem(value: 'Gurih', child: Text('Gurih')),
                  DropdownMenuItem(value: 'Pedas', child: Text('Pedas')),
                  DropdownMenuItem(value: 'Manis', child: Text('Manis')),
                  DropdownMenuItem(value: 'Asam', child: Text('Asam')),
                  DropdownMenuItem(
                    value: 'Pedas & Gurih',
                    child: Text('Pedas & Gurih'),
                  ),
                  DropdownMenuItem(
                    value: 'Manis & Gurih',
                    child: Text('Manis & Gurih'),
                  ),
                  DropdownMenuItem(
                    value: 'Manis & Asam',
                    child: Text('Manis & Asam'),
                  ),
                ],
                onChanged: (rasa) {
                  if (rasa != null) {
                    setState(() {
                      _rasaPilihan = rasa;
                    });
                  }
                },
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _deskripsiController,
                textCapitalization: TextCapitalization.sentences,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Deskripsi',
                  hintText: 'Ceritakan rasa dan keistimewaan menu',
                  alignLabelWithHint: true,
                  prefixIcon: Icon(Icons.notes_rounded),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _bahanController,
                textCapitalization: TextCapitalization.sentences,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'Bahan-bahan',
                  hintText: 'Contoh: ayam, cabai, bawang, kecap',
                  alignLabelWithHint: true,
                  prefixIcon: Icon(Icons.eco_outlined),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _simpanMenu,
                icon: const Icon(Icons.save_outlined),
                label: const TeksKantin(
                  'Simpan menu',
                  ukuran: 15,
                  ketebalan: FontWeight.w600,
                  warna: Colors.white,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE53935),
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
