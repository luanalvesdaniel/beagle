//
// Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//


import XCTest
@testable import BeagleUI
import SnapshotTesting

final class TouchableTests: XCTestCase {
    
    func testInitFromDecoder() throws {
        let component: Touchable = try componentFromJsonFile(fileName: "TouchableDecoderTest")
        assertSnapshot(matching: component, as: .dump)
    }

    func testTouchableView() throws {
        let touchable = Touchable(action: Navigate.popView, child: Text("Touchable"))
        let view = touchable.toView(context: BeagleContextDummy(), dependencies: BeagleDependencies())

        assertSnapshotImage(view, size: CGSize(width: 100, height: 80))
    }
}