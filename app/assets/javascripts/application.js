//= require rails-ujs
//= require activestorage
//= require jquery3
//= require cable

//= require underscore/underscore-min
//= require popper
//= require bootstrap-sprockets
//= require js-routes
//= require i18n
//= require i18n.js
//= require i18n/translations
//= require moment

//= require bootstrap-datetimepicker
//= require tinymce
//= require switchery
//= require icheck/icheck.min
//= require sortable

//= require bootstrap-tagsinput/dist/bootstrap-tagsinput.min
//= require fastclick/lib/fastclick
//= require select2/dist/js/select2

//= require perfect-scrollbar.jquery.min
//= require waves
//= require raphael/raphael.min
//= require morris.js/morris.min
//= require toastr/toastr.js
//= require lazyload/lazyload.min
//= require cp/sidebarmenu
//= require cp/custom

//= require jquery_nested_form

//= require functions

//= require datatables
//= require common

$(function () {
    initSwitchers();

    // trim all inputs that refers to slug
    $("input[name$='[slug]']").keyup(function () {
        var value = $(this).val().replace(/\s+/, '');
        $(this).val(value);
    });
});