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

  public static boolean addContact(Context context, String name, String phone, String label, String company) {
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

      // 电话号码
      values.clear();
      values.put(ContactsContract.Data.RAW_CONTACT_ID, rawContactId);
      values.put(
          ContactsContract.Data.MIMETYPE,
          ContactsContract.CommonDataKinds.Phone.CONTENT_ITEM_TYPE);
      values.put(ContactsContract.CommonDataKinds.Phone.NUMBER, phone);
      values.put(
          ContactsContract.CommonDataKinds.Phone.TYPE,
          ContactsContract.CommonDataKinds.Phone.TYPE_CUSTOM);
      values.put(ContactsContract.CommonDataKinds.Phone.LABEL,
          TextUtils.isEmpty(label) ? "BountyHunter" : label);
      resolver.insert(ContactsContract.Data.CONTENT_URI, values);

      // 姓名
      if (!TextUtils.isEmpty(name)) {
        values.clear();
        values.put(ContactsContract.Data.RAW_CONTACT_ID, rawContactId);
        values.put(
            ContactsContract.Data.MIMETYPE,
            ContactsContract.CommonDataKinds.StructuredName.CONTENT_ITEM_TYPE);
        values.put(ContactsContract.CommonDataKinds.StructuredName.DISPLAY_NAME, name);
        resolver.insert(ContactsContract.Data.CONTENT_URI, values);
      }

      // 公司名称
      if (!TextUtils.isEmpty(company)) {
        values.clear();
        values.put(ContactsContract.Data.RAW_CONTACT_ID, rawContactId);
        values.put(
            ContactsContract.Data.MIMETYPE,
            ContactsContract.CommonDataKinds.Organization.CONTENT_ITEM_TYPE);
        values.put(ContactsContract.CommonDataKinds.Organization.COMPANY, company);
        values.put(ContactsContract.CommonDataKinds.Organization.TYPE,
            ContactsContract.CommonDataKinds.Organization.TYPE_WORK);
        resolver.insert(ContactsContract.Data.CONTENT_URI, values);
      }
      return true;
    } catch (Exception e) {
      Log.e("ContactHelper", "add contact error", e);
      return false;
    }
  }
}

