//
//  StateObject.swift
//  OrganicFit
//
//  Created by Aleksey Kolosovskiy on 15.05.2020.
//  Copyright © 2020 Aleksey Kolosovskiy. All rights reserved.
//

import Foundation
import Realm


func ApplyUUID(object: Object) {
    guard let customObject = object as? CustomObject else { return }

    customObject.makeUUID()
}


open class CustomObject : Object {
    @objc dynamic public var uuid: String = CustomObject.newUUID
    @objc dynamic public var __isJunk: Bool = false
    
    
    static var newUUID: String { return UUID().uuidString }


    public static func create<Type: Object>(of type: Type, with value: Any) -> Type {
        let object = Type()

        RLMInitializeWithValue(object, value, .partialPrivateShared())
        ApplyUUID(object: object)

        return object
    }
    
    
    public func makeUUID() {
        uuid = CustomObject.newUUID
    }
    
    
    public override static func primaryKey() -> String? {
        return "uuid"
    }
}
