//
//  NSUserDefaultsTestTests.swift
//  NSUserDefaultsTestTests
//
//  Created by Paul Rehkugler on 6/14/16.
//  Copyright © 2016 Tumblr. All rights reserved.
//

import XCTest

final class NSUserDefaultsTestTests: XCTestCase {

    class SecurityApplicationGroup {
        static func identifier() -> String? {
            if let infoPlist = Bundle.main().infoDictionary,
                let identifier = infoPlist["SecurityGroupIdentifier"] as? String {
                return identifier
            }

            return nil
        }
    }

    func testThatUserDefaultsWithSuiteNameReturnsValuesWhenTheyAreSet() {
        guard let securityApplicationGroupIdentifier = SecurityApplicationGroup.identifier() else {
            XCTFail("No valid value for the security application group identifier.")
            return
        }

        guard let defaults = UserDefaults(suiteName: securityApplicationGroupIdentifier) else {
            XCTFail("UserDefaults(suiteName:) did not create an instance of UserDefaults.")
            return
        }

        let value = "value"
        let key = "key"

        defaults.setValue(value, forKey: key)

        let retrievedValue = defaults.value(forKey: key)

        XCTAssertNotNil(retrievedValue, "After a value is set in UserDefaults it should be retrievable.")
        XCTAssertEqual(value, retrievedValue as? String, "A value retrieved from UserDefaults should match the value set in it.")
    }

    func testThatUserDefaultsReturnsValuesWhenTheyAreSet() {
        let defaults = UserDefaults.standard()

        let value = "value"
        let key = "key"

        defaults.setValue(value, forKey: key)

        let retrievedValue = defaults.value(forKey: key)

        XCTAssertNotNil(retrievedValue, "After a value is set in UserDefaults it should be retrievable.")
        XCTAssertEqual(value, retrievedValue as? String, "A value retrieved from UserDefaults should match the value set in it.")
    }
}
