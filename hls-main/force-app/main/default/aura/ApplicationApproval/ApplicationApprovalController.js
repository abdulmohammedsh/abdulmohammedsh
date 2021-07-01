({
    loadAPIOptions: function(component,
        event, helper) {
        
        	var url_string = document.location.href;
        	console.log(url_string);
            helper.loadAPIOptions(component);
        },
    
    handleRegister: function (component,
        event, helper) {
        console.log('handleRegister');
        helper.handleRegister(component);
    },

    // this function automatic call by aura:waiting event
    showSpinner: function (component,
        event, helper) {
        console.log("Show Spinner");
        // make Spinner attribute true for display loading spinner
        component.set("v.Spinner",
            true);
    },

    // this function automatic call by aura:doneWaiting event
    hideSpinner: function (component,
        event, helper) {
        console.log("Hide Spinner");
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