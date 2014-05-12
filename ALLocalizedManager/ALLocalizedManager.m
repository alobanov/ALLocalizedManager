//
//  ALLocalizedManager.m
//  proteplo
//
//  Created by Lobanov Aleksey on 24.04.14.
//  Copyright (c) 2014 Lobanov Aleksey. All rights reserved.
//

#import "ALLocalizedManager.h"

@interface ALLocalizedManager()

@property (strong, nonatomic) NSString *currentLanguage;

@end

@implementation ALLocalizedManager

//Singleton instance
static NSBundle *bundle;

#pragma mark - init singletone

- (id) init {
    self = [super init];
    if (self) {
        [self initLang];
    }
    return self;
}

+ (ALLocalizedManager *) defaultManager {
    static ALLocalizedManager *instance = nil;
    if (instance == nil) {
        instance = [[ALLocalizedManager alloc] init];
    }
    return instance;
}

#pragma mark - Localized methods

- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)comment
{
    return [bundle localizedStringForKey:key value:comment table:@"InfoPlist"];
}

- (NSString *) localizedStringFromTableForKey:(NSString *)key value:(NSString *)comment andTable:(NSString *) table {
    return [bundle localizedStringForKey:key value:comment table:table];
}

#pragma mark - Lang init

- (void) initLang
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:UserdefaultsKey_Lang]) {
        if ([self existLangFromUD]) {
            [self setLang:[defaults objectForKey:UserdefaultsKey_Lang]];
        } else {
            [self resetLocalization];
            return;
        }
    } else {
        NSArray *langList = [self languageList];
        if ([langList count] == 1) {
            NSDictionary *langDict = [langList objectAtIndex:0];
            [self setLang:[langDict allKeys][0]];
        } else {
            NSString *langSystem = [[NSLocale preferredLanguages] objectAtIndex:0];
            BOOL find = NO;
            // Lets find system language
            for (NSDictionary *langDic in langList) {
                if ([langDic objectForKey:langSystem]) {
                    [self setLang:langSystem];
                    find = YES;
                    break;
                }
            }
            
            // So, find default language
            if (!find) {
                for (NSDictionary *langDic in langList) {
                    if ([langDic objectForKey:@"isDefault"]) {
                        [self setLang:[langDic allKeys][0]];
                        break;
                    }
                }
            }// find default
        }// multi language
    }
    
    if (!self.currentLanguage) {
        [self setLang:@"en"];
    }
}

- (BOOL) existLangFromUD {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *udLang = [defaults objectForKey:UserdefaultsKey_Lang];
    
    NSArray *langList = [self languageList];
    for (NSDictionary *langDic in langList) {
        if ([langDic objectForKey:udLang]) {
            return YES;
        }
    }
    
    return NO;
}

#pragma mark - Lang get

- (NSInteger) getLangIndex {
    NSString *lang = [self getLang];
    NSArray *langList = [self languageList];
    
    NSInteger index = 0;
    for (NSDictionary *langDic in langList) {
        if ([langDic objectForKey:lang]) {
            return index;
        }
        index++;
    }
    
    return 0;
}

- (NSString *) getLang {
    if (_currentLanguage) {
        return _currentLanguage;
    } else {
        return [[NSLocale preferredLanguages] objectAtIndex:0];
    }
}

- (NSString *) getNameLang {
    if (_currentLanguage) {
        NSInteger index = [self getLangIndex];
        NSDictionary *langDict = [[self languageList] objectAtIndex:index];
        return [langDict objectForKey:[langDict allKeys][0]];
    }
    
    return @"";
}

#pragma mark - Lang set

- (void) setLangByIndex:(NSInteger) index {
    NSArray *langList = [self languageList];
    
    NSDictionary *langDic = [langList objectAtIndex:index];
    [self setLang:[langDic allKeys][0]];
}

- (void) setLang:(NSString *) lang {
    if (!self.currentLanguage && [_currentLanguage isEqualToString:lang]) return;
    
    self.currentLanguage = lang;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:lang forKey:UserdefaultsKey_Lang];
    [defaults synchronize];
    
    [self updateBundle];
}

#pragma marl - Localized imagePath

- (NSString *) pathForResource:(NSString *) resource ofType:(NSString *) type {
    return [[NSBundle mainBundle] pathForResource:resource
                                           ofType:type
                                      inDirectory:nil
                                  forLocalization:[self getLang]];
}

- (UIImage *) imageForResource:(NSString *) resource ofType:(NSString *) type {
    NSString *path = [[NSBundle mainBundle] pathForResource:resource
                                                     ofType:type
                                                inDirectory:nil
                                            forLocalization:[self getLang]];
    
    return [UIImage imageWithContentsOfFile:path];
}


#pragma mark - Bundle

- (void) updateBundle {
    NSString *path = [[NSBundle mainBundle] pathForResource:_currentLanguage ofType:@"lproj"];
    
    bundle = (path == nil)?
    [NSBundle mainBundle]:
    [NSBundle bundleWithPath:path];
}

- (void) resetLocalization {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:UserdefaultsKey_Lang];
    [defaults synchronize];
    
    [self initLang];
}

- (void) throwNotification {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:ALLocalizedManagerChangeLangNotification object:nil];
}

#pragma mark - language settings list

- (NSArray *) languageList {
    return @[@{@"ru": @"Русский", @"isDefault":@"YES"},
             @{@"en": @"English"}];
}

@end
