//
//  PageViewController.swift
//  solo
//
//  Created by Erland Lewin on 2021-04-10.
//  Copyright © 2021 Erland Lewin. All rights reserved.
//

import UIKit
import CoreBluetooth
import Combine

class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource  {

  private var model: Model!
  var stateWatcher: AnyCancellable?

  lazy var orderedViewControllers: [UIViewController] = {
      return [self.newVc(viewController: "idleVC"),
              self.newVc(viewController: "sbMainVC"),
              self.newVc(viewController: "sbBlueVC"),
              ]
  }()

  func setModel( model: Model )
  {
    self.model = model;
/*
    stateWatcher = model.$state.sink { state in
      switch(state)
      {
      case .Armed:
        self.
      }
    }
*/
  }

  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      self.dataSource = self

      // This sets up the first view that will show up on our page control
      if let firstViewController = orderedViewControllers.first {
          setViewControllers([firstViewController],
                             direction: .forward,
                             animated: true,
                             completion: nil)
      }
    }

  override func viewDidAppear(_ animated: Bool) {
    let scene = self.view.window!.windowScene!.delegate as! SceneDelegate

    scene.model = model
   }

  func newVc(viewController: String) -> UIViewController {
    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController)
    if( vc is MainStatusViewController )
    {
      (vc as! MainStatusViewController).setModel( model: self.model )
    }

    if( vc is TemperaturesViewController )
    {
      (vc as! TemperaturesViewController).setModel( model: self.model )
    }

    if( vc is IdleViewController)
    {
      (vc as! IdleViewController).setModel( model: self.model )
    }

    return vc
   }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
  // MARK: Data source functions.
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
          return nil
      }

      let previousIndex = viewControllerIndex - 1

      // User is on the first view controller and swiped left to loop to
      // the last view controller.
      guard previousIndex >= 0 else {
          return orderedViewControllers.last
          // Uncommment the line below, remove the line above if you don't want the page control to loop.
          // return nil
      }

      guard orderedViewControllers.count > previousIndex else {
          return nil
      }

      return orderedViewControllers[previousIndex]
  }

  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
          return nil
      }

      let nextIndex = viewControllerIndex + 1
      let orderedViewControllersCount = orderedViewControllers.count

      // User is on the last view controller and swiped right to loop to
      // the first view controller.
      guard orderedViewControllersCount != nextIndex else {
          return orderedViewControllers.first
          // Uncommment the line below, remove the line above if you don't want the page control to loop.
          // return nil
      }

      guard orderedViewControllersCount > nextIndex else {
          return nil
      }

      return orderedViewControllers[nextIndex]
  }
}
