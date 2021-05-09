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

class ScanningViewController: UIViewController {

  let model = Model();
  var bluetoothStateSubscription: AnyCancellable?

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    bluetoothStateSubscription = model.$bluetoothState.sink {bs in
      if( bs == .following )
      {
        self.performSegue(withIdentifier: "foundSegue", sender: nil);
        self.bluetoothStateSubscription?.cancel()
        self.bluetoothStateSubscription = nil
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
    let pvc = segue.destination as? PageViewController;

    pvc!.setModel(model: self.model)
  }

  @IBAction func pretendFound() {
    self.performSegue(withIdentifier: "foundSegue", sender: nil);
    self.bluetoothStateSubscription?.cancel()
    self.bluetoothStateSubscription = nil
  }
  // when the model's BluetoothState changes to following

}

