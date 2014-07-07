$(function() {
      var pusher = new Pusher('be501751f2a6e46bddb3');
      // var url = window.location.href;
      // var url_array = url.split('/');
      var match_id = $('#conversation-id').text();
 
      var channel = pusher.subscribe(match_id);
      channel.bind('new_message', function(data) {
        console.log(data);
        var message = $('<div></div>').addClass('row');
        console.log(message);
        var div = $('<div></div>');
        var par = $('<p></p>');
        par.text(data.message_body);
        console.log(div);
        var pic = $('<img>');
        pic.attr('src', data.pic);
        var time = $('<time></time>');
        time.addClass('small pad-right-1');
        time.text(data.created_at);
        if ($('#current-user-id').text() === data.user_id) {
          div.addClass('my-message rounded-corners');
        } else {
          div.addClass('their-message rounded-corners');
        }
        div.append(par);
        message.append(div);
        console.log(message);
        $('.message-history').append(message);

        // msg = 
        // $('.message-history').append(msg);
        // dom_notify(msg);
        // title_notify(msg);
        // if (window.webkitNotifications) { webkit_notify(msg); }
      });
      
      // In DOM alert
      function dom_notify(msg) {
        $('#notify').text(msg);
        $('#notify').fadeIn();
        setTimeout(function() {
          $('#notify').fadeOut
          ();
        }, 2000);
      }
      
      // <title> msg
      function title_notify(msg) {
        $.titleAlert(msg);
      }
      
      // Webkit Notifications API
      // http://www.html5rocks.com/en/tutorials/notifications/quick/
      
      
      // Some useful Pusher debug msgs
      pusher.connection.bind('connecting', function() {
        $('div#status').text('Connecting to Pusher...');
      });
      pusher.connection.bind('connected', function() {
        $('div#status').text('Connected to Pusher!');
      });
      pusher.connection.bind('failed', function() {
        $('div#status').text('Connection to Pusher failed :(');
      });
      channel.bind('subscription_error', function(status) {
        $('div#status').text('Pusher subscription_error');
      });
    });

$(window).resize(function() {
  var headerHeight = $('.navbar-default').height();
  var chatUIHeight = $('.chat-interface').height();
  $('.chat-container').height($(window).height() - (headerHeight + chatUIHeight + 60));
});

$(window).trigger('resize');

$(document).delegate('*[data-toggle="lightbox"]', 'click', function(event) {
    event.preventDefault();
    $(this).ekkoLightbox();
}); 