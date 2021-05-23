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

  var chargerStateSubscription: AnyCancellable?

  override func viewDidLoad() {
    super.viewDidLoad()

    // guard let model = self.model else {return}

    // stateSubscription = model.$state.sink(receiveValue:self.transition)
  }

  override func viewDidAppear(_ animated: Bool) {
    chargerStateSubscription = model?.$chargerState.sink(receiveValue:self.updateChargerState)
  }
  @IBAction func disarm() {
    self.model?.requestStateChange(newState: .Idle)
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
