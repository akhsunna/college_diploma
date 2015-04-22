// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require_tree .

$(document).ready( function() {
    changeUserStauts();
});

function changeUserStauts()
{
    if( $("#user_status").find(":selected").val() == 2 )
    {
        $("#user_group_id").hide();
        $("#user_group_id").val(null);
    }
    else
    {
        $("#user_group_id").show();
        $("#user_group_id").val(1);
    }
}

function showPassword() {
    var key_attr = $('#key').attr('type');
    if(key_attr != 'text') {
        $('.checkbox').addClass('show');
        $('#key').attr('type', 'text');
    } else {
        $('.checkbox').removeClass('show');
        $('#key').attr('type', 'password');
    }
}