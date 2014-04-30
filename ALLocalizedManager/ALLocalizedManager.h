//
//  ALLocalizedManager.h
//  proteplo
//
//  Created by Lobanov Aleksey on 24.04.14.
//  Copyright (c) 2014 Lobanov Aleksey. All rights reserved.
//

#import <Foundation/Foundation.h>

#define UserdefaultsKey_Lang @"UserdefaultsKey_Lang"
#define ALLocalizedManagerChangeLangNotification @"ALLocalizedManagerChangeLangNotification"

#define ALLocalizedInit \
[ALLocalizedManager defaultManager]

#define ALLocalizedString(key, comment) \
[[ALLocalizedManager defaultManager] localizedStringForKey:(key) value:(comment)]

#define ALLocalizationSetLanguageByIndex(language) \
[[ALLocalizedManager defaultManager] setLangByIndex:(language)]

#define ALLocalizationSetLanguage(language) \
[[ALLocalizedManager defaultManager] setLang:(language)]

#define ALLocalizationGetLanguage \
[[ALLocalizedManager defaultManager] getLang]

#define ALLocalizationGetNameLanguage \
[[ALLocalizedManager defaultManager] getNameLang]

#define ALLocalizationGetLanguageIndex \
[[ALLocalizedManager defaultManager] getLangIndex]

#define ALLocalizationReset \
[[ALLocalizedManager defaultManager] resetLocalization]

#define ALLocalizationThrowNotification \
[[ALLocalizedManager defaultManager] throwNotification]

#define ALLocalizationResource(resource, type) \
[[ALLocalizedManager defaultManager] pathForResource:(resource) ofType:(type)]

#define ALLocalizationImage(resource, type) \
[[ALLocalizedManager defaultManager] imageForResource:(resource) ofType:(type)]

@interface ALLocalizedManager : NSObject;

+ (ALLocalizedManager*) defaultManager;

#pragma mark - Localized

- (NSString *) localizedStringForKey:(NSString *)key value:(NSString *)comment;


#pragma mark - Lang set

- (void) setLangByIndex:(NSInteger) index;
- (void) setLang:(NSString *) lang;

#pragma marl - Localized imagePath
- (NSString *) pathForResource:(NSString *) resource ofType:(NSString *) type;
- (UIImage *) imageForResource:(NSString *) resource ofType:(NSString *) type;

#pragma mark - Lang get

- (NSInteger) getLangIndex;
- (NSString *) getLang;
- (NSString *) getNameLang;

#pragma mark - Lang reset

- (void) resetLocalization;
- (void) throwNotification;

@end
