public class Constants {
    public static final String COMMUNITY_PROFILE = 'ACM Member User';
    public static final String COMMUNITY_ACCOUNT_NAME = 'ACM Registered Users';
    public static final String USER_REJECTION_EMAIL = 'Select_Health_ACM_User_Rejection';
    public static final String USER_WELCOME_EMAIL = 'selecthealthNewMember';
    public static final Id NETWORK_ID = !Test.isRunningTest() ? Network.getNetworkId() :
        [
            SELECT Id
            FROM Network
            WHERE Name = 'Select Health ACM'
            LIMIT 1
        ].Id;
}