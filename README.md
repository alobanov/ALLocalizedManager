ALLocalizedManager
==================

Simple localized manager

## Introduction

Sometimes we need to change language of application "on fly", without changing device locale. This manager very helpfull for this purpose

## Overview

1. You can simple usage ALLocalizedString(key, comment) like are NSLocalizedString(key, comment)
2. Or use you own table
3. Plural support with awesone TTTLocalizedPluralString

## Usage

Read article at [alobanov.github.io](http://lobanov-av.ru/libs/2014/01/07/2014-ALLocalizedManager.html)

### Settings up

1. In your AppDelegate file you configure manager

```objectiv-c
    [[ALLocalizedManager sharedInstance] setLanguages:@[ @{@"ru": @"Русский"}, @{@"en": @"English"}, @{@"pt-PT": @"Portugal"} ]];
    [[ALLocalizedManager sharedInstance] setDefaultLanguage:@"ru"];
```

2. After first running this manager uses default locale of device. Then user change language information stored at NSUserDefaults

3. You can change language by
```objectiv-c
    NSString *newLang = @"ru";
    ALLocalizationSetLanguage(newLang);
```

4. You can observe language changes by
```objectiv-c
    [[ALLocalizedManager sharedInstance] addChangeLanguageBlock:^(NSString *newLang) {
        [self updateTitles:nil];
        
    } forObject:self];
```

### Pluralization

For append plural rule to you project follow next steps

1. Add .strings file by default named LocalizablePlural

2. Append to file localizable plural rules like this
```
/* Murloc */
"%d Murloc (plural rule: one)" = "%d мурлок";
"%d Murloc (plural rule: few)" = "%d мурлока";
"%d Murloc (plural rule: many)" = "%d мурлоков";
"%d Murloc (plural rule: other)" = "%d мурлока";
```

3. Use plural like this
```objectiv-c
    NSString *pluralString = ALLocalizedPluralString(@"Murloc", 4, nil);
```
