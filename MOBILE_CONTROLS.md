# Mobile Controls - Virtual Joystick + Jump Button

Saya sudah menambahkan button jump di kanan bawah layar!

---

## Yang Sudah Dibuat:

### 1. Jump Button
- **Posisi**: Kanan bawah layar
- **Ukuran**: 100x100 pixel
- **Style**: Bulat, biru transparan
- **Fungsi**: Trigger action "jump"

### 2. Mobile UI Manager
- **Script**: `scripts/mobile_ui.gd`
- **Fungsi**: Mengatur layout dan style virtual controls
- **Auto-positioning**: Button otomatis di posisi yang tepat

---

## Layout Mobile Controls:

```
┌─────────────────────────────┐
│                             │
│                             │
│                             │
│                             │
│                             │
│  ◉ Joystick        [Jump] ◯ │
└─────────────────────────────┘
  Kiri Bawah       Kanan Bawah
```

---

## File yang Diupdate:

1. `scenes/ui.tscn` - Ditambah JumpButton
2. `scripts/mobile_ui.gd` - UI manager dengan styling
3. `scripts/jump_button.gd` - Alternative simple button script

---

## Testing:

### Di PC (dengan Mouse):
1. Run game (F5)
2. Klik button "Jump" di kanan bawah
3. Karakter harus melompat
4. Atau tekan Spacebar

### Di Android (dengan Touch):
1. Export ke APK
2. Install di device
3. Touch button "Jump" untuk melompat
4. Drag joystick kiri untuk bergerak

---

## Customization:

### Ubah Posisi Button:

Edit di `scripts/mobile_ui.gd`:
```gdscript
# Lebih ke kiri
jump_button.position = Vector2(viewport_size.x - 150, viewport_size.y - 120)

# Lebih ke atas
jump_button.position = Vector2(viewport_size.x - 120, viewport_size.y - 200)
```

### Ubah Ukuran Button:

```gdscript
jump_button.size = Vector2(120, 120)  # Lebih besar
```

### Ubah Warna Button:

```gdscript
style.bg_color = Color(1.0, 0.5, 0.0, 0.6)  # Orange
```

### Ubah Text Button:

```gdscript
jump_button.text = "⬆"  # Pakai icon/emoji
# atau
jump_button.text = ""  # Kosong, pakai icon image
```

### Tambah Icon ke Button:

1. Siapkan icon jump (PNG)
2. Simpan di `assets/ui/jump_icon.png`
3. Di script:
```gdscript
var icon = load("res://assets/ui/jump_icon.png")
jump_button.icon = icon
jump_button.text = ""  # Hapus text
```

---

## Multiple Buttons:

Kalau mau tambah button lain (attack, interact, dll):

### Di `scenes/ui.tscn`:
```
[node name="AttackButton" type="Button" parent="."]
offset_right = 100.0
offset_bottom = 100.0
text = "Attack"
```

### Di `scripts/mobile_ui.gd`:
```gdscript
@onready var attack_button = $AttackButton

func setup_ui():
	# ... existing code ...
	
	# Setup attack button (di atas jump button)
	if attack_button:
		attack_button.position = Vector2(viewport_size.x - 120, viewport_size.y - 240)
		attack_button.size = Vector2(100, 100)
		attack_button.pressed.connect(_on_attack_pressed)

func _on_attack_pressed():
	Input.action_press("attack")
	await get_tree().create_timer(0.1).timeout
	Input.action_release("attack")
```

---

## Layout dengan Multiple Buttons:

```
┌─────────────────────────────┐
│                             │
│                             │
│                    [Attack] │
│                             │
│                      [Jump] │
│  ◉ Joystick                 │
└─────────────────────────────┘
```

Atau horizontal:
```
┌─────────────────────────────┐
│                             │
│                             │
│                             │
│                             │
│              [Attack][Jump] │
│  ◉ Joystick                 │
└─────────────────────────────┘
```

---

## Troubleshooting:

### Button tidak muncul:
- Pastikan UI scene sudah di-instance ke World
- Check Output console untuk print message
- Pastikan CanvasLayer ada di scene

### Button tidak berfungsi:
- Pastikan input action "jump" ada di Input Map
- Check signal connection
- Test dengan Spacebar dulu

### Button posisi salah:
- Adjust di `mobile_ui.gd`
- Atau set manual di Inspector

### Button terlalu kecil di mobile:
- Increase size: `Vector2(120, 120)` atau lebih
- Recommended: minimal 80x80 untuk touchscreen

---

## Best Practices untuk Mobile UI:

1. **Button size**: Minimal 80x80 pixel
2. **Spacing**: Minimal 20 pixel antar button
3. **Position**: Tidak terlalu dekat dengan edge (margin 20-30px)
4. **Transparency**: 0.6-0.8 agar tidak menutupi gameplay
5. **Feedback**: Visual feedback saat pressed (sudah ada)

---

## Next Steps:

Setelah jump button berfungsi, bisa tambah:
- Attack/interact button
- Inventory button
- Menu button
- Tool selection buttons (cangkul, penyiram, dll)

Mau saya buatkan button tambahan?
