//
//  ALLocalizedExampleTests.m
//  ALLocalizedExampleTests
//
//  Created by Lobanov Aleksey on 30.04.14.
//  Copyright (c) 2014 Lobanov Aleksey. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface ALLocalizedExampleTests : XCTestCase

@property (strong, nonatomic) NSArray *languages;

@end

@implementation ALLocalizedExampleTests

- (void)setUp {
    [super setUp];
    
    self.languages = @[ @{@"ru": @"Русский"}, @{@"en": @"English"} ];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSetupDefault {
    
    [[ALLocalizedManager sharedInstance] resetLocalization];
    
    [[ALLocalizedManager sharedInstance] setLanguages:self.languages];
    [[ALLocalizedManager sharedInstance] setDefaultLanguage:@"ru"];
    
    NSString *systemLang = [[[NSLocale preferredLanguages] firstObject] substringToIndex:2];
    
    NSString *lang = [[ALLocalizedManager sharedInstance] getLang];
    
    XCTAssertEqual(lang, systemLang);
}

@end
