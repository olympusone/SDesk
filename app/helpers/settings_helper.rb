module SettingsHelper
  def setting_input(f, var, values, options={})
    _as = options[:as].present? ? options[:as] : :string

    wrapper_html = options[:wrapper_html] || nil

    if options[:collection].present?
      f.input var, label: t("activerecord.attributes.setting.#{var}"), include_blank: false, as: _as, collection: options[:collection], input_html:{class:'select2', value: values[var]}, wrapper_html: wrapper_html
    elsif options[:as] == :boolean
      f.input var, label: false, wrapper_html: wrapper_html do
        %Q[#{f.input_field var, as: :boolean, class: "js-switch", checked: values[var.to_s].to_i == 1} #{label_tag(var, t("activerecord.attributes.setting.#{var}"))}].html_safe
      end
    else
      f.input var, label: t("activerecord.attributes.setting.#{var}"), as: _as, input_html:{value: values[var]}, wrapper_html: wrapper_html
    end
  end
end
