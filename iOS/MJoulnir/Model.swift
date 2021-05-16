//
//  Model.swift
//  solo
//
//  Created by Erland Lewin on 2021-04-14.
//  Copyright © 2021 Erland Lewin. All rights reserved.
//

import Foundation
import CoreBluetooth
import CoreLocation

struct Balance
{
  var voltage: Double
  var soc: Double
}

struct Temperatures
{
  var vesc_mos: Int8?
  var vesc_mos_1: Int8?
  var vesc_mos_2: Int8?
  var vesc_mos_3: Int8?
  var motor: Int8?
  var battery: [[Int8?]]
  var pi: Int8?
}

struct Power
{
  var power: Int
  var battery_current: Double
  var energy_Wh: Int
  var duty_cycle: Int
  var motor_rpm: Int
}

class Model: NSObject, ObservableObject
{
  enum BluetoothState {
    case scanning
    case connected
    case following
  }

  enum State: UInt8 {
    case Off = 0
    case Booting = 1
    case Idle = 2
    case Armed = 3
    case Charging = 4
    case Balancing = 5
    case Active = 6
    case Error = 7

    static let names = [State.Off: "Off",
                        State.Booting: "Booting",
                        State.Idle: "Idle",
                        State.Armed: "Armed",
                        State.Charging: "Charging",
                        State.Balancing: "Balancing",
                        State.Active: "Active",
                        State.Error: "Error"
                       ];
    var name: String
    {
      return Model.State.names[self]!
    }
  }

  @Published private(set) var bluetoothState = BluetoothState.scanning
  @Published private(set) var state: State?
  @Published private(set) var balance: Balance?
  @Published private(set) var temperatures: Temperatures?
  @Published private(set) var power: Power?
  @Published private(set) var batteryLevel: Int?

  private var centralManager: CBCentralManager!
  private var locationManager: CLLocationManager!

  private var mjoulnir: CBPeripheral!

  private var service: CBService!
  private var batteryService: CBService!

  private var characteristic_state: CBCharacteristic!
  private var characteristic_balance: CBCharacteristic!
  private var characteristic_battery_level: CBCharacteristic!
  private var characteristic_power: CBCharacteristic!
  private var characteristic_temperatures: CBCharacteristic!

  override public init()
  {
    super.init()
  }
  
  func start()
  {
    centralManager = CBCentralManager(delegate: self, queue: nil)
    locationManager = CLLocationManager()
    locationManager.delegate = self
    locationManager.activityType = .otherNavigation
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
  }

  func startScanning() -> Void {
    // Start Scanning
    centralManager?.scanForPeripherals(withServices: [CBUUIDs.BLEMjoulnirService_UUID])
  }

  func refresh() -> Void {
    // called when the application returns from background
    switch(bluetoothState)
    {
      case .scanning:
        // is the centralManager still scanning? if not, start scanning
        if( !centralManager.isScanning ) {
          startScanning()
        }
        break

      case .following, .connected:
        print( "Refresh: mjoulnir state is: \(String(describing: mjoulnir.state))" )
        switch( mjoulnir.state )
        {
          case .disconnected:
            print("mjoulnir is disconnected")
            startScanning()
            break;

          default:
            print("mjoulnir is not disconnected")
            break;
        }

    }
  }

  func requestStateChange( newState: State )
  {
    var data = Data(capacity:1)
    data.append(newState.rawValue)
    self.mjoulnir!.writeValue( data, for: self.characteristic_state, type: CBCharacteristicWriteType.withResponse )
    // Try below, otherwise we don't get a notification?
    // self.mjoulnir!.readValue(for: self.characteristic_state)
  }
}

// Byte array (Data) to integer functionality
public enum Endian {
    case big, little
}
protocol IntegerTransform: Sequence where Element: FixedWidthInteger {
    func toInteger<I: FixedWidthInteger>(endian: Endian) -> I
}
extension IntegerTransform {
    func toInteger<I: FixedWidthInteger>(endian: Endian) -> I {
        let f = { (accum: I, next: Element) in accum &<< next.bitWidth | I(next) }
        return endian == .big ? reduce(0, f) : reversed().reduce(0, f)
    }
}

extension Data: IntegerTransform {}
extension Array: IntegerTransform where Element: FixedWidthInteger {}
// MARK: - CBCentralManagerDelegate
// A protocol that provides updates for the discovery and management of peripheral devices.
extension Model: CBCentralManagerDelegate {
  // MARK: - Check
  func centralManagerDidUpdateState(_ central: CBCentralManager) {

    switch central.state {
      case .poweredOff:
          print("Is Powered Off.")
        // TODO: Signal error to UI, and let ViewController display alerts
/*
          let alertVC = UIAlertController(title: "Bluetooth Required", message: "Check your Bluetooth Settings", preferredStyle: UIAlertController.Style.alert)

          let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction) -> Void in
              self.dismiss(animated: true, completion: nil)
          })

          alertVC.addAction(action)

          self.present(alertVC, animated: true, completion: nil)
*/
      case .poweredOn:
          print("Is Powered On.")
          startScanning()
      case .unsupported:
          print("Is Unsupported.")
      case .unauthorized:
        print("Is Unauthorized.")
      case .unknown:
          print("Unknown")
      case .resetting:
          print("Resetting")
      @unknown default:
        print("Error")
      }
  }

  func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,advertisementData: [String : Any], rssi RSSI: NSNumber) {

   mjoulnir = peripheral

   mjoulnir.delegate = self

   print("Mjoulnir Discovered: \(peripheral)")
   print("Mjoulnir name: \(String(describing: peripheral.name))")
   print("Advertisement Data : \(advertisementData)")

   centralManager?.stopScan()

    centralManager.connect(mjoulnir)

    // navigate to PageViewController

    /*
    let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("pageViewController") as NextViewController
    self.presentViewController(nextViewController, animated:true, completion:nil)
 */
  }

  func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
    print( "Connected" )
    self.bluetoothState = .connected
    self.mjoulnir.discoverServices([CBUUIDs.BLEMjoulnirService_UUID, CBUUIDs.BLEBatteryService_UUID])
    self.mjoulnir.delegate = self
  }
  func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
    print( "Peripheral disconnected, rescanning" )
    self.bluetoothState = .scanning
    startScanning()
  }

  func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
    print( "Failed to connect to peripheral, retrying..." )
    centralManager.connect(mjoulnir)
  }
}

extension Model: CBPeripheralDelegate {
  func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
    print( "Discovered services" )

    guard let services = peripheral.services else { return }

    for service in services {
      if service.uuid == CBUUIDs.BLEMjoulnirService_UUID
      {
        self.service = service
        peripheral.discoverCharacteristics(nil, for: service)
      }
      if service.uuid == CBUUIDs.BLEBatteryService_UUID
      {
        self.batteryService = service
        peripheral.discoverCharacteristics(nil, for: service)
      }
    }

  }

  func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
    print( "Discovered characteristics" )

    guard let characteristics = service.characteristics else { return }

    for characteristic in characteristics {
      switch characteristic.uuid
      {
        case CBUUIDs.BLEMjoulnirCharacteristic_State_UUID:
          self.characteristic_state = characteristic;
          peripheral.setNotifyValue(true, for: characteristic)
          peripheral.readValue(for: characteristic)
          break

      case CBUUIDs.BLEMjoulnirCharacteristic_Balance_UUID:
        self.characteristic_balance = characteristic
        peripheral.setNotifyValue(true, for: characteristic)
        peripheral.readValue(for: characteristic)
        break

      case CBUUIDs.BLEMjoulnirCharacteristic_Temperatures_UUID:
        self.characteristic_temperatures = characteristic
        peripheral.setNotifyValue(true, for: characteristic)
        peripheral.readValue(for: characteristic)
        break

      case CBUUIDs.BLEMjoulnirCharacteristic_Power_UUID:
        self.characteristic_power = characteristic
        peripheral.setNotifyValue(true, for: characteristic)
        peripheral.readValue(for: characteristic)
        break

      case CBUUIDs.BLECharacteristic_BatteryLevel_UUID:
        self.characteristic_battery_level = characteristic
        peripheral.setNotifyValue(true, for: characteristic)
        peripheral.readValue(for: characteristic)
        break

      default:
        break
      }
      print(characteristic)
    }
    print("Set bluetoothstate to following" )
    self.bluetoothState = .following
  }

  func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
    print( "didUpdateValueFor called, uuid=\(characteristic.uuid)" );
    switch characteristic.uuid
    {
      case CBUUIDs.BLECharacteristic_BatteryLevel_UUID:
        let value = characteristic.value!.first!
        print( "Read battery level: \(value)" )
        self.batteryLevel = Int(value)
        break

      case CBUUIDs.BLEMjoulnirCharacteristic_State_UUID:
        let value = characteristic.value!.first!
        let theState = Model.State(rawValue: value)
        print( "value: \(value), state:\(String(describing: theState))" )
        // problem is the line below. Value is properly 4.
        self.state = theState
        break

    case CBUUIDs.BLEMjoulnirCharacteristic_Balance_UUID:
      let voltage = (Double(characteristic.value![0]) + Double(characteristic.value![1]) * 256) / 1000.0
      let soc = (Double(characteristic.value![2]) + Double(characteristic.value![3]) * 256) / 10000.0

      print( "BLE: balance: \(voltage) V, \(soc * 100) % soc" )
      self.balance = Balance(voltage: voltage, soc: soc)
      break

    case CBUUIDs.BLEMjoulnirCharacteristic_Temperatures_UUID:
      let vesc_mos = temperatureIntOrNil( byte: characteristic.value![0] )
      let vesc_mos_1 = temperatureIntOrNil( byte: characteristic.value![1])
      let vesc_mos_2 = temperatureIntOrNil( byte: characteristic.value![2])
      let vesc_mos_3 = temperatureIntOrNil( byte: characteristic.value![3])
      let motor = temperatureIntOrNil( byte: characteristic.value![4])
      var batteries: [[Int8?]] = [[nil,nil], [nil,nil], [nil,nil]]

      for module in 0...2
      {
        for sensor in 0...1
        {
          batteries[module][sensor] = temperatureIntOrNil( byte: characteristic.value![5 + module * 2 + sensor])
        }
      }

      let pi = temperatureIntOrNil( byte: characteristic.value![11])

      // print( "BLE: vesc_mos temperature is \(vesc_mos)" )

      self.temperatures = Temperatures(vesc_mos: vesc_mos, vesc_mos_1: vesc_mos_1, vesc_mos_2: vesc_mos_2,
                                       vesc_mos_3: vesc_mos_3, motor: motor, battery: batteries, pi: pi )
      break

      case CBUUIDs.BLEMjoulnirCharacteristic_Power_UUID:
        // TODO: make resilient to fewer bytes
        // if
        let power_chunk = characteristic.value!.subdata(in:0..<2)
        let power: Int16 = power_chunk.toInteger( endian: .little )
        let current_chunk = characteristic.value!.subdata(in:2..<4)
        let wh_consumed_chunk = characteristic.value!.subdata(in:4..<6)
        let motor_rpm_chunk = characteristic.value!.subdata(in:6..<8)
        let duty_chunk = characteristic.value!.subdata(in:8..<9)

        let current : Int16 = current_chunk.toInteger(endian: .little)
        let energy_wh : Int16 = wh_consumed_chunk.toInteger(endian: .little)
        let motor_rpm :Int16 = motor_rpm_chunk.toInteger(endian: .little)
        let duty : Int8 = duty_chunk.toInteger(endian: .little)

        self.power = Power(power: Int(power), battery_current: Double(current) / 100.0, energy_Wh: Int(energy_wh), duty_cycle: Int(duty), motor_rpm: Int(motor_rpm) )
        break

      default:
        print( "Unrecognized characteristic UUID \(characteristic.uuid)" )
    }

  }

  func peripheral(_ peripheral: CBPeripheral, didWriteValueFor: CBCharacteristic, error: Error? )
  {
    if( error != nil )
    {
      print( "Error writing characteristic: \(error!)" );
    }
    else
    {
      print( "Successfully wrote characteristic" );
    }
  }

  func temperatureIntOrNil( byte: UInt8 ) -> Int8?
  {
    if( byte == 0x80 )
    {
      return nil
    }
    else
    {
      return Int8(byte);
    }
  }
}

extension Model: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager,
             didUpdateLocations locations: [CLLocation])
  {}



  func locationManager(_: CLLocationManager, didUpdateHeading: CLHeading)
  {}
}
