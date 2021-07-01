@IsTest
public class ApplicationAccessRequestControllerTest {
    @IsTest
    static void getAPIOptionsTest(){
        acm_pkg__CommunityApi__c communityAPIRec = new acm_pkg__CommunityApi__c();
        communityAPIRec.acm_pkg__ApiId__c = 'testCommunityAPI';
        communityAPIRec.acm_pkg__AssetVersion__c = '1';
        communityAPIRec.acm_pkg__VersionGroup__c = 'testVersion';
        communityAPIRec.acm_pkg__Visibility__c = 'Public';
        communityAPIRec.acm_pkg__Name__c = 'testCommunityAPI';
        communityAPIRec.acm_pkg__AssetType__c = 'api-group';
        insert communityAPIRec;
            
        Test.startTest();
        List<Map<String, String>> apiOptions = ApplicationAccessRequestController.getAPIOptions();
        Test.stopTest();
        
        System.assertNotEquals(apiOptions, null);
    }
    
    @IsTest
    static void getFieldLabelsTest(){
        Test.startTest();
        Map<String, String> fieldLabelMap = ApplicationAccessRequestController.getFieldLabels();
        Test.stopTest();
        
        System.assertNotEquals(fieldLabelMap, null);
    }
    
    @IsTest
    static void saveApplicationAccessRequestTest(){
        Application_Access_Request__c applicationAccessRequestRec = new Application_Access_Request__c();
        applicationAccessRequestRec.Select_APIs__c = 'Patient Access API';
        applicationAccessRequestRec.Application_Name__c = 'SelectHealth Application';
        applicationAccessRequestRec.Application_Description__c = 'Sample Description';
        applicationAccessRequestRec.Application_Release_Date__c = System.today();
        applicationAccessRequestRec.Developer_Contact_Name__c = 'Developer Name';
        applicationAccessRequestRec.Developer_Contact_Email__c = 'developer.name@email.com';
        applicationAccessRequestRec.Company_Name__c = 'SelectHealth';
        applicationAccessRequestRec.Company_URL__c = 'https://selecthealth.org';
        applicationAccessRequestRec.Company_Address__c = 'Salt Lake, Utah';
        applicationAccessRequestRec.Company_Primary_Contact__c = 'Developer Name';
        applicationAccessRequestRec.Company_Primary_Contact_Email__c = 'developer.name@email.com';
        applicationAccessRequestRec.Application_Redirect_URL_s__c = 'https://selecthealth.org';
        applicationAccessRequestRec.Terms_of_Use__c = true;
        applicationAccessRequestRec.Application_privacy_policy__c = 'Yes';
        applicationAccessRequestRec.Require_acknowledgement__c = true;
        applicationAccessRequestRec.Informs_user_of_data_access__c = true;
        applicationAccessRequestRec.User_data_will_be_shared__c = true;
        applicationAccessRequestRec.Captures_user_device_data__c = true;
        applicationAccessRequestRec.Requires_express_consent__c = true;
        applicationAccessRequestRec.Shows_how_to_terminate_access__c = true;
        applicationAccessRequestRec.Instructions_to_dispose_health_data__c = true;
        applicationAccessRequestRec.Enter_the_URL_for_your_privacy_policy__c = 'https://selecthealth.org';
        applicationAccessRequestRec.SH_Dev_Support_Email_Label__c = 'developer.name@email.com';
        applicationAccessRequestRec.SH_Dev_Terms_Of_Use_Link__c = 'developer.name@email.com';
        applicationAccessRequestRec.SH_ServiceNow_AssignmentGroup_Label__c = 'ServiceNow IT ServiceDesk';
        applicationAccessRequestRec.SH_ServiceNow_CI_Label__c = 'ServiceNow CI';
        applicationAccessRequestRec.SH_ServiceNow_Email_Label__c = 'servicenow@email.com';
        applicationAccessRequestRec.SH_ServiceNow_ShortDesc_Label__c = 'ServiceNow';
                                                    
        Test.startTest();
        Application_Access_Request__c insertedApplicationAccessRequest = ApplicationAccessRequestController.saveApplicationAccessRequest(applicationAccessRequestRec);
        Test.stopTest();
        
        System.assertNotEquals(insertedApplicationAccessRequest.Id, null);
    }
    
    @IsTest
    static void saveApplicationAccessRequestExceptionTest(){
        Application_Access_Request__c applicationAccessRequestRec = new Application_Access_Request__c();
        applicationAccessRequestRec.Application_Name__c = 'SelectHealth Application';
        applicationAccessRequestRec.Application_Description__c = 'Sample Description';
        applicationAccessRequestRec.Application_Release_Date__c = System.today();
        applicationAccessRequestRec.Developer_Contact_Name__c = 'Developer Name';
        applicationAccessRequestRec.Developer_Contact_Email__c = 'developer.name@email.com';
        applicationAccessRequestRec.Company_Name__c = 'SelectHealth';
        applicationAccessRequestRec.Company_URL__c = 'https://selecthealth.org';
        applicationAccessRequestRec.Company_Address__c = 'Salt Lake, Utah';
        applicationAccessRequestRec.Company_Primary_Contact__c = 'Developer Name';
        applicationAccessRequestRec.Company_Primary_Contact_Email__c = 'developer.name@email.com';
        applicationAccessRequestRec.Application_Redirect_URL_s__c = 'https://selecthealth.org';
        applicationAccessRequestRec.Terms_of_Use__c = true;
        applicationAccessRequestRec.Application_privacy_policy__c = 'Yes';
        applicationAccessRequestRec.Require_acknowledgement__c = true;
        applicationAccessRequestRec.Informs_user_of_data_access__c = true;
        applicationAccessRequestRec.User_data_will_be_shared__c = true;
        applicationAccessRequestRec.Captures_user_device_data__c = true;
        applicationAccessRequestRec.Requires_express_consent__c = true;
        applicationAccessRequestRec.Shows_how_to_terminate_access__c = true;
        applicationAccessRequestRec.Instructions_to_dispose_health_data__c = true;
        applicationAccessRequestRec.Enter_the_URL_for_your_privacy_policy__c = 'https://selecthealth.org';
        applicationAccessRequestRec.SH_Dev_Support_Email_Label__c = 'developer.name@email.com';
        applicationAccessRequestRec.SH_Dev_Terms_Of_Use_Link__c = 'developer.name@email.com';
        applicationAccessRequestRec.SH_ServiceNow_AssignmentGroup_Label__c = 'ServiceNow IT ServiceDesk';
        applicationAccessRequestRec.SH_ServiceNow_CI_Label__c = 'ServiceNow CI';
        applicationAccessRequestRec.SH_ServiceNow_Email_Label__c = 'servicenow@email.com';
        applicationAccessRequestRec.SH_ServiceNow_ShortDesc_Label__c = 'ServiceNow';
        
        try {
            Test.startTest();
            Application_Access_Request__c insertedApplicationAccessRequest = ApplicationAccessRequestController.saveApplicationAccessRequest(applicationAccessRequestRec);
            Test.stopTest();
            System.assert(false);
        } catch (Exception e) {
            System.assert(true);
        }
    }
    
    @IsTest
    static void getRequestInfoMapTest(){
        Application_Access_Request__c applicationAccessRequestRec = new Application_Access_Request__c();
        applicationAccessRequestRec.Select_APIs__c = 'Patient Access API';
        applicationAccessRequestRec.Application_Name__c = 'SelectHealth Application';
        applicationAccessRequestRec.Application_Description__c = 'Sample Description';
        applicationAccessRequestRec.Application_Release_Date__c = System.today();
        applicationAccessRequestRec.Developer_Contact_Name__c = 'Developer Name';
        applicationAccessRequestRec.Developer_Contact_Email__c = 'developer.name@email.com';
        applicationAccessRequestRec.Company_Name__c = 'SelectHealth';
        applicationAccessRequestRec.Company_URL__c = 'https://selecthealth.org';
        applicationAccessRequestRec.Company_Address__c = 'Salt Lake, Utah';
        applicationAccessRequestRec.Company_Primary_Contact__c = 'Developer Name';
        applicationAccessRequestRec.Company_Primary_Contact_Email__c = 'developer.name@email.com';
        applicationAccessRequestRec.Application_Redirect_URL_s__c = 'https://selecthealth.org';
        applicationAccessRequestRec.Terms_of_Use__c = true;
        applicationAccessRequestRec.Application_privacy_policy__c = 'Yes';
        applicationAccessRequestRec.Require_acknowledgement__c = true;
        applicationAccessRequestRec.Informs_user_of_data_access__c = true;
        applicationAccessRequestRec.User_data_will_be_shared__c = true;
        applicationAccessRequestRec.Captures_user_device_data__c = true;
        applicationAccessRequestRec.Requires_express_consent__c = true;
        applicationAccessRequestRec.Shows_how_to_terminate_access__c = true;
        applicationAccessRequestRec.Instructions_to_dispose_health_data__c = true;
        applicationAccessRequestRec.Enter_the_URL_for_your_privacy_policy__c = 'https://selecthealth.org';
        applicationAccessRequestRec.SH_Dev_Support_Email_Label__c = 'developer.name@email.com';
        applicationAccessRequestRec.SH_Dev_Terms_Of_Use_Link__c = 'developer.name@email.com';
        applicationAccessRequestRec.SH_ServiceNow_AssignmentGroup_Label__c = 'ServiceNow IT ServiceDesk';
        applicationAccessRequestRec.SH_ServiceNow_CI_Label__c = 'ServiceNow CI';
        applicationAccessRequestRec.SH_ServiceNow_Email_Label__c = 'servicenow@email.com';
        applicationAccessRequestRec.SH_ServiceNow_ShortDesc_Label__c = 'ServiceNow';
                                                    
        Test.startTest();
        Map<String, String> requestInfoMap = ApplicationAccessRequestController.getRequestInfoMap(applicationAccessRequestRec);
        Test.stopTest();
        
        System.assertNotEquals(requestInfoMap, null);
    }
}