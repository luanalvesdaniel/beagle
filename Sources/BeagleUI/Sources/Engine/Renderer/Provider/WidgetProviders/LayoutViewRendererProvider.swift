//
//  LayoutViewRendererProvider.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 16/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

final class LayoutViewRendererProviding: WidgetRendererProviderThrowable {
    
    func buildRenderer(for widget: Widget, dependencies: RendererDependencies) throws -> WidgetViewRendererProtocol {
        switch widget {
        case is FlexSingleWidget:
            return try FlexSingleWidgetViewRenderer(widget: widget, dependencies: dependencies)
        case is FlexWidget:
            return try FlexWidgetViewRenderer(widget: widget, dependencies: dependencies)
        case is Container:
            return try ContainerWidgetViewRenderer(widget: widget, dependencies: dependencies)
        case is Spacer:
            return try SpacerWidgetViewRenderer(widget: widget, dependencies: dependencies)
        case is ScrollView:
            return try ScrollViewWidgetViewRenderer(widget: widget, dependencies: dependencies)
        case is ListView:
            return try ListViewWidgetRenderer(widget: widget, dependencies: dependencies)
        case is Navigator:
            return try NavigatorWidgetViewRenderer(widget: widget, dependencies: dependencies)
        case is Form:
            return try FormWidgetViewRenderer(widget: widget, dependencies: dependencies)
        case is FormInput:
            return try FormInputWidgetViewRenderer(widget: widget, dependencies: dependencies)
        case is FormSubmit:
            return try FormSubmitWidgetViewRenderer(widget: widget, dependencies: dependencies)
        case is PageView:
            return try PageViewRender(widget: widget, dependencies: dependencies)
        case is LazyWidget:
            return try LazyWidgetViewRenderer(widget: widget, dependencies: dependencies)
        default:
            throw WidgetRendererProviding.Error.couldNotFindRendererForWidget(widget)
        }
    }
    
}
