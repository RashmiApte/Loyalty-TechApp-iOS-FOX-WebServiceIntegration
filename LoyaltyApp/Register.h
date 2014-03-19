//
//  Register.h
//  LoyaltyApp
//
//  Created by Ajeet Sharma on 3/10/14.
//
//

#import <UIKit/UIKit.h>

@interface Register : UIViewController <UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate>{
    
    NSMutableArray *arrayPickerView;
    NSMutableArray *arrayGender;
    
    
    UIScrollView *scrollViewRegister;
    
    UITextField *txtFirstName;
    UITextField *txtLastName;
    UITextField *txtEmailId;
    UITextField *txtPassword;
    UITextField *txtConfermPassword;
    UITextField *txtDOB;
    UITextField *txtGender;
    
    
    UILabel *lblBorderFirstName;
    UILabel *lblBorderLastName;
    UILabel *lblBorderEmailId;
    UILabel *lblBorderPassword;
    UILabel *lblBorderConfermPassword;
    UILabel *lblBorderDOB;
    UILabel *lblBorderGender;
    
    
    UIButton *btnBack;
    UIButton *btnRegister;
    
    UIButton *btnOpenDatePicker;
    UIButton *btnOpenGenderPicker;
    
    
    UIImageView *imgProfilePic;
    
    //-------------------- Pickerview -------------------//
    
    UIView *viewPickerView;
    
    UIDatePicker *datePicker;
    UIPickerView *pickerGender;
    
    UIButton *btnClosePicker;
    UIButton *btnDonePicker;
    
    NSDateFormatter *dateFormat;
    
    //--------------------------------------------------- //
    
    
}

@property(strong,nonatomic) IBOutlet UILabel *lblBorderFirstName;
@property(strong,nonatomic) IBOutlet UILabel *lblBorderLastName;
@property(strong,nonatomic) IBOutlet UILabel *lblBorderEmailId;
@property(strong,nonatomic) IBOutlet UILabel *lblBorderPassword;
@property(strong,nonatomic) IBOutlet UILabel *lblBorderConfermPassword;
@property(strong,nonatomic) IBOutlet UILabel *lblBorderDOB;
@property(strong,nonatomic) IBOutlet UILabel *lblBorderGender;

@property(strong,nonatomic) IBOutlet UIScrollView *scrollViewRegister;

@property(strong,nonatomic) IBOutlet UITextField *txtFirstName;
@property(strong,nonatomic) IBOutlet UITextField *txtLastName;
@property(strong,nonatomic) IBOutlet UITextField *txtEmailId;
@property(strong,nonatomic) IBOutlet UITextField *txtPassword;
@property(strong,nonatomic) IBOutlet UITextField *txtConfermPassword;
@property(strong,nonatomic) IBOutlet UITextField *txtDOB;
@property(strong,nonatomic) IBOutlet UITextField *txtGender;

@property(strong,nonatomic) IBOutlet UIImageView *imgProfilePic;


//-------------------- Pickerview -------------------//

@property(strong,nonatomic) IBOutlet UIView *viewPickerView;
@property(strong,nonatomic) IBOutlet UIDatePicker *datePicker;
@property(strong,nonatomic) IBOutlet UIPickerView *pickerGender;
@property(strong,nonatomic) IBOutlet UIButton *btnClosePicker;
@property(strong,nonatomic) IBOutlet UIButton *btnDonePicker;

//--------------------------------------------------- //

- (BOOL) validateEmail: (NSString *) candidate;
-(BOOL)validPassword:(NSString*)password;

-(void)createScrollview;
-(IBAction)pickerClosePicker:(id)sender;
-(IBAction)pickerDonePicker:(id)sender;

- (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size ;
-(UIImage*)imageWithImage: (UIImage*) sourceImage scaledToWidth: (float) i_width;
-(NSString *)Base64Encode:(NSData *)theData;

-(BOOL)validation;

@end
