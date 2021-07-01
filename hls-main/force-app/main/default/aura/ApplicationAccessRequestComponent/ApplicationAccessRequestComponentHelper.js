({
	getCustomLabelValues : function(component, event, helper) {
		component.set("v.defaultDevSupportEmailLabel", $A.get("$Label.c.SH_Dev_Support_Email_Label"));
        component.set("v.defaultDevTermsOfUseLink", $A.get("$Label.c.SH_Dev_Terms_Of_Use_Link"));
        component.set("v.defaultServiceNowEmailLabel", $A.get("$Label.c.SH_ServiceNow_Email_Label"));
        component.set("v.defaultServiceNowAssignmentGroupLabel", $A.get("$Label.c.SH_ServiceNow_AssignmentGroup_Label"));
        component.set("v.defaultServiceNowCILabel", $A.get("$Label.c.SH_ServiceNow_CI_Label"));
        component.set("v.defaultServiceNowShortDescLabel", $A.get("$Label.c.SH_ServiceNow_ShortDesc_Label"));
	},
    
    getAPIOptions : function(component, event, helper) {
        let action = component.get("c.getAPIOptions");
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.availableAPIs", response.getReturnValue());
                let availableAPIs = response.getReturnValue();
                component.set("v.showSpinner", false);
            } else {
                let errors = response.getError();
                let errMessage = errors[0].message;
                let title = "Error!";
                let message = "The following error has occured : [" + errMessage + "]. Kindly contact an administrator for assistance.";
                let type = "error";
                this.showToast(component, event, helper, title, message, type);
                component.set("v.showSpinner", false);
            }
        });
        $A.enqueueAction(action);
    },
    
    getFieldLabels : function(component, event, helper) {
        let action = component.get("c.getFieldLabels");
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let fieldLabelMap = response.getReturnValue();
                component.set("v.applicationPrivacyPolicyLabel", fieldLabelMap['Application_privacy_policy__c']);
    			component.set("v.requireAcknowledgementLabel", fieldLabelMap['Require_acknowledgement__c']);
                component.set("v.informUserOfDataAccessLabel", fieldLabelMap['Informs_user_of_data_access__c']);
                component.set("v.userDataWillBeSharedLabel", fieldLabelMap['User_data_will_be_shared__c']);
                component.set("v.captureUserDeviceDataLabel", fieldLabelMap['Captures_user_device_data__c']);
                component.set("v.requireExpressConsentLabel", fieldLabelMap['Requires_express_consent__c']);
                component.set("v.showsHowToTerminateAccessLabel", fieldLabelMap['Shows_how_to_terminate_access__c']);
                component.set("v.instructionsToDisposeDataLabel", fieldLabelMap['Instructions_to_dispose_health_data__c']);
                component.set("v.showSpinner", false);
            } else {
                let errors = response.getError();
                let errMessage = errors[0].message;
                let title = "Error!";
                let message = "The following error has occured : [" + errMessage + "]. Kindly contact an administrator for assistance.";
                let type = "error";
                this.showToast(component, event, helper, title, message, type);
                component.set("v.showSpinner", false);
            }
        });
        $A.enqueueAction(action);
    },
    
    saveApplicationAccessRequest : function(component, event, helper, applicationAccessRequest) {
        let action = component.get("c.saveApplicationAccessRequest");
        action.setParams({
            applicationAccessRequest : applicationAccessRequest
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let createdApplicationAccessRequest = response.getReturnValue();
                let title = "Success!";
                let message = "Application Access Request has been submitted successfully.";
                let type = "success";
                this.showToast(component, event, helper, title, message, type);
                this.clearFields(component, event, helper);
                component.set("v.showSpinner", false);
            } else {
                let errors = response.getError();
                let errMessage = errors[0].message;
                let title = "Error!";
                let message = "The following error has occured : [" + errMessage + "]. Kindly contact an administrator for assistance.";
                let type = "error";
                this.showToast(component, event, helper, title, message, type);
                component.set("v.showSpinner", false);
            }
        });
        $A.enqueueAction(action);
    },
    
    clearFields : function(component, event, helper) {
        component.find("Application_Name__c").set("v.value", null);
        component.find("Application_Description__c").set("v.value", null);
        component.find("Application_Release_Date__c").set("v.value", null);
        component.find("Developer_Contact_Name__c").set("v.value", null);
        component.find("Developer_Contact_Email__c").set("v.value", null);
        component.find("Company_Name__c").set("v.value", null);
        component.find("Company_URL__c").set("v.value", null);
        component.find("Company_Address__c").set("v.value", null);
        component.find("Company_Primary_Contact__c").set("v.value", null);
        component.find("Company_Primary_Contact_Email__c").set("v.value", null);
        component.find("Application_Redirect_URL_s__c").set("v.value", null);
        component.find("Terms_of_Use__c").set("v.value", false);
        component.find("Application_privacy_policy__c").set("v.value", false);
        component.find("Require_acknowledgement__c").set("v.value", false);
        component.find("Informs_user_of_data_access__c").set("v.value", false);
        component.find("User_data_will_be_shared__c").set("v.value", false);
        component.find("Captures_user_device_data__c").set("v.value", false);
        component.find("Requires_express_consent__c").set("v.value", false);
        component.find("Shows_how_to_terminate_access__c").set("v.value", false);
        component.find("Instructions_to_dispose_health_data__c").set("v.value", false);
        component.find("Enter_the_URL_for_your_privacy_policy__c").set("v.value", null);
        let emptyList = [];
        component.set("v.selectedAPIs", emptyList);
        component.set("v.showOtherCheckboxes", false);
    },
    
    showToast : function(component, event, helper, title, message, type) {
        let toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title: title,
            message: message,
            type: type
        });
        toastEvent.fire();
        component.set("v.showSpinner", false);
    }
})