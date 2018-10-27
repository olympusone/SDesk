module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def default_meta_tags
    {
        site:        Setting.company_name,
        title:       Setting.seo_title,
        description: Setting.seo_description,
        keywords:    Setting.seo_keywords,
    }
  end

  def image_input(form, image_object, options={})
    css_class = options[:css] || 'mx-auto d-block'

    if image_object.attached?
      image = image_tag(image_object,
                        width: options[:width],
                        id: options[:id],
                        data: options[:data],
                        class: css_class,
                        lazy: options[:lazy],
                        style: options[:style])
    else
      image = nil
    end

    %Q[
      #{image}
      #{form.input image_object.name}
    ].html_safe
  end

  def locale_icon(locale, options = {})
    image_tag ['locales', "#{locale.to_s}.png"].join('/'), options
  end

  def page_title
    content_for?(:title) ? content_for(:title) : I18n.t([controller_name, action_name, 'title'].join('.'))
  end

  def header_btn(title, link, options = {})
    content_for :header_button do
      link_to link, class: 'btn btn-info d-none d-lg-block m-l-15', remote: options[:remote] do
        %Q[<span>
            <i class="fas fa-#{options[:icon].present? ? options[:icon] : 'plus'}"></i>
            <span>#{title.html_safe}</span>
          </span>].html_safe
      end
    end
  end

  # Datatable helpers
  def table_actions(record, *options)
    btns = []

    if options.present?
      options.each do |o|
        if o.is_a? Hash
          o.each do |op|
            btns << send("table_#{op.first}_btn", record, remote: op.last[:remote].present?)
          end
        elsif o.is_a? Symbol
          btns << send("table_#{o}_btn", record)
        end
      end
    end

    btns.join(' ').html_safe
  end

  def table_edit_btn(record, options = {})
    if can?(:edit, record)
      link_to(icon('fas', 'edit'), {id: record.id, action: :edit, controller: record.model_name.route_key}, class: 'btn btn-sm btn-icon btn-warning btn-outline ', remote: options[:remote].present?, data: {skin: 'dark', toggle: 'tooltip', placement: 'top'}, title: t('datatable.edit'))
    end
  end

  def table_show_btn(record, options = {})
    if can?(:show, record)
      link_to(icon('fas', 'info'), record, class: 'btn btn-sm btn-icon btn-info btn-outline ', remote: options[:remote].present?, data: {skin: 'dark', toggle: 'tooltip', placement: 'top'}, title: t('datatable.show'))
    end
  end

  def table_destroy_btn(record, options = {})
    if can?(:destroy, record)
      link_to(icon('fas', 'times'), send("#{record.model_name.param_key}_path", record.id), class: 'btn btn-sm btn-icon btn-danger btn-outline ', method: :delete, remote: options[:remote].present?, title: t('datatable.delete'), data: {skin: 'dark', toggle: 'tooltip', placement: 'top', confirm: t('confirmation.delete')})
    end
  end

  # Cancel link for forms
  def cancel_btn(path = root_path, options = {})
    btn_class = ['btn btn-warning waves-effect waves-light']
    btn_class << options[:class] if options[:class].present?

    link_to t('btn.cancel'), path, class: btn_class.join(' ')
  end

  def delete_btn(resource, options = {})
    if can?(:destroy, resource) && resource.persisted?
      btn_class = ['btn btn-danger waves-effect waves-light']
      btn_class << options[:class] if options[:class].present?
      route = options[:route].present? ? options[:route] : resource
      link_to t('btn.delete'), send("#{resource.model_name.param_key}_path"), class: btn_class.join(' '), method: :delete, remote: options[:remote].present?, data: {confirm: t('confirmation.delete')}
    end
  end

  # return value from datatable params by given index
  def dt_params_val(index, options = {})
    _param = params['columns'][index.to_s]['search']['value']

    if options[:join].present?
      _param.split(',').map(&:strip).reject(&:blank?).join(options[:join])
    else
      _param
    end
  end
end
