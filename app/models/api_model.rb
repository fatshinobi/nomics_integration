class ApiModel
  include ActiveModel::Serializers::JSON

  def is_figure?(in_str)
    in_str.match(/^(\d)+$/)
  end

  def attributes=(hash)
    hash.each do |key, value|
      attr_name = is_figure?(key[0]) ? "_#{key}" : key
      if value.is_a? Hash
        sub_instance = send(attr_name)
        sub_instance.from_json(value.to_json)
      else
        send("#{attr_name}=", value)
      end
    end
  end

  def attributes
    instance_values
  end

end