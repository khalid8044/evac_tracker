
package com.connectauz.evacmobile
import android.os.Build
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterFragmentActivity() {
    private val CHANNEL = "platform_build"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getBuildSdkVersion" -> {
                    val sdkVersion = getBuildSdkVersion()
                    if (sdkVersion != null) {
                        result.success(sdkVersion)
                    } else {
                        result.error("UNAVAILABLE", "Build SDK version not available.", null)
                    }
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    private fun getBuildSdkVersion(): Int {
        return Build.VERSION.SDK_INT
    }
}

