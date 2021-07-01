({
    handleRegister: function (component,
        event, helper) {

        var validForm = component.find(
            'FormVal').reduce(
                function (validSoFar,
                    inputCmp) {
                    // Displays error messages for invalid fields
                    inputCmp.showHelpMessageIfInvalid();
                    return validSoFar &&
                        inputCmp.get(
                            'v.validity'
                        ).valid;
                }, true);
        // If we pass error checking, do some real work
        if (validForm) {

            // Get the Username from Component
            var fName = component.get(
                "v.FirstName");
            var lName = component.get(
                "v.LastName");
            var eMail = component.get(
                "v.Email");
            var reCaptchaSuccess = component.get('v.reCaptchaSuccess');
            //Calling controller
            // Create the action
            var action = component.get(
                "c.registerUser");
            action.setParams({
                firstName: fName,
                lastName: lName,
                email: eMail,
                canSubmit: reCaptchaSuccess
            }); 
            // Add callback behavior for when response is received
            action.setCallback(this,
                function (response) {
                    var state =
                        response.getState();
                    var rtnValue =
                        response.getReturnValue();
                    if (rtnValue !==
                        null) {
                        component.set(
                            "v.errorLabel",
                            rtnValue
                        );
                    }
                    else{
                        component.set('v.registered', true);
                    }
                });

            // Send action off to be executed
            $A.enqueueAction(action);
        }
    },

    // this function automatic call by aura:waiting event
    showSpinner: function (component,
        event, helper) {
        // make Spinner attribute true for display loading spinner
        component.set("v.Spinner",
            true);
    },

    // this function automatic call by aura:doneWaiting event
    hideSpinner: function (component,
        event, helper) {
        // make Spinner attribute to false for hide loading spinner
        component.set("v.Spinner",
            false);
    },
    // reCaptcha items
    handleCallback : function(component, event, helper) {
        var registerButton = component.find('register');
        registerButton.set("v.disabled", false);
        component.set("v.reCaptchaSuccess", true);
        console.log('Callback: ' + event.getParam('response'));
    },
    handleVerifyCallback : function(component, event, helper) {
        console.log('Verified Response: ' + event.getParam('response'));
    },
    handleExpiredCallback : function(component, event, helper) {
        var registerButton = component.find('register');
        registerButton.set("v.disabled", true);
        component.set("v.reCaptchaSuccess", false);
        console.log('Expired Callback');
    },
    handleErrorCallback : function(component, event, helper) {
        var registerButton = component.find('register');
        registerButton.set("v.disabled", true);
        component.set("v.reCaptchaSuccess", false);
        console.log('Error Callback');
    },
})