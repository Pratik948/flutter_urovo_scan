package com.example.flutter_urovo_scan

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.graphics.BitmapFactory
import android.util.Log

class ScannerUrovoReceiver(private val plugin: FlutterUrovoScanPlugin?) : BroadcastReceiver() {
    override fun onReceive(context: Context?, intent: Intent?) {
        val action = intent?.action
        Log.d("[TEST]", "onReceive: action: $action")

        // Get Scan Image . Make sure to make a request before getting a scanned image
        if (Singleton.ACTION_CAPTURE_IMAGE == action) {
            Log.d("[TEST]", "onReceive: ACTION_CAPTURE_IMAGE");
            val imageData =
                intent.getByteArrayExtra(Singleton.DECODE_CAPTURE_IMAGE_KEY)
            if (imageData != null && imageData.isNotEmpty()) {
                val bitmap = BitmapFactory.decodeByteArray(imageData, 0, imageData.size)
//                    val msg: Message =
//                        mHandler.obtainMessage(MSG_SHOW_SCAN_IMAGE)
//                    msg.obj = bitmap
//                    mHandler.sendMessage(msg)
                Log.d("[TEST]", "onReceive: imagedata bitmap:$bitmap")
                plugin?.sendScanResultToFlutter("TEST IMAGE")
            } else {
                Log.d("[TEST]", "onReceive: ignore imageData:$imageData")
            }
        } else {
            Log.d("[TEST]", "onReceive: ELSE");
//                result = HashMap<String, Any>()
            // Get scan results, including string and byte data etc.
            val barcode = intent?.getByteArrayExtra(Singleton.DECODE_DATA_TAG)
            val barcodeLen = intent?.getIntExtra(Singleton.BARCODE_LENGTH_TAG, 0)
            val temp = intent?.getByteExtra(Singleton.BARCODE_TYPE_TAG, 0.toByte())
            val barcodeStr = intent?.getStringExtra(Singleton.BARCODE_STRING_TAG)
            Log.d("[TEST]", "onReceive: temp: $temp");
            val scanResult = String(barcode!!, 0, barcodeLen ?: 0)
            Log.d("[TEST]", "FlutterUrovoScanPlugin onReceive: scanResult/barcode: $scanResult")
            Log.d("[TEST]", "onReceive: length: $barcodeLen")
            Log.d("[TEST]", "onReceive: bytesToHexString: ${bytesToHexString(barcode)}")
            Log.d("[TEST]", "onReceive: barcodeStr: $barcodeStr")

            // Send scan result to Flutter
            plugin?.sendScanResultToFlutter(scanResult)
            Log.d("[TEST]", "FlutterUrovoScanPlugin eventSink?.success(scanResult): $scanResult")
        }
    }

    /**
     * byte[] toHex String
     *
     * @param src
     * @return String
     */
    private fun bytesToHexString(src: ByteArray?): String? {
        val stringBuilder = StringBuilder("")
        if (src == null || src.size <= 0) {
            return null
        }
        for (i in src.indices) {
            val v = src[i].toInt() and 0xFF
            val hv = Integer.toHexString(v)
            if (hv.length < 2) {
                stringBuilder.append(0)
            }
            stringBuilder.append(hv)
        }
        return stringBuilder.toString()
    }
}

