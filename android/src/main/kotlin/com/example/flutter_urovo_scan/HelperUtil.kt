package com.example.flutter_urovo_scan

import android.content.Context
import android.content.Context.BATTERY_SERVICE
import android.os.BatteryManager
import android.util.Log
import androidx.core.content.ContextCompat.getSystemService
import io.flutter.plugin.common.MethodChannel

class HelperUtil(private val context: Context) {

    fun getStackStrace(result: MethodChannel.Result) {
        try {
            val stackError = Log.getStackTraceString(Throwable())
            result.success(stackError)
        } catch (e: Exception) {
            result.error("ERROR", "getStackStrace error: ${e.toString()}", null)
        }
    }

    // Function to handle getting battery level
     fun handleBatteryLevel(result: MethodChannel.Result) {
        Log.d("[TEST]", "handleBatteryLevel: WORKING!");
        val batteryLevel = getBatteryLevel()


        if (batteryLevel != -1) {
            result.success(batteryLevel)
        } else {
            result.error("UNAVAILABLE", "Battery level not available.", null)
        }
    }

     private fun getBatteryLevel(): Int {
        val batteryLevel: Int
        val batteryManager = context.getSystemService(BATTERY_SERVICE) as BatteryManager
        batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)

        return batteryLevel
    }
}