# Troubleshooting - Karakter Tidak Bergerak

## Langkah-langkah Debug:

### 1. Test dengan Script Sederhana

Ganti script player dengan versi simple untuk test:

1. Buka `scenes/player.tscn` di Godot
2. Klik node "player" (CharacterBody2D)
3. Di Inspector, bagian Script, ganti dengan `scripts/player_simple.gd`
4. Save dan test (F5)
5. Coba tekan WASD

**Jika bergerak:** Berarti masalah di script kompleks
**Jika tidak bergerak:** Masalah di setup scene atau input

### 2. Cek Output Console

Saat game jalan, buka Output console (View > Output atau Alt+3):

**Yang harus muncul:**
```
Player: Virtual joystick found!
```
atau
```
Player: Virtual joystick NOT found - using keyboard only
```

**Saat tekan WASD, harus muncul:**
```
Input detected: (1, 0) | Velocity: (200, 0)
```

**Jika tidak ada output sama sekali:**
- Script tidak jalan
- Node tidak aktif
- Scene setup salah

### 3. Cek Scene Structure

Buka `scenes/player.tscn`, struktur harus:
```
player (CharacterBody2D) <- Script di sini
├── CollisionShape2D
├── Sprite2D
└── Camera2D
```

**JANGAN:**
```
Node2D
└── player (CharacterBody2D)
```

**Cara fix:**
1. Buka player.tscn
2. Jika ada Node2D parent, hapus dan buat ulang
3. Root node harus CharacterBody2D langsung

### 4. Cek Input Mapping

Di Godot Editor:
1. Project > Project Settings > Input Map
2. Pastikan ada:
   - move_left (A, Left Arrow)
   - move_right (D, Right Arrow)
   - move_up (W, Up Arrow)
   - move_down (S, Down Arrow)

### 5. Cek Collision

Karakter mungkin stuck di collision:

1. Buka world.tscn
2. Pindahkan player ke posisi yang bebas (tidak overlap dengan ground)
3. Atau hapus ground dulu untuk test

### 6. Test Manual di Editor

Tanpa run game:
1. Buka player.tscn
2. Klik tombol "Play Scene" (F6) - bukan F5
3. Coba gerakkan dengan WASD
4. Jika bergerak di sini tapi tidak di world, masalah di world scene

## Solusi Cepat: Buat Ulang Player Scene

1. Scene > New Scene
2. Pilih "CharacterBody2D" sebagai root
3. Rename jadi "Player"
4. Add Child: CollisionShape2D
   - Shape: CircleShape2D, radius 30
5. Add Child: Sprite2D
   - Texture: drag sprite kamu
6. Add Child: Camera2D
   - Zoom: (2, 2)
7. Attach script: `scripts/player_simple.gd`
8. Save sebagai `scenes/player_new.tscn`
9. Di world, hapus player lama, instance player_new
10. Test

## Checklist:

- [ ] Input mapping ada di Project Settings
- [ ] Player scene root adalah CharacterBody2D
- [ ] Script attached ke CharacterBody2D
- [ ] CollisionShape2D ada dan punya shape
- [ ] Player tidak overlap dengan collision lain
- [ ] Console menunjukkan output saat tekan WASD
- [ ] Keyboard berfungsi di OS (test di notepad)

## Jika Masih Tidak Bergerak:

Kirim screenshot:
1. Scene tree (player.tscn)
2. Inspector (node Player dengan script)
3. Output console saat game jalan
4. Input Map di Project Settings
