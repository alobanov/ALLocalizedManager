//
//  ALLocalizedManager.h
//  proteplo
//
//  Created by Lobanov Aleksey on 24.04.14.
//  Copyright (c) 2014 Lobanov Aleksey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define UserdefaultsKey_Lang @"UserdefaultsKey_Lang"
#define ALLocalizedManagerChangeLangNotification @"ALLocalizedManagerChangeLangNotification"

#define ALLocalizationSetLanguageByIndex(language) \
[[ALLocalizedManager sharedInstance] setLangByIndex:(language)]

#define ALLocalizationSetLanguage(language) \
[[ALLocalizedManager sharedInstance] setLang:(language)]

#define ALLocalizationGetLanguage \
[[ALLocalizedManager sharedInstance] getLang]

#define ALLocalizationGetNameLanguage \
[[ALLocalizedManager sharedInstance] getNameLang]

#define ALLocalizationGetLanguageIndex \
[[ALLocalizedManager sharedInstance] getLangIndex]

#define ALLocalizationReset \
[[ALLocalizedManager sharedInstance] resetLocalization]

#define ALLocalizationThrowNotification \
[[ALLocalizedManager sharedInstance] throwNotification]

#define ALLocalizationResource(resource, type) \
[[ALLocalizedManager sharedInstance] pathForResource:(resource) ofType:(type)]

#define ALLocalizationImage(resource, type) \
[[ALLocalizedManager sharedInstance] imageForResource:(resource) ofType:(type)]

// localized string
#define ALLocalizedString(key, comment) \
[[ALLocalizedManager sharedInstance] localizedStringForKey:(key) value:(comment)]

#define ALLocalizedStringFromTable(key, comment, tableName) \
[[ALLocalizedManager sharedInstance] localizedStringFromTableForKey:(key) value:(comment) andTable:(tableName)]

#define ALLocalizedStringGeneral(key, comment) \
[[ALLocalizedManager sharedInstance] localizedStringFromTableForKey:(key) value:(comment) andTable:@"Localizable"]

@interface ALLocalizedManager : NSObject;

+ (id)sharedInstance;

#pragma mark - Localized

- (NSString *) localizedStringForKey:(NSString *)key value:(NSString *)comment;
- (NSString *) localizedStringFromTableForKey:(NSString *)key value:(NSString *)comment andTable:(NSString *) table;

#pragma mark - Lang set

- (void)setLanguages:(NSArray *)languages;
- (void)setDefaultLanguage:(NSString *)languageIdentifier;

- (void) setLang:(NSString *) lang;

#pragma mark - Languages
- (NSArray *)languages;

#pragma marl - Localized imagePath
- (NSString *) pathForResource:(NSString *) resource ofType:(NSString *) type;
- (UIImage *) imageForResource:(NSString *) resource ofType:(NSString *) type;

#pragma mark - Lang get

- (NSString *) getLang;
- (NSString *) getNameLang;

#pragma mark - Lang reset

- (void) resetLocalization;
- (void) throwNotification;

#pragma mark - Observation

- (void)addChangeLanguageBlock:(void (^)(NSString *newLang))changeBlock forObject:(NSObject *)observer;
- (void)removeChangeLanguageBlockForObject:(NSObject *)observer;

#pragma mark - Language bundle
- (NSBundle *)bundle;

@end
