




//pasword Alert

NSString* const passwordminimunlegnth= @"Password cannot be less than 8 characters and greater than 15 characters";
NSString* const alphanumericvalueinPWd= @"Password must contain atleast a digit.";
NSString* const alphanumericvalueinalphabet= @"Password must contain atleast a character.";
NSString* const passwordAtleastOneCaps=@"Password must contain atleast a uppercase letter";

NSString* const enterpwd=@"Please enter the Password.";
NSString* const reenterpwd=@"Please re-enter the password.";
NSString* const specialcharacterpwd=@"Please enter only alphabet and digits in the password.";
NSString* const bothpwdsame=@"The two passwords did not match. Please verify again.";
NSString* const enternewpwd=@"Please enter the new password.";
NSString* const enteroldpwd=@"Please enter the old password.";
NSString* const reenternewpwd=@"Please re-enter the new password.";


//sighn up
NSString* const successfullyregistered=@"You have been successfully registered.";
NSString* const Unabletosignuptitle= @"Unable to Sign Up";
NSString* const firstnameentr=@"Please enter the First Name.";
NSString* const lastnameentr=@"Please enter the Last Name.";
NSString* const emailentr=@"Please enter the Email Address.";

NSString* const enterCvv=@"Please enter the CVV / CSC.";
NSString* const entercardnumber=@"Please enter the Card Number.";
NSString* const entercardname=@"Please enter the Card Name.";

NSString* const enterpostcode=@"Please enter the Post Code.";
NSString* const enterstreetAdd1=@"Please enter the Street Address 1.";
NSString* const validemailid=@"Please enter the correct Email Address.";
NSString* const unablecurrencylist=@"Unable to get currency list from server.";
NSString* const Unablecountrylist=@"Unable to get country list from server.";
NSString* const secondryemail=@"Please enter the correct Secondary Email Address.";
NSString* const expirydate=@"Please enter the Expiry Date.";

//Cardholder Alert
NSString* const statuscode1=@"Please enter valid Email Address and Password \n[Error code:1].";
NSString* const statuscode4=@"[Error code:4].";
//NSString* const statuscode4=@"Please enter valid Email Address \n[Error code:4].";
NSString* const statuscode6=@"Unable to serve your request at present. Please try again later \n[Error code:6].";
NSString* const statuscode7=@"No records to display \n[Error code:7]";
NSString* const statuscode9=@"You have already been registered. Please login with the registered Email and Password \n[Error code:9].";
NSString* const statuscode12=@"Unable to serve your request at present. Please try again later \n[Error code:12].";
NSString* const statuscode15=@"Card could not be added at present. Please try again later \n[Error code:15].";
NSString* const statuscode16=@"Card could not be suspended. Please try again \n[Error code:16].";
NSString* const statuscode17=@"Card could not be reactivated. Please try again \n[Error code:17].";
NSString* const statuscode18=@"Card could not be deleted. Please try again \n[Error code:18].";
NSString* const statuscode21=@"The amount could not be transferred, possibly due to the balance in card is less than the amount entered \n[Error code:21].";
NSString* const statuscode27=@"Already Logged In. Do you want to logout and start new session? \n[Error code:27]";
NSString* const statuscode30=@"Card details could not be updated at present. Please try gain later \n[Error code:30].";
NSString* const statuscode33=@"Card could not be added, possibly due to incorrect card details entered or due to some reason from the bank \n[Error code:33].";

//Adnew card
NSString* const unabletoaddnewcard=@"Unable to Add Card";
NSString* const successfullyaddcard=@"Successfully Added.";
NSString* const cardholdername=@"Please enter the Cardholder Name.";
NSString* const invalideemail=@"Please enter the correct Email Address.";
NSString* const Cardnumberlegnth=@"Card number should not be more than 20 character.";
NSString*const  Invalidecardnumber=@"Invalid card number";

//updatecard
NSString* const unabletoupdatecard=@"Unable to Update";
NSString* const succesfulyupdate=@"Successfully Updated.";

NSString* const entercity =@"Please enter the City.";
NSString* const enterstreet=@"Please enter the Street.";
NSString* const entercountry=@"Please select the Country.";
NSString* const deliveryaddressupdatesuccessfully=@"Delivery Address Successfully Updated.";
NSString* const pwdupdatesuccessfully=@"Password Successfully Updated. Please login with the new password.";

//for virtual card creation
NSString* const cardcanbeactiveonemonth=@"The card can be active for 1 day and upto 1 month from the date created. Please enter a valid expiry date.";
NSString* const successfullycreated=@"Successfully Created";
NSString* const enteramountforvirtualcard=@"Please enter the amount for the virtual card.";
NSString* const amountlegnthlessthan9digit=@"Amount leghth less than 9 digit";
NSString* const entervirtualcardname=@"Please enter the Virtual Card Name";

//for resetpassword
NSString* const pleaseenterregisteremail=@"Please enter the registered Email Address.";
NSString* const newpwdhassendto=@"The new password has been sent to";
//loginhelp

NSString* const alreadyloginalert=@"Already Logged In. Do you want to logout and start new session?";
NSString* const unknownuserid=@"Please enter the Email Address registered with the application.";
NSString* const entercorrectidpwd=@"Please enter the Valid Email Address and Password.";
NSString* const unabletologinntitle=@"Unable to Login";

//problem occuring atserver
NSString* const problemoccuratserver=@"Problem occurred in making connection with the server. Please try again later.";
//Network Alert
NSString* const networkconnectiontitle=@"No Network Connection";
NSString* const networkconnectionmessage=@"This operation requires network connection. Please enable Internet connection on your mobile and try again.";
//hud alert
NSString* const dataupdatinghud=@"Updating. Please wait...";
NSString* const loginhud=@"Logging in. Please wait...";
NSString* const sighnuphud=@"Signing up. Please wait...";
NSString* const logouthud=@"Logging out. Please wait...";
NSString* const deletecardhud=@"Deleting. Please wait...";
NSString* const activatingcardhud=@"Reactivating. Please wait...";
NSString* const supendcardhud=@"Suspending. Please wait...";
NSString* const loadingaything=@"Loading. Please wait...";
NSString* const generatingcard=@"Generating the card. Please wait…";
NSString* const transferringardhud=@"Transferring. Please wait...";
// session expired Alert
NSString* const sessionexpired=@"Session Expired. Please login again.";
//MYcardoperation
NSString* const cardwillsuspend=@"The card will be suspended.";
NSString* const cardwilldelete=@"The card will be deleted.";
NSString* const cardwillreactivated=@"The card will be reactivated.";
NSString* const createvirtualcardfornonactivecard=@"Virtual card can be created only from an active card.";
NSString* const successfullysuspend=@"Successfully Suspended.";
NSString* const successfullyreactivated=@"Successfully Reactivated.";
NSString* const successfullydeleted=@"Successfully Deleted.";
NSString* const cardwilltransferred=@"Transfer card to another wallet account.";
NSString* const successfullyTransfer=@"Successfully Transferred.";

//logout
NSString* const logoutalert=@"Are you sure you want to logout?";
//setting country and currency
NSString* const countrycurrencysuccessfullysert=@"Country and Currency set Successfully.";

//reports

NSString *const startEndDateValidation=@"The start date should not be greater than the End date.";
NSString *const setStartEndDate=@"Please select both start and End the date.";
NSString* const selctvalidexpirydate=@"Expiry date should not be less than today.";


//transferred virtual card

NSString* const transferredvirtualcard=@"Virtual card cannot be transferred to the same wallet account.";






































