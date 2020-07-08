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
#import "PostCell.h"

@interface HomeVC () <UITableViewDelegate, UITableViewDataSource>

// MARK: Outlets
@property (weak, nonatomic) IBOutlet UITableView *tableView;

// MARK: Properties
@property (strong, nonatomic) NSMutableArray *posts;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(getPosts) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    self.posts = [[NSMutableArray alloc] init];
    
    [self getPosts];
}

// MARK: Actions
- (IBAction)onLogout:(id)sender {
    [NSNotificationCenter.defaultCenter postNotificationName:@"didLogout" object:nil];
}

// MARK: Helpers
- (void)getPosts {
    // initialize query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query includeKey:@"author"];
    [query orderByDescending:@"createdAt"];
    query.limit = 20;
    
    JGProgressHUD *HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
    [HUD showInView:self.view];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError  *error) {
        if (posts != nil) {
            [self.posts removeAllObjects];
            for (Post *post in posts) {
                [self.posts addObject:post];
            }
            [HUD dismissAnimated:YES];
            [self.refreshControl endRefreshing];
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}

// MARK: TableView
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    Post *post = self.posts[indexPath.row];
    [cell setPostCell:post];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}


@end
