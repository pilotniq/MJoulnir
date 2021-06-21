//
//  CBUUIDs.swift
//  solo
//
//  Created by Erland Lewin on 2021-04-08.
//  Copyright © 2021 Erland Lewin. All rights reserved.
//

import Foundation

import CoreBluetooth

struct CBUUIDs{

  static let kBLE_BatteryService_UUID = "180f"
  static let kBLE_Characteristic_BatteryLevel_UUID = "2a19"

  static let kBLE_MJoulnirService_UUID = "71498776-a04c-4800-a1d9-25ebc70b0000" // 6e400001-b5a3-f393-e0a9-e50e24dcca9e"
  static let kBLE_MJoulnirCharacteristic_BatteryVoltages_UUID = "71498776-a04c-4800-a1d9-25ebc70b0001"
  static let kBLE_MJoulnirCharacteristic_State_UUID = "71498776-a04c-4800-a1d9-25ebc70b0002"
  static let kBLE_MJoulnirCharacteristic_Balance_UUID = "71498776-a04c-4800-a1d9-25ebc70b0003"
  static let kBLE_MJoulnirCharacteristic_Temperatures_UUID = "71498776-a04c-4800-a1d9-25ebc70b0004"
  static let kBLE_MJoulnirCharacteristic_Power_UUID = "71498776-a04c-4800-a1d9-25ebc70b0005"
  static let kBLE_MJoulnirCharacteristic_ChargerState_UUID = "71498776-a04c-4800-a1d9-25ebc70b0006"
  static let kBLE_MJoulnirCharacteristic_ChargerSettings_UUID = "71498776-a04c-4800-a1d9-25ebc70b0007"
//    static let MaxCharacters = 20


  static let BLEBatteryService_UUID = CBUUID(string: kBLE_BatteryService_UUID)
  static let BLECharacteristic_BatteryLevel_UUID = CBUUID(string: kBLE_Characteristic_BatteryLevel_UUID)

  static let BLEMjoulnirService_UUID = CBUUID(string: kBLE_MJoulnirService_UUID)
  static let BLEMjoulnirCharacteristic_State_UUID = CBUUID(string: kBLE_MJoulnirCharacteristic_State_UUID)
  static let BLEMjoulnirCharacteristic_Balance_UUID = CBUUID(string: kBLE_MJoulnirCharacteristic_Balance_UUID)
  static let BLEMjoulnirCharacteristic_Temperatures_UUID = CBUUID(string: kBLE_MJoulnirCharacteristic_Temperatures_UUID)
  static let BLEMjoulnirCharacteristic_Power_UUID = CBUUID(string: kBLE_MJoulnirCharacteristic_Power_UUID)
  static let BLEMjoulnirCharacteristic_ChargerState_UUID = CBUUID(string: kBLE_MJoulnirCharacteristic_ChargerState_UUID)
  static let BLEMjoulnirCharacteristic_ChargerSettings_UUID = CBUUID(string: kBLE_MJoulnirCharacteristic_ChargerSettings_UUID)
}
