package org.apache.cordova.umeng;

import android.util.Log;

import com.umeng.analytics.AnalyticsConfig;
import com.umeng.analytics.MobclickAgent;
import com.umeng.update.UmengUpdateAgent;
import com.umeng.update.UpdateConfig;
import com.umeng.update.UpdateStatus;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.PluginResult;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class Update extends CordovaPlugin {

    private static final String TAG = "cordova-umeng-update";

    @Override
    public void onPause(boolean multitasking) {
        super.onPause(multitasking);
        MobclickAgent.onPause(cordova.getActivity());
    }

    @Override
    public void onResume(boolean multitasking) {
        super.onResume(multitasking);
        MobclickAgent.onResume(cordova.getActivity());
    }

    @Override
    public void onStop() {
        super.onStop();
    }

    @Override
    public boolean execute(String action, JSONArray args,
                           CallbackContext callback) throws JSONException {
        Log.d(TAG, action + " is called.");
        if (action.equals("config")) config(args.getJSONObject(0), callback);
        else if (action.equals("update")) update(callback);
        else if (action.equals("forceUpdate")) forceUpdate(callback);
        else if (action.equals("silentUpdate")) silentUpdate(callback);
        else return false;
        return true;
    }


    private void config(JSONObject obj, CallbackContext callback) throws JSONException {
        UpdateConfig.setChannel(obj.getString("channel"));
        UpdateConfig.setAppkey(obj.getString("appkey"));

        if (obj.has("updateOnlyWifi")) UpdateConfig.setUpdateOnlyWifi(obj.getBoolean("updateOnlyWifi"));
        if (obj.has("deltaUpdate")) UpdateConfig.setDeltaUpdate(obj.getBoolean("deltaUpdate"));
        if (obj.has("updateAutoPopup")) UpdateConfig.setUpdateAutoPopup(obj.getBoolean("updateAutoPopup"));
        if (obj.has("richNotification")) UpdateConfig.setRichNotification(obj.getBoolean("richNotification"));
        if (obj.has("updateCheckConfig")) UpdateConfig.setUpdateOnlyWifi(obj.getBoolean("updateCheckConfig"));
        if (obj.has("updateUIStyle")) UmengUpdateAgent.setUpdateUIStyle(obj.getInt("updateUIStyle"));

        callback.success();
    }

    private void update(CallbackContext callback) {
        UmengUpdateAgent.update(cordova.getActivity());
        callback.success();
    }

    private void forceUpdate(CallbackContext callback) {
        UmengUpdateAgent.forceUpdate(cordova.getActivity());
        callback.success();
    }

    private void silentUpdate(CallbackContext callback) {
        UmengUpdateAgent.silentUpdate(cordova.getActivity());
        callback.success();
    }


}
