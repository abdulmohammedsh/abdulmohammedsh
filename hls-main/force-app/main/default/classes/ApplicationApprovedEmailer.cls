global class ApplicationApprovedEmailer {
    @InvocableMethod 
    public static void applicationApproved(List<Application_Approval__c> aaList ){
        Application_Approval__c appApproval = aaList[0];
        //abdulmohammed@mulesoft.com
    	Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
        // query group members for ApplicationApprovers group
        // this could be changed to AnypointAdminGroup ( for instance)
        List<User> appApprovers = [SELECT User.Id, User.Email FROM User WHERE Id IN (SELECT UserOrGroupId FROM GroupMember WHERE Group.Name = 'ApplicationApprovers')];
        
        // interate through GroupMembers
        // 0030q00000VKKQKAA5 Abdul Portal Conta
        // 0050q000002zqR0AAI kevin user
        for(User approver : appApprovers){

        
            mail.setTargetObjectId(approver.id);
            // so replacing values
            //
            String body = '<div>SelectHealth Anypoint Administrator, <BR><BR>' 
                + 'API Access has been approved for the following Application: <BR><BR>'
                + '<div ">'
                + '<div style="display:flex; "><div style="flex:2; text-align:right; font-weight:bold;">Application Name:</div><div style="flex:4;"> ' + appApproval.Application_Name__c + '</div></div>'
                + '<div style="display:flex; "><div style="flex:2; text-align:right; font-weight:bold;">Developer:</div><div style="flex:4;"> ' + appApproval.First_Name__c + ' '  + appApproval.Last_Name__c + '</div></div>'
                + '<div style="display:flex; "><div style="flex:2; text-align:right; font-weight:bold;">Email:</div><div style="flex:4;"> ' + appApproval.Email__c + '</div></div>'
                + '<div style="display:flex; "><div style="flex:2; text-align:right; font-weight:bold;">Description:</div><div style="flex:4;"> ' + appApproval.Description__c + '</div></div>'
                + '<div style="display:flex; "><div style="flex:2; text-align:right; font-weight:bold;">Company:</div><div style="flex:4;"> ' + appApproval.Company__c  +'</div></div>'
            	+ '<div style="display:flex; "><div style="flex:6; margin-top:6px; font-weight:bold;">APIs Requested:</div></div>';
            	
            //
            //
            List<ApplicationApproval_CommunityAPI__c> joiners = [select id, Application_Approval__c,  
                                    CommunityApi__c,CommunityApi__r.Name 
                                    from ApplicationApproval_CommunityAPI__c
                                    where Application_Approval__c = :appApproval.Id];
            system.debug(joiners);
        for(ApplicationApproval_CommunityAPI__c j : joiners){
            body = body + '<div style="display:flex;"><div style="flex:6; margin-top:6px;">' + j.CommunityApi__r.Name + '</div></div>' ;
        }
        body = body + '</div>' ; 
            
        mail.setHtmlBody(body);
        mail.setBccSender(false); 
        mail.setUseSignature(false); 
        mail.setSenderDisplayName('Select Health API Portal Admin'); 
        mail.setSaveAsActivity(false); 
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        }
    }
}