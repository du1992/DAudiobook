//
//  UIView+YSBlock.h
//  TemplateDemo
//
//  Created by 谷硕 on 16/1/19.
//  Copyright © 2016年 sure. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YSBlock)<UIAlertViewDelegate,UIActionSheetDelegate>

//UIAlertView
-(void)showWithCompletionHandler:(void (^)(NSInteger buttonIndex))completionHandler;

//UIActionSheet
-(void)showInView:(UIView *)view withCompletionHandler:(void (^)(NSInteger buttonIndex))completionHandler;

-(void)showFromToolbar:(UIToolbar *)view withCompletionHandler:(void (^)(NSInteger buttonIndex))completionHandler;

-(void)showFromTabBar:(UITabBar *)view withCompletionHandler:(void (^)(NSInteger buttonIndex))completionHandler;

-(void)showFromRect:(CGRect)rect
             inView:(UIView *)view
           animated:(BOOL)animated
withCompletionHandler:(void (^)(NSInteger buttonIndex))completionHandler;

-(void)showFromBarButtonItem:(UIBarButtonItem *)item
                    animated:(BOOL)animated
       withCompletionHandler:(void (^)(NSInteger buttonIndex))completionHandler;
@end


/*使用方法
 UIImagePickerController *controller = [[[UIImagePickerController alloc] init] autorelease];
 controller.allowsEditing = YES;
 [controller presentFromController:self
 onPhontePicked:^(UIImage *chosenImage) {
 NSLog(@"%@",NSStringFromCGSize(chosenImage.size));
 } onCancel:^{
 NSLog(@"canceled");
 }];
 */
typedef void (^YSCancelBlock)();
typedef void (^YSPhotoPickedBlock)(UIImage *chosenImage);

@interface UIImagePickerController(YSBlock)<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

+ (void)photoPickerSelectTypeAndShowWithPresentVC:(UIViewController *)presentVC
                                   onPhontePicked:(YSPhotoPickedBlock)photoPicked
                                         onCancel:(YSCancelBlock)cancelled;
+ (UIImagePickerController *)photoPickerWithSourceType:(UIImagePickerControllerSourceType)type
                                             presentVC:(UIViewController *)presentVC
                                        onPhontePicked:(YSPhotoPickedBlock)photoPicked
                                              onCancel:(YSCancelBlock)cancelled;
- (void)presentFromController:(UIViewController *)presentVC
               onPhontePicked:(YSPhotoPickedBlock)photoPicked
                     onCancel:(YSCancelBlock)cancelled;


@property (nonatomic, copy) YSPhotoPickedBlock photoPickedBlock;
@property (nonatomic, copy) YSCancelBlock cancelBlock;

@end