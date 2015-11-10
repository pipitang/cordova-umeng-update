var exec = require('cordova/exec');

module.exports = {
    Update:{
        config: function (parameters, onSuccess, onError) {
            exec(onSuccess, onError, "Update", "config", [parameters]);
        },

        update: function(onSuccess, onError) {
            exec(onSuccess, onError, "Update", "update", []);
        },

        forceUpdate: function(onSuccess, onError) {
            exec(onSuccess, onError, "Update", "forceUpdate", []);
        },

        silentUpdate: function(onSuccess, onError) {
            exec(onSuccess, onError, "Update", "silentUpdate", []);    
        },

        checkUpdate: function(storeAppId, config , onSuccess, onError) {
            exec(onSuccess, onError, "Update", "checkUpdate", [storeAppId, config]);    
        }
    }
};
