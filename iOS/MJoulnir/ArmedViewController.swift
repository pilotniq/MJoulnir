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

  override func viewDidLoad() {
    super.viewDidLoad()

    // guard let model = self.model else {return}

    // stateSubscription = model.$state.sink(receiveValue:self.transition)
  }

  @IBAction func disarm() {
    self.model?.requestStateChange(newState: .Idle)
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
