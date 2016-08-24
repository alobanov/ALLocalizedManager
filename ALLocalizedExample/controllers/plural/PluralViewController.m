//
//  PluralViewController.m
//  ALLocalizedExample
//
//  Created by Dmitry Avvakumov on 24.08.16.
//  Copyright © 2016 Lobanov Aleksey. All rights reserved.
//

#import "PluralViewController.h"

@interface PluralViewController ()

@property IBOutlet UILabel *textLabel;

@end

@implementation PluralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *strArr = [NSMutableArray arrayWithCapacity:10];
    for (int i = 1; i < 100; i++) {
        NSString *str = ALLocalizedPluralString(@"Murloc", i, nil);
        [strArr addObject:str];
    }
    
    self.textLabel.text = [strArr componentsJoinedByString:@"\n"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
