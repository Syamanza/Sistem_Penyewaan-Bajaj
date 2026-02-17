# Sistem Manajemen Penyewaan Bajaj (Medan) 🛺

Proyek ini adalah sistem database untuk mengelola penyewaan armada Bajaj, mencakup manajemen driver, kendaraan, penyewaan, pembayaran, dan perawatan bengkel.

## Fitur Utama Database
1. **Manajemen Armada:** Status kendaraan (Available, Rented, Maintenance).
2. **Sistem Keuangan:** Pencatatan setoran harian dan deteksi tunggakan (utang).
3. **Log Perawatan:** Riwayat servis di bengkel resmi (Showroom Cemara) dan bengkel umum.
4. **Validasi Data:** Menggunakan Foreign Key dan Constraint untuk integritas data.

## Cara Import Database
1. Pastikan PostgreSQL sudah terinstall.
2. Buat database kosong bernama `penyewaan_bajaj`.
3. Jalankan file `database_bajaj_final.sql` di Query Tool atau import via pgAdmin.
4. Data dummy tahun 2026 (Medan) akan otomatis terisi.

## Teknologi
- PostgreSQL 16
- pgAdmin 4
