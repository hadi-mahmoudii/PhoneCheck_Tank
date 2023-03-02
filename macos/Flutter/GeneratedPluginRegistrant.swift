//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

import audio_session
import battery_plus
import connectivity_plus
import device_info_plus_macos
import geolocator_apple
import just_audio
import path_provider_macos
import tbibaudioplayers

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  AudioSessionPlugin.register(with: registry.registrar(forPlugin: "AudioSessionPlugin"))
  BatteryPlusMacosPlugin.register(with: registry.registrar(forPlugin: "BatteryPlusMacosPlugin"))
  ConnectivityPlugin.register(with: registry.registrar(forPlugin: "ConnectivityPlugin"))
  DeviceInfoPlusMacosPlugin.register(with: registry.registrar(forPlugin: "DeviceInfoPlusMacosPlugin"))
  GeolocatorPlugin.register(with: registry.registrar(forPlugin: "GeolocatorPlugin"))
  JustAudioPlugin.register(with: registry.registrar(forPlugin: "JustAudioPlugin"))
  PathProviderPlugin.register(with: registry.registrar(forPlugin: "PathProviderPlugin"))
  tbibaudioplayersPlugin.register(with: registry.registrar(forPlugin: "tbibaudioplayersPlugin"))
}
