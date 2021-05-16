//
//  IdleViewController.swift
//  MJoulnir
//
//  Created by Erland Lewin on 2021-05-10.
//  Copyright © 2021 Erland Lewin. All rights reserved.
//

import UIKit
import Combine

class IdleViewController: UIViewController, SetModel {
  var model: Model?
    /* Let the PageViewController do this

      stateWatcher = model!.$state.sink { newState in
        print( "state sink: state is \(String(describing: newState))" )
        if( newState != nil ) {
          self.stateLabel.text = newState!.name
          self.stateChanged( newStateOptional: newState! )
        } }
    balanceWatcher = model!.$balance.sink { newBalance in
      print( "balance sink: balance is \(String(describing: newBalance))" )
      if( newBalance != nil ) {
        self.balanceLabel.text = "Balance: \(String.localizedStringWithFormat( "%.0f", newBalance!.voltage * 1000 )) mV, \(String.localizedStringWithFormat("%.2f", newBalance!.soc * 100))%"
      } }
     */
    /*
    bluetoothStateWatcher = model!.$bluetoothState.sink { newState in
      print( "bluetooth sink: state is \(String(describing: newState))" )
      self.bluetoothStateLabel.text = "Bluetooth: \(String(describing: newState))"
      }
 */
    /*
    powerWatcher = model!.$power.sink { newPower in
      if( newPower != nil )
      {
        let nf = NumberFormatter()
        nf.maximumFractionDigits = 0
        nf.numberStyle = .decimal

        print( "power sink: power is \(String(describing: newPower))" )
        self.powerLabel.text = "\(nf.string( from: NSNumber(value: -newPower!.power))!) W"
        self.energyLabel.text = "\(nf.string( from: NSNumber(value: -newPower!.energy_Wh))!) Wh"
        self.throttleLabel.text = "Throttle: \(nf.string( from: NSNumber(value: newPower!.duty_cycle))!) %"
        self.rpmLabel.text = "Motor: \(nf.string( from: NSNumber(value: -newPower!.motor_rpm))!) RPM"
      }
    }
     */

  @IBAction func armAction() {
    self.model?.requestStateChange(newState: .Armed)
  }

  @IBAction func offAction() {
    self.model?.requestStateChange(newState: .Off)
  }

  func setModel( model: Model )
  {
    self.model = model
  }
}
