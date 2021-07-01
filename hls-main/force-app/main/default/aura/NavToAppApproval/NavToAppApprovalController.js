({
    openPage: function(component, event, helper) {
        var pageReference = {
			type: "comm__namedPage",
			attributes: {
    		pageName: "application-authorization"
            }
		};
        var navService = component.find("navService");
        navService.navigate(pageReference);
    }
})