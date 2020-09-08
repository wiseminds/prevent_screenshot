package com.wisemindssolution.prevent_screenshot

import android.app.Activity
import androidx.annotation.NonNull

import android.view.WindowManager.LayoutParams
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import androidx.activity.ComponentActivity
import android.content.Context
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.PluginRegistry.Registrar

/** PreventScreenshotPlugin */
class PreventScreenshotPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var mContext: Context
  private  lateinit var mActivity: Activity

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "prevent_screenshot")
    channel.setMethodCallHandler(this)
//    mActivity = flutterPluginBinding.activity
    this.mContext = flutterPluginBinding.applicationContext;
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else if (call.method == "lock_app") {
      mActivity.window.setFlags(LayoutParams.FLAG_SECURE, LayoutParams.FLAG_SECURE)
    } else if (call.method == "unlock_app") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onDetachedFromActivity() {
//    TODO("Not yet implemented")
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    mActivity = binding.activity
    mActivity.window.setFlags(LayoutParams.FLAG_SECURE, LayoutParams.FLAG_SECURE)
//    Log.d(TAG, "ReattachedToActivityForConfigChanges")
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    mActivity = binding.activity
    mActivity.window.setFlags(LayoutParams.FLAG_SECURE, LayoutParams.FLAG_SECURE)
//    Log.d(TAG, "onAttachedToActivity")
  }

  override fun onDetachedFromActivityForConfigChanges() {
//    Log.d(TAG, "onDetachedFromActivityForConfigChanges")
  }

}
