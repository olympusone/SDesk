function initSwitchers(target) {
    let _target = target === 'undefined' ? 'body' : target;

    if($('.js-switch', target).length){
        $('.js-switch', target).each(function(){
            initSwitch($(this))
        });
    }
}

function initSwitch(element){
    let defaults = {
        color             : '#64bd63',
        secondaryColor    : '#dfdfdf',
        jackColor         : '#fff',
        jackSecondaryColor: null,
        className         : 'switchery',
        disabled          : false,
        disabledOpacity   : 0.5,
        speed             : '0.2s',
        size              : 'default'
    };

    $.each(defaults, function (key, value) {
        let el_value = element.data(key);

        if(typeof el_value === 'undefined')
            el_value = element.data(key.toLowerCase());

        if(typeof  el_value !== 'undefined'){
            defaults[key] = el_value;
        }
    });

    new Switchery(element[0], defaults);
}

function dataTableChangePosition(table, resource){
    let change_path = "Routes.set_position_"+resource+"_path(I18n.locale, id, position)";

    $(table).on('click', '.set-position-btn', function (e) {
        e.preventDefault();
        let id = $(this).parents('tr').attr('id');
        let position = $(this).data('position');

        $.get(eval(change_path), function () {
            $(table).DataTable().draw(false);
        });
    })
}

function showFormErrors(form, errors, fullErrors){
    form.find('.is-invalid').removeClass('is-invalid');
    form.find('.alert').remove();
    form.find('span.invalid-feedback').remove();

    let html = '<div class="alert alert-danger">';
    let error = '';

    if(_.isArray(errors)){
        html += I18n.t('simple_form.error_notification.default_message');
        html += '<ul>';

        $.each(errors, function (k,v) {
            html += '<li>'+v+'</li>';
        });

        html += '</ul>';
    }else{
        html += errors;
    }

    html += '</div>';

    if(!_.isObject(form)){
       form = $(form);
    }

    form.prepend(html);

    if(typeof fullErrors !== 'undefined'){
        if(_.isObject(fullErrors)){
            $.each(fullErrors, function (index, error) {
                form.find('[name$="['+index+']"]').addClass('is-invalid')
                    .parents('.form-group').append('<span class="invalid-feedback">'+error+'</span>');
            });
        }
    }
}