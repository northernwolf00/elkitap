plugins {
    id("com.android.application")
    id("com.google.gms.google-services")
    id("com.google.firebase.firebase-perf")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.googadev.elkitap"
    compileSdk = flutter.compileSdkVersion
    // ndkVersion = "29.0.14033849"
  
    compileOptions {
    sourceCompatibility = JavaVersion.VERSION_17
    targetCompatibility = JavaVersion.VERSION_17
    isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    defaultConfig {
        
        applicationId = "com.googadev.elkitap"
        
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // isMinifyEnabled = false
            // isShrinkResources = false
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
  
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.3")
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk8")

}
