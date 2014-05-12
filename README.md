ALLocalizedManager
==================

Simple localized manager

## Usage

At first add init in appdelegate
```objective-c
// Localized init
ALLocalizedInit;
```
then add notification for observed change lang event
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
### Methods
```objective-c
ALLocalizedInit

ALLocalizationSetLanguageByIndex(language)
ALLocalizationSetLanguage(language)
ALLocalizationGetLanguage
ALLocalizationGetNameLanguage
ALLocalizationGetLanguageIndex
ALLocalizationReset
ALLocalizationThrowNotification
ALLocalizationResource(resource, type)
ALLocalizationImage(resource, type) 

// localized string
ALLocalizedString(key, comment)
ALLocalizedStringFromTable(key, comment, tableName)
```
