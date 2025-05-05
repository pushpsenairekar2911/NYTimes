//
//  CoordinatorInterface.swift
//  NYTimes
//
//  Created by Pushpsen Airekar on 03/05/25.
//

import Foundation
import UIKit

@MainActor
public protocol CoordinatorInterface: AnyObject {
    /// Unique identifier of the coordinator
    var identifier: UUID { get }
    
    /// Dictionary of child coordinators by their ideitifiers to make adding and removing child coordinators efficient as against array
    var childCoordinators: [UUID: CoordinatorInterface] { get }
    
    /// Closure called by the child coordinator to inform parent coordinator when it is finished
    var didFinish: ((CoordinatorInterface) -> Void)? { get set }
    
    /// Entry point of  the coordinator, returns the view controller managed by this coordinator
    func start() -> UIViewController
    
    /// Call this function when parent coordinator intends to complete lifecycle of any of its child coordinator, typically when it needs to replace current coordinator with another child coordinator
    func finish()
}
