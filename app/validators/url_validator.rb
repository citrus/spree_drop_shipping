require 'uri'

class UrlValidator < ActiveModel::EachValidator
  
  def validate_each(record, attribute, value)
    
    begin
      uri = URI.parse(value)
      allowed_schemes = options[:schemes] || %w(http https)
      raise(URI::InvalidURIError) unless allowed_schemes.include?(uri.scheme)
      raise(URI::InvalidURIError) if [ :scheme, :host ].any?{ |i| uri.send(i).blank? }
    rescue URI::InvalidURIError => e
      record.errors.add(attribute, :invalid, :default => options[:message], :value => value)
    end
           
  end
      
end
