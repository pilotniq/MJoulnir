//
//  TemperaturesViewController.swift
//  solo
//
//  Created by Erland Lewin on 2021-04-19.
//  Copyright © 2021 Erland Lewin. All rights reserved.
//

import UIKit
import Combine

class TemperaturesViewController: UIViewController {

  var temperatureWatcher: AnyCancellable?

  @IBOutlet weak var vescTemperatures: UILabel!
  @IBOutlet weak var MotorTemperature: UILabel!
  @IBOutlet weak var BatteryTemperatures: UILabel!

  var model: Model?

  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    temperatureWatcher = model!.$temperatures.sink { newTemperatures in
      // print( "state sink: state is \(String(describing: newState))" )
      if( newTemperatures != nil && newTemperatures!.vesc_mos != nil) {
        self.vescTemperatures.text = "VESC: \(newTemperatures!.vesc_mos!)°C, \(newTemperatures!.vesc_mos_1!)°C, \(newTemperatures!.vesc_mos_2!)°C, \(newTemperatures!.vesc_mos_3!)°C"
        self.MotorTemperature.text = "Motor: \(newTemperatures!.motor!)°C"
        self.BatteryTemperatures.text = "Batteries: \(newTemperatures!.battery[0][0]!)°C, \(newTemperatures!.battery[0][1]!)°C, \(newTemperatures!.battery[1][0]!)°C, \(newTemperatures!.battery[1][1]!)°C, \(newTemperatures!.battery[2][0]!)°C, \(newTemperatures!.battery[2][1]!)°C"
      } }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

  func setModel( model: Model )
  {
    self.model = model
  }
}
