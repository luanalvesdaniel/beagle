//
//  LayoutWidgetRendererProvider.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 07/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

protocol LayoutWidgetRendererProvider {
    func buildRenderer(for widget: Widget) throws -> WidgetViewRenderer
}

//final class LayoutRendererProvider:  {
//
//    func buildRenderer(for widget: Widget) -> WidgetViewRenderer? {
//        switch widget {
//        case is FlexSingleWidget:
//            debugPrint("FlexSingleWidget")
//        case is FlexWidget:
//            debugPrint("FlexWidget")
//        case is Container:
//            debugPrint("Container")
//        case is Horizontal:
//            debugPrint("Horizontal")
//        case is Padding:
//            debugPrint("Padding")
//        case is Spacer:
//            debugPrint("Spacer")
//        case is Stack:
//            debugPrint("Stack")
//        case is Vertical:
//            debugPrint("Vertical")
//        default:
//            debugPrint("Unknown")
//        }
//    }
//}
