@IsTest
public class ApplicationApprovalControllerTest {
    @TestSetup
    static void makeData(){
        /* User u = new User();
        u.Email = 'fake@mock.test';
        u.FirstName = 'Fake';
        u.LastName = 'Mock';
        u.Username = 'fake@mock.test';
        u.Alias = 'fmock';
        u.CommunityNickname = 'Fake Mock';

        Account a = new Account();
        a.Name = 'ACM Registered Users';
        insert a;
        Site.createExternalUser(u, a.Id, 'Salesforce1!'); */
        
        
        // to do MAKE TESTS
        //create Application_Approval Object 


    }

    @IsTest
    static void registerSuccess(){
        Test.startTest();
        String[] apis = new String[]{};
        apis.add('6ee10956-fd4c-4000-99a7-369e5fcf4a39:test-api');
        String retVal = ApplicationApprovalController.registerApplication('Fake App', apis,'Fake', 'Mock', 'fake@notexists.test','MockCompany','MockTitle', true);
        Test.stopTest();
        System.assert(retVal == null);
    }

    @IsTest
    static void registerError(){
        Test.startTest();
        String[] apis = new String[]{};
        apis.add('6ee10956-fd4c-4000-99a7-369e5fcf4a39:test-api');
        String retVal = ApplicationApprovalController.registerApplication('Fake App', apis,'Fake', 'Mock', 'fake@notexists.test','MockCompany','MockTitle', false);
        Test.stopTest();
        System.assert(retVal != null);
    }
}