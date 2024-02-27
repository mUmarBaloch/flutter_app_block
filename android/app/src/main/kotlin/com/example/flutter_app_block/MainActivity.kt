package com.example.flutter_app_block

import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import io.flutter.embedding.android.FlutterActivity
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class MainActivity: FlutterActivity() {
    private val CHANNEL = "samples.flutter.dev/battery"
    private val SECONDCHANNEL = "samples.flutter.dev/batteryCharging"


    private fun getBatteryLevel(): Int {
        val batteryLevel: Int
        if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP){
            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
            batteryLevel = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
        }
        
        return batteryLevel
    }
    private fun getIsCharging(): Boolean {
      val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
      val status = intent!!.getIntExtra(BatteryManager.EXTRA_STATUS, -1)
      return status == BatteryManager.BATTERY_STATUS_CHARGING || status == BatteryManager.BATTERY_STATUS_FULL
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
      super.configureFlutterEngine(flutterEngine)
      MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
          // This method is invoked on the main thread.
          if (call.method == "getBatteryLevel") {
              val batteryLevel = getBatteryLevel()
  
              if (batteryLevel != -1) {
                  result.success(batteryLevel)
              } else {
                  result.error("UNAVAILABLE", "Battery level not available.", null)
              }
          } else {
              result.notImplemented()
          }
      }
  
      MethodChannel(flutterEngine.dartExecutor.binaryMessenger, SECONDCHANNEL).setMethodCallHandler { call, result ->
          if (call.method == "getIsCharging") {
              val isCharging = getIsCharging()
              result.success(isCharging)
          }
      }
  }
}

