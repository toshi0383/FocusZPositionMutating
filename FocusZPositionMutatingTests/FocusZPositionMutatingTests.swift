//
//  FocusZPositionMutatingTests.swift
//  FocusZPositionMutatingTests
//
//  Created by Toshihiro Suzuki on 2017/11/21.
//  Copyright © 2017 toshi0383. All rights reserved.
//

import XCTest
import UIKit
@testable import FocusZPositionMutating

class FocusZPositionMutatingTests: XCTestCase {
    func test() {

        try! UIView.fzpm_swizzleDidUpdateFocus()
        XCTAssertEqual(_focusedZPosition, 1.0)
        XCTAssertEqual(_unfocusedZPosition, 0.0)
        XCTAssertEqual(intermediateZPosition, 0.5)
        try! UIView.fzpm_swizzleDidUpdateFocus(focusedZPosition: 1.0, unfocusedZPosition: 0.0)
        XCTAssertEqual(_focusedZPosition, 1.0)
        XCTAssertEqual(_unfocusedZPosition, 0.0)
        XCTAssertEqual(intermediateZPosition, 0.5)
        try! UIView.fzpm_swizzleDidUpdateFocus(focusedZPosition: 0.0, unfocusedZPosition: -0.5)
        XCTAssertEqual(_focusedZPosition, 0.0)
        XCTAssertEqual(_unfocusedZPosition, -0.5)
        XCTAssertEqual(intermediateZPosition, -0.25)

        do {
            try UIView.fzpm_swizzleDidUpdateFocus(focusedZPosition: 0.0, unfocusedZPosition: -0.1)
            XCTFail()
        } catch {
            if case FZPMError.invalidParameter = error {
                // pass
            } else {
                XCTFail()
            }
        }

        do {
            try UIView.fzpm_swizzleDidUpdateFocus(focusedZPosition: 0.0, unfocusedZPosition: -0.10001)
            XCTAssertEqual(_focusedZPosition, 0.0)
            XCTAssertEqual(_unfocusedZPosition, -0.10001)
            XCTAssertEqual(intermediateZPosition, -0.050005)
        } catch {
            XCTFail()
        }
    }
}
