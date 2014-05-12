ALLocalizedManager
==================

Simple localized manager

## Usage

At first add init in appdelegate
```objective-c
// Localized init
ALLocalizedInit;
```
Then add the notification for observing language
```objective-c
NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(changeAppLanguage:)
               name:ALLocalizedManagerChangeLangNotification
             object:nil];
             
-(void) updateTitles:(NSNotification*) notify {
    NSLog(ALLocalizedString(@"Change_language", @"Изменить язык"));
                    forState:UIControlStateNormal ];
    NSLog(ALLocalizedString(@"Hello", @"Привет мир"));
    NSLog(ALLocalizedStringFromTable(@"Current_lang", @"Русский", @"examplePlist"));
}
```
### Settings language
Selection logic first language:
At first see device lang. If device lang not in list take lang mark as isDefault key.

Example of lang array:
```objective-c
#pragma mark - Lang
- (NSArray *) languageList {
    return @[@{@"ru": @"Русский", @"isDefault":@"YES"},
             @{@"en": @"English"},
             @{@"es": @"Spanish"}];
}
```

### Methods
```objective-c
// init localized manager
ALLocalizedInit

// Update current index by index 
ALLocalizationSetLanguageByIndex(language)

// set language (example "ru","en")
ALLocalizationSetLanguage(language)

// return "ru","en" and etc.
ALLocalizationGetLanguage

// Full name of lang
ALLocalizationGetNameLanguage

// take current index selected language
ALLocalizationGetLanguageIndex

// reset all by default
ALLocalizationReset

// after selecting language you can throw notice
ALLocalizationThrowNotification

// localized images
ALLocalizationResource(resource, type)
ALLocalizationImage(resource, type) 

// localized string
ALLocalizedString(key, comment)
ALLocalizedStringFromTable(key, comment, tableName)
```
