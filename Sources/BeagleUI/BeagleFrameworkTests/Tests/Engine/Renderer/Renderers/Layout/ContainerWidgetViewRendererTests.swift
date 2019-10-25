//
//  ContainerWidgetViewRendererTests.swift
//  BeagleFrameworkTests
//
//  Created by Gabriela Coelho on 17/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class ContainerWidgetViewRendererTests: XCTestCase {
    
    func test_buildView_shouldReturnTheExpectedView() {
        // Given
        let flexConfiguratorSpy = FlexViewConfiguratorSpy()
        let container = Container(header: WidgetDummy(), content: WidgetDummy(), footer: WidgetDummy())
        guard let renderer = try? ContainerWidgetViewRenderer(
            widget: container,
            rendererProvider: WidgetRendererProviderDummy(),
            flexViewConfigurator: flexConfiguratorSpy) else {
                XCTFail("Could not create renderer.")
                return
        }
        
        // When
        let resultingView = renderer.buildView()
        
        // Then
        XCTAssertTrue(flexConfiguratorSpy.applyFlexCalled, "Expected to call `applyFlex`.")
        XCTAssertEqual(Flex.FlexDirection.column, flexConfiguratorSpy.flexPassed?.flexDirection, "Expected flex to have column as a flexDirection, but got \(String(describing: flexConfiguratorSpy.flexPassed?.flexDirection)).")
        XCTAssertEqual(Flex.JustifyContent.spaceBetween, flexConfiguratorSpy.flexPassed?.justifyContent, "Expected flex to have spaceBetween as a justifyContent, but got \(String(describing: flexConfiguratorSpy.flexPassed?.justifyContent)).")
        XCTAssertEqual(resultingView, flexConfiguratorSpy.viewPassedToApplyFlex, "Expected \(String(describing: resultingView)), but got \(String(describing: flexConfiguratorSpy.viewPassedToApplyFlex)).")
        XCTAssertTrue(resultingView.subviews.count == 3, "Expected view to have 3 subviews, a header, a content and a footer, but has \(resultingView.subviews)")
    }
}

// MARK: - Testing Helpers

private final class FlexViewConfiguratorSpy: FlexViewConfiguratorProtocol {
    
    private(set) var applyFlexCalled = false
    private(set) var flexPassed: Flex?
    private(set) var viewPassedToApplyFlex: UIView?
    func applyFlex(_ flex: Flex, to view: UIView) {
        applyFlexCalled = true
        flexPassed = flex
        viewPassedToApplyFlex = view
        
    }
    
    private(set) var applyYogaLayoutCalled = false
    private(set) var viewPassedToApplyYogaLayout: UIView?
    private(set) var preservingOriginPassed: Bool?
    func applyYogaLayout(to view: UIView, preservingOrigin: Bool) {
        applyYogaLayoutCalled = true
        viewPassedToApplyYogaLayout = view
        preservingOriginPassed = preservingOrigin
    }
    
    private(set) var enableYogaCalled = false
    private(set) var enablePassed: Bool?
    private(set) var viewPassedToEnableYoga: UIView?
    func enableYoga(_ enable: Bool, for view: UIView) {
        enableYogaCalled = true
        enablePassed = enable
        viewPassedToEnableYoga = view
    }
    
}
