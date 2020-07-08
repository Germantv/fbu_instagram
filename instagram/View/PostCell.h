//
//  PostCell.h
//  instagram
//
//  Created by German Flores on 7/7/20.
//  Copyright © 2020 German Flores. All rights reserved.
//

#import <Parse/Parse.h>
#import "PFImageView.h"
#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell

// MARK: Properties
@property (strong, nonatomic) Post *post;

//MARK: Outlets
@property (weak, nonatomic) IBOutlet PFImageView *authorImageView;
@property (weak, nonatomic) IBOutlet UILabel *authorTopLabel;
@property (weak, nonatomic) IBOutlet PFImageView *postImageView;
@property (weak, nonatomic) IBOutlet UILabel *authorBottomLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;

// MARK: Methods
- (void)setPostCell:(Post *)post;

@end

NS_ASSUME_NONNULL_END
