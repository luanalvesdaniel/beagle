//
//  CustomComponnentScreen.swift
//  BeagleDemo
//
//  Created by Yan Dias on 27/02/20.
//  Copyright © 2020 Zup IT. All rights reserved.
//

import UIKit
import BeagleUI

struct CustomComponentScreen: DeeplinkScreen {
    init(path: String, data: [String : String]?) {
    }
    
    func screenController() -> UIViewController {
        return Beagle.screen(.declarative(screen))
    }
    
    var screen: Screen {
        return Screen(
            navigationBar: NavigationBar(title: "Custom Component"),
            content: Container(
                children: [
                    Text("Here its a custom component\n in this case a Collection View", alignment: .center),
                    DSCollection(
                        flex: Flex(size: Flex.Size(width: .init(value: 100, type: .percent), height: .init(value: 300, type: .real))),
                        dataSource: DSCollectionDataSource(cards: [
                            DSCollectionDataSource.Card(name: "Pocas", age: 22),
                            DSCollectionDataSource.Card(name: "Borracha", age: 40),
                            DSCollectionDataSource.Card(name: "Gotto", age: 42),
                            DSCollectionDataSource.Card(name: "Tulio", age: 38)
                        ])
                    )
                ]
            )
        )
    }
}
