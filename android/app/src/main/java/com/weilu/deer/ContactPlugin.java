package com.dasewan.bounty_hunter;

import android.content.Context;
import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/** Platform channel for adding a contact into the phone book. */
public class ContactPlugin implements FlutterPlugin, MethodChannel.MethodCallHandler {

  private static final String CHANNEL_NAME = "contact_channel";

  private MethodChannel channel;
  private Context applicationContext;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
    applicationContext = binding.getApplicationContext();
    channel = new MethodChannel(binding.getBinaryMessenger(), CHANNEL_NAME);
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    if (channel != null) {
      channel.setMethodCallHandler(null);
      channel = null;
    }
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
    if ("addContact".equals(call.method)) {
      String name = call.argument("name");
      String phone = call.argument("phone");
      String label = call.argument("label");
      String company = call.argument("company");
      boolean added = ContactHelper.addContact(applicationContext, name, phone, label, company);
      if (added) {
        result.success(true);
      } else {
        result.error("add_failed", "Failed to add contact", null);
      }
    } else {
      result.notImplemented();
    }
  }

}

