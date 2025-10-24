package com.example.androidtvsample

import android.app.Activity
import android.os.Bundle
import android.widget.TextView

class MainActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val tv = TextView(this)
        tv.text = "Hello Android TV Sample App (placeholder)"
        tv.textSize = 24f
        setContentView(tv)
    }
}
