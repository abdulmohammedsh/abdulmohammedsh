/**
* @description Controller class for the ApplicationAccessRequest Lightning Component
*/
public without sharing class ApplicationAccessRequestController {
    
    /**
	* @description Method that retrieves the API Options
	* @return List<Map<String,String>> - List of API Options
	*/
    @AuraEnabled
    public static List<Map<String,String>> getAPIOptions() {
        List<Map<String, String>> apiOptions = new List<Map<String,String>>();
        for (acm_pkg__CommunityApi__c apiRec : [SELECT acm_pkg__ApiId__c, acm_pkg__Name__c, acm_pkg__AssetType__c 
                                                FROM acm_pkg__CommunityApi__c 
                                                WHERE acm_pkg__AssetType__c = 'api-group'
                                                AND acm_pkg__CommunityName__c = 'SelectHealth Developer Portal']) {
            apiOptions.add(new Map<String,String>{'value' => apiRec.id, 'label' => apiRec.acm_pkg__Name__c});  
        }
        return apiOptions;
    }
    
    /**
	* @description Method that retrieves the helptext of Application Access Request fields
	* @return Map<String, String> - Map of Application Access Request fields and its corresponding help text
	*/
    @AuraEnabled 
    public static Map<String, String> getFieldLabels() {
        Map<String, String> fieldLabelMap = new Map<String, String>();
        Map<String, Schema.SObjectField> fieldMap = Schema.getGlobalDescribe().get('Application_Access_Request__c').getDescribe().fields.getMap();
        for (Schema.SObjectField fieldValue : fieldMap.values()) {
            fieldLabelMap.put(fieldValue.getDescribe().getName(), fieldValue.getDescribe().getInlineHelpText());
        }
        return fieldLabelMap;
    }
    
    /**
	* @description Method that inserts the Application Access Request record and calls the email utility for the notifications
	* @param applicationAccessRequest - Application Access Request record
	* @return Application_Access_Request__c - Application Access Request record
	*/
    @AuraEnabled 
    public static Application_Access_Request__c saveApplicationAccessRequest(Application_Access_Request__c applicationAccessRequest) {
        try {
            insert applicationAccessRequest;
            Map<String, String> requestInfoMap = getRequestInfoMap(applicationAccessRequest);
            String sendEmailRequestResponse = ApplicationAccessRequestEmail.sendEmailRequest(requestInfoMap);
            String sendAcknowledgementEmailResponse = ApplicationAccessRequestEmail.sendAcknowledgementEmail(requestInfoMap);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        return applicationAccessRequest;
    }
    
    /**
	* @description Method that converts the Application Access Request into a map of its fields and corresponding value
	* @param applicationAccessRequest - Application Access Request record
	* @return Map<String, String> - Map of Application Access Request fields and corresponding value
	*/
    public static Map<String, String> getRequestInfoMap(Application_Access_Request__c applicationAccessRequest) {
        Map<String, String> requestInfoMap = new Map<String, String>();
        Map<String, Schema.SObjectField> fieldMap = Schema.getGlobalDescribe().get('Application_Access_Request__c').getDescribe().fields.getMap();
        for (Schema.SObjectField fieldValue : fieldMap.values()) {
            if (applicationAccessRequest.get(fieldValue.getDescribe().getName()) != null) {
                requestInfoMap.put(fieldValue.getDescribe().getLabel(), String.valueOf(applicationAccessRequest.get(fieldValue.getDescribe().getName())));
            }
        }
        return requestInfoMap;
    }
}