//
//  APIManager.swift
//  movieSearch
//
//  Created by Satya on 30/07/16.
//  Copyright © 2016 My Company. All rights reserved.
//

import Foundation
import UIKit

typealias NetworkingOnFailure = (error: NSError?) -> Void
typealias NetworkingOnSuccess = (result: AnyObject?) -> Void

class APIManager: NSObject {
    
    //MARK: - Accessors
    
    /**
     Callback called when the operation fails.
     */
    var onFailure: NetworkingOnFailure?
    
    /**
     Callback called when the operation completes succesfully.
     */
    var onSuccess: NetworkingOnSuccess?
}
