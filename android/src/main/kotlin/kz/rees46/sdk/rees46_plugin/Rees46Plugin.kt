package kz.rees46.sdk.rees46_plugin

import Rees46Receiver
import Rees46Sender
import android.app.Activity
import android.content.Context
import android.util.Log
import com.personalizatio.Api
import com.personalizatio.Api.OnApiCallbackListener
import com.personalizatio.Params
import com.personalizatio.Params.RecommendedBy
import com.rees46.sdk.REES46
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import org.json.JSONObject


/** Rees46Plugin */
class Rees46Plugin : FlutterPlugin, Rees46Sender, ActivityAware {
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

    override fun initialize(shopID: String, apiDomain: String?) {
        if (apiDomain == null) {
            REES46.initialize(appContext, shopID);
        } else {
            REES46.initialize(appContext, shopID, apiDomain);
        }
    }

    override fun track(trackEvent: String, itemID: String, amount: Long?) {
        if (trackEvent.toLowerCase() == "cart") {
            //Add to cart (extended)
            val cart = Params()
            cart
                .put(
                    Params.Item(itemID)
                        .set(Params.Item.COLUMN.AMOUNT, amount!!.toInt())
                )
            REES46.track(Params.TrackEvent.valueOf(trackEvent), cart);
            return;
        }
        REES46.track(Params.TrackEvent.valueOf(trackEvent), itemID);
    }

    override fun recommend(
        recommenderCode: String,
        extended: Boolean,
        itemID: String,
        categoryID: String,
        callback: (Result<List<String>?>) -> Unit
    ) {
        val params = Params()
        params.put(Params.Parameter.EXTENDED, extended)
        params.put(Params.Parameter.ITEM, itemID)
        params.put(Params.Parameter.CATEGORY, categoryID) //filter by category

        var response: List<String>

        REES46.recommend(recommenderCode, params, object : Api.OnApiCallbackListener() {
            override fun onSuccess(response: JSONObject) {
                callback(Result.success(parseRecommends(response)))
            }

            override fun onError(code: Int, msg: String?) {
                super.onError(code, msg)
            }
        })
    }


    fun parseRecommends(jsonObject: JSONObject): List<String> {
        val recommendsArray = jsonObject.getJSONArray("recommends")
        val recommendsList = mutableListOf<String>()

        for (i in 0 until recommendsArray.length()) {
            recommendsList.add(recommendsArray.getString(i))
        }

        return recommendsList
    }


    override fun setProfile(userId: String, email: String, phone: String) {
        var params: HashMap<String?, String?> = HashMap<String?, String?>()
        params.put("email", email)
        params.put("phone", phone)
        params.put("loyalty_id", userId)
        REES46.profile(params)
        //With callback
        REES46.profile(params, object : OnApiCallbackListener() {
            override fun onSuccess(response: JSONObject?) {
                android.util.Log.i(TAG, "Response: " + response.toString())
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
