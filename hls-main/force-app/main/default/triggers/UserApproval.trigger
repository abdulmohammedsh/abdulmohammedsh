trigger UserApproval on User_Approval__c (after insert, after update) {
    UserApprovalHelper.addCommunityUser(Trigger.new);
}