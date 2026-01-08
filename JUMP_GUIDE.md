# Panduan Fitur Jump/Lompat

Saya sudah buatkan 2 jenis jump sesuai tipe game:

---

## Tipe 1: Hop/Bounce (Untuk Top-Down Game)

**Cocok untuk:** Farming game, Zelda-style, Stardew Valley
**Script:** `scripts/player_with_jump.gd`

### Fitur:
- Karakter "melompat" dengan efek visual (sprite naik-turun)
- Tidak ada gravity
- Cooldown antar jump
- Smooth arc animation
- Scale effect saat di udara

### Setup:

1. Buka `scenes/player.tscn`
2. Klik node **Player** (CharacterBody2D)
3. Ganti script dengan: `scripts/player_with_jump.gd`
4. Di Inspector, adjust settings:
   - **Jump Height**: 30 (tinggi hop dalam pixel)
   - **Jump Duration**: 0.4 (durasi hop dalam detik)
   - **Jump Cooldown**: 0.5 (cooldown antar jump)
5. Save dan test

### Controls:
- **Spacebar** = Jump
- **Gamepad A** = Jump
- **WASD** = Movement

---

## Tipe 2: Platform Jump (Untuk Side-View Game)

**Cocok untuk:** Platformer, Mario-style, Metroidvania
**Script:** `scripts/player_platformer_jump.gd`

### Fitur:
- Gravity-based jump
- Platform collision
- Variable jump height
- Ground detection

### Setup:

1. Buka `scenes/player.tscn`
2. Klik node **Player** (CharacterBody2D)
3. Ganti script dengan: `scripts/player_platformer_jump.gd`
4. Di Inspector, adjust:
   - **Jump Velocity**: -400 (kekuatan jump, negatif = ke atas)
   - **Gravity**: 980 (gravitasi)
   - **Move Speed**: 200
5. Tambah ground/platform dengan StaticBody2D
6. Save dan test

### Controls:
- **Spacebar** = Jump
- **A/D** = Move left/right

---

## Input Mapping

Input "jump" sudah ditambahkan ke project:
- **Spacebar** (keyboard)
- **Button A** (gamepad)

Bisa diubah di: Project > Project Settings > Input Map

---

## Untuk Game Farming (Recommended):

Pakai **Tipe 1 (Hop)** karena:
- Lebih cocok untuk top-down view
- Tidak perlu setup platform/ground
- Visual effect lebih sesuai
- Bisa lompat melewati obstacle kecil

---

## Customization:

### Adjust Jump Height:
```gdscript
@export var jump_height: float = 50.0  # Lebih tinggi
```

### Adjust Jump Speed:
```gdscript
@export var jump_duration: float = 0.3  # Lebih cepat
```

### Disable Cooldown:
```gdscript
@export var jump_cooldown: float = 0.0  # Bisa spam jump
```

### Add Shadow Effect:

1. Tambah Sprite2D child ke Player, rename "Shadow"
2. Set texture: lingkaran hitam transparan
3. Di script, update shadow position saat jump:

```gdscript
@onready var shadow = $Shadow

func update_jump(delta):
	# ... existing code ...
	if shadow:
		shadow.modulate.a = 0.5 - (abs(jump_offset) / jump_height) * 0.3
```

---

## Troubleshooting:

### Jump tidak berfungsi:
- Pastikan input "jump" ada di Input Map
- Check Output console untuk print "Jump!"
- Pastikan cooldown sudah habis

### Sprite tidak naik-turun:
- Pastikan ada node Sprite2D di player
- Check nama node: harus "Sprite2D"
- Atau adjust di script: `@onready var sprite = $NamaSprite`

### Jump terlalu tinggi/rendah:
- Adjust **jump_height** di Inspector
- Atau adjust **jump_duration**

---

## Testing:

1. Run game (F5)
2. Tekan **Spacebar** untuk jump
3. Karakter harus naik dan turun dengan smooth
4. Ada cooldown 0.5 detik antar jump

---

## Next Features:

Setelah jump berfungsi, bisa tambah:
- Jump melewati obstacle (fence, rock)
- Jump animation (sprite change)
- Jump sound effect
- Dash/roll mechanic
- Double jump

Mau saya buatkan fitur tambahan?
