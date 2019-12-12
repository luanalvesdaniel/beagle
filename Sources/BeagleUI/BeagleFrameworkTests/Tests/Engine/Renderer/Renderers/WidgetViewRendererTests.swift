//
//  WidgetViewRendererTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 17/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

//import XCTest
@testable import BeagleUI
//
//final class WidgetViewRendererTests: XCTestCase {
//    
//    func test_callingBuildView_withoutOverrinding_shouldThrowFatalError() {
//        // Given
//        let text = Text("Some text.")
//        guard let sut = try? WidgetViewRenderer<Text>(text) else {
//            XCTFail("Could not create SUT.")
//            return
//        }
//        
//        // When / Then
//        expectFatalError(expectedMessage: "This needs to be overriden.") {
//            _ = sut.buildView(context: BeagleContextDummy())
//        }
//    }
//    
//}

struct RendererDependenciesContainer: RendererDependencies {
    var flex: FlexViewConfiguratorProtocol = FlexViewConfiguratorDummy()
    var rendererProvider: WidgetRendererProvider = WidgetRendererProviderDummy()
    var theme: Theme = AppThemeDummy()
    var validatorHandler: ValidatorHandler? = ValidatorHandling()
}
