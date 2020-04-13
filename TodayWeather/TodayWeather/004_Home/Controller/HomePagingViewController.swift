//
//  HomePagingViewController.swift
//  TodayWeather
//
//  Created by Tuan Vu on 4/12/20.
//  Copyright © 2020 Đào Thanh Hải. All rights reserved.
//

import UIKit
import PagingMenuController

struct PagingMenuOptions: PagingMenuControllerCustomizable {
    var viewcontrollers = [UIViewController]()

    internal var componentType: ComponentType {
        return .pagingController(pagingControllers: pagingControllers)
    }

    fileprivate var pagingControllers: [UIViewController] {
        return viewcontrollers
    }
}
