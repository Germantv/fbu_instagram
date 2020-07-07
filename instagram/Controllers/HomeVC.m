//
//  HomeVC.m
//  instagram
//
//  Created by German Flores on 7/6/20.
//  Copyright © 2020 German Flores. All rights reserved.
//

#import "HomeVC.h"
#import <Parse/Parse.h>
#import "JGProgressHUD.h"

@interface HomeVC ()

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

// MARK: Actions
- (IBAction)onLogout:(id)sender {
    [NSNotificationCenter.defaultCenter postNotificationName:@"didLogout" object:nil];
}



#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}


@end
