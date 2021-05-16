//
//  MainStatusViewController.swift
//  solo
//
//  Created by Erland Lewin on 2021-04-14.
//  Copyright © 2021 Erland Lewin. All rights reserved.
//

import UIKit
import Combine

class MainStatusViewController: UIViewController, SetModel {

  var model: Model?

  var stateWatcher: AnyCancellable?
  var balanceWatcher: AnyCancellable?
  var bluetoothStateWatcher: AnyCancellable?
  var batteryLevelWatcher: AnyCancellable?

  @IBOutlet weak var stateLabel: UILabel!
  @IBOutlet weak var socLabel: UILabel!
  @IBOutlet weak var balanceLabel: UILabel!
  @IBOutlet weak var bluetoothStateLabel: UILabel!

  @IBOutlet weak var armedView: UIView!
  @IBOutlet weak var disarmedView: UIView!
  @IBOutlet weak var activeView: UIView!

  override func viewDidLoad() {
        super.viewDidLoad()
    }

  override func viewWillAppear(_ animated: Bool) {
    // let scene = self.view.window!.windowScene!.delegate as! SceneDelegate
    // scene.model = model

    guard let model = self.model else {return}

        // Do any additional setup after loading the view.
      stateWatcher = model.$state.sink { newState in
        print( "state sink: state is \(String(describing: newState))" )
        if( newState != nil ) {
          self.stateLabel.text = newState!.name
          self.stateChanged( newStateOptional: newState! )
        } }

    if let batteryLevel = model.batteryLevel
    {
      updateSOC(percentage: batteryLevel)
    }

      // Do any additional setup after loading the view.
    batteryLevelWatcher = model.$batteryLevel.sink { percentage in
        self.updateSOC( percentage: percentage )
    }
    balanceWatcher = model.$balance.sink { newBalance in
      print( "balance sink: balance is \(String(describing: newBalance))" )
      if( newBalance != nil ) {
        self.balanceLabel.text = "Balance: \(String.localizedStringWithFormat( "%.0f", newBalance!.voltage * 1000 )) mV, \(String.localizedStringWithFormat("%.2f", newBalance!.soc * 100))%"
      } }
    bluetoothStateWatcher = model.$bluetoothState.sink { newState in
      print( "bluetooth sink: state is \(String(describing: newState))" )
      self.bluetoothStateLabel.text = "Bluetooth: \(String(describing: newState))"
      }
  }

  override func viewDidDisappear(_ animated: Bool) {
    batteryLevelWatcher?.cancel()
    bluetoothStateWatcher?.cancel()
    balanceWatcher?.cancel()
    stateWatcher?.cancel()
  }

  func setModel( model: Model )
  {
    self.model = model
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let vc = segue.destination as? SetModel
    {
      vc.setModel(model: self.model!)
    }
  }

  func stateChanged( newStateOptional: Model.State? )
  {

    if let newState = newStateOptional
    {
      switch newState
      {
      case .Idle:
        self.disarmedView.isHidden = false
        self.armedView.isHidden = true
        self.activeView.isHidden = true
        break

      case .Armed:
        self.disarmedView.isHidden = true
        self.armedView.isHidden = false
        self.activeView.isHidden = true
        break

      case .Active:
        self.armedView.isHidden = true
        self.disarmedView.isHidden = true
        self.activeView.isHidden = false
        break

      default:
        self.disarmedView.isHidden = true
        self.armedView.isHidden = true
        self.activeView.isHidden = true
        break;
      }
      /*
      let disarm_enabled = newState != .Idle
      let arm_enabled = newState != .Armed

       self.updateButtonAppearance( button: self.disarmButton, enabled: disarm_enabled )
      self.updateButtonAppearance( button: self.armButton, enabled: arm_enabled )
*/
    }
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
/*
  @IBAction func disarm(_ sender: Any) {
    self.model?.requestStateChange(newState: .Idle)
  }

  
  @IBAction func arm(_ sender: Any) {
    self.model?.requestStateChange(newState: .Armed)
  }
*/
  func updateSOC( percentage: Int? )
    {
      if let percentagex = percentage
      {
        self.socLabel.text = "Battery: \(percentagex)%"
      }
      else
      {
        self.socLabel.text = "Battery: Unknown"
      }
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
