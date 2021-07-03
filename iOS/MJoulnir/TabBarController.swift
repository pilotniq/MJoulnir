//
//  TabBarController.swift
//  MJoulnir
//
//  Created by Erland Lewin on 2021-05-13.
//  Copyright © 2021 Erland Lewin. All rights reserved.
//

import UIKit
import Combine

class TabBarController: UITabBarController, SetModel {

  var model: Model?
  var bluetoothStateWatcher: AnyCancellable?
  
  func setModel(model: Model) {
    self.model = model
    if let subPanel = self.viewControllers![0] as? SetModel {
      subPanel.setModel(model: self.model!)
    }
  }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // listen to Bluetooth connection state, transition back to splash screen if connection is lost

    }

  override func viewWillAppear(_ animated: Bool) {
    bluetoothStateWatcher = model!.$bluetoothState.sink { newState in
      print( "TabBarController: bluetooth sink: state is \(String(describing: newState))" )
      // self.bluetoothStateLabel.text = "Bluetooth: \(String(describing: newState))"
      if(newState == .scanning)
      {
        // self.performSegue(withIdentifier: "scanningSegue", sender: nil);
        // self.dismiss(animated:true)
      }
    }
  }

  override func viewWillDisappear(_ animated: Bool) {
    bluetoothStateWatcher?.cancel()
  }
/*
  override func viewDidAppear(_ animated: Bool) {
    <#code#>
  }
*/
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
      if let subPanel = segue.destination as? SetModel {
        subPanel.setModel(model: self.model!)
      }
    }

}
