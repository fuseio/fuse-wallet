package io.fuse.fusecash

import org.json.JSONObject

import android.os.Bundle
import android.content.Intent
import android.util.Log

import com.anggach.flutterandroidlifecycle.FlutterAndroidLifecycleActivity
import com.anggach.flutterbranchioplugin.INTENT_EXTRA_DATA
import com.anggach.flutterbranchioplugin.DEBUG_NAME
import com.anggach.flutterbranchioplugin.src.DeepLinkStreamHandler

import io.branch.referral.Branch
import io.branch.referral.BranchUtil
import io.branch.referral.BranchError


import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant

import android.os.Build
import android.view.ViewTreeObserver
import android.view.WindowManager

class MainActivity: FlutterAndroidLifecycleActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    if (!BranchUtil.isTestModeEnabled()) {
      Branch.getInstance(this)
    } else {
      Branch.getTestInstance(this)
    }

    // Branch logging for debugging
    Branch.enableDebugMode()

    // Branch object initialization
    Branch.getAutoInstance(this)

//    Branch.getInstance().initSession({ referringParams: JSONObject?, error: BranchError? ->
//      Log.d(DEBUG_NAME, "BRANCH CALLBACK")
//      if (error == null) {
//        Log.d(DEBUG_NAME, "BRANCH IO INITIALIZED")
//        val params = referringParams?.toString()
//        val intent = Intent()
//        intent.putExtra(INTENT_EXTRA_DATA, params)
//        DeepLinkStreamHandler().handleIntent(this, intent)
//      } else {
//        Log.e(DEBUG_NAME, "BRANCH IO INITIALIZATION ERROR ${error.message}")
//      }
//    }, this.intent.data, this)

    val flutter_native_splash = true
    var originalStatusBarColor = 0
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
        originalStatusBarColor = window.statusBarColor
        window.statusBarColor = 0xff2d98e7.toInt()
    }
    val originalStatusBarColorFinal = originalStatusBarColor

    GeneratedPluginRegistrant.registerWith(this)
    val vto = flutterView.viewTreeObserver
    vto.addOnGlobalLayoutListener(object : ViewTreeObserver.OnGlobalLayoutListener {
      override fun onGlobalLayout() {
        flutterView.viewTreeObserver.removeOnGlobalLayoutListener(this)
        window.clearFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
          window.statusBarColor = originalStatusBarColorFinal
        }
      }
    })
  }
}