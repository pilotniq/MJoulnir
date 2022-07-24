//
//  ArmedViewController.swift
//  MJoulnir
//
//  Created by Erland Lewin on 2021-05-10.
//  Copyright © 2021 Erland Lewin. All rights reserved.
//

import UIKit
import Combine

class ArmedViewController: UIViewController, SetModel {
  var model: Model?

  @IBOutlet weak var chargerStateLabel: UILabel!
  @IBOutlet weak var chargingTargetSOCSlider: UISlider!
  @IBOutlet weak var maxWallCurrentSlider: UISlider!
  @IBOutlet weak var chargingTargetSOCLabel: UILabel!
  @IBOutlet weak var maxWallCurrentLabel: UILabel!
  @IBOutlet weak var targetLevelLabel: UILabel!
  @IBOutlet weak var changedWallCurrentLabel: UILabel!
  @IBOutlet weak var changedTargetLevelLabel: UILabel!

  @IBOutlet weak var throttleButton: UIButton!

  @IBOutlet weak var throttleMenu: UIMenu!

  var chargerStateSubscription: AnyCancellable?
  var chargerMaxWallCurrentSubscription: AnyCancellable?
  var chargerTargetSOCSubscription: AnyCancellable?

  override func viewDidLoad() {
    super.viewDidLoad()

    // guard let model = self.model else {return}

    // stateSubscription = model.$state.sink(receiveValue:self.transition)
  }

  override func viewWillAppear(_ animated: Bool) {
    chargerStateSubscription = model?.$chargerState.sink(receiveValue:self.updateChargerState)

    chargerMaxWallCurrentSubscription = model?.$chargerMaxWallCurrent.sink { newMaxWallCurrent in self.updateMaxWallCurrent(maxWallCurrentOpt: newMaxWallCurrent) }
    chargerTargetSOCSubscription = model?.$chargerTargetSOC.sink { newTargetSOC in self.updateTargetSOC(targetSOCOpt: newTargetSOC) }

    updateMaxWallCurrent(maxWallCurrentOpt: model?.chargerMaxWallCurrent)
    updateTargetSOC(targetSOCOpt: model?.chargerTargetSOC)

    if #available(iOS 15.0, *) {
      throttleButton.changesSelectionAsPrimaryAction = true
      throttleButton.showsMenuAsPrimaryAction = true
/*
      throttleMenu.changesSelectionAsPrimaryAction = true
      throttleMenu.showsMenuAsPrimaryAction = true
 */
    } else {
      // Fallback on earlier versions
    }
  }

  override func viewWillDisappear(_ animated: Bool) {
    chargerStateSubscription?.cancel();
    chargerMaxWallCurrentSubscription?.cancel();
    chargerTargetSOCSubscription?.cancel();
  }
/*
  override func viewDidAppear(_ animated: Bool) {
  }
*/
  @IBAction func disarm() {
    self.model?.requestStateChange(newState: .Idle)
  }

  @IBAction func charge() {
    self.model?.requestStateChange(newState: .Charging)
  }
  
  @IBAction func setChargingTargetSOC() {
    model?.requestSetTargetSOC(newTargetSOC: UInt(self.chargingTargetSOCSlider.value.rounded()))
  }

  @IBAction func setMaxWallCurrent() {
    model?.requestSetMaxWallCurrent(newMaxWallCurrent: Double(self.maxWallCurrentSlider.value))
  }
  
  @IBAction func targetLevelSliderChanged() {
    let nf = NumberFormatter()
    nf.maximumFractionDigits = 0
    nf.numberStyle = .decimal
    let target = chargingTargetSOCSlider.value.rounded();

    changedTargetLevelLabel.text = "\(nf.string(from: NSNumber(value: target))!)%"
  }

  func updateMaxWallCurrent( maxWallCurrentOpt: Double?)
  {
    if let maxWallCurrent = maxWallCurrentOpt
    {
      let nf = NumberFormatter()
      nf.maximumFractionDigits = 0
      nf.numberStyle = .decimal

      self.maxWallCurrentSlider.setValue(Float(maxWallCurrent), animated: false)
      self.maxWallCurrentLabel.text = "\(nf.string(from: NSNumber(value:maxWallCurrent))!) A (\(nf.string(from: NSNumber(value: maxWallCurrent * 230))!) W)"
    }
  }

  func updateTargetSOC( targetSOCOpt: UInt?)
  {
    if let targetSOC = targetSOCOpt
    {
      let nf = NumberFormatter()
      nf.maximumFractionDigits = 0
      nf.numberStyle = .decimal

      self.chargingTargetSOCSlider.setValue(Float(targetSOC), animated: false)
      // var targetSoc = (chargerSettings.target_soc * 100)
      // targetSoc.round()
      self.targetLevelLabel.text = "\(nf.string(from: NSNumber(value: targetSOC))!)%"
      self.changedTargetLevelLabel.text = "\(nf.string(from: NSNumber(value: targetSOC))!)%"
    }
  }

  func updateChargerState( chargerStateOpt: ChargerState?)
  {
    var description: String;

    print("ChargerState: updateChargerState: chargerStateOpt=" + String( describing: chargerStateOpt))
    if let chargerState = chargerStateOpt
    {
      if( chargerState.errorBits == 0 )
      {
        if( chargerState.detected )
        {
          if( chargerState.powered )
          {
            description = "Powered"
          }
          else
          {
            description = "Detected but not powered"
          }
        }
        else
        {
          description = "Not Detected"
        }
      }
      else
      {
        if( (chargerState.errorBits & 1) != 0)
        {
          description = "Communication Error"
        }
        else
        {
          description = ""
        }

        if( (chargerState.errorBits & 2) != 0)
        {
          if( description.count != 0 ) { description += ", " }
          description += "Over Temperature"
        }

        if( (chargerState.errorBits & 4) != 0)
        {
          if( description.count != 0 ) { description += ", " }
          description += "Battery Error"
        }

        if( (chargerState.errorBits & 8) != 0)
        {
          if( description.count != 0 ) { description += ", " }
          description += "Hardware Error"
        }
     }
    }
    else
    {
      description = "Not available"
    }

    chargerStateLabel.text = description
}
/*
  func transition( state: Model.State? )
  {
    print( "ArmedViewController: transition to \(String(describing: state)): entry")
    guard let st = state else { return }

    let segueName = segues[st]

    guard let sn = segueName else {
      print( "ArmedViewController: No segue to \(st)" );
      return
    }

    self.stateSubscription?.cancel()
    self.stateSubscription = nil
    // self.bluetoothStateSubscription?.cancel()
    // self.bluetoothStateSubscription = nil

    self.performSegue(withIdentifier: sn, sender: nil);
  }
*/
  func setModel( model: Model )
  {
    self.model = model
  }
}
