import UIKit
import XCTest

func flatRecursive(obj: Any) -> [Int] {
    
    var result: [Int] = []
    
    if let objInt = obj as? Int {
        result.append(objInt)
        return result
    }
    
    if let obj = obj as? Array<Any> {
        for x in obj {
           result += flatRecursive(obj: x)
        }
    }
    
    return result
}

func flatIterative(obj: Any) -> [Int] {
   
    var result: Array<Int> = []
    
    if var array = obj as? Array<Any> {
        while array.count > 0 {
            let first = array[0]
            
            if let int = first as? Int {
                result.append(int)
                array.removeFirst()
            }
            
            if let arr = first as? Array<Any> {
                array.replaceSubrange(Range(NSRange(location: 0, length: 1))!, with: arr)
            }
        }
    }
    return result
}

// MARK: - Test

class FlatRecursiveArrayCase: XCTestCase {
    
    func testNestedArray1() {
        let result = flatRecursive(obj: [[1,2,[3]],4])
        XCTAssertTrue(result == [1,2,3,4])
    }
    
    func testNestedArray2() {
        let result = flatRecursive(obj: [[[1,2],[3]],4])
        XCTAssertTrue(result == [1,2,3,4])
    }
    
    func testNestedArray3() {
        let result = flatRecursive(obj: [1,[2,3,[4]]])
        XCTAssertTrue(result == [1,2,3,4])
    }
    
    func testNestedArray4() {
        let result = flatRecursive(obj: [[1,[],2],4])
        XCTAssertTrue(result == [1,2,4])
    }
    
    func testEmptyArray() {
        let result = flatRecursive(obj: [])
        XCTAssertTrue(result == [])
    }
}

class FlatIterativeArrayCase: XCTestCase {
    
    func testNestedArray1() {
        let result = flatIterative(obj: [[1,2,[3]],4])
        XCTAssertTrue(result == [1,2,3,4])
    }
    
    func testNestedArray2() {
        let result = flatIterative(obj: [[[1,2],[3]],4])
        XCTAssertTrue(result == [1,2,3,4])
    }
    
    func testNestedArray3() {
        let result = flatIterative(obj: [1,[2,3,[4]]])
        XCTAssertTrue(result == [1,2,3,4])
    }
    
    func testNestedArray4() {
        let result = flatIterative(obj: [[1,[],2],4])
        XCTAssertTrue(result == [1,2,4])
    }
    
    func testEmptyArray() {
        let result = flatIterative(obj: [])
        XCTAssertTrue(result == [])
    }
}

FlatRecursiveArrayCase.defaultTestSuite.run()
FlatIterativeArrayCase.defaultTestSuite.run()
