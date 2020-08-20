import UIKit
import XCTest

func flatRecursive(obj: Any) -> [Int] {
    
    var res: [Int] = []
    
    if let objInt = obj as? Int {
        res.append(objInt)
        return res
    }
    
    if let obj = obj as? Array<Any> {
        for x in obj {
           res += flatRecursive(obj: x)
        }
    }
    
    return res
}

let integersRecursive = flatRecursive(obj: [[1,2,[3]],4])
print(integersRecursive)

class FlatArrayCase: XCTestCase {
    
    func testNestedArray1() {
        print("\n==== Array [[1,2,[3]],4] --> [1,2,3,4] ====\n")
        let result = flatRecursive(obj: [[1,2,[3]],4])
        XCTAssertTrue(result == [1,2,3,4])
    }
    
    func testNestedArray2() {
        print("\n==== Array [[[1,2],[3]],4] --> [1,2,3,4] ====\n")
        let result = flatRecursive(obj: [[[1,2],[3]],4])
        XCTAssertTrue(result == [1,2,3,4])
    }
    
    func testNestedArray3() {
        print("\n==== Array [1,[2,3,[4]]] --> [1,2,3,4] ====\n")
        let result = flatRecursive(obj: [1,[2,3,[4]]])
        XCTAssertTrue(result == [1,2,3,4])
    }
    
    func testNestedArray4() {
        print("\n==== Array [[1,2,[]],4] --> [1,2,3,4] ====\n")
        let result = flatRecursive(obj: [[1,[],2],4])
        XCTAssertTrue(result == [1,2,4])
    }
    
    func testEmptyArray() {
        print("\n==== Empty Array [] --> [] ====\n]")
        let result = flatRecursive(obj: [])
        XCTAssertTrue(result == [])
    }
}

FlatArrayCase.defaultTestSuite.run()
