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
@property (strong, nonatomic) NSString *defaultLanguage;

@property (strong, nonatomic) NSArray *languagesStore;

@property (strong, nonatomic) NSMutableDictionary *changedBlocks;

@end

@implementation ALLocalizedManager

//Singleton instance
static NSBundle *bundle;
static ALLocalizedManager *SINGLETON = nil;

#pragma mark - init singletone

- (id) init {
    self = [super init];
    if (self) {
        self.currentLanguage = nil;
        self.defaultLanguage = nil;
        self.languagesStore = nil;
        
        // app state observers
        self.changedBlocks = [NSMutableDictionary dictionaryWithCapacity:10];
        
        bundle = [NSBundle mainBundle];
    }
    return self;
}

+ (id)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SINGLETON = [[super allocWithZone:NULL] init];
    });
    
    return SINGLETON;
}

#pragma mark - Localized methods

- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)comment
{
    return [bundle localizedStringForKey:key value:comment table:@"InfoPlist"];
}

- (NSString *) localizedStringFromTableForKey:(NSString *)key value:(NSString *)comment andTable:(NSString *) table {
    return [bundle localizedStringForKey:key value:comment table:table];
}

#pragma mark - Lang get

- (NSString *) getLang {
    if (self.currentLanguage) {
        return self.currentLanguage;
    } else {
        return [self systemPreferredLanguage];
    }
}

- (NSString *) getNameLang {
    NSString *langID = self.currentLanguage;
    NSDictionary *langInfo = [self languageByIdentifier:langID];
    if (langInfo == nil) return @"Undefined";
    
    return [[langInfo allValues] firstObject];
}

#pragma mark - Lang set

- (void) setLang:(NSString *) lang {
    if (self.currentLanguage && [self.currentLanguage isEqualToString:lang]) return;
    
    self.currentLanguage = lang;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:lang forKey:UserdefaultsKey_Lang];
    [defaults synchronize];
    
    [self updateBundle];
    
    // send by observers
    [self sendNewLanguageByObservers];
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
    NSString *path = [[NSBundle mainBundle] pathForResource:self.currentLanguage ofType:@"lproj"];
    
    bundle = (path == nil) ? [NSBundle mainBundle] : [NSBundle bundleWithPath:path];
}

- (void) resetLocalization {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:UserdefaultsKey_Lang];
    [defaults synchronize];
    
    self.defaultLanguage = nil;
    self.currentLanguage = nil;
    self.languagesStore = nil;
}

- (void) throwNotification {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:ALLocalizedManagerChangeLangNotification object:nil];
}

#pragma mark - language settings list

- (void)setLanguages:(NSArray *)languages {
    NSMutableArray *newLanguages = nil;
    
    @try {
        newLanguages = [NSMutableArray arrayWithCapacity:[languages count]];
        
        for (NSDictionary *langInfo in languages) {
            NSString *langID = [[langInfo allKeys] firstObject];
            NSString *langName = [[langInfo allValues] firstObject];
            
            [newLanguages addObject:@{ langID: langName }];
        }
        
    } @catch (NSException *exception) {
        
        NSLog(@"Error parsing language list");
        NSLog(@"%@", exception);
        
        newLanguages = nil;
        
    } @finally {
        
    }
    
    if (newLanguages == nil) {
        newLanguages = [@[ @{ @"en": @"English" } ] mutableCopy];
    }
    
    self.languagesStore = newLanguages;
    
    [self restoreCurrentlanguage];
}

#pragma mark - Languages

- (NSArray *)languages {
    return self.languagesStore;
}

- (void)setDefaultLanguage:(NSString *)languageIdentifier {
    NSDictionary *langInfo = [self languageByIdentifier:languageIdentifier];
    if (langInfo == nil) return;
    
    _defaultLanguage = languageIdentifier;
    
    [self restoreCurrentlanguage];
}

- (NSDictionary *)languageByIdentifier:(NSString *)langID {
    for (NSDictionary *langInfo in self.languagesStore) {
        NSString *langIDCandidate = [[langInfo allKeys] firstObject];
        
        if ([langIDCandidate isEqualToString:langID]) {
            return langInfo;
        }
    }
    
    return nil;
}

- (void)restoreCurrentlanguage {
    if (self.defaultLanguage == nil) return;
    if (self.languagesStore == nil) return;
    
    // try to restore from settings
    [self restoreSavedLanguage];
    
    // check if success
    if (self.currentLanguage) return;
    
    // try to set system language
    [self restoreSystemLanguage];
    
    // check if success
    if (self.currentLanguage) return;
    
    // try to set default
    [self restoreDefaultLanguage];
}

- (void)restoreSavedLanguage {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *langID = [defaults objectForKey:UserdefaultsKey_Lang];
    if (langID == nil) return;
    
    NSDictionary *langInfo = [self languageByIdentifier:langID];
    if (langInfo == nil) return;
    
    [self setLang:langID];
}

- (void)restoreDefaultLanguage {
    
    NSString *langID = self.defaultLanguage;
    if (langID == nil) return;
    
    NSDictionary *langInfo = [self languageByIdentifier:langID];
    if (langInfo == nil) return;
    
    [self setLang:langID];
}

- (void)restoreSystemLanguage {
    
    NSString *langID = [self systemPreferredLanguage];
    if (langID == nil) return;
    
    NSDictionary *langInfo = [self languageByIdentifier:langID];
    if (langInfo == nil) return;
    
    [self setLang:langID];
}

#pragma mark - System lang ID

- (NSString *)systemPreferredLanguage {
    NSString *langID = [[NSLocale preferredLanguages] objectAtIndex:0];
    NSDictionary *langInfo = [self languageByIdentifier:langID];
    if (langInfo) {
        return langID;
    }
    
    langID = [langID substringToIndex:2];
    langInfo = [self languageByIdentifier:langID];
    if (langInfo) {
        return langID;
    }
    
    return nil;
}

#pragma mark - Observation

- (void)addChangeLanguageBlock:(void (^)(NSString *newLang))changeBlock forObject:(NSObject *)observer {
    NSString *key = [NSString stringWithFormat:@"%p", observer];
    
    [self.changedBlocks setObject:[changeBlock copy] forKey:key];
}

- (void)removeChangeLanguageBlockForObject:(NSObject *)observer {
    NSString *key = [NSString stringWithFormat:@"%p", observer];
    
    [self.changedBlocks removeObjectForKey:key];
}

#pragma mark - Watchdog sender

- (void)sendNewLanguageByObservers {
    NSString *langID = self.currentLanguage;
    
    NSDictionary *changedBlocks = [self.changedBlocks copy];
    for (NSString *key in changedBlocks) {
        void (^changedBlock)(NSString *newLang) = changedBlocks[key];
        changedBlock( langID );
    }
}

#pragma mark - Language bundle

- (NSBundle *)bundle {
    return bundle;
}


@end
