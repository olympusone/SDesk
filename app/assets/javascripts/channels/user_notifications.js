App.user_notifications = App.cable.subscriptions.create("UserNotificationsChannel",
    {
        connected: function(){
            // Called when the subscription is ready for use on the server
            console.log('Connected to notifications channel');
        },disconnected: function () {
            // Called when the subscription has been terminated by the server
            // console.log('Disconnected from notifications channel');
        },received: function(data){
            // Called when there's incoming data on the websocket for this channel
            if(data.alert){
                swal(data.alert);
            }else if(data.notification){
                _type = _.keys(data.notification)[0];
                _message = data.notification[_type];

                toastr[_type](_message, {
                    "closeButton": true,
                    "newestOnTop": true,
                    "progressBar": true,
                    "preventDuplicates": true
                });
            }
        }
    }
);