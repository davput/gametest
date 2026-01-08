# Quick Start - Tambah Background Map

## Cara Tercepat (5 Menit):

### 1. Pakai ColorRect (Temporary)

Di Godot Editor:

1. Buka `scenes/world.tscn`
2. Klik kanan pada "Node2D" (root) > Add Child Node
3. Cari dan pilih **ColorRect**
4. Rename jadi "Background"
5. Di Inspector, set:
   - **Size**: 2000 x 2000 (atau lebih besar dari viewport)
   - **Color**: Pilih warna hijau muda (untuk grass)
   - **Position**: (-500, -500) agar centered
6. Di Scene tree, **drag Background ke paling atas** (agar di belakang semua)
7. Save dan test (F5)

✅ Selesai! Sekarang ada background hijau.

---

## Cara dengan TileMap (Proper Way):

### Step-by-Step:

#### 1. Buat TileMapLayer

1. Buka `scenes/world.tscn`
2. Add Child > **TileMapLayer**
3. Rename jadi "GroundLayer"
4. Drag ke paling atas di scene tree

#### 2. Buat TileSet Sederhana

1. Klik node "GroundLayer"
2. Di Inspector, bagian **Tile Set**:
   - Klik dropdown > "New TileSet"
   - Klik TileSet yang baru muncul (untuk edit)

3. Di panel bawah (TileSet editor):
   - Klik tombol **"+"** (Add TileSet Source)
   - Pilih **"Atlas"**
   - Browse ke `icon.svg` (temporary, nanti ganti)
   - Klik "Open"

4. Set properties:
   - **Texture Region Size**: 128 x 128 (ukuran icon.svg)
   - Klik "Create"

#### 3. Paint Tiles

1. Klik node "GroundLayer" lagi
2. Di panel bawah, switch ke tab **"TileMap"**
3. Klik tile yang muncul (icon.svg)
4. Klik-klik di viewport untuk menggambar tiles
5. Gambar area sekitar 20x15 tiles

#### 4. Test

- Save (Ctrl+S)
- Run (F5)
- Sekarang ada background tile!

---

## Cara dengan Image Background:

### Jika Punya Gambar Background:

1. Simpan gambar di `assets/backgrounds/farm.png`
2. Di world.tscn, Add Child > **Sprite2D**
3. Rename jadi "Background"
4. Di Inspector:
   - **Texture**: Drag `farm.png`
   - **Centered**: Uncheck (false)
   - **Position**: (0, 0)
5. Drag ke paling atas di scene tree
6. Save dan test

---

## Rekomendasi:

**Untuk sekarang (testing):**
- Pakai ColorRect hijau

**Untuk development:**
- Pakai TileMap dengan tileset proper

**Untuk production:**
- Pakai TileMap dengan custom tileset farming

---

## Download Free Tileset:

1. **Kenney Farm Pack**: https://kenney.nl/assets/farm-pack
2. **itch.io Farming**: https://itch.io/game-assets/tag-farming
3. **OpenGameArt**: https://opengameart.org/art-search?keys=farm

Download, extract, simpan di `assets/tilesets/`, lalu setup di TileMap!

---

## Mau Saya Buatkan?

Kalau mau saya buatkan scene dengan background siap pakai, bilang aja:
- "Buatkan dengan ColorRect"
- "Buatkan dengan TileMap"
- "Buatkan dengan Sprite2D"
