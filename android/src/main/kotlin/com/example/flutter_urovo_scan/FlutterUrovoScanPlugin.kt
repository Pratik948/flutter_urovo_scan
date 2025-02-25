package com.example.flutter_urovo_scan

import android.content.Context
import android.content.IntentFilter
import android.device.scanner.configuration.PropertyID
import android.util.Log
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** FlutterUrovoScanPlugin */
class FlutterUrovoScanPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var context: Context
  private lateinit var channel : MethodChannel
  private lateinit var eventChannel: EventChannel
  private var eventSink: EventChannel.EventSink? = null
  private lateinit var helperUtil: HelperUtil
  private lateinit var scannerHelper: ScannerManagerHelper

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    Log.d("[TEST]", "FlutterUrovoScanPlugin: onAttachedToEngine")
    context = flutterPluginBinding.applicationContext
    scannerHelper = ScannerManagerHelper(context, this)
    helperUtil = HelperUtil(context)

    // Set Method Channel
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_urovo_scan")
    channel.setMethodCallHandler(this)

    // Set Event Channel
    EventChannel(flutterPluginBinding.binaryMessenger,"flutter_urovo_scan_plugin/scan").setStreamHandler(
      object : EventChannel.StreamHandler {
        override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
          eventSink = events
          Log.d("[TEST]", "EventChannel: Listening for scan events: ${eventSink.toString()}")
        }

        override fun onCancel(arguments: Any?) {
          eventSink = null
          Log.d("[TEST]", "EventChannel: Cancelled")
        }
      }
    )
    
    // Register BroadcastReceiver
    scannerHelper.registerReceiver(true)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    Log.d("[TEST]", "FlutterUrovoScanPlugin: onMethodCall")
    when (call.method) {
      "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
      "getBatteryLevel" -> helperUtil.handleBatteryLevel(result)
      "getStackStrace" -> helperUtil.getStackStrace(result)
      "getScannerState" -> scannerHelper.getScannerState(result)
      "openScanner" -> scannerHelper.openScanner(result)
      "closeScanner" -> scannerHelper.closeScanner(result)
      "getOutputMode" -> scannerHelper.getOutputMode(result)
      "setOutputMode" -> {
        val mode: Int = call.argument<Int>("output_mode") ?: 1
        scannerHelper.setOutputMode(mode, result)
      }
      "getTriggerMode" -> scannerHelper.getTriggerMode(result)
      "setTriggerMode" -> {
        val mode: String = call.argument<String>("mode") ?: "HOST"
        scannerHelper.setTriggerMode(mode, result)
      }

      "getParameterInts" -> scannerHelper.getParameterInts(result)
      "startDecode" -> scannerHelper.startDecode(result)
      "stopDecode" -> scannerHelper.stopDecode(result)
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    Log.d("[TEST]", "FlutterUrovoScanPlugin: onDetachedFromEngine")
    channel.setMethodCallHandler(null)
    scannerHelper.registerReceiver(false)
    eventSink = null
  }

  fun sendScanResultToFlutter(result: String) {
    eventSink?.success(result)
    Log.d("[TEST]", "sendScanResultToFlutter: $result")
  }
}
