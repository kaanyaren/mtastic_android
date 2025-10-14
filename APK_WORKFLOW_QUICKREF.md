# APK Workflow Hızlı Referans / Quick Reference

## 🚀 En Hızlı Yollar / Fastest Ways

### Debug APK (Test için / For Testing)
```bash
./gradlew assembleDebug
```
📁 Konum / Location: `app/build/outputs/apk/*/debug/*.apk`

### Release APK (Production için / For Production)
1. GitHub'a git / Go to GitHub
2. **Actions** → **Create or Promote Release**
3. Version: `2.4.0` (örnek / example)
4. Channel: `internal`
5. **Run workflow** tıkla / click

📁 İndirme / Download: GitHub **Releases** sayfasından / from Releases page

---

## 📋 Workflow Karşılaştırması / Workflow Comparison

| Workflow | Nasıl Çalıştırılır / How to Run | APK Türü / APK Type | Ne Zaman Kullan / When to Use |
|----------|----------------------------------|---------------------|-------------------------------|
| **Create or Promote Release** | GitHub Actions (manuel) | Release (imzalı/signed) | Production release |
| **Reusable Android Build** | Otomatik (PR'da) / Auto (on PR) | Debug (imzasız/unsigned) | PR testleri / PR tests |
| **Local Gradle** | `./gradlew assemble...` | Debug/Release | Yerel test / Local testing |

---

## 🎯 Hangi Workflow'u Kullanmalıyım? / Which Workflow Should I Use?

### Kullanım Senaryosu / Use Case → Workflow

| İhtiyaç / Need | Kullan / Use | Komut / Command |
|----------------|--------------|-----------------|
| Hızlı test / Quick test | Local Gradle | `./gradlew assembleDebug` |
| PR kontrolü / PR check | Automatic | PR aç / Open PR |
| Beta test | GitHub Actions | Create or Promote Release (internal) |
| Production | GitHub Actions | Create or Promote Release (production) |

---

## 📦 APK Tipleri / APK Types

### Google Flavor
- **google-release.apk** ✅ İmzalı / Signed → Google Play Store
- **google-debug.apk** ⚙️ Test → Yerel test / Local testing

### F-Droid Flavor
- **fdroid-release.apk** ✅ İmzalı / Signed → F-Droid Store
- **fdroid-debug.apk** ⚙️ Test → Yerel test / Local testing

---

## 🛠️ Hızlı Komutlar / Quick Commands

```bash
# Temizle / Clean
./gradlew clean

# Debug build (her iki flavor / both flavors)
./gradlew assembleDebug

# Sadece F-Droid debug / F-Droid debug only
./gradlew assembleFdroidDebug

# Sadece Google debug / Google debug only
./gradlew assembleGoogleDebug

# Tüm release APK'lar / All release APKs (keystore gerekli / requires keystore)
./gradlew assembleRelease

# APK'ları listele / List APKs
find app/build/outputs/apk -name "*.apk"
```

---

## ⚙️ Gereksinimler / Requirements

### Yerel Build / Local Build
- ✅ JDK 21
- ✅ Android SDK (API 36)
- ✅ `local.properties` dosyası (secrets için / for secrets)

### GitHub Actions
- ✅ Repository write erişimi / write access
- ✅ Secrets yapılandırılmış / Secrets configured

---

## 🔗 Daha Fazla Bilgi / More Information

- 🇹🇷 **Türkçe Detaylı Rehber:** [APK_WORKFLOW_TR.md](APK_WORKFLOW_TR.md)
- 🇬🇧 **English Detailed Guide:** [APK_WORKFLOW_EN.md](APK_WORKFLOW_EN.md)
- 📊 **Görsel Diyagram:** [APK_WORKFLOW_DIAGRAM.txt](APK_WORKFLOW_DIAGRAM.txt)
- 🚀 **Release Süreci:** [RELEASE_PROCESS.md](RELEASE_PROCESS.md)

---

## ❓ Sık Sorulan Sorular / FAQ

**S: APK'yı nerede bulabilirim? / Q: Where can I find the APK?**
- Yerel: `app/build/outputs/apk/` / Local: `app/build/outputs/apk/`
- GitHub: Releases sayfası veya workflow Artifacts / GitHub: Releases page or workflow Artifacts

**S: "Run workflow" butonu yok / Q: No "Run workflow" button**
- Repository'ye write erişimi gerekli / Needs write access to repository

**S: Build başarısız / Q: Build fails**
- Logs'u kontrol et / Check logs
- JDK 21 kullandığından emin ol / Make sure using JDK 21
- `local.properties` dosyası var mı? / Does `local.properties` exist?

---

## 📞 Yardım / Help

- 💬 Discord: https://discord.gg/meshtastic
- 🐛 Issues: https://github.com/kaanyaren/mtastic_android/issues
- 📖 Forum: https://github.com/orgs/meshtastic/discussions
