//
//  iyubaDemoUITestsMy.m
//  iyubaDemoUITestsMy
//
//  Created by HuanLeiMac on 2018/3/26.
//  Copyright © 2018年 nice2meet-demo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "iyubaDemoUITestsMy-Swift.h"

@interface iyubaDemoUITestsMy : XCTestCase

@end

@implementation iyubaDemoUITestsMy

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [Snapshot setupSnapshot:app];
    [app launch];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *rightArrowButton = app.buttons[@"right arrow"];
    [rightArrowButton tap];
    [Snapshot snapshot:@"screenshot-1" timeWaitingForIdle:20];
    
    [rightArrowButton tap];
    [Snapshot snapshot:@"screenshot-2" timeWaitingForIdle:20];
    [rightArrowButton tap];
    [Snapshot snapshot:@"screenshot-3" timeWaitingForIdle:20];
    //[app.tables/*@START_MENU_TOKEN@*/.staticTexts[@" \U673a\U5668\U4eba\U6cbb\U7597\U5e08"]/*[[".cells.staticTexts[@\" \\U673a\\U5668\\U4eba\\U6cbb\\U7597\\U5e08\"]",".staticTexts[@\" \\U673a\\U5668\\U4eba\\U6cbb\\U7597\\U5e08\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    //[Snapshot snapshot:@"screenshot-4" timeWaitingForIdle:20];
    [app.images[@"bottomImg"] tap];
    [Snapshot snapshot:@"screenshot-4" timeWaitingForIdle:20];

}

@end
