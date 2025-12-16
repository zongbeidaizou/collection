package com.dasewan.bounty_hunter;

import android.Manifest;
import android.content.ContentResolver;
import android.content.ContentUris;
import android.content.ContentValues;
import android.content.Context;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.provider.ContactsContract;
import android.text.TextUtils;
import android.util.Log;
import androidx.core.content.ContextCompat;

/** Helper to add a contact; extracted so both MainActivity and ContactPlugin can reuse. */
public final class ContactHelper {

  private ContactHelper() {}

  public static boolean addContact(Context context, String name, String phone) {
    if (context == null || TextUtils.isEmpty(phone)) {
      return false;
    }

    if (ContextCompat.checkSelfPermission(context, Manifest.permission.WRITE_CONTACTS)
        != PackageManager.PERMISSION_GRANTED) {
      return false;
    }

    try {
      ContentResolver resolver = context.getContentResolver();
      ContentValues values = new ContentValues();

      Uri rawContactUri = resolver.insert(ContactsContract.RawContacts.CONTENT_URI, values);
      if (rawContactUri == null) {
        return false;
      }

      long rawContactId = ContentUris.parseId(rawContactUri);

      values.clear();
      values.put(ContactsContract.Data.RAW_CONTACT_ID, rawContactId);
      values.put(
          ContactsContract.Data.MIMETYPE,
          ContactsContract.CommonDataKinds.Phone.CONTENT_ITEM_TYPE);
      values.put(ContactsContract.CommonDataKinds.Phone.NUMBER, phone);
      values.put(
          ContactsContract.CommonDataKinds.Phone.TYPE,
          ContactsContract.CommonDataKinds.Phone.TYPE_MOBILE);
      resolver.insert(ContactsContract.Data.CONTENT_URI, values);

      if (!TextUtils.isEmpty(name)) {
        values.clear();
        values.put(ContactsContract.Data.RAW_CONTACT_ID, rawContactId);
        values.put(
            ContactsContract.Data.MIMETYPE,
            ContactsContract.CommonDataKinds.StructuredName.CONTENT_ITEM_TYPE);
        values.put(ContactsContract.CommonDataKinds.StructuredName.DISPLAY_NAME, name);
        resolver.insert(ContactsContract.Data.CONTENT_URI, values);
      }
      return true;
    } catch (Exception e) {
      Log.e("ContactHelper", "add contact error", e);
      return false;
    }
  }
}

