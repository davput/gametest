# Panduan Export ke Android via GitHub

Saya sudah setup GitHub Actions untuk otomatis build APK setiap kali push!

---

## File yang Sudah Dibuat:

1. `.github/workflows/android-export.yml` - GitHub Actions workflow
2. `export_presets.cfg` - Godot export configuration

---

## Setup GitHub Repository:

### 1. Buat Repository di GitHub

1. Buka https://github.com/new
2. Nama repository: `game-bubub` (atau terserah)
3. Pilih **Public** atau **Private**
4. **JANGAN** centang "Add README" (sudah ada)
5. Klik "Create repository"

### 2. Push Project ke GitHub

Di terminal/command prompt, jalankan:

```bash
# Initialize git (jika belum)
git init

# Add all files
git add .

# Commit
git commit -m "Initial commit - Game Bubub"

# Add remote (ganti USERNAME dengan username GitHub kamu)
git remote add origin https://github.com/USERNAME/game-bubub.git

# Push
git branch -M main
git push -u origin main
```

### 3. Enable GitHub Actions

1. Buka repository di GitHub
2. Klik tab **Actions**
3. Jika diminta, klik **"I understand my workflows, go ahead and enable them"**

---

## Cara Kerja:

### Otomatis Build:

Setiap kali kamu push ke GitHub:
1. GitHub Actions akan otomatis jalan
2. Download Godot 4.5
3. Setup Android SDK
4. Export APK
5. Upload APK sebagai artifact

### Download APK:

1. Buka repository di GitHub
2. Klik tab **Actions**
3. Klik workflow run terbaru (yang hijau ✓)
4. Scroll ke bawah, bagian **Artifacts**
5. Download **android-apk.zip**
6. Extract dan install APK di Android

---

## Manual Export (Tanpa GitHub):

Jika mau export manual di PC:

### 1. Install Android SDK

**Cara Mudah - Pakai Android Studio:**
1. Download Android Studio: https://developer.android.com/studio
2. Install dan buka
3. Tools > SDK Manager
4. Install:
   - Android SDK Platform 33
   - Android SDK Build-Tools 33.0.0
   - Android SDK Command-line Tools

**Atau Pakai sdkmanager (CLI):**
```bash
# Download command line tools
# https://developer.android.com/studio#command-tools

# Install SDK
sdkmanager "platforms;android-33"
sdkmanager "build-tools;33.0.0"
```

### 2. Setup Godot

1. Buka Godot Editor
2. Editor > Editor Settings
3. Export > Android:
   - **Android SDK Path**: Path ke Android SDK
     - Windows: `C:\Users\USERNAME\AppData\Local\Android\Sdk`
     - Linux: `~/Android/Sdk`
   - **Debug Keystore**: Buat atau pakai default

### 3. Generate Debug Keystore

```bash
keytool -genkeypair -v -keystore debug.keystore -alias androiddebugkey -keyalg RSA -keysize 2048 -validity 10000 -storepass android -keypass android -dname "CN=Android Debug,O=Android,C=US"
```

Simpan di folder `android/debug.keystore`

### 4. Download Export Templates

1. Di Godot Editor
2. Editor > Manage Export Templates
3. Download and Install (untuk Godot 4.5)

### 5. Export APK

1. Project > Export
2. Add > Android
3. Set export path: `build/android/game-bubub.apk`
4. Klik "Export Project"
5. APK siap di folder `build/android/`

---

## Install APK di Android:

### Via USB:

1. Enable Developer Options di Android:
   - Settings > About Phone
   - Tap "Build Number" 7x
2. Enable USB Debugging:
   - Settings > Developer Options > USB Debugging
3. Connect ke PC via USB
4. Install APK:
   ```bash
   adb install build/android/game-bubub.apk
   ```

### Via File Transfer:

1. Copy APK ke Android (via USB, Google Drive, dll)
2. Di Android, buka File Manager
3. Tap APK file
4. Allow "Install from Unknown Sources" jika diminta
5. Install

---

## Release Build (Production):

Untuk release ke Google Play Store:

### 1. Generate Release Keystore

```bash
keytool -genkeypair -v -keystore release.keystore -alias release -keyalg RSA -keysize 2048 -validity 10000
```

**PENTING:** Simpan password dan keystore dengan aman!

### 2. Update export_presets.cfg

```
[preset.0.options]
package/signed=true
keystore/debug=""
keystore/debug_user=""
keystore/debug_password=""
keystore/release="android/release.keystore"
keystore/release_user="release"
keystore/release_password="YOUR_PASSWORD"
```

### 3. Export Release

```bash
godot --headless --export-release "Android" build/android/game-bubub-release.apk
```

---

## GitHub Secrets (untuk Release Build):

Jika mau build release di GitHub:

1. Buka repository > Settings > Secrets and variables > Actions
2. Add secrets:
   - `ANDROID_KEYSTORE_BASE64`: Base64 encoded keystore
   - `KEYSTORE_PASSWORD`: Password keystore
   - `KEY_ALIAS`: Alias key
   - `KEY_PASSWORD`: Password key

Encode keystore:
```bash
base64 -w 0 release.keystore > keystore.base64
```

---

## Troubleshooting:

### GitHub Actions Failed:

- Check logs di Actions tab
- Pastikan `export_presets.cfg` ada
- Pastikan Godot version benar (4.5)

### APK Tidak Bisa Install:

- Enable "Install from Unknown Sources"
- Check Android version (minimal Android 5.0 / API 21)
- Re-download APK (mungkin corrupt)

### Game Crash di Android:

- Check Output console di Godot saat export
- Test di Android emulator dulu
- Check permissions di `export_presets.cfg`

### Virtual Controls Tidak Muncul:

- Pastikan UI scene sudah di-instance
- Check script errors
- Test di PC dulu

---

## Monitoring Build:

### Check Build Status:

1. Buka repository di GitHub
2. Klik tab **Actions**
3. Lihat status workflow:
   - 🟡 Yellow = Running
   - ✅ Green = Success
   - ❌ Red = Failed

### Build Time:

- Biasanya 5-10 menit
- Tergantung GitHub Actions queue

---

## Auto-Release (Optional):

Untuk otomatis create release saat tag:

```bash
# Create tag
git tag v1.0.0

# Push tag
git push origin v1.0.0
```

GitHub Actions akan otomatis:
1. Build APK
2. Create GitHub Release
3. Upload APK ke release

Download dari: Releases tab di GitHub

---

## Next Steps:

1. Push project ke GitHub
2. Wait for Actions to complete
3. Download APK dari Artifacts
4. Test di Android device
5. Iterate and improve!

Mau saya bantu setup GitHub repository atau ada yang mau ditanyakan?
