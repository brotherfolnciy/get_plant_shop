package com.example.get_plant

import android.os.Build
import android.os.Bundle
import android.graphics.Color
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            window.setDecorFitsSystemWindows(false)
            window.navigationBarColor = 0
            window.navigationBarDividerColor = 0
            window.statusBarColor = 0
        }
    }
}