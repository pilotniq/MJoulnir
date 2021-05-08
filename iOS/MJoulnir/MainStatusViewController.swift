//
//  MainStatusViewController.swift
//  solo
//
//  Created by Erland Lewin on 2021-04-14.
//  Copyright © 2021 Erland Lewin. All rights reserved.
//

import UIKit
import Combine

class MainStatusViewController: UIViewController {

  var model: Model?

  var stateWatcher: AnyCancellable?
  var balanceWatcher: AnyCancellable?
  var bluetoothStateWatcher: AnyCancellable?
  var powerWatcher: AnyCancellable?

  @IBOutlet weak var stateLabel: UILabel!
  @IBOutlet weak var balanceLabel: UILabel!
  @IBOutlet weak var bluetoothStateLabel: UILabel!
  @IBOutlet weak var powerLabel: UILabel!
  @IBOutlet weak var energyLabel: UILabel!
  @IBOutlet weak var throttleLabel: UILabel!
  @IBOutlet weak var rpmLabel: UILabel!
  @IBOutlet weak var balance: UIButton!
  @IBOutlet weak var disarmButton: UIButton!
  @IBOutlet weak var armButton: UIButton!
  @IBOutlet weak var chargeButton: UIButton!
  @IBOutlet weak var balanceButton: UIButton!
  
  override func viewDidLoad() {
        super.viewDidLoad()

    // let scene = self.view.window!.windowScene!.delegate as! SceneDelegate
    // scene.model = model

        // Do any additional setup after loading the view.
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
    bluetoothStateWatcher = model!.$bluetoothState.sink { newState in
      print( "bluetooth sink: state is \(String(describing: newState))" )
      self.bluetoothStateLabel.text = "Bluetooth: \(String(describing: newState))"
      }
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
    }
    
  func setModel( model: Model )
  {
    self.model = model
  }

  func stateChanged( newStateOptional: Model.State? )
  {
    let newState = newStateOptional!

    let disarm_enabled = newState != .Idle
    let arm_enabled = newState != .Armed

    self.updateButtonAppearance( button: self.disarmButton, enabled: disarm_enabled )
    self.updateButtonAppearance( button: self.armButton, enabled: arm_enabled )

  }

  func updateButtonAppearance( button: UIButton, enabled: Bool)
  {
    button.isEnabled = enabled
    if( enabled )
    {
      button.backgroundColor = .yellow
    }
    else
    {
      button.backgroundColor = .darkGray
    }
  }

  @IBAction func disarm(_ sender: Any) {
    self.model?.requestStateChange(newState: .Idle)
  }

  
  @IBAction func arm(_ sender: Any) {
    self.model?.requestStateChange(newState: .Armed)
  }
  /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
