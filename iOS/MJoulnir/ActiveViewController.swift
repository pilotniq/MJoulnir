//
//  ActiveViewController.swift
//  MJoulnir
//
//  Created by Erland Lewin on 2021-05-14.
//  Copyright © 2021 Erland Lewin. All rights reserved.
//

import UIKit
import Combine

extension TimeInterval {
    func format( /* using units: NSCalendar.Unit */) -> String? {
      let units: NSCalendar.Unit = [.hour, .minute, .second]
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = units
        formatter.unitsStyle = .abbreviated
        formatter.zeroFormattingBehavior = .pad

        return formatter.string(from: self)
    }
}
class ActiveViewController: UIViewController, SetModel {

  var model: Model?

  @IBOutlet weak var powerLabel: UILabel!
  @IBOutlet weak var energyLabel: UILabel!
  @IBOutlet weak var throttleLabel: UILabel!
  @IBOutlet weak var motorRPMlabel: UILabel!
  @IBOutlet weak var vescTemp: UILabel!
  @IBOutlet weak var motorTemp: UILabel!
  @IBOutlet weak var batteryTemp: UILabel!

  @IBOutlet weak var measureTimeLabel: UILabel!
  @IBOutlet weak var measureEnergyLabel: UILabel!
  @IBOutlet weak var measureAvgPowerLabel: UILabel!

  var powerWatcher: AnyCancellable?
  var temperatureWatcher: AnyCancellable?

  var measurementInitialEnergy: Int?
  var measurementInitialTime: Date?
  var measurementUpdateTimer: Timer?

  override func viewDidLoad() {
      super.viewDidLoad()

      // Do any additional setup after loading the view.
  }
    
  override func viewWillAppear(_ animated: Bool) {
    guard let model = self.model else {return}

    powerWatcher = model.$power.sink { newPower in
        if( newPower != nil )
        {
          let nf = NumberFormatter()
          nf.maximumFractionDigits = 0
          nf.numberStyle = .decimal

          print( "power sink: power is \(String(describing: newPower))" )
          self.powerLabel.text = "\(nf.string( from: NSNumber(value: -newPower!.power))!) W"
          self.energyLabel.text = "\(nf.string( from: NSNumber(value: -newPower!.energy_Wh))!) Wh"
          self.throttleLabel.text = "Throttle: \(nf.string( from: NSNumber(value: newPower!.duty_cycle))!) %"
          self.motorRPMlabel.text = "Motor: \(nf.string( from: NSNumber(value: -newPower!.motor_rpm))!) RPM"

          // Update measurement
          if self.measurementInitialTime == nil
          {
            // power data was not available when measurement was started, try to start it now instead
            self.measurement_reset()
          }

          self.updateMeasurementLabels()
        }
      }

    temperatureWatcher = model.$temperatures.sink { newTemperatures in
      // print( "state sink: state is \(String(describing: newState))" )
      if( newTemperatures != nil && newTemperatures!.vesc_mos != nil) {
        self.vescTemp.text = "VESC: \(newTemperatures!.vesc_mos!)°C, \(newTemperatures!.vesc_mos_1!)°C, \(newTemperatures!.vesc_mos_2!)°C, \(newTemperatures!.vesc_mos_3!)°C"
        self.motorTemp.text = "Motor: \(newTemperatures!.motor!)°C"

        self.batteryTemp.text = "Batteries: \(newTemperatures!.battery[0][0]!)°C, \(newTemperatures!.battery[0][1]!)°C, \(newTemperatures!.battery[1][0]!)°C, \(newTemperatures!.battery[1][1]!)°C, \(newTemperatures!.battery[2][0]!)°C, \(newTemperatures!.battery[2][1]!)°C"
 
      } }

      measurement_reset()
/*
    self.measurementUpdateTimer = Timer.scheduledTimer(timeInterval:2, target: self, selector: #selector(updateMeasurementDisplay), repeats: true)
*/

  }

  override func viewWillDisappear(_ animated: Bool) {
    self.measurementUpdateTimer?.invalidate()
    self.powerWatcher?.cancel()
    self.temperatureWatcher?.cancel()
  }

  func measurement_reset()
  {
    if let energy = self.model?.power?.energy_Wh
    {
      // initialize measurement
      self.measurementInitialTime = Date()
      self.measurementInitialEnergy = energy

      updateMeasurementLabels()
    }
    else
    {
      self.measurementInitialTime = nil
    }
    updateMeasurementLabels()
  }

  func updateMeasurementLabels()
  {
    if let initialTime = self.measurementInitialTime
    {
      let now = Date()
      let dt = now.timeIntervalSince(initialTime)
      let newPower = self.model!.power!
      let dEnergy = newPower.energy_Wh - self.measurementInitialEnergy!
      let avgPower = Double(dEnergy) / (dt / 3600.0)

      let nf = NumberFormatter()
      nf.maximumFractionDigits = 0
      nf.numberStyle = .decimal

      self.measureTimeLabel.text = "Time: " + dt.format()!
      self.measureEnergyLabel.text = "Energy: " + nf.string(from:NSNumber(value: dEnergy))! + " Wh"
      self.measureAvgPowerLabel.text = "Power: " + nf.string(from:NSNumber(value: avgPower))! + " W"
    }
    else
    {
      self.measureTimeLabel.text = "Time: Unavailable"
      self.measureEnergyLabel.text = "Energy: Unavailable"
      self.measureAvgPowerLabel.text = "Power: Unavailable"
    }

  }
/*
  @objc func updateMeasurementDisplay()
  {
    if self.measurementInitialTime == nil
    {
      // power data was not available when measurement was started, try to start it now instead
      self.measurement_reset()
    }

    if let initialTime = self.measurementInitialTime
    {
      let now = Date()
      let dt = now.timeIntervalSince(date: intialTime)
      let energy = self.model!.power.

    }
  }
 */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
  @IBAction func resetMeasurement(_ sender: Any) {
    measurement_reset()
  }

  func setModel( model: Model )
  {
    self.model = model
  }
}
