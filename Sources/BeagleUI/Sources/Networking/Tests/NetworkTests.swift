//
//  Copyright © 25/10/19 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class NetworkTests: XCTestCase {

    private struct Dependencies: NetworkDefault.Dependencies {
        var baseURL: URL?
        var networkClient: NetworkClient
        var decoder: ComponentDecoding

        init(
            baseURL: URL? = nil,
            networkClient: NetworkClient = NetworkClientDummy(),
            decoder: ComponentDecoding = ComponentDecodingDummy()
        ) {
            self.baseURL = baseURL
            self.networkClient = networkClient
            self.decoder = decoder
        }
    }

    func test_requestWithInvalidURL_itShouldFail() {
        let sut = NetworkDefault(dependencies: BeagleDependencies())
        let invalidURL = "🥶"
        
        // When
        let fetchComponentExpectation = expectation(description: "fetchComponent")
        var fetchError: Request.Error?

        sut.fetchComponent(url: invalidURL) {
            if case let .failure(error) = $0 {
                fetchError = error
            }
            fetchComponentExpectation.fulfill()
        }

        let submitFormExpectation = expectation(description: "submitForm")
        var formError: Request.Error?
        let formData = Request.FormData(
            method: .post, values: [:]
        )

        sut.submitForm(url: invalidURL, data: formData) {
            if case let .failure(error) = $0 {
                formError = error
            }
            submitFormExpectation.fulfill()
        }
        wait(for: [fetchComponentExpectation, submitFormExpectation], timeout: 1.0)

        // Then
        guard
            case .networkError? = fetchError,
            case .networkError? = formError
        else {
            XCTFail("Expected an error")
            return
        }
    }
    
    func test_whenRequestSucceeds_withValidData_itShouldReturnSomeComponent() {
        // Given
        guard let jsonData = """
        {
            "_beagleType_": "beagle:component:text",
            "text": "some text"
        }
        """.data(using: .utf8) else {
            XCTFail("Could not create test data.")
            return
        }
        let clientStub = NetworkClientStub(result: .success(jsonData))
        let sut = NetworkDefault(dependencies: Dependencies(
            networkClient: clientStub,
            decoder: ComponentDecoder()
        ))
        let url = "www.something.com"

        // When
        var componentReturned: ServerDrivenComponent?
        let expec = expectation(description: "fetchComponentExpectation")
        sut.fetchComponent(url: url) { result in
            if case .success(let component) = result {
                componentReturned = component
            }
            expec.fulfill()
        }
        wait(for: [expec], timeout: 1.0)

        // Then
        XCTAssertNotNil(componentReturned)
        XCTAssert(componentReturned is Text)
    }

    func test_whenRequestSucceeds_butTheDecodingFailsWithAnError_itShouldThrowDecodingError() {
        // Given
        let clientStub = NetworkClientStub(result: .success(Data()))
        let decoderStub = ComponentDecodingStub()
        decoderStub.errorToThrowOnDecode = NSError(domain: "Mock", code: 1, description: "Mock")
        let sut = NetworkDefault(dependencies: Dependencies(
            networkClient: clientStub,
            decoder: decoderStub
        ))

        let url = "www.something.com"

        // When
        var errorThrown: Request.Error?
        let expec = expectation(description: "fetchComponentExpectation")
        sut.fetchComponent(url: url) { result in
            if case let .failure(error) = result {
                errorThrown = error
            }
            expec.fulfill()
        }
        wait(for: [expec], timeout: 1.0)

        // Then
        XCTAssertNotNil(errorThrown)
        guard case .decoding? = errorThrown else {
            XCTFail("Expected a `.decoding` error, but got \(String(describing: errorThrown)).")
            return
        }
    }
}

// MARK: - Testing Helpers

final class ComponentDecodingStub: ComponentDecoding {
    
    func register<T>(_ type: T.Type, for typeName: String) where T: ComponentEntity {}
    func decodableType(forType type: String) -> Decodable.Type? { return nil }

    var componentToReturnOnDecode: ComponentEntity?
    var errorToThrowOnDecode: Error?
    
    func decodeComponent(from data: Data) throws -> ServerDrivenComponent {
        if let error = errorToThrowOnDecode {
            throw error
        }
        return ComponentDummy()
    }

    func decodeAction(from data: Data) throws -> Action {
        if let error = errorToThrowOnDecode {
            throw error
        }
        return ActionDummy()
    }
}

private struct MappingFailureComponent: ComponentEntity, ComponentConvertible {
    func mapToComponent() throws -> ServerDrivenComponent {
        throw NSError(domain: "Tests", code: -1, description: "MappingFailureComponent")
    }
}

class NetworkStub: Network {

    let componentResult: Result<ServerDrivenComponent, Request.Error>?
    let formResult: Result<Action, Request.Error>?
    let imageResult: Result<Data, Request.Error>?

    private(set) var didCallDispatch = false
    private(set) var token = Token()

    class Token: RequestToken {
        var didCallCancel = false

        func cancel() {
            didCallCancel = true
        }
    }

    init(
        componentResult: Result<ServerDrivenComponent, Request.Error>? = nil,
        formResult: Result<Action, Request.Error>? = nil,
        imageResult: Result<Data, Request.Error>? = nil
    ) {
        self.componentResult = componentResult
        self.formResult = formResult
        self.imageResult = imageResult
    }

    func fetchComponent(url: String, completion: @escaping (Result<ServerDrivenComponent, Request.Error>) -> Void) -> RequestToken? {
        didCallDispatch = true
        if let result = componentResult {
            completion(result)
        }
        return token
    }

    func submitForm(url: String, data: Request.FormData, completion: @escaping (Result<Action, Request.Error>) -> Void) -> RequestToken? {
        didCallDispatch = true
        if let result = formResult {
            completion(result)
        }
        return token
    }

    func fetchImage(url: String, completion: @escaping (Result<Data, Request.Error>) -> Void) -> RequestToken? {
        didCallDispatch = true
        if let result = imageResult {
            completion(result)
        }
        return token
    }
}

class NetworkClientStub: NetworkClient {

    let result: NetworkClient.Result

    private(set) var executedRequest: Request?

    init(result: NetworkClient.Result) {
        self.result = result
    }

    func executeRequest(_ request: Request, completion: @escaping RequestCompletion) -> RequestToken? {
        executedRequest = request
        completion(result)
        return nil
    }
}
