Spree::Admin::BaseHelper.class_eval do

  def error_message_on(object, method, options = {})
    object = convert_to_model(object).to_s.gsub(/[^a-z0-9]/, '_')
    obj = object.respond_to?(:errors) ? object : instance_variable_get("@#{object}")

    if obj && obj.errors[method].present?
      errors = obj.errors[method].map{|err| h(err)}.join('<br/>').html_safe
      content_tag(:span, errors, :class => 'formError')
    else
      ''
    end
  end

end
