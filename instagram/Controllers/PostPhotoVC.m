//
//  PostPhotoVC.m
//  instagram
//
//  Created by German Flores on 7/6/20.
//  Copyright © 2020 German Flores. All rights reserved.
//

#import "PostPhotoVC.h"
#import <Parse/Parse.h>
#import "JGProgressHUD.h"
#import "Post.h"

@interface PostPhotoVC () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

// MARK: Properties
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UITextField *captionField;

@end

@implementation PostPhotoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createImagePicker];
}

// MARK: Actions
- (IBAction)onUploadPhoto:(id)sender {
    NSLog(@"Loading images...");
    [self createImagePicker];
}

- (IBAction)onPost:(id)sender {
    if (![self.photoImageView.image isEqual:[UIImage imageNamed:@"image_placeholder"]]) {
        JGProgressHUD *HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
        HUD.textLabel.text = @"Posting";
        [HUD showInView:self.view];
        
        [Post postUserImage:self.photoImageView.image withCaption:self.captionField.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
            if (succeeded) {
                self.photoImageView.image = [UIImage imageNamed:@"image_placeholder"];
                [HUD dismissAnimated:YES];
            }
            else {
                NSLog(@"Failed to post");
                // Create an alert
            }
            [self performSegueWithIdentifier:@"homeFromPostVC" sender:nil];
        }];
    }
    else {
        NSLog(@"No image to upload");
    }
}

- (IBAction)onCancel:(id)sender {
    [self clearUI];
    
    [self performSegueWithIdentifier:@"homeFromPostVC" sender:nil];
    
}

// MARK: ImagePicker
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    // Get the image captured by the UIImagePickerController
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    // Do something with the images (based on your use case)
    self.photoImageView.image = [self resizeImage:editedImage withSize:CGSizeMake(220, 220)];
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

// MARK: Helpers
- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void)createImagePicker {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (void)clearUI {
    self.photoImageView.image = [UIImage imageNamed:@"image_placeholder"];
    self.captionField.text = @"";
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}


@end
