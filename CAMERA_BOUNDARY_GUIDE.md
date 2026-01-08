# Panduan Camera Boundary - Agar Kamera Tidak Keluar Map

Ada 2 cara untuk membatasi kamera:

---

## Cara 1: Camera Limit (Recommended)

Cara ini membatasi kamera agar tidak melewati batas map.

### Setup di Godot Editor:

#### Opsi A: Manual di Inspector

1. Buka `scenes/player.tscn`
2. Klik node **Camera2D**
3. Di Inspector, cari bagian **Limit**:
   - **Left**: 0
   - **Top**: 0
   - **Right**: 2000 (sesuaikan dengan lebar background)
   - **Bottom**: 2000 (sesuaikan dengan tinggi background)
4. Centang **Limit Smoothed** (untuk smooth transition)
5. Save dan test

#### Opsi B: Pakai Script (Auto Setup)

1. Buka `scenes/player.tscn`
2. Klik node **Camera2D**
3. Attach script: `scripts/camera_limit.gd`
4. Di Inspector, set export variables:
   - **Map Width**: 2000 (lebar background)
   - **Map Height**: 2000 (tinggi background)
   - **Map Offset**: (0, 0) atau sesuai posisi background
5. Save dan test

Script akan otomatis set camera limits saat game start.

---

## Cara 2: World Boundary Script (Auto-detect)

Script ini otomatis mencari camera dan set limits.

### Setup:

1. Buka `scenes/world.tscn`
2. Klik node **World** (root Node2D)
3. Attach script: `scripts/world_boundary.gd`
4. Di Inspector, set:
   - **Map Width**: 2000
   - **Map Height**: 2000
   - **Map Offset**: (0, 0)
5. Save dan test

Script akan otomatis cari Camera2D di scene dan set limits-nya.

---

## Cara 3: Player Boundary (Clamp Position)

Alternatif: Batasi posisi player langsung, bukan kamera.

### Setup:

1. Buka `scenes/player.tscn`
2. Klik node **Player** (CharacterBody2D)
3. Ganti script dengan: `scripts/player_with_boundary.gd`
4. Di Inspector, set:
   - **Map Min**: (0, 0)
   - **Map Max**: (2000, 2000)
   - **Enable Boundary**: ✓ (checked)
5. Save dan test

Player tidak bisa keluar dari area yang ditentukan.

---

## Cara Menentukan Ukuran Map:

### Jika Pakai ColorRect:
- Lihat Size di Inspector ColorRect
- Contoh: 2000 x 2000

### Jika Pakai Sprite2D:
- Lihat ukuran texture
- Atau lihat Region Rect di Inspector

### Jika Pakai TileMap:
- Hitung: tile_size × jumlah_tiles
- Contoh: 32px × 50 tiles = 1600px

### Jika Background Tidak di (0,0):
- Set **Map Offset** sesuai posisi background
- Contoh: Background di (-500, -500), size 2000x2000
  - Map Offset: (-500, -500)
  - Map Width: 2000
  - Map Height: 2000

---

## Rekomendasi:

**Untuk game farming:**
- Pakai **Cara 1 (Camera Limit)** - paling standard
- Set limit sesuai ukuran map
- Enable **Limit Smoothed** untuk smooth camera

**Untuk map yang dinamis:**
- Pakai **Cara 2 (World Boundary Script)**
- Bisa ganti map size dari script

**Untuk multiple areas:**
- Pakai script yang update camera limits saat pindah area
- Contoh: Masuk ke barn, camera limit berubah

---

## Testing:

1. Run game (F5)
2. Gerakkan player ke tepi map
3. Camera harus berhenti di batas, tidak keluar dari background
4. Check Output console untuk konfirmasi limits

---

## Troubleshooting:

### Camera masih keluar dari map:
- Pastikan limit values sudah benar
- Check apakah background size sesuai dengan limit
- Pastikan camera zoom tidak terlalu besar

### Camera terlalu ketat:
- Tambahkan margin ke limits
- Contoh: Right = map_width - 100

### Camera tidak smooth:
- Enable **Limit Smoothed**
- Adjust **Position Smoothing** di Camera2D

---

## Quick Setup (Copy-Paste):

Di Camera2D Inspector:
```
Limit:
  Left: 0
  Top: 0
  Right: 2000
  Bottom: 2000
  Smoothed: ✓
```

Sesuaikan Right dan Bottom dengan ukuran background kamu!

---

## Mau Saya Setup Langsung?

Kasih tau:
1. Ukuran background kamu (width x height)
2. Posisi background (offset dari 0,0)
3. Mau pakai cara yang mana (1, 2, atau 3)

Saya akan setup langsung di scene kamu!
