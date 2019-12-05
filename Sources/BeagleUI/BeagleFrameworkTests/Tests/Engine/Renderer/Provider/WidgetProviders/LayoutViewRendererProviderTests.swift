//
//  LayoutViewRendererProviderTests.swift
//  BeagleFrameworkTests
//
//  Created by Gabriela Coelho on 25/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class LayoutViewRendererProviderTests: XCTestCase {
    
    func test_whenFlexWidget_shouldReturnFlexWidgetViewRenderer() {
        // Given
        let widget = FlexWidget(children: [Text("Oloquinho")],
                                flex: Flex(direction: .ltr, flexDirection: .column))
        let renderer = WidgetRendererProviding()
        // When
        let flexWidgetViewRenderer = renderer.buildRenderer(for: widget)
        // Then
        XCTAssert(flexWidgetViewRenderer is FlexWidgetViewRenderer, "Expected to build a flex widget view renderer, but has built \(String(describing: type(of: flexWidgetViewRenderer))).")
    }
    
    func test_whenFlexSingleWidget_shouldReturnFlexSingleWidgetViewRenderer() {
        // Given
        let widget = FlexSingleWidget(
            child: Text("Meu"),
            flex: Flex(direction: .ltr, flexDirection: .column)
        )
        let renderer = WidgetRendererProviding()
        // When
        let flexSingleWidgetViewRenderer = renderer.buildRenderer(for: widget)
        // Then
        XCTAssert(flexSingleWidgetViewRenderer is FlexSingleWidgetViewRenderer, "Expected to build a flex single widget view renderer, but has built \(String(describing: type(of: flexSingleWidgetViewRenderer))).")
    }
    
    func test_whenContainer_shouldReturnContainerWidgetViewRenderer() {
        // Given
        let widget = Container(header: Text("Tá pegando"), content: Text("Fogo"), footer: Text("Bixo"))
        let renderer = WidgetRendererProviding()
        // When
        let containerWidgetViewRenderer = renderer.buildRenderer(for: widget)
        // Then
        XCTAssert(containerWidgetViewRenderer is ContainerWidgetViewRenderer, "Expected to build a container widget view renderer, but has built \(String(describing: type(of: containerWidgetViewRenderer))).")
    }
    
    func test_whenSpacer_shouldReturnSpacerWidgetViewRenderer() {
        // Given
        let widget = Spacer(100)
        let renderer = WidgetRendererProviding()
        // When
        let spacerWidgetViewRenderer = renderer.buildRenderer(for: widget)
        // Then
        XCTAssert(spacerWidgetViewRenderer is SpacerWidgetViewRenderer, "Expected to build a spacer widget view renderer, but has built \(String(describing: type(of: spacerWidgetViewRenderer))).")
    }
    
    func test_whenListView_shouldReturnListViewWidgetViewRenderer() {
        // Given
        let widget = ListView()
        let renderer = WidgetRendererProviding()
        // When
        let listViewWidgetViewRenderer = renderer.buildRenderer(for: widget)
        // Then
        XCTAssert(listViewWidgetViewRenderer is ListViewWidgetRenderer, "Expected to build a listview widget view renderer, but has built \(String(describing: type(of: listViewWidgetViewRenderer))).")
    }
    
    func test_whenNavigator_shouldReturnNavigatorWidgetViewRenderer() {
        // Given
        let widget = Navigator(
            action: Navigate(type: .popView),
            child: Text("Navigation")
        )
        let renderer = WidgetRendererProviding()
        // When
        let navigatorWidgetViewRenderer = renderer.buildRenderer(for: widget)
        // Then
        XCTAssert(navigatorWidgetViewRenderer is NavigatorWidgetViewRenderer, "Expected to build a navigator widget view renderer, but has built \(String(describing: type(of: navigatorWidgetViewRenderer))).")
    }

    func test_whenScrollView_shouldReturnScrollViewWidgetViewRenderer() {
        // Given
        let widget = ScrollView {
            FlexWidget {
                Text("Text")
            }
        }
        let renderer = WidgetRendererProviding()
        // When
        let containerWidgetViewRenderer = renderer.buildRenderer(for: widget)
        // Then
        XCTAssert(containerWidgetViewRenderer is ScrollViewWidgetViewRenderer, "Expected to build a container widget view renderer, but has built \(String(describing: type(of: containerWidgetViewRenderer))).")
    }
    
    func test_whenForm_shouldReturnFormViewRenderer() {
        // Given
        let widget = Form(action: "", method: .get, child: WidgetDummy())
        let renderer = WidgetRendererProviding()
        // When
        let flexWidgetViewRenderer = renderer.buildRenderer(for: widget)
        // Then
        XCTAssert(flexWidgetViewRenderer is FormWidgetViewRenderer)
    }
    
    func test_whenFormInput_shouldReturnFormInputViewRenderer() {
        // Given
        let widget = FormInput(name: "name", child: WidgetDummy())
        let renderer = WidgetRendererProviding()
        // When
        let flexWidgetViewRenderer = renderer.buildRenderer(for: widget)
        // Then
        XCTAssert(flexWidgetViewRenderer is FormInputWidgetViewRenderer)
    }
    
    func test_whenFormSubmit_shouldReturnFormSubmitViewRenderer() {
        // Given
        let widget = FormSubmit(child: WidgetDummy())
        let renderer = WidgetRendererProviding()
        // When
        let flexWidgetViewRenderer = renderer.buildRenderer(for: widget)
        // Then
        XCTAssert(flexWidgetViewRenderer is FormSubmitWidgetViewRenderer)
    }
    
    func test_whenLazyWidget_shouldReturnLazyWidgetViewRenderer() {
        // Given
        let widget = LazyWidget(url: "", initialState: WidgetDummy())
        let renderer = WidgetRendererProviding()
        // When
        let flexWidgetViewRenderer = renderer.buildRenderer(for: widget)
        // Then
        XCTAssert(flexWidgetViewRenderer is LazyWidgetViewRenderer)
    }
}


