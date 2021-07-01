@IsTest
public class SelfRegisterControllerTest {
    @TestSetup
    static void makeData(){
        User u = new User();
        u.Email = 'fake@mock.test';
        u.FirstName = 'Fake';
        u.LastName = 'Mock';
        u.Username = 'fake@mock.test';
        u.Alias = 'fmock';
        u.CommunityNickname = 'Fake Mock';

        Account a = new Account();
        a.Name = 'ACM Registered Users';
        insert a;

        Site.createExternalUser(u, a.Id, 'Salesforce1!');
    }

    @IsTest
    static void registerSuccess(){
        Test.startTest();
        String retVal = SelfRegisterController.registerUser('Fake', 'Mock', 'fake@notexists.test', true);
        Test.stopTest();
        System.assert(retVal == null);
    }

    @IsTest
    static void registerError(){
        Test.startTest();
        String retVal = SelfRegisterController.registerUser('Fake', 'Mock', null, true);
        Test.stopTest();
        System.assert(retVal != null);
    }
}