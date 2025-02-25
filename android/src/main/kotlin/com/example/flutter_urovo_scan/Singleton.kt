package com.example.flutter_urovo_scan

import android.device.ScanManager

object Singleton {
//    const val methodChannelKey = "com.mycompany.urovotest"
//    const val eventChannelKey = "channel/scan_urovo"

    const val ACTION_DECODE: String = ScanManager.ACTION_DECODE // default action
    const val ACTION_DECODE_IMAGE_REQUEST: String = "action.scanner_capture_image"
    const val ACTION_CAPTURE_IMAGE = "scanner_capture_image_result"
    const val DECODE_CAPTURE_IMAGE_KEY = "bitmapBytes"
    const val DECODE_DATA_TAG = ScanManager.DECODE_DATA_TAG
    const val BARCODE_LENGTH_TAG = ScanManager.BARCODE_LENGTH_TAG
    const val BARCODE_TYPE_TAG = ScanManager.BARCODE_TYPE_TAG
    const val BARCODE_STRING_TAG = ScanManager.BARCODE_STRING_TAG
}