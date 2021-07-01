public without sharing class SelfRegisterController {
    @AuraEnabled
    public static String registerUser(String firstName, String lastName, String email, Boolean canSubmit) {
        try {
            if (!canSubmit)
                return 'Captcha was invalid. Please, resubmit';

            User_Approval__c u = new User_Approval__c();
            u.Email__c = email.trim();
            u.First_Name__c = firstName.trim();
            u.last_Name__c = lastName.trim();
            u.Status__c = 'Pending';

            insert u;
            return null;
        }
        catch (Exception ex) {
            return ex.getMessage();
        }
    }
}