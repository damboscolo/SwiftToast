import UIKit
import XCTest
import SwiftToast

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testHeight() {
        let toast = SwiftToast()
        let height = toast.height(8)
        XCTAssert(height == 16)
    }
}
