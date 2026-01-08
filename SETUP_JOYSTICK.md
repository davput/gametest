# Setup Virtual Joystick - Panduan Lengkap

## Masalah: Joystick tidak bisa digerakkan

### Penyebab:
1. Scene UI belum di-instance ke World
2. Path ke joystick salah
3. Joystick tidak visible

### Solusi Step-by-Step:

## 1. Pastikan World Scene Setup dengan Benar

Di Godot Editor:

1. Buka `scenes/world.tscn` (atau buat jika belum ada)
2. Struktur harus seperti ini:
   ```
   World (Node2D)
   ├── ColorRect (background)
   ├── Player (instance dari player.tscn)
   └── UI (instance dari ui.tscn)
   ```

3. Cara instance UI:
   - Klik kanan pada World
   - "Instantiate Child Scene"
   - Pilih `scenes/ui.tscn`
   - Pastikan nama node-nya "UI" (bukan UI2 atau lainnya)

## 2. Test dengan Keyboard Dulu

Sebelum test joystick, pastikan player bisa gerak dengan keyboard:
- Tekan F5
- Coba gerakkan dengan WASD
- Jika tidak bisa, berarti ada masalah di input mapping atau player script

## 3. Test Virtual Joystick

### Di PC (dengan Mouse):
- Joystick akan muncul di kiri bawah layar (lingkaran abu-abu)
- Klik dan drag lingkaran dalam untuk menggerakkan
- Lepas mouse untuk berhenti

### Di Android (dengan Touch):
- Touch dan drag joystick untuk bergerak
- Lepas jari untuk berhenti

## 4. Troubleshooting

### Joystick tidak terlihat:
- Pastikan UI sudah di-instance ke World
- Check di Scene tree, harus ada: World > UI > VirtualJoystick
- Coba zoom out camera jika joystick terlalu kecil

### Joystick terlihat tapi tidak berfungsi:
- Buka Output console (View > Output)
- Harus ada print: "Virtual Joystick initialized at: ..."
- Jika tidak ada, berarti script tidak jalan

### Player tidak bergerak:
- Check path di player.gd line 9:
  ```gdscript
  @onready var virtual_joystick = get_node_or_null("/root/World/UI/VirtualJoystick")
  ```
- Path harus sesuai dengan struktur scene
- Jika World scene nama-nya beda, ganti "World" dengan nama yang sesuai

## 5. Alternative: Test Tanpa Joystick

Jika masih bermasalah, test player dulu tanpa joystick:

1. Comment line 9 di `scripts/player.gd`:
   ```gdscript
   # @onready var virtual_joystick = get_node_or_null("/root/World/UI/VirtualJoystick")
   ```

2. Test dengan keyboard (WASD)

3. Jika keyboard berfungsi, berarti masalah di joystick setup

## 6. Cara Cepat: Buat Scene Manual

Jika file .tscn bermasalah, buat manual:

### Buat UI Scene:
1. Scene > New Scene > CanvasLayer
2. Rename jadi "UI"
3. Add Child > Control
4. Rename jadi "VirtualJoystick"
5. Attach script: `scripts/virtual_joystick.gd`
6. Save sebagai `scenes/ui.tscn`

### Tambah ke World:
1. Buka world scene
2. Instance ui.tscn
3. Test lagi

## Keyboard Controls (Selalu Berfungsi):
- W / Arrow Up = Atas
- S / Arrow Down = Bawah
- A / Arrow Left = Kiri
- D / Arrow Right = Kanan

Keyboard akan selalu berfungsi, joystick hanya tambahan untuk mobile!
