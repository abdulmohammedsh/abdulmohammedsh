@IsTest(SeeAllData=false)
public class ApplicationAccessRequestEmailTest {

    @IsTest static void testSendEmailRequestSuccess(){
        ApplicationAccessRequestEmail.testRecipient = 'test@testemail.com';
        String result = ApplicationAccessRequestEmail.sendEmailRequest(new Map<String,String>{
            'Name' => 'Test',
                'Contact' => 'test@testemail.com',
                'Description' => 'Field1:Value1|Field2:Value2',
                'DateSubmitted' => '2021-01-01'
                });
        System.assertEquals('SUCCESS',result,'Email send failed');
    }
    
    @IsTest static void testSendEmailRequestError(){
        ApplicationAccessRequestEmail.testRecipient = 'test@testemail.com';
        String result = ApplicationAccessRequestEmail.sendEmailRequest(null);
        System.assertNotEquals('SUCCESS',result,'Method accepted null values');
    }
    
    @IsTest static void testSendEmailRequestFailed(){
        ApplicationAccessRequestEmail.testRecipient = 'test';
        String result = ApplicationAccessRequestEmail.sendEmailRequest(new Map<String,String>{
            'Name' => 'Test',
                'Contact' => 'test',
                'Description' => 'Field1:Value1|Field2:Value2',
                'DateSubmitted' => '2021-01-01'
                });
        System.assertNotEquals('SUCCESS',result,'Method accepted invalid email');
    }
    
    @IsTest static void testSendAcknowledgementEmailSuccess(){
        ApplicationAccessRequestEmail.testRecipient = 'test@testemail.com';
        String result = ApplicationAccessRequestEmail.sendAcknowledgementEmail(new Map<String,String>{
            'FirstName' => 'Test',
                'LastName' => 'Test',
                'Email' => 'test@testemail.com'
                });
        System.assertEquals('SUCCESS',result,'Email send failed');
    }
    
    @IsTest static void testSendAcknowledgementEmailError(){
        ApplicationAccessRequestEmail.testRecipient = 'test@testemail.com';
        String result = ApplicationAccessRequestEmail.sendAcknowledgementEmail(null);
        System.assertNotEquals('SUCCESS',result,'Method accepted null values');
    }
    
    @IsTest static void testSendAcknowledgementEmailFailed(){
        ApplicationAccessRequestEmail.testRecipient = 'test';
        String result = ApplicationAccessRequestEmail.sendAcknowledgementEmail(new Map<String,String>{
            'FirstName' => 'Test',
                'LastName' => 'Test',
                'Email' => 'test'
                });
        System.assertNotEquals('SUCCESS',result,'Method accepted invalid email');
    }
    
}