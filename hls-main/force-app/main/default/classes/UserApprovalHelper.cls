public class UserApprovalHelper {
    public static void addCommunityUser(List<User_Approval__c> users) {
        for (User_Approval__c ua : users){
            if (ua.Status__c == 'Approved'){
                Contact c = new Contact();
            
                c.Email = ua.email__c.trim();
                c.FirstName = ua.first_name__c.trim();
                c.LastName = ua.last_name__c.trim();
                c.AccountId = [SELECT Id FROM Account WHERE Name = 'ACM Registered Users' LIMIT 1].Id;

                insert c;

                User u = new User();

                u.ContactId = c.Id;
                u.Email = ua.email__c.trim();
                u.FirstName = ua.First_Name__c.trim();
                u.LastName = ua.Last_Name__c.trim();
                u.Username = ua.email__c.trim();
                u.Alias = ua.First_Name__c.trim().substring(0, 1) + ua.Last_Name__c.trim().right(5);
        
                Id a = [SELECT Id FROM Account WHERE Name =: Constants.COMMUNITY_ACCOUNT_NAME LIMIT 1].Id;
        
                //Site.createExternalUser(u, a);
                String nn = (u.firstName.trim() + ' ' + u.lastName.trim()).left(35);
                List<User> nicknames = [
                    SELECT CommunityNickname, LastName
                    FROM User 
                    WHERE CommunityNickname LIKE :nn + '%'
                    ORDER BY CommunityNickname DESC
                ];
          
                if (nicknames.size() == 0){
                    nn += ' 1';
                }
                else{
                    Integer nameNumber = 0;
                    for (User comUser : nicknames){
                        try{
                            System.debug(comUser.CommunityNickname.Split(' ').size() - 1);
                            System.debug(comUser.CommunityNickname.Split(' ').get(comUser.CommunityNickname.Split(' ').size() - 1));
                            nameNumber = Integer.valueOf(comUser.CommunityNickname.Split(' ').get(comUser.CommunityNickname.Split(' ').size() - 1));
                            nameNumber++;
                        }
                        catch(Exception e){
                            nameNumber++;
                        }
                        break;
                    }
          
                    nn += ' ' + nameNumber;
                }
          
                u.CommunityNickname = nn;
                
                u.TimeZoneSidKey = 'America/Phoenix'; // Required
                u.LocaleSidKey = 'en_US'; // Required
                u.EmailEncodingKey = 'ISO-8859-1'; // Required
                u.LanguageLocaleKey = 'en_US'; // Required
          
                u.ProfileId = [
                  SELECT Id
                  FROM Profile
                  WHERE Name LIKE 'ACM Member User'
                ].Id;

                insert u;

                // Send Welcome Email to User
                EmailTemplate welcome = [
                    SELECT Id, Subject, Description, DeveloperName, Body
                    FROM EmailTemplate
                    WHERE DeveloperName =: Constants.USER_WELCOME_EMAIL
                ];

                Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();

                message.setSenderDisplayName('Select Health');
                message.setReplyTo('no-reply@api.selecthealth.org');
                message.setUseSignature(false);
                message.setBccSender(false);
                message.setSaveAsActivity(false);
                message.setTargetObjectId(c.Id);
                message.setWhatId(Constants.NETWORK_ID);
                
                message.templateid = welcome.Id;
                message.toAddresses = new String[] { ua.Email__c};

                Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage> {message};
                Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
                if (results[0].success) {
                    System.debug('The email was sent successfully.');
                } else {
                    System.debug('The email failed to send: ' +  results[0].errors[0].message);
                }
            }
            else if (ua.Status__c == 'Rejected'){
                // Send Rejection Email to User
                EmailTemplate reject = [
                    SELECT Id, Subject, Description, DeveloperName, Body
                    FROM EmailTemplate
                    WHERE DeveloperName =: Constants.USER_REJECTION_EMAIL
                ];

                Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();

                message.setSenderDisplayName('Select Health');
                message.setReplyTo('no-reply@api.selecthealth.org');
                message.setUseSignature(false);
                message.setBccSender(false);
                message.setSaveAsActivity(false);
                message.setTargetObjectId(ua.OwnerId);
                
                message.templateid = reject.Id;
                message.toAddresses = new String[] { ua.Email__c};

                Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage> {message};
                Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
                if (results[0].success) {
                    System.debug('The email was sent successfully.');
                } else {
                    System.debug('The email failed to send: ' +  results[0].errors[0].message);
                }
            }
        }
    }
}