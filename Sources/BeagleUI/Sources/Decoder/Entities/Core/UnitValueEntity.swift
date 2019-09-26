//
//  UnitValueEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

/// Defines an API representation for `UnitValue`
struct UnitValueEntity: WidgetEntity {
    
    let value: Double
    let type: UnitTypeEntity
    
    static let `default` = UnitValueEntity(value: 0.0, type: .real)
    
}
extension UnitValueEntity: UIModelConvertible {
    
    // MARK: - Public Functions
    
    /// Converts the Entity to an UIModel
    ///
    /// - Returns: the respective UIModel
    func mapToUIModel() throws -> UnitValue {
        let type = mapType()
        return UnitValue(value: value, type: type)
    }
    
    // MARK: - Private Functions
    
    private func mapType() -> UnitType {
        switch type {
        case .real:
            return .real
        case .percent:
            return .percent
        }
    }
    
}

/// Defines an API representation for `UnitType`
enum UnitTypeEntity: String, WidgetEntity {
    case real
    case percent
}
