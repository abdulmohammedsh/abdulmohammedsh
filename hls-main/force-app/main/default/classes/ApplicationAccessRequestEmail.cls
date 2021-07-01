public without sharing class ApplicationAccessRequestEmail {
    
    @TestVisible private static String testRecipient {get; set;}
    
    /**
     * Email template to service now
     * @param customerInfo The customer information
     * @return response whether the method succeeds or fails
     */
    public static String sendEmailRequest(Map<String, String> requestInfoMap){
        try {
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            Id addressId = getOrgWideAddress(requestInfoMap);
            System.debug(addressId);
            if (addressId != null) {
                mail.setOrgWideEmailAddressId(addressId);
            }
            String descriptionString = '';
            for (String requestInfoKey : requestInfoMap.keySet()) {
                if (!(requestInfoKey.startsWith('SH-') || requestInfoKey.contains('Enter'))) {
                	descriptionString += requestInfoKey + ' : ' + requestInfoMap.get(requestInfoKey) + ' | ';
                }
            }
            mail.setSubject('Intermountain Inbound');
            List<String> recipientEmail = Test.isRunningTest() ? new List<String>{testRecipient} : new List<String>{requestInfoMap.get('SH-ServiceNow-Email-Label')};
            System.Debug('@@@recipientEmail: ' + recipientEmail);
            mail.setToAddresses(recipientEmail);
            String body = ''
                + '<div style="display:flex; "><div style="flex:2; text-align:right; font-weight:bold;">Customer:</div>&nbsp;<div style="flex:4;">' + UserInfo.getName() + '</div></div>'
                + '<div style="display:flex; "><div style="flex:2; text-align:right; font-weight:bold;">Contact Information:</div>&nbsp;<div style="flex:4;">' + UserInfo.getUserEmail() + '</div></div>'
                + '<div style="display:flex; "><div style="flex:2; text-align:right; font-weight:bold;">Short Description:</div>&nbsp;<div style="flex:4;">' + requestInfoMap.get('SH-ServiceNow-ShortDesc-Label') + '</div></div>'
                + '<div style="display:flex; "><div style="flex:2; text-align:right; font-weight:bold;">Assignment Group:</div>&nbsp;<div style="flex:4;">' + requestInfoMap.get('SH-ServiceNow-AssignmentGroup-Label') + '</div></div>'
                + '<div style="display:flex; "><div style="flex:2; text-align:right; font-weight:bold;">PHI:</div>&nbsp;<div style="flex:4;">No</div></div>'
                + '<div style="display:flex; "><div style="flex:2; text-align:right; font-weight:bold;">Priority:</div>&nbsp;<div style="flex:4;">Medium</div></div>'
                + '<div style="display:flex; "><div style="flex:2; text-align:right; font-weight:bold;">CI:</div>&nbsp;<div style="flex:4;">' + requestInfoMap.get('SH-ServiceNow-CI-Label') + '</div></div>'
                + '<div style="display:flex; "><div style="flex:2; text-align:right; font-weight:bold;">Category:</div>&nbsp;<div style="flex:4;">Software</div></div>'
                + '<div style="display:flex; "><div style="flex:2; text-align:right; font-weight:bold;">Subcategory:</div>&nbsp;<div style="flex:4;">Information</div></div>'
                + '<div style="display:flex; "><div style="flex:2; text-align:right; font-weight:bold;">Symptom:</div>&nbsp;<div style="flex:4;">Configuration</div></div>'
                + '<div style="display:flex; "><div style="flex:2; text-align:right; font-weight:bold;">Description:</div><br/><div style="flex:4;">' + '{' + descriptionString + ' DateSubmitted : ' + String.valueOf(DateTime.now()) + '}' + '</div></div>';
            mail.setHtmlBody(body);
            Messaging.SendEmailResult[] result = Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{mail}, false);
            String returnMessage='';
            if (result[0].isSuccess()) {
                returnMessage = 'SUCCESS';
            } else{
                for (Messaging.SendEmailError error : result[0].getErrors()){
                    returnMessage += error.getMessage()+'; ';
                }
            }
            return returnMessage;
        }
        catch(Exception ex){
            return ex.getMessage();
        }
    }
    
    /**
     * Email template for acknowledgement of Interoperability API access request.
     * @param customer The customer information
     * @return response whether the method succeeds or fails
     */
    public static String sendAcknowledgementEmail(Map<String,String> requestInfoMap) {
        try {
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            Id addressId = getOrgWideAddress(requestInfoMap);
            if (addressId != null) {
                mail.setOrgWideEmailAddressId(addressId);
            }
            
            String descriptionString = '';
            for (String requestInfoKey : requestInfoMap.keySet()) {
                descriptionString += requestInfoKey + ' : ' + requestInfoMap.get(requestInfoKey) + '<br/>';
            }
            mail.setSubject('SelectHealth received your API access request');
            List<String> recipientEmail = Test.isRunningTest() ? new List<String>{testRecipient} : new List<String>{requestInfoMap.get('Developer Contact Email')};
            System.Debug('@@@recipientEmail: ' + recipientEmail);
            mail.setToAddresses(recipientEmail);
            String body = ''
                + '<div style="display:flex; ">Dear ' + UserInfo.getName() + ',</div></div> <br/>'
                + '<div style="display:flex; ">Thank you for submitting the request to gain access to SelectHealth\'s Interoperability APIs. SelectHealth will review your request in a timely manner and send you further information and instructions for accessing SelectHealth\'s Interoperability APIs.</div> <br/>'
                + '<div style="display:flex; ">If you have further questions, please email &nbsp;' + requestInfoMap.get('SH-Dev-Support-Email_Label') + '.</div><br/>'
                + '<div style="display:flex; ">The information you provided:</div> <br/>' 
                + '<div>' + descriptionString + ' DateSubmitted : ' + String.valueOf(DateTime.now()) + '</div>';
            mail.setHtmlBody(body);
            Messaging.SendEmailResult[] result = Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{mail}, false);
            String returnMessage = '';
            if (result[0].isSuccess()) {
                returnMessage = 'SUCCESS';
            } else{
                for (Messaging.SendEmailError error : result[0].getErrors()) {
                    returnMessage += error.getMessage()+'; ';
                }
            }
            return returnMessage;
        }
        catch(Exception ex){
            return ex.getMessage();
        }
    }
    
    /**
     * Get an org-wide email address related to SH_Dev_Support_Email_Label
     * @param N/A
     * @return N/A
     */
    private static Id getOrgWideAddress(Map<String,String> requestInfoMap){
        System.debug(requestInfoMap.get('SH-Dev-Support-Email_Label'));
        List<OrgWideEmailAddress> addresses = [SELECT Id FROM OrgWideEmailAddress WHERE Address ='pauloezekiel.dignos@simplus.com'/*: requestInfoMap.get('SH-Dev-Support-Email_Label')*/];
        return addresses.size() > 0 ? addresses[0].Id : null;
    }
}