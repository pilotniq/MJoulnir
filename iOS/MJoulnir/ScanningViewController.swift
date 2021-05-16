//
//  ViewController.swift
//  solo
//
//  Created by Erland Lewin on 2021-04-01.
//  Copyright © 2021 Erland Lewin. All rights reserved.
//

import UIKit
import Combine
import CoreBluetooth

protocol SetModel {
  func setModel(model: Model) -> Void
}

class ScanningViewController: UIViewController {

  let model = Model();
  let segues = [ Model.State.Idle: "idleSegue",
                 Model.State.Armed: "armedSegue" ]
  var bluetoothStateSubscription: AnyCancellable?
  var stateSubscription: AnyCancellable?

  override func viewDidLoad() {
    super.viewDidLoad()

    stateSubscription = model.$state.sink(receiveValue:self.transition)
    // Do any additional setup after loading the view.
    bluetoothStateSubscription = model.$bluetoothState.sink {bs in
      if( bs == .following )
      {
        guard let state = self.model.state else { return }

        self.transition(state: state)
        // self.performSegue(withIdentifier: "foundSegue", sender: nil);
      }
    }
    model.start()
    // let scene = self.view.window!.windowScene!.delegate as! SceneDelegate
    // scene.model = model
  }

  override func viewDidAppear(_ animated: Bool) {
    let scene = self.view.window!.windowScene!.delegate as! SceneDelegate
    scene.model = model
   }
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // there is only one segue, to the PageViewController
    let pvc = segue.destination as? SetModel;

    pvc!.setModel(model: self.model)
  }

  func transition(state: Model.State?)
  {
    self.performSegue(withIdentifier: "foundSegue", sender: nil);
    self.bluetoothStateSubscription?.cancel()
    self.bluetoothStateSubscription = nil
    self.stateSubscription?.cancel()
    self.stateSubscription = nil

   /*
    guard let st = state else { return }

    let segueName = segues[st]

    guard let sn = segueName else {
      print( "ScanningViewController: No segue to \(st)" );
      return
    }

    self.stateSubscription?.cancel()
    self.stateSubscription = nil
    self.bluetoothStateSubscription?.cancel()
    self.bluetoothStateSubscription = nil

    self.performSegue(withIdentifier: sn, sender: nil);
 */
  }

  @IBAction func pretendFound() {
    self.performSegue(withIdentifier: "foundSegue", sender: nil);
    self.bluetoothStateSubscription?.cancel()
    self.bluetoothStateSubscription = nil
  }
  // when the model's BluetoothState changes to following

}

