//
//  TabBarController.swift
//  MJoulnir
//
//  Created by Erland Lewin on 2021-05-13.
//  Copyright © 2021 Erland Lewin. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, SetModel {

  var model: Model?

  func setModel(model: Model) {
    self.model = model
    if let subPanel = self.viewControllers![0] as? SetModel {
      subPanel.setModel(model: self.model!)
    }
  }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
