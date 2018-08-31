I18n.defaultLocale = defaultLocale;
I18n.locale = locale;
I18n.fallbacks = fallbacks;

$.fn.modal.Constructor.prototype.enforceFocus = function() {};

$.extend(true, $.fn.datetimepicker.defaults, {
    icons: {
        time: 'far fa-clock',
        date: 'far fa-calendar',
        up: 'fas fa-arrow-up',
        down: 'fas fa-arrow-down',
        previous: 'fas fa-chevron-left',
        next: 'fas fa-chevron-right',
        today: 'fas fa-calendar-check',
        clear: 'far fa-trash-alt',
        close: 'far fa-times-circle'
    }
});

$(document).on('hide.bs.modal', function(e) {
    if($(e.target).data('remove')){
        $('.modal-backdrop').remove();
    }
});

$(document).on('hidden.bs.modal', function(e) {
    if($(e.target).data('remove')){
        $(e.target).remove();
    }
});


$(document).on('show.bs.modal', function(e) {
    $('.modal-backdrop').remove();
});

$(document).on('shown.bs.modal', function(e) {
    if($('.select2', e.target).length){
        $('.select2', e.target).select2();
    }
});

$(document).on('nested:fieldAdded', function(event){
    $('.select2').select2();
});

$(function() {
    'use strict';

    $("img").lazyload();

    FastClick.attach(document.body);

    var _token = $('meta[name=csrf-token]').attr('content');

    // always pass csrf tokens on ajax calls
    $.ajaxSetup({
        headers: {'X-CSRF-Token': _token}
    });

    // set moment config
    moment.updateLocale(I18n.locale, {
        week : {
            dow : 1 // Monday is the first day of the week
        }
    });

    $(document).on("focusout", "input[type='text']", function () {
        var value = $(this).val().trim();
        $(this).val(value);
    });

    // init datepicker
    $('input.date-picker').datetimepicker({
        locale: I18n.locale,
        format: 'DD/MM/YYYY',
        keepOpen: false,
    });

    // init datepicker
    $('input.datetime-picker').datetimepicker({
        locale: I18n.locale,
        format: 'DD/MM/YYYY HH:mm',
        keepOpen: false,
    });

    $('.select2').select2();

    $(document).on('keyup', 'input.nospace, textarea.nospace', function(){
        var value = $(this).val().replace(/\s+/, '');
        $(this).val(value);
    })

    $('.tagsinput').tagsinput({
        trimValue: true
    });
});