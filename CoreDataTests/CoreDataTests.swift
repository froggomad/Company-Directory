//
//  CoreDataTests.swift
//  CoreDataTests
//
//  Created by Kenny on 3/21/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

import XCTest
@testable import CoreData

class CoreDataTests: XCTestCase {
    let testCo = Company(name: "Test Company", founded: Date(), employees: [])
    let testEmp = Employee(identifier: UUID(), name: "Joe", address: "999 test st.")
    let companyController = CompanyModelController()

    func testAddCompany() {
        companyController.addCompany(testCo)
        XCTAssertEqual(companyController.companies.firstIndex(of: testCo), 0)
    }

    func testAddEmployee() {
        companyController.addCompany(testCo)
        companyController.addEmployee(testCo, employee: testEmp)
        XCTAssertEqual(companyController.companies[0].employees.firstIndex(of: testEmp), 0)
    }

    func testUpdateEmployee() {
        var testingEmp = testEmp
        testingEmp.address = "123 main st."
        companyController.addCompany(testCo)
        companyController.addEmployee(testCo, employee: testEmp)
        companyController.updateEmployee(testCo, employee: testingEmp)
        XCTAssertEqual(companyController.companies.count, 1)
        XCTAssertEqual(companyController.companies[0].employees.count, 1)
        XCTAssertEqual(companyController.companies[0].employees[0].address, "123 main st.")
    }

    func testRemoveEmployee() {
        companyController.addCompany(testCo)
        companyController.addEmployee(testCo, employee: testEmp)
        companyController.removeEmployee(testCo, employee: testEmp)
        XCTAssertTrue(companyController.companies[0].employees.isEmpty)
    }

    func testRemoveCompany() {
        companyController.addCompany(testCo)
        companyController.removeCompany(testCo)
        XCTAssertTrue(companyController.companies.isEmpty)
    }

}
