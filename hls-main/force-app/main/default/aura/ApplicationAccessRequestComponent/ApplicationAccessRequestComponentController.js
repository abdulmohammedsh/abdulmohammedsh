({
	handleInit : function(component, event, helper) {
		component.set("v.showSpinner", true);
        helper.getCustomLabelValues(component, event, helper);
        helper.getAPIOptions(component, event, helper);
        helper.getFieldLabels(component, event, helper);
	},
    
    handleApplicationPrivacyPolicyToggle : function(component, event, helper) {
        let showOtherCheckboxes = component.find("Application_privacy_policy__c").get("v.value") == 'Yes' ? true : false;
        component.set("v.showOtherCheckboxes", showOtherCheckboxes);
    },
    
    handleValidateRequest : function(component, event, helper) {
        component.set("v.showSpinner", true);
        let selectedAPIs = component.get("v.selectedAPIs");
        if (selectedAPIs.length === 0 || 
            component.find("Application_Name__c").get("v.value") == null || 
            component.find("Application_Description__c").get("v.value") == null || 
            component.find("Application_Release_Date__c").get("v.value") == null || 
            component.find("Developer_Contact_Name__c").get("v.value") == null ||
            component.find("Developer_Contact_Email__c").get("v.value") == null || 
            component.find("Company_Name__c").get("v.value") == null || 
            component.find("Company_URL__c").get("v.value") == null || 
            component.find("Company_Address__c").get("v.value") == null || 
            component.find("Company_Primary_Contact__c").get("v.value") == null || 
            component.find("Company_Primary_Contact_Email__c") == null ||
            component.find("Application_Redirect_URL_s__c").get("v.value") == null || 
            component.find("Terms_of_Use__c").get("v.value") == false ||
            component.find("Application_privacy_policy__c").get("v.value") == null) {
            debugger;
            let title = "Error!";
            let message = "There are required fields that are not populated. Kindly complete filling up the form before submitting.";
            let type = "error";
            helper.showToast(component, event, helper, title, message, type);
            component.set("v.showSpinner", false);
        } else {
            debugger;
            if (component.find("Application_privacy_policy__c").get("v.value") == 'Yes') {
                debugger;
                if (component.find("Require_acknowledgement__c").get("v.value") == false || 
                    component.find("Informs_user_of_data_access__c").get("v.value") == false || 
                    component.find("User_data_will_be_shared__c").get("v.value") == false || 
                    component.find("Captures_user_device_data__c").get("v.value") == false || 
                    component.find("Requires_express_consent__c").get("v.value") == false || 
                    component.find("Shows_how_to_terminate_access__c").get("v.value") == false || 
                    component.find("Instructions_to_dispose_health_data__c").get("v.value") == false || 
                    component.find("Enter_the_URL_for_your_privacy_policy__c").get("v.value") == null) {
                    let title = "Error!";
                    let message = "There are required fields that are not populated. Kindly complete filling up the form before submitting.";
                    let type = "error";
                    helper.showToast(component, event, helper, title, message, type);
                    component.set("v.showSpinner", false);
                } else {
                    let availableAPIs = component.get("v.availableAPIs");
                    let selectAPIList = '';
                    availableAPIs.forEach(function(availableAPI) {
                        selectedAPIs.forEach(function(selectedAPI) {
                            if (availableAPI.value == selectedAPI) {
                                if (selectAPIList == '') {
                                    selectAPIList = availableAPI.label;
                                } else {
                                    selectAPIList = selectAPIList + ';' + availableAPI.label;
                                }
                            }
                        });
                    });
                    let devSupportEmail = component.get("v.designDevSupportEmailLabel") != null ? component.get("v.designDevSupportEmailLabel") : component.get("v.defaultDevSupportEmailLabel");
                    let devTermsOfUseLink = component.get("v.designDevTermsOfUseLink") != null ? component.get("v.designDevTermsOfUseLink") : component.get("v.defaultDevTermsOfUseLink");
                    let serviceNowEmail = component.get("v.designServiceNowEmailLabel") != null ? component.get("v.designServiceNowEmailLabel") : component.get("v.defaultServiceNowEmailLabel");
                    let serviceNowAssignmentGroup = component.get("v.designServiceNowAssignmentGroupLabel") != null ? component.get("v.designServiceNowAssignmentGroupLabel") : component.get("v.defaultServiceNowAssignmentGroupLabel");
                    let serviceNowCI = component.get("v.designServiceNowCILabel") != null ? component.get("v.designServiceNowCILabel") : component.get("v.defaultServiceNowCILabel");
                    let serviceNowShortDescription = component.get("v.designServiceNowShortDescLabel") != null ? component.get("v.designServiceNowShortDescLabel") : component.get("v.defaultServiceNowShortDescLabel");
                    let applicationAccessRequest = {Select_APIs__c : selectAPIList,
                                                    Application_Name__c : component.find("Application_Name__c").get("v.value"), 
                                                    Application_Description__c : component.find("Application_Description__c").get("v.value"), 
                                                    Application_Release_Date__c : component.find("Application_Release_Date__c").get("v.value"),
                                                    Developer_Contact_Name__c : component.find("Developer_Contact_Name__c").get("v.value"),
                                                    Developer_Contact_Email__c : component.find("Developer_Contact_Email__c").get("v.value"),
                                                    Company_Name__c : component.find("Company_Name__c").get("v.value"),
                                                    Company_URL__c : component.find("Company_URL__c").get("v.value"),
                                                    Company_Address__c : component.find("Company_Address__c").get("v.value"),
                                                    Company_Primary_Contact__c : component.find("Company_Primary_Contact__c").get("v.value"),
                                                    Company_Primary_Contact_Email__c : component.find("Company_Primary_Contact_Email__c").get("v.value"),
                                                    Application_Redirect_URL_s__c : component.find("Application_Redirect_URL_s__c").get("v.value"),
                                                    Terms_of_Use__c : component.find("Terms_of_Use__c").get("v.value"),
                                                    Application_privacy_policy__c : component.find("Application_privacy_policy__c").get("v.value"),
                                                    Require_acknowledgement__c : component.find("Require_acknowledgement__c").get("v.value"),
                                                    Informs_user_of_data_access__c : component.find("Informs_user_of_data_access__c").get("v.value"),
                                                    User_data_will_be_shared__c : component.find("User_data_will_be_shared__c").get("v.value"),
                                                    Captures_user_device_data__c : component.find("Captures_user_device_data__c").get("v.value"),
                                                    Requires_express_consent__c : component.find("Requires_express_consent__c").get("v.value"),
                                                    Shows_how_to_terminate_access__c : component.find("Shows_how_to_terminate_access__c").get("v.value"),
                                                    Instructions_to_dispose_health_data__c : component.find("Instructions_to_dispose_health_data__c").get("v.value"),
                                                    Enter_the_URL_for_your_privacy_policy__c : component.find("Enter_the_URL_for_your_privacy_policy__c").get("v.value"),
                                                    SH_Dev_Support_Email_Label__c : devSupportEmail,
                                                    SH_Dev_Terms_Of_Use_Link__c : devTermsOfUseLink,
                                                    SH_ServiceNow_AssignmentGroup_Label__c : serviceNowAssignmentGroup,
                                                    SH_ServiceNow_CI_Label__c : serviceNowCI,
                                                    SH_ServiceNow_Email_Label__c : serviceNowEmail,
                                                    SH_ServiceNow_ShortDesc_Label__c : serviceNowShortDescription,
                                                    sobjectType : 'Application_Access_Request__c'};
                    debugger;
                    helper.saveApplicationAccessRequest(component, event, helper, applicationAccessRequest);
                }
            } else {
                debugger;
                let availableAPIs = component.get("v.availableAPIs");
                let selectAPIList = '';
                availableAPIs.forEach(function(availableAPI) {
                    selectedAPIs.forEach(function(selectedAPI) {
                        if (availableAPI.value == selectedAPI) {
                            if (selectAPIList == '') {
                                selectAPIList = availableAPI.label;
                            } else {
                                selectAPIList = selectAPIList + ';' + availableAPI.label;
                            }
                        }
                    });
                });
                let devSupportEmail = component.get("v.designDevSupportEmailLabel") != null ? component.get("v.designDevSupportEmailLabel") : component.get("v.defaultDevSupportEmailLabel");
                let devTermsOfUseLink = component.get("v.designDevTermsOfUseLink") != null ? component.get("v.designDevTermsOfUseLink") : component.get("v.defaultDevTermsOfUseLink");
                let serviceNowEmail = component.get("v.designServiceNowEmailLabel") != null ? component.get("v.designServiceNowEmailLabel") : component.get("v.defaultServiceNowEmailLabel");
                let serviceNowAssignmentGroup = component.get("v.designServiceNowAssignmentGroupLabel") != null ? component.get("v.designServiceNowAssignmentGroupLabel") : component.get("v.defaultServiceNowAssignmentGroupLabel");
                let serviceNowCI = component.get("v.designServiceNowCILabel") != null ? component.get("v.designServiceNowCILabel") : component.get("v.defaultServiceNowCILabel");
                let serviceNowShortDescription = component.get("v.designServiceNowShortDescLabel") != null ? component.get("v.designServiceNowShortDescLabel") : component.get("v.defaultServiceNowShortDescLabel");
                debugger;
                let applicationAccessRequest = {Select_APIs__c : selectAPIList,
                                                Application_Name__c : component.find("Application_Name__c").get("v.value"), 
                                                Application_Description__c : component.find("Application_Description__c").get("v.value"), 
                                                Application_Release_Date__c : component.find("Application_Release_Date__c").get("v.value"),
                                                Developer_Contact_Name__c : component.find("Developer_Contact_Name__c").get("v.value"),
                                                Developer_Contact_Email__c : component.find("Developer_Contact_Email__c").get("v.value"),
                                                Company_Name__c : component.find("Company_Name__c").get("v.value"),
                                                Company_URL__c : component.find("Company_URL__c").get("v.value"),
                                                Company_Address__c : component.find("Company_Address__c").get("v.value"),
                                                Company_Primary_Contact__c : component.find("Company_Primary_Contact__c").get("v.value"),
                                                Company_Primary_Contact_Email__c : component.find("Company_Primary_Contact_Email__c").get("v.value"),
                                                Application_Redirect_URL_s__c : component.find("Application_Redirect_URL_s__c").get("v.value"),
                                                Terms_of_Use__c : component.find("Terms_of_Use__c").get("v.value"),
                                                Application_privacy_policy__c : component.find("Application_privacy_policy__c").get("v.value"),
                                                Require_acknowledgement__c : false,
                                                Informs_user_of_data_access__c : false,
                                                User_data_will_be_shared__c : false,
                                                Captures_user_device_data__c : false,
                                                Requires_express_consent__c : false,
                                                Shows_how_to_terminate_access__c : false,
                                                Instructions_to_dispose_health_data__c : false,
                                                Enter_the_URL_for_your_privacy_policy__c : '',
                                                SH_Dev_Support_Email_Label__c : devSupportEmail,
                                                SH_Dev_Terms_Of_Use_Link__c : devTermsOfUseLink,
                                                SH_ServiceNow_AssignmentGroup_Label__c : serviceNowAssignmentGroup,
                                                SH_ServiceNow_CI_Label__c : serviceNowCI,
                                                SH_ServiceNow_Email_Label__c : serviceNowEmail,
                                                SH_ServiceNow_ShortDesc_Label__c : serviceNowShortDescription,
                                                sobjectType : 'Application_Access_Request__c'};
                helper.saveApplicationAccessRequest(component, event, helper, applicationAccessRequest);
            }
        }
    }
})