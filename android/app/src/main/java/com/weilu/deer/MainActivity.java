package com.dasewan.bounty_hunter;

import android.graphics.Color;
import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

/**
 * @author dasewan
 */
public class MainActivity extends FlutterActivity {

  private static final String CONTACT_CHANNEL = "contact_channel";

  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    super.configureFlutterEngine(flutterEngine);
    flutterEngine.getPlugins().add(new InstallAPKPlugin(this));
    flutterEngine.getPlugins().add(new ContactPlugin());
    setupContactChannel(flutterEngine);
  }

  @Override
  protected void onCreate(@Nullable Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    /// 设置状态栏透明，导航栏沉浸。
//    getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_NAVIGATION);
    getWindow().setStatusBarColor(Color.TRANSPARENT);
  }

  private void setupContactChannel(@NonNull FlutterEngine flutterEngine) {
    new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CONTACT_CHANNEL)
        .setMethodCallHandler(
            (call, result) -> {
              if (!"addContact".equals(call.method)) {
                result.notImplemented();
                return;
              }
              String name = call.argument("name");
              String phone = call.argument("phone");
              String label = call.argument("label");
              String company = call.argument("company");
              boolean ok = ContactHelper.addContact(this, name, phone, label, company);
              if (ok) {
                result.success(true);
              } else {
                result.error("add_failed", "Failed to add contact", null);
              }
            });
  }
}
