({
    loadAPIOptions : function(component) {
        console.log("get options");
        var action = component.get("c.getAPIOptions");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log( response.getReturnValue());
                component.set("v.availableAPIs", response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    },
    handleRegister : function(component) {
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
        console.log("is form Valid?" + validForm)
        if (validForm) {
			
            // Get the Username from Component
            // 
            var aName = component.get("v.ApplicationName");
            var fName = component.get("v.FirstName");
            var lName = component.get("v.LastName");
            var eMail = component.get("v.Email");
            var company = component.get("v.Company");
            var description = component.get("v.Description");
            var selectedApis = component.get("v.selectedAPIs");
       		console.log('build action...');
            var action = component.get("c.registerApplication");
            action.setParams({
                applicationName: aName,
                communityAPIs: selectedApis,
                firstName: fName,
                lastName: lName,
                email: eMail,
                company: company,
                description: description
            });
           
            // Add callback behavior for when response is received
            action.setCallback(this,
                function (response) {
                     console.log("got response...");
                    var state =
                        response.getState();
                    var rtnValue =
                        response.getReturnValue();
                    if (rtnValue !==
                        null) {
                        let errmsg = rtnValue;
                        if(rtnValue.includes('DUPLICATE_VALUE')){
                            errmsg="The current value for Application Name is already taken.";
                        }
                        console.log(errmsg);
                        component.set("v.errorLabel",errmsg);
                    }
                    else{
                        console.log("set submitted...");
                        component.set("v.requestSubmitted",true);  
                    }
                    return null;
                });
 			console.log("call  the controller");
            // Send action off to be executed
            $A.enqueueAction(action);
        }
    }
})