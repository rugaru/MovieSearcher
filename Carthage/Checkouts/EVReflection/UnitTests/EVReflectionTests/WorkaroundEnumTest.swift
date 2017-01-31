//
//  EnumWorkaroundTests.swift
//
//  Created by Edwin Vermeer on 7/23/15.
//  Copyright (c) 2015 evict. All rights reserved.
//

import XCTest
@testable import EVReflection


class myClass: NSObject {
    let item: String = ""
}

/**
Testing The enum workaround. Ignore this. Nothing is used in the actual library
*/
class EnumWorkaroundsTests: XCTestCase {
    
    /**
     For now nothing to setUp
     */
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        EVReflection.setBundleIdentifier(myClass.self)
    }
    
    /**
     For now nothing to tearDown
     */
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEnumToRaw() {
        let test1 = getRawValue(MyEnumOne.OK)
        XCTAssertTrue(test1 as? String == "OK-2", "Could nog get the rawvalue using a generic function. As a workaround just add the EVRawString protocol")
        let test2 = getRawValue(MyEnumTwo.ok)
        XCTAssertTrue(test2 as? Int == 1, "Could nog get the rawvalue using a generic function. As a workaround just add the EVRawInt protocol")
        let test3 = getRawValue(MyEnumThree.ok)
        XCTAssertTrue(test3 as? NSNumber == 1, "Could nog get the rawvalue using a generic function. As a workaround just add the EVRaw protocol")
        let varTest4 = MyEnumFour.notOK(message: "realy wrong")
        let test4 = getRawValue(varTest4) as? String
        XCTAssertTrue(varTest4.associated.label == "notOK", "Could nog get the associated value using a generic function")
        XCTAssertTrue(test4 == "realy wrong", "Could nog get the associated value using a generic function")
        let varTest5 = MyEnumFour.ok(level: 3)
        let test5 = getRawValue(varTest5) as? Int
        XCTAssertTrue(varTest5.associated.label == "ok", "Could nog get the rawvalue using a generic function")
        XCTAssertTrue(test5 == 3, "Could nog get the associated value using a generic function")
        let test6 = getRawValue(MyEnumFive.ok)
        XCTAssertTrue(test6 as? String == "ok", "So we could get the raw value? Otherwise this would succeed")
    }
    
    func testArrayNullable() {
        var testArray: [myClass?] = [myClass]()
        testArray.append(myClass())
        testArray.append(nil)
        let newArray: [myClass] = (testArray.filter { $0 != nil }) as! [myClass]
        XCTAssertTrue(newArray.count == 1, "We should have 1 object in the array")
    }
    
    func testArrayNotNullable() {
        var testArray: [myClass] = [myClass]()
        testArray.append(myClass())
        let newArray: [myClass] = (testArray.filter { $0 != nil })  // Yes, you will ge a warning, but we do have to test this. reflection could have messed things up
        XCTAssertTrue(newArray.count == 1, "We should have 1 object in the array")
    }
    
    func testNotAssociated() {
        NSLog("\n\n==>You will get a warning because MyEnumOne.OK does not have an associated value")
        let a = MyEnumOne.OK.associated
        XCTAssertNil(a.value, "Associated value should be nil")
    }
    
    enum MyEnumOne: String, EVRaw, EVAssociated {      // Add , EVRawString to make the test pass
        case NotOK = "NotOK-1"
        case OK = "OK-2"
    }
    
    enum MyEnumTwo: Int, EVRaw {       // Add , EVRawInt to make the test pass
        case notOK = 0
        case ok = 1
    }
    
    enum MyEnumThree: Int64, EVRaw {   // Add , EVRaw to make the test pass
        case notOK = 0
        case ok = 1
    }
    
    enum MyEnumFour: EVAssociated {
        case notOK(message: String)
        case ok(level: Int)
    }
    
    enum MyEnumFive: Int {
        case notOK = 0
        case ok = 1
    }
    
    func getRawValue(_ theEnum: Any) -> Any {        
        let (val, _, _) = EVReflection.valueForAny(self, key: "a", anyValue: theEnum)
        return val
    }
}








class EVReflectionTests2: XCTestCase {
    
    /**
     For now nothing to setUp
     */
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        EVReflection.setBundleIdentifier(Comment.self)
    }
    
    /**
     For now nothing to tearDown
     */
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTemp() {
        
        let test = "[\n {\n \"status\" : \"0\",\n \"content\" : \"Shuru\",\n \"ctime\" : \"1438250556\",\n \"img\" : \"\",\n \"testuserinfo\" : {\n \"avatar\" : \"/5602503cc79de.jpg\",\n \"uid\" : \"d8b81b21c72f1177300247e2d8d88ec5\",\n \"telnum\" : \"18565280137\",\n \"is_seller\" : \"0\",\n \"sex\" : \"男\",\n \"name\" : \"\",\n \"interest\" : \"\"\n },\n \"fabric\" : null,\n \"commentid\" : \"22\",\n \"sound\" : \"\",\n \"vote\" : \"0\",\n \"isvote\" : 0,\n \"seller_card\" : null\n }\n]"
        print("\(test)")
        var comments = EVReflection.arrayFromJson(type: Comment(), json: test)
        var comments2 = [Comment](json: test)
        print(comments[0].testuserinfo?.uid ?? "")
        print(comments2[0].testuserinfo?.uid ?? "")
    }
    
    func testTemp2() {
        let test = "[\n {\n \"status\" : \"0\",\n \"content\" : \"Shuru\",\n \"ctime\" : \"1438250556\",\n \"img\" : \"\",\n \"isvote\" : 0,\n \"testuserinfo\" : {\n \"avatar\" : \"\",\n \"uid\" : \"d8b81b21c72f1177300247e2d8d88ec5\",\n \"telnum\" : \"18565280137\",\n \"is_seller\" : \"0\",\n \"sex\" : \"男\",\n \"name\" : \"\",\n \"interest\" : \"\"\n },\n \"commentid\" : \"22\",\n \"fabric\" : null,\n \"sound\" : \"\",\n \"vote\" : \"0\",\n \"seller_card\" : null\n }\n]"
        let comments = EVReflection.arrayFromJson(type: Comment(), json: test)
        print(comments[0].testuserinfo?.telnum ?? "")
    }
}

class Comment: EVObject {
    var commentid = ""
    var content = ""
    var ctime = ""
    var status = "2"
    var img = ""
    var vote = "0"
    var sound: String?
    var isvote: Bool = false
    var seller_card: String?
    var fabric: String?
    var testuserinfo: UserInfo?
}

class UserInfo: EVObject {
    var avatar = ""
    var uid = ""
    var telnum = ""
    var is_seller = "0"
    var sex = "M"
    var name = "TestUser"
    var interest = ""
}
