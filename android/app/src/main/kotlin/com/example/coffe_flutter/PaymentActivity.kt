package com.example.coffe_flutter

import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.view.View
import android.widget.TextView
import io.flutter.embedding.android.FlutterActivity


class PaymentActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_payment);
        val bundle = intent.extras
        if(bundle !== null){
            val tvPrice: TextView = findViewById(R.id.tvPrice);
            val price = bundle.getDouble("payment_value");
            Log.i("TAG_PRICE", price.toString());
            tvPrice.text = "Заказ на сумму: $price";
        }
    }

    fun onPayment(view: View?){
        intent.putExtra("payment_success", "123434");
        Log.i("BTN_CLICK_PAYMENT", "true");
        setResult(601, intent);
        finish();
    }
}