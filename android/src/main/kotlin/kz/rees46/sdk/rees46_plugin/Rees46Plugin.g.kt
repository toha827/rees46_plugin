// Autogenerated from Pigeon (v18.0.1), do not edit directly.
// See also: https://pub.dev/packages/pigeon
@file:Suppress("UNCHECKED_CAST", "ArrayInDataClass")


import android.util.Log
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MessageCodec
import io.flutter.plugin.common.StandardMessageCodec
import java.io.ByteArrayOutputStream
import java.nio.ByteBuffer

private fun wrapResult(result: Any?): List<Any?> {
  return listOf(result)
}

private fun wrapError(exception: Throwable): List<Any?> {
  return if (exception is FlutterError) {
    listOf(
      exception.code,
      exception.message,
      exception.details
    )
  } else {
    listOf(
      exception.javaClass.simpleName,
      exception.toString(),
      "Cause: " + exception.cause + ", Stacktrace: " + Log.getStackTraceString(exception)
    )
  }
}

/**
 * Error class for passing custom error details to Flutter via a thrown PlatformException.
 * @property code The error code.
 * @property message The error message.
 * @property details The error details. Must be a datatype supported by the api codec.
 */
class FlutterError (
  val code: String,
  override val message: String? = null,
  val details: Any? = null
) : Throwable()

enum class TrackEvent(val raw: Int) {
  VIEW(0),
  CATEGORY(1),
  CART(2),
  REMOVE_FROM_CART(3),
  PURCHASE(4),
  SEARCH(5),
  WISH(6),
  REMOVE_WISH(7);

  companion object {
    fun ofRaw(raw: Int): TrackEvent? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

/**
 * FLUTTER FRAMEWORK -> FLUTTER ENGINE
 *
 * Generated interface from Pigeon that represents a handler of messages from Flutter.
 */
interface Rees46Sender {
  fun initialize(shopID: String, apiDomain: String?)
  fun track(trackEvent: String, itemID: String, amount: Long?)
  fun recommend(recommenderCode: String, extended: Boolean, itemID: String, categoryID: String, callback: (Result<List<String>?>) -> Unit)
  fun setProfile(userId: String, email: String, phone: String)

  companion object {
    /** The codec used by Rees46Sender. */
    val codec: MessageCodec<Any?> by lazy {
      StandardMessageCodec()
    }
    /** Sets up an instance of `Rees46Sender` to handle messages through the `binaryMessenger`. */
    fun setUp(binaryMessenger: BinaryMessenger, api: Rees46Sender?, messageChannelSuffix: String = "") {
      val separatedMessageChannelSuffix = if (messageChannelSuffix.isNotEmpty()) ".$messageChannelSuffix" else ""
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.rees64_plugin.Rees46Sender.initialize$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val shopIDArg = args[0] as String
            val apiDomainArg = args[1] as String?
            val wrapped: List<Any?> = try {
              api.initialize(shopIDArg, apiDomainArg)
              listOf<Any?>(null)
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.rees64_plugin.Rees46Sender.track$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val trackEventArg = args[0] as String
            val itemIDArg = args[1] as String
            val amountArg = args[2].let { num -> if (num is Int) num.toLong() else num as Long? }
            val wrapped: List<Any?> = try {
              api.track(trackEventArg, itemIDArg, amountArg)
              listOf<Any?>(null)
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.rees64_plugin.Rees46Sender.recommend$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val recommenderCodeArg = args[0] as String
            val extendedArg = args[1] as Boolean
            val itemIDArg = args[2] as String
            val categoryIDArg = args[3] as String
            api.recommend(recommenderCodeArg, extendedArg, itemIDArg, categoryIDArg) { result: Result<List<String>?> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                val data = result.getOrNull()
                reply.reply(wrapResult(data))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.rees64_plugin.Rees46Sender.setProfile$separatedMessageChannelSuffix", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val userIdArg = args[0] as String
            val emailArg = args[1] as String
            val phoneArg = args[2] as String
            val wrapped: List<Any?> = try {
              api.setProfile(userIdArg, emailArg, phoneArg)
              listOf<Any?>(null)
            } catch (exception: Throwable) {
              wrapError(exception)
            }
            reply.reply(wrapped)
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
    }
  }
}
/**
 * FLUTTER FRAMEWORK <- FLUTTER ENGINE
 *
 * Generated class from Pigeon that represents Flutter messages that can be called from Kotlin.
 */
class Rees46Receiver(private val binaryMessenger: BinaryMessenger, private val messageChannelSuffix: String = "") {
  companion object {
    /** The codec used by Rees46Receiver. */
    val codec: MessageCodec<Any?> by lazy {
      StandardMessageCodec()
    }
  }
}
