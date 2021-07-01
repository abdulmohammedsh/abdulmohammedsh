global class SSOJitHandler implements Auth.SamlJitHandler {
  private class JitException extends Exception{}
  private void handleUser(boolean create, User u, Map<String, String> attributes,
    String federationIdentifier, boolean isStandard) {
      Contact c = new Contact();
      Boolean hasContact = false;

      for (String keyVal : attributes.keySet()){
        System.debug(keyVal + ': ' + attributes.get(keyVal));
      }
  
      if(attributes.containsKey('email')) {
        c.Email = attributes.get('email');
      }
      if(attributes.containsKey('firstname')) {
        c.FirstName = attributes.get('firstname');
      }
      if(attributes.containsKey('lastname')) {
        c.LastName = attributes.get('lastname');
      }

      if (create){
        c.AccountId = [SELECT Id FROM Account WHERE Name = 'ACM Registered Users' LIMIT 1].Id;
        insert c;
        u.ContactId = c.Id;
      }
      else {
        c = [SELECT Id FROM Contact WHERE Email =: c.Email LIMIT 1];
      }

      for (String keyVal : attributes.keySet()){
        System.debug(keyVal + ': ' + attributes.get(keyVal));
      }

      if(create && attributes.containsKey('email')) {
        u.Username = attributes.get('email') + '.acm';
      }
      if(create) {
          u.FederationIdentifier = federationIdentifier;
      }
      if(attributes.containsKey('email')) {
        u.Email = attributes.get('email');
      }
      
      u.FirstName = attributes.get('firstname');
      u.LastName = attributes.get('lastname');
      System.debug(u.LastName);
      u.Alias = u.firstName.trim().substring(0, 1) + u.lastName.trim().right(5);
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
      
      if (create){
        insert u;
      }
      else{
        update u;
      }
  }

  private void handleJit(boolean create, User u, Id samlSsoProviderId, Id communityId, Id portalId,
    String federationIdentifier, Map<String, String> attributes, String assertion) {
    handleUser(create, u, attributes, federationIdentifier, false);
  }

  global User createUser(Id samlSsoProviderId, Id communityId, Id portalId,
    String federationIdentifier, Map<String, String> attributes, String assertion) {
    User u = new User();
    handleJit(true, u, samlSsoProviderId, communityId, portalId,
      federationIdentifier, attributes, assertion);
    return u;
  }

  global void updateUser(Id userId, Id samlSsoProviderId, Id communityId, Id portalId,
    String federationIdentifier, Map<String, String> attributes, String assertion) {
    User u = [SELECT Id, FirstName, ContactId FROM User WHERE Id=:userId];
    handleJit(false, u, samlSsoProviderId, communityId, portalId,
      federationIdentifier, attributes, assertion);
  }
}