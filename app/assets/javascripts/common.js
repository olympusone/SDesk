I18n.defaultLocale = defaultLocale;
I18n.locale = locale;
I18n.fallbacks = fallbacks;

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
    if($('input[type="checkbox"]:not(.js-switch)', e.target).length){
        $('input[type="checkbox"]:not(.js-switch)').iCheck({
            checkboxClass: 'icheckbox_square-blue',
            radioClass: 'iradio_square-blue'
        });
    }

    if($('.tagsinput', e.target).length){
        $('.tagsinput', e.target).tagsinput({
            trimValue: true
        });
    }

    if($('.select2', e.target).length){
        $('.select2', e.target).select2();
    }

    if($('input.date-picker', e.target).length){
        // init datepicker
        $('input.date-picker', e.target).datetimepicker({
            locale: I18n.locale,
            format: 'DD/MM/YYYY',
            keepOpen: false,
        });
    }

    if($('input.datetime-picker', e.target).length){
        // init datepicker
        $('input.datetime-picker', e.target).datetimepicker({
            locale: I18n.locale,
            format: 'DD/MM/YYYY HH:mm',
            keepOpen: false,
        });
    }

    if($('.select2-ajax', e.target).length){
        $('.select2-ajax', e.target).each(function () {
            initSelect2Ajax($(this));
        })
    }
});

$(document).on('nested:fieldAdded', function(event){
    $('.select2').select2();
});

$(function(){
    'use strict';

    let _token = $('meta[name=csrf-token]').attr('content');

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

    $.fn.modal.Constructor.prototype.enforceFocus = function() {};

    $("img").lazyload();

    $('input[type="checkbox"]:not(.js-switch)').iCheck({
        checkboxClass: 'icheckbox_flat-blue',
        radioClass: 'iradio_flat-blue',
        labelHover: false,
        cursor: true
    });

    FastClick.attach(document.body);

    $(document).on("focusout", "input[type='text']", function () {
        let value = $(this).val().trim();
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
    if($('.select2-ajax').length){
        $('select2-ajax').each(function () {
            initSelect2Ajax($(this));
        })
    }

    $(document).on('keyup', 'input.nospace, textarea.nospace', function(){
        let value = $(this).val().replace(/\s+/, '');
        $(this).val(value);
    });

    $('.tagsinput').tagsinput({
        trimValue: true
    });

});