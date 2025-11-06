# How to Use APK-Generating Workflows

This guide explains the workflows that generate APK files in the Meshtastic-Android project and how to invoke them.

## APK-Generating Workflows

There are **3 different workflows** in the project that generate APK files:

### 1. 🎯 **Create or Promote Release** (Recommended for Release APKs)

**File:** `.github/workflows/create-or-promote-release.yml`

**When to use:** To create official release APKs (signed, production-ready)

**How to invoke:**

1. Go to the GitHub repository: https://github.com/kaanyaren/mtastic_android
2. Click on the **Actions** tab
3. Select **"Create or Promote Release"** workflow from the left menu
4. Click the **"Run workflow"** dropdown on the right
5. Fill in the parameters:
   - **base_version:** Version number (e.g., `2.4.0`)
   - **channel:** Select target channel:
     - `internal` - For initial testing (internal track)
     - `closed` - For closed beta testing
     - `open` - For open beta testing
     - `production` - For final production release
   - **dry_run:** `false` (for actual release)
6. Click the **"Run workflow"** button

**Outputs:**
- ✅ Google Play AAB (app-google-release.aab)
- ✅ Google Play APK (app-google-release.apk)
- ✅ F-Droid APK (app-fdroid-release.apk)
- All files are attached to GitHub Release
- Automatically uploaded to Google Play Console

**Downloading artifacts:**
- After workflow completes, download from **Releases** tab or from the **Artifacts** section of the workflow run

---

### 2. 🔨 **Reusable Android Build** (For Debug APKs)

**File:** `.github/workflows/reusable-android-build.yml`

**When to use:** To create debug APKs for development and testing

**How to invoke:**

This workflow cannot be invoked manually, but runs automatically when:
- A Pull Request is opened (via `.github/workflows/pull-request.yml`)
- Added to merge queue

**To manually get debug APKs:** Run this command on your local machine:

```bash
# F-Droid debug APK
./gradlew assembleFdroidDebug

# Google debug APK
./gradlew assembleGoogleDebug

# Build both APKs
./gradlew assembleDebug
```

**Outputs:**
- Debug APKs are created in `app/build/outputs/apk/` directory
- Stored as artifacts in CI/CD (14 days retention)

---

### 3. 📦 **Pull Request Workflow** (Automatic Debug Build)

**File:** `.github/workflows/pull-request.yml`

**When to use:** Runs automatically on pull requests

**How to invoke:**

Runs automatically when you create a pull request. No manual invocation needed.

**Outputs:**
- Debug APKs (fdroidDebug and googleDebug)
- Can be downloaded from the **Checks** section of the pull request

---

## Quick Start Guide

### Fastest Way - Get Debug APK:

```bash
# For a clean build
./gradlew clean

# Build debug APK (both flavors)
./gradlew assembleDebug

# Find the APKs
ls -la app/build/outputs/apk/fdroid/debug/app-fdroid-debug.apk
ls -la app/build/outputs/apk/google/debug/app-google-debug.apk
```

### For Production Release APK:

1. On GitHub: **Actions** → **Create or Promote Release**
2. Enter version (e.g., `2.5.0`)
3. Select `internal` as channel (for first release)
4. Click **Run workflow**
5. After workflow completes, download APKs from **Releases** page

---

## APK Types

| Type | Signed | Google Play | F-Droid Compatible | Usage |
|------|--------|-------------|-------------------|-------|
| **google-release.apk** | ✅ Yes | ✅ Yes | ❌ No | Google Play Store |
| **fdroid-release.apk** | ✅ Yes | ❌ No | ✅ Yes | F-Droid Store |
| **google-debug.apk** | ❌ No | ❌ No | ❌ No | Development/Testing |
| **fdroid-debug.apk** | ❌ No | ❌ No | ❌ No | Development/Testing |

---

## Requirements

### For Release Build (GitHub Actions):
- ✅ GitHub repository admin access
- ✅ Secrets configured (KEYSTORE, GOOGLE_PLAY_JSON_KEY, etc.)

### For Local Build:
- ✅ JDK 21
- ✅ Android SDK
- ✅ `local.properties` file (copied from secrets.defaults.properties)

---

## Troubleshooting

**Q: Can't find the workflow?**
- A: In the Actions tab, select "Create or Promote Release" from the "All workflows" dropdown

**Q: Where can I find the APK?**
- A: After workflow completes:
  1. Releases page (for production)
  2. "Artifacts" section of the workflow run page (for testing)

**Q: "Run workflow" button not showing?**
- A: You need write access to the repository. This feature may not work in forked repos.

**Q: Build is failing?**
- A: Check the workflow logs and refer to RELEASE_PROCESS.md

---

## Related Files

- **Workflow definitions:** `.github/workflows/`
- **Release process:** `RELEASE_PROCESS.md`
- **Build configuration:** `app/build.gradle.kts`
- **Fastlane configuration:** `fastlane/Fastfile`

---

## More Information

For detailed release process: [RELEASE_PROCESS.md](RELEASE_PROCESS.md)
