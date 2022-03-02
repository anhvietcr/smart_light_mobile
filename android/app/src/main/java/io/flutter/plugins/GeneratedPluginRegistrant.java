package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
import dev.fluttercommunity.plus.device_info.DeviceInfoPlusPlugin;
import com.baseflow.permissionhandler.PermissionHandlerPlugin;
import com.alternadom.wifiiot.WifiIotPlugin;

/**
 * Generated file. Do not edit.
 */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    DeviceInfoPlusPlugin.registerWith(registry.registrarFor("dev.fluttercommunity.plus.device_info.DeviceInfoPlusPlugin"));
    PermissionHandlerPlugin.registerWith(registry.registrarFor("com.baseflow.permissionhandler.PermissionHandlerPlugin"));
    WifiIotPlugin.registerWith(registry.registrarFor("com.alternadom.wifiiot.WifiIotPlugin"));
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry) {
    final String key = GeneratedPluginRegistrant.class.getCanonicalName();
    if (registry.hasPlugin(key)) {
      return true;
    }
    registry.registrarFor(key);
    return false;
  }
}
