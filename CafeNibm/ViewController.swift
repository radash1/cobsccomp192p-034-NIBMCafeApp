//
//  ViewController.swift
//  CafeNibm
//
//  Created by Ravindu Liyanage on 3/6/21.
//  Copyright © 2021 Ravindu Liyanage. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
       private var locationManager:CLLocationManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager?.requestAlwaysAuthorization()
        
        // Do any additional setup after loading the view.
    }


}

