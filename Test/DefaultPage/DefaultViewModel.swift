//
//  DefaultViewModel.swift
//  Test
//
//  Created by Kamila Kussainova on 10/14/20.
//  Copyright © 2020 Kamila Kusainova. All rights reserved.
//
typealias VoidCallback = () -> Void


import Foundation

class DefaultViewModel {
    
    let title = "Hello"
    var didSuccessSend: VoidCallback?
    
    private let isEdit = false
    private var duration: Int?
    
    func setDurations(with duration: Int) {
        self.duration = duration
    }
}

private extension DefaultViewModel {
    func textConverter() { }
}


private extension DefaultViewModel {
    // MARK: API requests
    func getAllCities() {
        // ...
    }
}
