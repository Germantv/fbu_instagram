//
//  PostCell.m
//  instagram
//
//  Created by German Flores on 7/7/20.
//  Copyright © 2020 German Flores. All rights reserved.
//

#import "PostCell.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPostCell:(Post *)post {
    self.post = post;
    
    self.postImageView.file = post[@"image"];
    [self.postImageView loadInBackground];
    [self.postImageView sizeToFit];
    
    self.authorImageView.file = post[@"image"];
    [self.authorImageView loadInBackground];
    self.authorImageView.layer.cornerRadius = self.authorImageView.frame.size.height / 2;
    
    self.captionLabel.text = post[@"caption"];
    self.authorTopLabel.text = post.author.username;
    self.authorBottomLabel.text = post.author.username;
    
    NSDate *timeStamp = [self.post createdAt];
    NSLog(@"%@", timeStamp);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
    [formatter setDateFormat:@"h:mm a"];
    self.timestampLabel.text = [formatter stringFromDate:timeStamp];
}

@end
