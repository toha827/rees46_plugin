package kz.rees46.sdk.rees46_plugin

import Rees46Receiver
import Rees46Sender
import android.app.Activity
import android.content.Context
import android.util.Log
import androidx.annotation.NonNull
import com.rees46.sdk.REES46
import com.personalizatio.Api
import com.personalizatio.Params

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import org.json.JSONObject

/** Rees46Plugin */
class Rees46Plugin: FlutterPlugin, Rees46Sender, ActivityAware {
  private companion object {
    private const val TAG = "Rees46Plugin"

    private var sink: Rees46Receiver? = null

    lateinit var appContext: Context

    private lateinit var activity: Activity
  }

  override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    try {
      Rees46Sender.setUp(binding.binaryMessenger, this);
      sink = Rees46Receiver(binding.binaryMessenger)
      appContext = binding.applicationContext
      Log.i(TAG, "REES46 INITIALIZED")
    } catch (e: Exception) {
      Log.e(TAG, "$e")
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    Rees46Sender.setUp(binding.binaryMessenger, null);
    sink = null
  }

  override fun initialize(shopID: String, apiDomain: String) {
    REES46.initialize(appContext, shopID);
  }

  override fun track(trackEvent: String, itemID: String) {
    REES46.track(Params.TrackEvent.valueOf(trackEvent), itemID);
  }

  override fun recommend(recommenderCode: String, extended: Boolean, itemID: String, categoryID: String) {
    val params = Params()
    params.put(Params.Parameter.EXTENDED, extended)
    params.put(Params.Parameter.ITEM, itemID)
    params.put(Params.Parameter.CATEGORY, categoryID) //filter by category

    REES46.recommend("RECOMMENDER_CODE", params, object : Api.OnApiCallbackListener() {
      override fun onSuccess(response: JSONObject) {
        Log.i(TAG, "Recommender response: $response")
      }
    })
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
    TODO("Not yet implemented")
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    TODO("Not yet implemented")
  }

  override fun onDetachedFromActivity() {
    TODO("Not yet implemented")
  }

}
