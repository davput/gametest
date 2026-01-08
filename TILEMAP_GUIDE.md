# Panduan Menambahkan Background Map (TileMap)

## Untuk Game Farming seperti Stardew Valley

Ada 2 cara: **Dengan Tileset** (recommended) atau **Tanpa Tileset** (simple)

---

## Cara 1: Dengan Tileset (Recommended untuk Game Farming)

### Step 1: Siapkan Tileset Image

Kamu butuh gambar tileset, contoh:
- Grass tiles (berbagai variasi)
- Dirt/tanah
- Path/jalan
- Water/air
- dll

Format: PNG, ukuran tile biasanya 16x16 atau 32x32 pixel

**Contoh struktur tileset:**
```
[Grass1][Grass2][Grass3][Dirt1]
[Path1 ][Path2 ][Water1][Water2]
```

Simpan di: `assets/tilesets/farm_tileset.png`

### Step 2: Buat TileMap di Godot

1. Buka `scenes/world.tscn`
2. Add Child Node > **TileMapLayer**
3. Rename jadi "GroundLayer"
4. Pindahkan ke atas Player di scene tree (agar di belakang player)

### Step 3: Setup TileSet

1. Klik node "GroundLayer"
2. Di Inspector, klik **Tile Set** > "New TileSet"
3. Klik TileSet yang baru dibuat untuk edit
4. Di panel bawah, klik tab "TileSet"
5. Klik tombol "+" untuk add source
6. Pilih "Atlas"
7. Browse dan pilih `farm_tileset.png`
8. Set **Texture Region Size** sesuai ukuran tile (16x16 atau 32x32)

### Step 4: Paint Tiles

1. Klik node "GroundLayer" lagi
2. Di panel bawah, klik tab "TileMap"
3. Pilih tile yang mau di-paint
4. Klik di viewport untuk menggambar
5. Tools:
   - **Paint**: Gambar tile
   - **Line**: Gambar garis
   - **Rect**: Gambar kotak
   - **Bucket**: Fill area
   - **Eraser**: Hapus tile

### Step 5: Atur Layer Order

Di Scene tree, urutan dari atas ke bawah:
```
World
├── GroundLayer (TileMapLayer) <- Paling belakang
├── DecorationLayer (optional)
├── Player
└── UI
```

---

## Cara 2: Tanpa Tileset (Simple - Untuk Testing)

Jika belum punya tileset, pakai ColorRect atau Sprite2D:

### Opsi A: Pakai ColorRect (Solid Color)

1. Buka `scenes/world.tscn`
2. Add Child > **ColorRect**
3. Rename jadi "Background"
4. Set properties:
   - Size: 1920 x 1080 (atau lebih besar)
   - Color: Hijau muda (untuk grass)
   - Position: (0, 0)
5. Pindahkan ke paling atas di scene tree

### Opsi B: Pakai Sprite2D (Single Image)

1. Siapkan gambar background (PNG/JPG)
2. Simpan di `assets/backgrounds/farm_bg.png`
3. Add Child > **Sprite2D**
4. Rename jadi "Background"
5. Di Inspector:
   - Texture: drag `farm_bg.png`
   - Centered: false
   - Position: (0, 0)

### Opsi C: Pakai ParallaxBackground (Scrolling Background)

Untuk background yang scroll dengan camera:

1. Add Child > **ParallaxBackground**
2. Add Child ke ParallaxBackground > **ParallaxLayer**
3. Add Child ke ParallaxLayer > **Sprite2D**
4. Set texture sprite
5. Di ParallaxLayer, set **Motion Scale** (1, 1) untuk ground layer

---

## Cara 3: Generate Tilemap Procedural (Temporary)

Untuk testing cepat tanpa asset:

1. Buka `scenes/world.tscn`
2. Add Child > **TileMapLayer**
3. Rename jadi "GroundLayer"
4. Attach script: `scripts/tilemap_setup.gd`
5. Setup TileSet minimal:
   - Inspector > Tile Set > New TileSet
   - Buat atlas dengan warna solid (bisa pakai icon.svg dulu)
6. Run game, tiles akan ter-generate otomatis

---

## Rekomendasi untuk Game Farming:

### Layer Structure:
```
World
├── BackgroundLayer (TileMapLayer) - Sky, far background
├── GroundLayer (TileMapLayer) - Grass, dirt, path
├── CropLayer (TileMapLayer atau Node2D) - Tanaman
├── DecorationLayer (TileMapLayer) - Rocks, flowers
├── Player
├── BuildingLayer (TileMapLayer) - Fences, buildings
└── UI
```

### Tile Size:
- **16x16**: Retro style, seperti Stardew Valley
- **32x32**: Lebih detail
- **48x48**: HD style

### Free Tileset Resources:
- **itch.io**: Banyak free farming tilesets
- **OpenGameArt.org**: Free game assets
- **Kenney.nl**: Free game assets pack

---

## Quick Start (Tanpa Asset):

Jika mau mulai coding dulu tanpa asset:

1. Pakai ColorRect hijau untuk grass
2. Nanti ganti dengan TileMap saat sudah ada asset
3. Fokus ke gameplay mechanics dulu

```gdscript
# Di world scene, tambah ColorRect:
var bg = ColorRect.new()
bg.size = Vector2(2000, 2000)
bg.color = Color(0.3, 0.6, 0.3)  # Hijau
add_child(bg)
move_child(bg, 0)  # Pindah ke belakang
```

---

## Next Steps:

1. Cari/buat tileset untuk farming game
2. Setup TileMap dengan tileset
3. Design map layout
4. Tambah collision untuk obstacles (rocks, trees, fences)
5. Tambah interaction system untuk farming

Mau saya buatkan contoh tilemap sederhana atau mau langsung pakai tileset yang sudah ada?
