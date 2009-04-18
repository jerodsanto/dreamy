class Hash
  def to_param_array
    p = Array.new
    self.each do |k,v|
      p << "#{k}=#{v}"
    end
    p
  end
end