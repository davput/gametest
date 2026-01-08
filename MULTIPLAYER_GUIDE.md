# Panduan Multiplayer - HP & Laptop

Sistem multiplayer sudah siap! Satu device jadi host, yang lain join.

---

## File yang Sudah Dibuat:

1. `scripts/network_manager.gd` - Network manager (autoload)
2. `scripts/multiplayer_menu.gd` - Menu host/join
3. `scripts/player_multiplayer.gd` - Player dengan sync
4. `scripts/world_multiplayer.gd` - World spawn manager
5. `scenes/multiplayer_menu.tscn` - Menu scene
6. `scenes/player_multiplayer.tscn` - Player scene

---

## Cara Main Multiplayer:

### Setup 1: Laptop jadi Host, HP jadi Client

#### Di Laptop (Host):

1. Run game (F5)
2. Masukkan nama: "Laptop"
3. Klik **"Host Game"**
4. Lihat IP address yang muncul (contoh: 192.168.1.100)
5. Tunggu HP join
6. Game otomatis start

#### Di HP (Client):

1. Install APK dan buka game
2. Masukkan nama: "HP"
3. Masukkan IP laptop (contoh: 192.168.1.100)
4. Klik **"Join Game"**
5. Tunggu connecting...
6. Game start!

---

### Setup 2: HP jadi Host, Laptop jadi Client

#### Di HP (Host):

1. Buka game
2. Masukkan nama
3. Klik **"Host Game"**
4. Catat IP yang muncul
5. Tunggu laptop join

#### Di Laptop (Client):

1. Run game
2. Masukkan nama
3. Masukkan IP HP
4. Klik **"Join Game"**

---

## Cara Cek IP Address:

### Di Laptop (Windows):

1. Buka Command Prompt (CMD)
2. Ketik: `ipconfig`
3. Cari "IPv4 Address" di bagian WiFi
4. Contoh: 192.168.1.100

### Di HP (Android):

1. Settings > WiFi
2. Tap WiFi yang connected
3. Lihat IP address
4. Contoh: 192.168.1.101

### Di Game:

IP otomatis muncul di menu saat klik "Host Game"

---

## Syarat Multiplayer:

✅ **Harus di jaringan WiFi yang sama**
- Laptop dan HP connect ke WiFi router yang sama
- Tidak bisa pakai data seluler

✅ **Port 7777 harus terbuka**
- Biasanya otomatis terbuka di WiFi rumah
- Jika tidak bisa connect, check firewall

✅ **Godot 4.5 support ENet**
- Sudah built-in, tidak perlu install tambahan

---

## Testing:

### Test di 1 PC (2 Instance):

1. Export game ke executable
2. Run 2x (buka 2 window)
3. Window 1: Host
4. Window 2: Join dengan IP "127.0.0.1" (localhost)

### Test di 2 PC:

1. PC 1: Host
2. PC 2: Join dengan IP PC 1

### Test HP + Laptop:

1. Pastikan sama-sama di WiFi yang sama
2. Laptop host, HP join (atau sebaliknya)
3. Masukkan IP yang benar

---

## Fitur Multiplayer:

✅ **Real-time sync:**
- Posisi player
- Movement
- Jump animation

✅ **Support 4 player:**
- 1 host + 3 client
- Bisa ditambah di `network_manager.gd`

✅ **Auto spawn:**
- Player otomatis spawn saat join
- Posisi spawn berbeda untuk tiap player

✅ **Player label:**
- Setiap player ada label nama
- Beda warna untuk identifikasi

---

## Troubleshooting:

### Tidak bisa connect:

**Check WiFi:**
- Pastikan sama-sama di WiFi yang sama
- Tidak bisa pakai hotspot HP + WiFi berbeda

**Check IP:**
- Pastikan IP benar (192.168.x.x)
- Jangan pakai 127.0.0.1 kecuali localhost

**Check Firewall:**
- Windows: Allow Godot di firewall
- Router: Port 7777 harus terbuka

**Check game:**
- Pastikan NetworkManager autoload aktif
- Check Output console untuk error

### Connection timeout:

- Tunggu 5-10 detik
- Jika masih gagal, restart game
- Check IP lagi

### Player tidak muncul:

- Check scene structure
- Pastikan player_multiplayer.tscn ada
- Check Output console

### Movement lag:

- Normal untuk WiFi
- Jika terlalu lag, kurangi sync rate
- Atau pakai dedicated server

---

## Customization:

### Ubah Port:

Di `network_manager.gd`:
```gdscript
const PORT = 8888  # Ganti dari 7777
```

### Ubah Max Players:

```gdscript
const MAX_PLAYERS = 8  # Dari 4 jadi 8
```

### Ubah Spawn Position:

Di `world_multiplayer.gd`:
```gdscript
var spawn_positions = [
	Vector2(100, 200),
	Vector2(300, 200),
	Vector2(500, 200),
	Vector2(700, 200)
]
```

### Tambah Chat:

Bisa ditambahkan dengan RPC:
```gdscript
@rpc("any_peer", "reliable")
func send_chat(message: String):
	print("Chat: ", message)
```

---

## Network Architecture:

```
Host (Server)
    ├── Client 1 (HP)
    ├── Client 2 (Laptop)
    └── Client 3 (Tablet)
```

- Host = Server + Player
- Client = Player only
- Semua sync melalui host

---

## Next Steps:

Setelah multiplayer berfungsi:

1. **Sync farming actions:**
   - Tanam tanaman
   - Panen
   - Interaksi objek

2. **Persistent world:**
   - Save/load world state
   - Tanaman tetap ada saat reconnect

3. **Chat system:**
   - Text chat antar player

4. **Trading system:**
   - Trade items antar player

5. **Dedicated server:**
   - Server 24/7 tanpa host player

Mau saya buatkan fitur tambahan?

---

## Quick Reference:

**Host:**
1. Klik "Host Game"
2. Catat IP
3. Share IP ke teman

**Join:**
1. Minta IP dari host
2. Masukkan IP
3. Klik "Join Game"

**Disconnect:**
- Close game atau back to menu

**Reconnect:**
- Restart game dan join lagi
