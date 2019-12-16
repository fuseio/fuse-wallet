package io.fuse.fusecash

import android.os.Bundle
import com.anggach.flutterandroidlifecycle.FlutterAndroidLifecycleActivity

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterAndroidLifecycleActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
  }
}
