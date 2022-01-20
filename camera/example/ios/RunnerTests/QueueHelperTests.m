// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

@import camera;
@import XCTest;

@interface QueueHelperTests : XCTestCase

@end

@implementation QueueHelperTests

- (void)testShouldStayOnMainQueueIfCalledFromMainQueue {
  XCTestExpectation *expectation =
      [self expectationWithDescription:@"Block must be run on the main queue."];
  [QueueHelper ensureToRunOnMainQueue:^{
    if (NSThread.isMainThread) {
      [expectation fulfill];
    }
  }];
  [self waitForExpectationsWithTimeout:1 handler:nil];
}

- (void)testShouldDispatchToMainQueueIfCalledFromBackgroundQueue {
  XCTestExpectation *expectation =
      [self expectationWithDescription:@"Block must be run on the main queue."];
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    [QueueHelper ensureToRunOnMainQueue:^{
      if (NSThread.isMainThread) {
        [expectation fulfill];
      }
    }];
  });
  [self waitForExpectationsWithTimeout:1 handler:nil];
}

@end
