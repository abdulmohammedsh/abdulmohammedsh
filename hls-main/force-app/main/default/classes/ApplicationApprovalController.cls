public with sharing class ApplicationApprovalController {
    @AuraEnabled
    public static String registerApplication(String applicationName, List<String> communityAPIs, String firstName, String lastName, 
                String email,String company,String description) {
        try {
            system.debug('registerApplication');
            Application_Approval__c a = new Application_Approval__c();
            a.Application_Name__c = applicationName.trim();
            a.Email__c = email.trim();
            a.First_Name__c = firstName.trim();
            a.Last_Name__c = lastName.trim();
            a.Company__c = company.trim();
            a.Description__c = description.trim();
           
            insert a;
          	system.debug('app approval inserted');
            List<ApplicationApproval_CommunityAPI__c> joins = new List<ApplicationApproval_CommunityAPI__c>();
            for (String api : communityAPIs) {
    			ApplicationApproval_CommunityAPI__c ac = new ApplicationApproval_CommunityAPI__c();
                ac.Application_Approval__c = a.Id;
                ac.CommunityApi__c = api;
          		system.debug(api);
          		system.debug(a);
                joins.add(ac);
			}
            system.debug('before joins inserted...');
            insert joins;
            system.debug('apis inserted');
            
            // enter approval process from APEX
            // 
             Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
        	 req1.setComments('Submitting ACM Application Request for approval.');
         	 req1.setObjectId(a.id);
        
        	// Submit on behalf of a specific submitter
        		req1.setSubmitterId(UserInfo.getUserId()); 
        
        	// Submit the record to specific process and skip the criteria evaluation
        	req1.setProcessDefinitionNameOrId('Community_Application_Approval');
        	req1.setSkipEntryCriteria(true);
        
        	// Submit the approval request for the account
        	Approval.ProcessResult result = Approval.process(req1);
            
            return null;
        }
        catch (Exception ex) {
           
            return ex.getMessage();
        }
    }
    @AuraEnabled
    public static List<Map<String,String>> getAPIOptions(){
        List<acm_pkg__CommunityApi__c> apis =  [select acm_pkg__ApiId__c, acm_pkg__Name__c,acm_pkg__AssetType__c from acm_pkg__CommunityApi__c where acm_pkg__AssetType__c = 'api-group'];
        List<Map<String,String>> options = new List<Map<String,String>>();
        for(integer i=0;i<apis.size();i++)
        {
            options.add(new Map<String,String>{'value' => apis[i].id, 'label' => apis[i].acm_pkg__Name__c});  
        }
        return options;
    }
   
}