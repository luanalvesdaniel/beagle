//
//  UIComponentViewRendererProvidingTests.swift
//  BeagleFrameworkTests
//
//  Created by Gabriela Coelho on 25/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class UIComponentViewRendererProvidingTests: XCTestCase {
    
    func test_whenButton_shouldReturnButtonWigetViewRenderer() {
        // Given
        let widget = Button(text: "Aoba")
        let renderer = WidgetRendererProviding()
        // When
        let buttonWidgetViewRenderer = renderer.buildRenderer(for: widget)
        // Then
        XCTAssert(buttonWidgetViewRenderer is ButtonWidgetViewRenderer, "Expected to build a button widget view renderer, but has built \(String(describing: type(of: buttonWidgetViewRenderer))).")
    }

    func test_whenText_shouldReturnTextWigetViewRenderer() {
        // Given
        let widget = Text("aoba")
        let renderer = WidgetRendererProviding()
        // When
        let textWidgetViewRenderer = renderer.buildRenderer(for: widget)
        // Then
        XCTAssert(textWidgetViewRenderer is TextWidgetViewRenderer, "Expected to build a text widget view renderer, but has built \(String(describing: type(of: textWidgetViewRenderer))).")
    }

}
