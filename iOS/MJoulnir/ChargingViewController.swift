//
//  ChargingViewController.swift
//  MJoulnir
//
//  Created by Erland Lewin on 2021-05-22.
//  Copyright © 2021 Erland Lewin. All rights reserved.
//

import UIKit
import Combine

class ChargingViewController: UIViewController, SetModel {

  @IBOutlet weak var targetLevelLabel: UILabel!
  @IBOutlet weak var targetLevelSlider: UISlider!
  @IBOutlet weak var changedTargetLevelLabel: UILabel!
  @IBOutlet weak var maxWallCurrentLabel: UILabel!
  @IBOutlet weak var maxWallCurrentSlider: UISlider!
  
  @IBOutlet weak var changedWallCurrentLabel: UILabel!
  
  @IBOutlet weak var socLabel: UILabel!
  @IBOutlet weak var voltageLabel: UILabel!

  @IBOutlet weak var currentLabel: UILabel!
  @IBOutlet weak var powerLabel: UILabel!
  @IBOutlet weak var chargeLabel: UILabel!
  @IBOutlet weak var batteryTemperatureLabel: UILabel!

  var model: Model?

  var chargerStateSubscription: AnyCancellable?
  var batterySubscription: AnyCancellable?
  var temperaturesSubscription: AnyCancellable?

  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
  override func viewWillAppear(_ animated: Bool) {
    chargerStateSubscription = model?.$chargerState.sink(receiveValue:self.updateChargerState)


    batterySubscription = model?.$batteryLevel.sink { newLevel in self.updateBattery( batteryLevelOpt: newLevel ) }

    /* self.batterySubscription = model?.$batteryLevel.sink(receiveValue:self.updateBattery) */
    temperaturesSubscription = model?.$temperatures.sink { newTemperatures in self.updateTemperatures(temperaturesOpt: newTemperatures) }

    updateTemperatures(temperaturesOpt: model?.temperatures)
    updateBattery(batteryLevelOpt: model?.batteryLevel)
    updateChargerState(chargerStateOpt: model?.chargerState)
 //    targetLevelSlider.setValue(model!.chargerState., animated: <#T##Bool#>)
  }

  override func viewWillDisappear(_ animated: Bool) {
    chargerStateSubscription?.cancel()
  }

  func updateTemperatures( temperaturesOpt: Temperatures? )
  {
    if let temperatures = temperaturesOpt
    {
      self.batteryTemperatureLabel.text = "\(temperatures.getMaxBatteryTemperature()) °C"
    }
  }

  func updateBattery(batteryLevelOpt: UInt?)
  {
    if let soc = batteryLevelOpt
    {
      self.socLabel.text = String(soc) + " %"
    }
  }

  func setModel(model: Model)
  {
    self.model = model
  }

  func updateChargerState(chargerStateOpt: ChargerState?)
  {
    if let chargerState = chargerStateOpt
    {
      let nf = NumberFormatter()
      nf.maximumFractionDigits = 1
      nf.numberStyle = .decimal
      self.voltageLabel.text = "\(nf.string( from: NSNumber(value: chargerState.outputVoltage))!) V"
      self.currentLabel.text = "\(nf.string( from: NSNumber(value: chargerState.outputCurrent))!) A"


      let power = chargerState.outputVoltage * chargerState.outputCurrent

      nf.maximumFractionDigits = 0
      self.powerLabel.text = "\(nf.string(from: NSNumber(value: power))!) W"
      self.chargeLabel.text = "\(nf.string(from: NSNumber(value: chargerState.ackChargeWh))!) Wh"
      /*
      self.currentLabel.text = "\(nf.string( from: NSNumber(value: chargerState.ackChargeWh))!) Wh"
 */
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
  @IBAction func setTargetLevel(_ sender: Any) {
  }
  @IBAction func targetLevelSliderChanged() {
  }
  @IBAction func maxWallCurrentSliderChangd() {
  }
  @IBAction func setMaxWallCurrent() {
  }
  @IBAction func stopCharging() {
    self.model?.requestStateChange(newState: .Armed)
  }

}
