//
//  ViewController.m
//  ALLocalizedExample
//
//  Created by Lobanov Aleksey on 30.04.14.
//  Copyright (c) 2014 Lobanov Aleksey. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *changeLangBtn;

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(updateTitles:)
               name:ALLocalizedManagerChangeLangNotification
             object:nil];
    
    [self updateTitles:nil];
}

- (void) updateTitles:(NSNotification*) notify {
    [_changeLangBtn setTitle:ALLocalizedString(@"Change_language", @"Изменить язык")
                    forState:UIControlStateNormal ];
    [_titleLabel setText:ALLocalizedString(@"Hello", @"Привет мир")];
}

- (IBAction) changeLanguage:(UIButton *) button {
    NSInteger index = (ALLocalizationGetLanguageIndex == 0)?1:0;
    ALLocalizationSetLanguageByIndex(index);
    ALLocalizationThrowNotification;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
