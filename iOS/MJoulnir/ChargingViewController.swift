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
  var chargerMaxWallCurrentSubscription: AnyCancellable?
  var chargerTargetSOCSubscription: AnyCancellable?

  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
  override func viewWillAppear(_ animated: Bool) {
    chargerStateSubscription = model?.$chargerState.sink(receiveValue:self.updateChargerState)
    batterySubscription = model?.$batteryLevel.sink { newLevel in self.updateBattery( batteryLevelOpt: newLevel ) }

    /* self.batterySubscription = model?.$batteryLevel.sink(receiveValue:self.updateBattery) */
    temperaturesSubscription = model?.$temperatures.sink { newTemperatures in self.updateTemperatures(temperaturesOpt: newTemperatures) }

    chargerMaxWallCurrentSubscription = model?.$chargerMaxWallCurrent.sink { newMaxWallCurrent in self.updateMaxWallCurrent(maxWallCurrentOpt: newMaxWallCurrent) }
    chargerTargetSOCSubscription = model?.$chargerTargetSOC.sink { newTargetSOC in self.updateTargetSOC(targetSOCOpt: newTargetSOC) }

    updateTemperatures(temperaturesOpt: model?.temperatures)
    updateBattery(batteryLevelOpt: model?.batteryLevel)
    updateChargerState(chargerStateOpt: model?.chargerState)
    updateMaxWallCurrent(maxWallCurrentOpt: model?.chargerMaxWallCurrent)
    updateTargetSOC(targetSOCOpt: model?.chargerTargetSOC)
 //    targetLevelSlider.setValue(model!.chargerState., animated: <#T##Bool#>)
  }

  override func viewWillDisappear(_ animated: Bool) {
    chargerStateSubscription?.cancel()
    temperaturesSubscription?.cancel()
    chargerMaxWallCurrentSubscription?.cancel()
    chargerTargetSOCSubscription?.cancel()
    batterySubscription?.cancel()
  }

  @IBAction func setTargetSOC() {
    model?.requestSetTargetSOC(newTargetSOC: UInt(self.targetLevelSlider.value.rounded()))
  }

  @IBAction func setMaxWallCurrent() {
    model?.requestSetMaxWallCurrent(newMaxWallCurrent: Double(self.maxWallCurrentSlider.value))
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
      nf.minimumFractionDigits = 1
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

      self.targetLevelSlider.setValue(Float(targetSOC), animated: false)
      // var targetSoc = (chargerSettings.target_soc * 100)
      // targetSoc.round()
      self.targetLevelLabel.text = "\(nf.string(from: NSNumber(value: targetSOC))!)%"
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
  @IBAction func setTargetLevel(_ sender: UISlider) {
    let nf = NumberFormatter()
    nf.maximumFractionDigits = 0
    nf.numberStyle = .decimal

    // snap in increments of 0.1 Amps
    let soc = round(sender.value)
    sender.value = soc;

    // nf.string( from: NSNumber(value: -newPower!.power))
    changedTargetLevelLabel.text = "\(nf.string( from: NSNumber(value: soc))!)%"
    // print("UISlider: \(sender.value)")
  }
  @IBAction func maxWallCurrentSliderChanged2(_ sender: UISlider, forEvent event: UIEvent)
  {
    /*
    guard let current = sender.value else {
      print( "maxWallCurrentSliderChanged2: slider value was not set!?")
      return
    }
 */
    let nf = NumberFormatter()
    nf.maximumFractionDigits = 0
    nf.numberStyle = .decimal

    // snap in increments of 0.1 Amps
    let current = round(sender.value)
    sender.value = current;

    // nf.string( from: NSNumber(value: -newPower!.power))
    changedWallCurrentLabel.text = "\(nf.string( from: NSNumber(value: current))!) A (\(nf.string(from: NSNumber(value: current * 230))!)) W"
    // print("UISlider: \(sender.value)")
  }
  @IBAction func targetLevelSliderChanged() {

  }
  @IBAction func maxWallCurrentSliderChangd() {
  }
  @IBAction func stopCharging() {
    self.model?.requestStateChange(newState: .Armed)
  }

}
