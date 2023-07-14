package com.example.coffe_flutter

import android.app.Activity
import android.app.Instrumentation.ActivityResult
import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.view.View
import android.widget.Button
import androidx.activity.result.ActivityResultLauncher
import androidx.activity.result.contract.ActivityResultContracts
import androidx.annotation.NonNull
import com.google.android.material.bottomsheet.BottomSheetDialog
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import model.Payment

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.coffe_flutter/payment"
    private var result_payment_channel:  MethodChannel.Result? = null;

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            Log.i("MethodChannel", "Method Channel active");
            if (call.method == "payment") {
                val intent = Intent(this, PaymentActivity::class.java);
                val price = call.argument<Double>("price") as Double;
                intent.putExtra("payment_value", Payment(price = price).price);
                result_payment_channel = result;
                startActivityForResult(intent,666);
            }

            if (call.method == "payment_bottom_sheet") {
                val dialog = BottomSheetDialog(this)
                val view = layoutInflater.inflate(R.layout.bottom_sheet_dialog, null)

                val btnClose = view.findViewById<Button>(R.id.idBtnDismiss)

                btnClose.setOnClickListener {
                    result?.success("2324243");
                    dialog.dismiss()
                }
                dialog.setCancelable(false)
                dialog.setContentView(view)
                dialog.show()
            }

        }
    }


    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data);
        if(requestCode == 666  && data != null){
            Log.i("requestCode", "666");
            if(resultCode == 601){
                val bundle = intent.extras;
                Log.i("resultCode", "601");
                if(bundle !== null){
                    val value = data.getStringExtra("payment_success");
                    result_payment_channel?.success(value);
                }
            } else{
                result_payment_channel?.error(401.toString(),"Fail payment", null);
            }

        }
    }

    fun onPaymentBottomSheet(view: View?){
       Log.i("onPaymentBottomSheet", "true");
    }
}


