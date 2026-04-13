import XCTest
@testable import GratefulMoments

class MomentViewModelTests: XCTestCase {
    var viewModel: MomentViewModel!

    override func setUp() {
        super.setUp()
        // Initialize the MomentViewModel before each test
        viewModel = MomentViewModel()
    }

    override func tearDown() {
        // Clear the view model after each test
        viewModel = nil
        super.tearDown()
    }

    func testFetchMomentsSuccess() {
        // This test simulates a successful fetch of moments
        let expectation = self.expectation(description: "Fetch moments success")

        viewModel.fetchMoments { result in
            switch result {
            case .success(let moments):
                // Expect the moments to be non-empty
                XCTAssertFalse(moments.isEmpty, "Expected moments to be fetched")
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5)
    }

    func testFetchMomentsFailure() {
        // This test simulates a failure to fetch moments
        let expectation = self.expectation(description: "Fetch moments failure")

        viewModel.fetchMoments { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                // Check that the error type is as expected
                XCTAssertNotNil(error, "Expected an error when failing to fetch moments")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5)
    }

    func testAddMomentSuccess() {
        // This test verifies adding a moment succeeds
        let expectation = self.expectation(description: "Add moment success")
        let moment = Moment(id: UUID().uuidString, text: "Test moment")

        viewModel.addMoment(moment) { result in
            switch result {
            case .success:
                XCTAssertTrue(self.viewModel.moments.contains(where: { $0.id == moment.id }), "Moment should be added successfully")
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5)
    }

    func testAddMomentFailure() {
        // This test verifies that an error occurs when adding a moment fails
        let expectation = self.expectation(description: "Add moment failure")
        let moment = Moment(id: UUID().uuidString, text: "") // Simulate an invalid moment with empty text

        viewModel.addMoment(moment) { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertNotNil(error, "Expected an error when failing to add moment")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5)
    }
}