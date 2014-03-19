//
//  CampaginDetailViewController.m
//  LoyaltyApp
//
//  Created by ankit on 2/28/14.
//
//

#import "CampaginDetailViewController.h"
#import "Constant.h"

@interface CampaginDetailViewController ()
{
    NSInteger containerHeight;
    NSInteger firstsectionFlag;
    NSInteger secondsectionFlag;
    NSInteger thirdsecvtionflag;
}

@property(strong,nonatomic)NSMutableArray *arryfirstsection;
@property(strong, nonatomic)NSMutableArray *arrysecondsection;
@property(strong,nonatomic)NSMutableArray *arrythirdsection;

@property(strong,nonatomic)NSMutableArray *arrydata;

@property(strong,nonatomic)NSString *strFirstsection;
@property(strong,nonatomic)NSString *strSecondsection;
@property(strong,nonatomic)NSString *strThirdsection;
@property(strong,nonatomic)NSString *strFourthsection;

@end

@implementation CampaginDetailViewController
@synthesize tablecampagindetail;
@synthesize arryfirstsection,arrysecondsection,arrythirdsection;
@synthesize strFirstsection,strSecondsection,strThirdsection,strFourthsection;





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
    
    arryfirstsection=[[NSMutableArray alloc] initWithObjects:@"inr",nil];
    arrysecondsection=[[NSMutableArray alloc] initWithObjects:@"inr",nil];
    arrythirdsection=[[NSMutableArray alloc]initWithObjects:@"inr", nil];
    
    
    strFirstsection=@"hello";
    strSecondsection=@"Terms and condition Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
    strThirdsection=@"About usLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
    
    self.tablecampagindetail.backgroundColor=[UIColor clearColor];
    [self hideEmptySeparators];
    
    
    
    //---------------------- Back button -----------------------------
    
	UIButton *btnBack =  [UIButton buttonWithType:UIButtonTypeCustom];
    [btnBack setBackgroundImage:[UIImage imageNamed:@"button_home_60_29.png"] forState:UIControlStateNormal];
	[btnBack addTarget:self action:@selector(BacktoView) forControlEvents:UIControlEventTouchUpInside];
    btnBack.titleLabel.font = [UIFont fontWithName:labelmediumFont size:(14.0)];
    [btnBack.titleLabel setTextColor:btntextColor];
    [btnBack setTitle:@"Back" forState:UIControlStateNormal];
	[btnBack setFrame:CGRectMake(5,7, 60, 29)];
    
    
    //--------------------- Design heder of This screen --------------
    
    CGRect re= CGRectMake(0, 0, 320, 53);
    UIImageView* img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_back.png"]];//create_new_ac_back.png
    UILabel *lbl =[[UILabel alloc]init];
    CGRect lblrect= CGRectMake(98,10, 180, 23);// 73, 10, 142, 23
    lbl.frame=lblrect;
    lbl.text=@"Campaign Detail";
    [lbl setTextColor:headertitletextColor];
    lbl.font = [UIFont fontWithName:labelregularFont size:(22.0)];
    lbl.backgroundColor=[UIColor clearColor];
    
    [img addSubview:lbl];
    img.frame=re;
    
    [self.view addSubview:img];
    [self.view addSubview:btnBack];
    // [self.view addSubview:btnSubmit];
    //----------------------------------------------------------------
    //--------------------SetFrameForIphone4AndIphone5-----------------
    if ([UIScreen mainScreen].bounds.size.height==568) {
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f) {
            
            self.tablecampagindetail.frame=CGRectMake(0,50, 320, 500);
        }
        else{
            self.tablecampagindetail.frame=CGRectMake(0,48, 320, 541);
        }
    }
    else{
        NSLog(@"value of active campagin");
    }
    
    
    // Do any additional setup after loading the view from its nib.
}

-(void)BacktoView
{
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
#pragma mark - Table view delegate methode

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==0)
    {
        return 0.0;
    }else{
        if(section==1)
        {
            return 0.0;
        }
        if(section==2)
        {
            return 0.0;
        }
    }
    return 0.0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rowCount;
    
    NSLog(@"array count=%lu",(unsigned long)[arryfirstsection count]);
    rowCount = [self returnNumberofRow:section];
    // Return the number of rows in the section.
    NSLog(@"row counrti s%ld",(long)rowCount);
    return rowCount;
}
-(NSInteger)returnNumberofRow:(NSInteger)tablesection
{
    NSInteger rowCount;
    switch (tablesection)
    {
        case 1:
            NSLog (@"validity");
            rowCount=[arryfirstsection count];
            break;
        case 2:
            NSLog (@"Terms and condition");
            rowCount=[arrysecondsection count];
            break;
        case 3:
            NSLog (@"About us");
            rowCount=[arrythirdsection count];
            break;
        default:
            rowCount=1;
            break;
    }
    return rowCount;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger rowheight;
    
    if ([indexPath section]==0) {
        rowheight=80;
    }
    if([indexPath section]==1){
        
        if([indexPath row]==0)
            rowheight=40;
        else{
            rowheight=containerHeight;
        }
    }
    if([indexPath section]==2)
    {
        if([indexPath row]==0)
            rowheight=40;
        else
            rowheight=containerHeight;
    }
    
    if([indexPath section]==3)
    {
        if([indexPath row]==0)
            rowheight=40;
        
        else
            rowheight=containerHeight;
    }
    return rowheight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UITableViewCell *profileMenuCell=[tableView dequeueReusableCellWithIdentifier:nil];
    if(profileMenuCell==nil){
        profileMenuCell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    for (UIView *view in profileMenuCell.contentView.subviews){
        [view removeFromSuperview];
    }
    if([indexPath section]==0)
    {
        UILabel *lblCampaginname=[[UILabel alloc]initWithFrame:CGRectMake(87,9, 226,55)];
        UIImageView *imgCampagin=[[UIImageView alloc]initWithFrame:CGRectMake(9,9,59,55)];
        imgCampagin.image=[UIImage imageNamed:@"noimage.png"];
        lblCampaginname.text=@"Campaign Name";
        lblCampaginname.font=[UIFont fontWithName:labelregularFont size:(18.0)];
        [lblCampaginname setBackgroundColor:[UIColor clearColor]];
        lblCampaginname.textColor=labelTransactionListTitle;
	 	lblCampaginname.textAlignment = NSTextAlignmentLeft;
        [profileMenuCell.contentView addSubview:lblCampaginname];
        [profileMenuCell.contentView addSubview:imgCampagin];
    }
    if([indexPath section]==1){
        if([indexPath row]==0){
            
            //------------------Validity image-------------------
            UIImageView *imgvaliditylogo=[[UIImageView alloc]initWithFrame:CGRectMake(9,12,20,20)];
            imgvaliditylogo.image=[UIImage imageNamed:@"aboutus.png"];
            [profileMenuCell.contentView addSubview:imgvaliditylogo];
            //------------------UP  and bottom image---------------------
            UIImageView *imgbotumuplogo=[[UIImageView alloc]initWithFrame:CGRectMake(285,12, 20,20)];
            imgbotumuplogo.image=[UIImage imageNamed:@"downarrow.png"];
            [profileMenuCell.contentView addSubview:imgbotumuplogo];
            profileMenuCell.accessoryView=imgbotumuplogo;
            //------------------row title lable--------------------------
            UILabel *lblvalidity=[[UILabel alloc]initWithFrame:CGRectMake(50,11,175, 21)];
            lblvalidity.text=@"Validity";
            lblvalidity.font=[UIFont fontWithName:labelregularFont size:(18.0)];
            [lblvalidity setBackgroundColor:[UIColor clearColor]];
            lblvalidity.textColor=labelTransactionListTitle;
            lblvalidity.textAlignment = NSTextAlignmentLeft;
            [profileMenuCell.contentView addSubview:lblvalidity];
            
        }else{
            UILabel *lblstardate=[[UILabel alloc]initWithFrame:CGRectMake(10,0,100,20)];
            UILabel *lblenddate=[[UILabel alloc]initWithFrame:CGRectMake(10,20,80,40)];
            lblenddate.text=@"End Date:";
            lblstardate.text=@"Start Date:";
            [profileMenuCell.contentView addSubview:lblstardate];
            [profileMenuCell.contentView addSubview:lblenddate];
            [lblstardate setNumberOfLines:0];
            [lblstardate sizeToFit];
            [lblstardate setFont:[UIFont systemFontOfSize:12]];
            
            [lblenddate setNumberOfLines:0];
            [lblenddate sizeToFit];
            [lblenddate setFont:[UIFont systemFontOfSize:12]];
            
            
            UILabel *lblstardatevalue=[[UILabel alloc]initWithFrame:CGRectMake(90,0,150,40)];
            UILabel *lblenddatevalue=[[UILabel alloc]initWithFrame:CGRectMake(90,20,150,40)];
            
            lblstardatevalue.text=@"20/12/2014";
            lblenddatevalue.text= @"12/12/2014";
            [profileMenuCell.contentView addSubview:lblstardatevalue];
            [profileMenuCell.contentView addSubview:lblenddatevalue];
            
            
            
            [lblstardatevalue setNumberOfLines:0];
            [lblstardatevalue sizeToFit];
            [lblstardatevalue setFont:[UIFont systemFontOfSize:12]];
            
            [lblenddatevalue setNumberOfLines:0];
            [lblenddatevalue sizeToFit];
            [lblenddatevalue setFont:[UIFont systemFontOfSize:12]];
            
            
            
            [profileMenuCell.textLabel setNumberOfLines:0];
            [profileMenuCell.textLabel sizeToFit];
            [profileMenuCell.textLabel setFont:[UIFont systemFontOfSize:12]];
        }
    }else{
        
        if([indexPath section]==2)
        {
            if([indexPath row]==0)
            {
                //---------------terms and condition leftside image ------------------------------
                UIImageView *imgaboutuslogo=[[UIImageView alloc]initWithFrame:CGRectMake(9,12,20,20)];
                imgaboutuslogo.image=[UIImage imageNamed:@"aboutus.png"];
                [profileMenuCell.contentView addSubview:imgaboutuslogo];
                
                //---------------terms and condition right image ------------------------------
                UIImageView *imgbotumuplogo=[[UIImageView alloc]initWithFrame:CGRectMake(285,12, 20,20)];
                imgbotumuplogo.image=[UIImage imageNamed:@"downarrow.png"];
                [profileMenuCell.contentView addSubview:imgbotumuplogo];
                profileMenuCell.accessoryView=imgbotumuplogo;
                
                //---------------Lable Terms and condition ------------------------------
                UILabel *lbltermsandcondition=[[UILabel alloc]initWithFrame:CGRectMake(50,11,175, 21)];
                lbltermsandcondition.text=@"Terms and condition";
                lbltermsandcondition.font=[UIFont fontWithName:labelregularFont size:(18.0)];
                lbltermsandcondition.textAlignment = NSTextAlignmentLeft;
                
                lbltermsandcondition.font=[UIFont fontWithName:labelregularFont size:(18.0)];
                [lbltermsandcondition setBackgroundColor:[UIColor clearColor]];
                lbltermsandcondition.textColor=labelTransactionListTitle;
                lbltermsandcondition.textAlignment = NSTextAlignmentLeft;
                [profileMenuCell.contentView addSubview:lbltermsandcondition];
            }
            else{
                profileMenuCell.textLabel.text=strSecondsection;
                [profileMenuCell.textLabel setNumberOfLines:0];
                [profileMenuCell.textLabel sizeToFit];
                [profileMenuCell.textLabel setFont:[UIFont systemFontOfSize:12]];
            }
            
        }
        else{
            if([indexPath section]==3)
            {
                if([indexPath row]==0)
                {
                    //-----------------------aboutus logo ----------------------------------
                    UIImageView *imgaboutuslogo=[[UIImageView alloc]initWithFrame:CGRectMake(9,12,20,20)];
                    imgaboutuslogo.image=[UIImage imageNamed:@"aboutus.png"];
                    [profileMenuCell.contentView addSubview:imgaboutuslogo];
                    //-----------------------aboutus drawerup and down --------------------------------------
                    UIImageView *imgbotumuplogo=[[UIImageView alloc]initWithFrame:CGRectMake(285,12,20,20)];
                    imgbotumuplogo.image=[UIImage imageNamed:@"downarrow.png"];
                    [profileMenuCell.contentView addSubview:imgbotumuplogo];
                    profileMenuCell.accessoryView=imgbotumuplogo;
                    
                    //-----------------------Aboutus title ------------------------------------------
                    UILabel *lblaboutus=[[UILabel alloc]initWithFrame:CGRectMake(50,11,175, 21)];
                    lblaboutus.text=@"About Us";
                    lblaboutus.font=[UIFont fontWithName:labelregularFont size:(18.0)];
                    lblaboutus.textColor=labelTransactionListTitle;
                    lblaboutus.textAlignment = NSTextAlignmentLeft;
                    [profileMenuCell.contentView addSubview:lblaboutus];
                }
                else{
                    profileMenuCell.textLabel.text=strThirdsection;
                    [profileMenuCell.textLabel setNumberOfLines:0];
                    [profileMenuCell.textLabel sizeToFit];
                    [profileMenuCell.textLabel setFont:[UIFont systemFontOfSize:12]];
                }
            }
        }
        
    }
    profileMenuCell.selectionStyle=UITableViewCellAccessoryNone;
    return profileMenuCell;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"value of third section flag is %ld",(long)thirdsecvtionflag);
    NSLog(@"value of firstsection flag us %ld",(long)firstsectionFlag);
    NSLog(@"value of second section flag is %ld",(long)secondsectionFlag);
    
    
    NSIndexPath* firstnewIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    UITableViewCell *firstcell = [tableView cellForRowAtIndexPath:firstnewIndexPath];
    UIImageView *imgfirstbotumuplogo=[[UIImageView alloc]initWithFrame:CGRectMake(285,12, 20,20)];
    imgfirstbotumuplogo.image=[UIImage imageNamed:@"downarrow.png"];
    
    
    NSIndexPath* secondnewIndexPath = [NSIndexPath indexPathForRow:0 inSection:2];
    UITableViewCell *secondcell = [tableView cellForRowAtIndexPath:secondnewIndexPath];
    UIImageView *imgsecondimgbotumuplogo=[[UIImageView alloc]initWithFrame:CGRectMake(285,12, 20,20)];
    imgsecondimgbotumuplogo.image=[UIImage imageNamed:@"downarrow.png"];
    
    
    
    NSIndexPath* thirdnewsection = [NSIndexPath indexPathForRow:0 inSection:3];
    UITableViewCell *thirdcell = [tableView cellForRowAtIndexPath:thirdnewsection];
    UIImageView *imgthirsimgbotumuplogo=[[UIImageView alloc]initWithFrame:CGRectMake(285,12, 20,20)];
    imgthirsimgbotumuplogo.image=[UIImage imageNamed:@"downarrow.png"];
    
    
    UITableViewCell *selectedcell = [tableView cellForRowAtIndexPath:indexPath];
    
    
    
    
    NSArray* subviews = [selectedcell.contentView subviews];
    
    NSLog(@"value of array is %@",subviews);
    if ([indexPath section]==1||[indexPath section]==2||[indexPath section]==3) {
        
        
        if([indexPath row]==0){
            NSMutableArray *tempArray = [[NSMutableArray alloc] init];
            [tempArray addObject:[NSIndexPath indexPathForRow:indexPath.row+1 inSection:[indexPath section]]];
            if([indexPath section]==1){
                if(firstsectionFlag){
                    firstsectionFlag=0;
                    firstcell.accessoryView=imgfirstbotumuplogo;
                    [arryfirstsection removeObjectAtIndex:indexPath.row];
                    [[self tablecampagindetail] beginUpdates];
                    [[self tablecampagindetail] deleteRowsAtIndexPaths:tempArray withRowAnimation:UITableViewRowAnimationFade];
                    UIImageView *imgbotumuplogo=[[UIImageView alloc]initWithFrame:CGRectMake(285,12, 20,20)];
                    imgbotumuplogo.image=[UIImage imageNamed:@"downarrow.png"];
                    selectedcell.accessoryView=imgbotumuplogo;
                    //temparry
                    [[self tablecampagindetail] endUpdates];
                }else{
                    //second cell remove
                    UIImageView *imgbotumuplogo=[[UIImageView alloc]initWithFrame:CGRectMake(285,12, 20,20)];
                    imgbotumuplogo.image=[UIImage imageNamed:@"uparrow.png"];
                    selectedcell.accessoryView=imgbotumuplogo;
                    
                    if(secondsectionFlag){
                        secondsectionFlag=0;
                        
                        secondcell.accessoryView=imgsecondimgbotumuplogo;
                        
                        NSMutableArray *tempArray1 = [[NSMutableArray alloc] init];
                        [tempArray1 addObject:[NSIndexPath indexPathForRow:indexPath.row+1 inSection:2]];
                        [[self tablecampagindetail] beginUpdates];
                        [arrysecondsection removeObjectAtIndex:1];
                        [[self tablecampagindetail] deleteRowsAtIndexPaths:tempArray1 withRowAnimation:UITableViewRowAnimationFade];
                        [[self tablecampagindetail] endUpdates];
                    }
                    if(thirdsecvtionflag)
                    {
                        thirdsecvtionflag=0;
                        
                        thirdcell.accessoryView=imgthirsimgbotumuplogo;
                        
                        NSMutableArray *tempArray1 = [[NSMutableArray alloc] init];
                        [tempArray1 addObject:[NSIndexPath indexPathForRow:indexPath.row+1 inSection:3]];
                        [[self tablecampagindetail] beginUpdates];
                        [arrythirdsection removeObjectAtIndex:1];
                        [[self tablecampagindetail] deleteRowsAtIndexPaths:tempArray1 withRowAnimation:UITableViewRowAnimationFade];
                        [[self tablecampagindetail] endUpdates];
                    }
                    int rowHeight =0.0f;
                    CGSize size=CGSizeMake(300,20);
                    rowHeight = size.height;
                    containerHeight=rowHeight+20;
                    firstsectionFlag=1;
                    [arryfirstsection insertObject:@"new row" atIndex:indexPath.row+1];
                    [[self tablecampagindetail] beginUpdates];
                    [[self tablecampagindetail] insertRowsAtIndexPaths:(NSArray *)tempArray withRowAnimation:UITableViewRowAnimationFade];
                    [[self tablecampagindetail] endUpdates];
                }
            }
            
            else{
                if([indexPath section]==2)
                {
                    if(secondsectionFlag){
                        secondsectionFlag=0;
                        
                        secondcell.accessoryView=imgsecondimgbotumuplogo;
                        [arrysecondsection removeObjectAtIndex:indexPath.row+1];
                        [[self tablecampagindetail] beginUpdates];
                        [[self tablecampagindetail] deleteRowsAtIndexPaths:tempArray withRowAnimation:UITableViewRowAnimationFade];
                        //temparry
                        [[self tablecampagindetail] endUpdates];
                        
                    }else{
                        //second cell remove
                        
                        
                        UIImageView *imgbotumuplogo=[[UIImageView alloc]initWithFrame:CGRectMake(285,12, 20,20)];
                        imgbotumuplogo.image=[UIImage imageNamed:@"uparrow.png"];
                        selectedcell.accessoryView=imgbotumuplogo;
                        if(firstsectionFlag){
                            firstsectionFlag=0;
                            firstcell.accessoryView=imgfirstbotumuplogo;
                            NSMutableArray *tempArray1 = [[NSMutableArray alloc] init];
                            [tempArray1 addObject:[NSIndexPath indexPathForRow:indexPath.row+1 inSection:1]];
                            [[self tablecampagindetail] beginUpdates];
                            
                            [arryfirstsection removeObjectAtIndex:1];
                            [[self tablecampagindetail] deleteRowsAtIndexPaths:tempArray1 withRowAnimation:UITableViewRowAnimationFade];
                            [[self tablecampagindetail] endUpdates];
                        }
                        if(thirdsecvtionflag){
                            thirdsecvtionflag=0;
                            thirdcell.accessoryView=imgthirsimgbotumuplogo;
                            NSMutableArray *tempArray1 = [[NSMutableArray alloc] init];
                            [tempArray1 addObject:[NSIndexPath indexPathForRow:indexPath.row+1 inSection:3]];
                            [[self tablecampagindetail] beginUpdates];
                            [arrythirdsection removeObjectAtIndex:1];
                            [[self tablecampagindetail] deleteRowsAtIndexPaths:tempArray1 withRowAnimation:UITableViewRowAnimationFade];
                            [[self tablecampagindetail] endUpdates];
                        }
                        
                        int rowHeight =0.0f;
                        CGSize size = [self.strSecondsection  sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(300, 5000) lineBreakMode:NSLineBreakByWordWrapping];
                        rowHeight = size.height;
                        containerHeight=rowHeight+20;
                        secondsectionFlag=1;
                        [arrysecondsection insertObject:@"new row" atIndex:indexPath.row+1];
                        [[self tablecampagindetail] beginUpdates];
                        [[self tablecampagindetail] insertRowsAtIndexPaths:(NSArray *)tempArray withRowAnimation:UITableViewRowAnimationFade];
                        [[self tablecampagindetail] endUpdates];
                    }
                }
                if([indexPath section]==3)
                {
                    
                    
                    if(thirdsecvtionflag){
                        thirdcell.accessoryView=imgthirsimgbotumuplogo;
                        UIImageView *imgbotumuplogo=[[UIImageView alloc]initWithFrame:CGRectMake(285,12, 20,20)];
                        imgbotumuplogo.image=[UIImage imageNamed:@"downarrow.png"];
                        selectedcell.accessoryView=imgbotumuplogo;
                        thirdsecvtionflag=0;
                        [arrythirdsection removeObjectAtIndex:indexPath.row+1];
                        [[self tablecampagindetail] beginUpdates];
                        [[self tablecampagindetail] deleteRowsAtIndexPaths:tempArray withRowAnimation:UITableViewRowAnimationFade];
                        [[self tablecampagindetail] endUpdates];
                    }else{
                        UIImageView *imgbotumuplogo=[[UIImageView alloc]initWithFrame:CGRectMake(285,12, 20,20)];
                        imgbotumuplogo.image=[UIImage imageNamed:@"uparrow.png"];
                        selectedcell.accessoryView=imgbotumuplogo;
                        if(firstsectionFlag){
                            firstsectionFlag=0;
                            firstcell.accessoryView=imgfirstbotumuplogo;
                            
                            NSMutableArray *tempArray1 = [[NSMutableArray alloc] init];
                            [tempArray1 addObject:[NSIndexPath indexPathForRow:indexPath.row+1 inSection:1]];
                            [[self tablecampagindetail] beginUpdates];
                            
                            [arryfirstsection removeObjectAtIndex:1];
                            [[self tablecampagindetail] deleteRowsAtIndexPaths:tempArray1 withRowAnimation:UITableViewRowAnimationFade];
                            [[self tablecampagindetail] endUpdates];
                            
                        }
                        if(secondsectionFlag)
                        {
                            secondsectionFlag=0;
                            secondcell.accessoryView=imgsecondimgbotumuplogo;
                            UIImageView *imgbotumuplogo=[[UIImageView alloc]initWithFrame:CGRectMake(285,12, 20,20)];
                            imgbotumuplogo.image=[UIImage imageNamed:@"downarrow.png"];
                            selectedcell.accessoryView=imgbotumuplogo;
                            NSMutableArray *tempArray1 = [[NSMutableArray alloc] init];
                            [tempArray1 addObject:[NSIndexPath indexPathForRow:indexPath.row+1 inSection:2]];
                            [[self tablecampagindetail] beginUpdates];
                            
                            [arrysecondsection removeObjectAtIndex:1];
                            [[self tablecampagindetail] deleteRowsAtIndexPaths:tempArray1 withRowAnimation:UITableViewRowAnimationFade];
                            [[self tablecampagindetail] endUpdates];
                        }
                        int rowHeight =0.0f;
                        CGSize size = [strThirdsection sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(300, 5000) lineBreakMode:NSLineBreakByWordWrapping];
                        rowHeight = size.height;
                        //CGSize sizeOfText=[self getLabelHeightForIndex:strsecondtext];
                        containerHeight=rowHeight+20;
                        thirdsecvtionflag=1;
                        [arrythirdsection insertObject:@"new row" atIndex:indexPath.row+1];
                        [[self tablecampagindetail] beginUpdates];
                        [[self tablecampagindetail] insertRowsAtIndexPaths:(NSArray *)tempArray withRowAnimation:UITableViewRowAnimationFade];
                        [[self tablecampagindetail] endUpdates];
                    }
                    
                }
            }
        }
    }
    
    
    //cell selection remove
    if([indexPath row]==1){
        
        NSMutableArray *tempArray1 = [[NSMutableArray alloc] init];
        if(firstsectionFlag){
            [arryfirstsection removeObjectAtIndex:1];
            [tempArray1 addObject:[NSIndexPath indexPathForRow:indexPath.row inSection:1]];
            firstcell.accessoryView=imgfirstbotumuplogo;
            NSLog(@"inside a firstsection");
        }
        
        if(secondsectionFlag){
            [arrysecondsection removeObjectAtIndex:1];
            [tempArray1 addObject:[NSIndexPath indexPathForRow:indexPath.row inSection:2]];
            secondcell.accessoryView=imgsecondimgbotumuplogo;
            NSLog(@"inside a second");
        }
        if(thirdsecvtionflag)
        {
            [arrythirdsection removeObjectAtIndex:1];
            [tempArray1 addObject:[NSIndexPath indexPathForRow:indexPath.row inSection:3]];
            thirdcell.accessoryView=imgthirsimgbotumuplogo;
            NSLog(@"insice a third");
            
        }
        firstsectionFlag=0;
        secondsectionFlag=0;
        thirdsecvtionflag=0;
        
        [[self tablecampagindetail] beginUpdates];
        [[self tablecampagindetail] deleteRowsAtIndexPaths:tempArray1 withRowAnimation:UITableViewRowAnimationFade];
        [[self tablecampagindetail] endUpdates];
    }
    
    
    
    
    
}

- (void)hideEmptySeparators
{
    UIView *removesepratorview = [[UIView alloc] initWithFrame:CGRectZero];
    removesepratorview.backgroundColor = [UIColor clearColor];
    [tablecampagindetail setTableFooterView:removesepratorview];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
