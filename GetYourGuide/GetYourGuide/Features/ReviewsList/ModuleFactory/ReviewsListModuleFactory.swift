//
//  ReviewsListModuleFactory.swift
//  GetYourGuide
//
//  Created by Nickolay Sheika on 10/08/2019.
//  Copyright © 2019 Nickolay Sheika. All rights reserved.
//

struct ReviewsListModuleFactory: ModuleFactory {

    func createModule() -> Module<ReviewsListModuleInput> {
        let view = make(ReviewsListViewController.self)
        let moduleInput = view.output as! ReviewsListModuleInput
        return Module(moduleInput: moduleInput, view: view)
    }
    
}