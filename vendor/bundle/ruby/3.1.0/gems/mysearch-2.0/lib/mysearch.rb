class MySearch

  def self.booking(attributes, keyword)
    query_attrs = attributes.map { |a| "#{a.to_s}::TEXT ILIKE '%#{keyword}%'"}.join(' OR ')
    Booking.where(query_attrs)
  end

  def self.user(attributes, keyword)
    query_attrs = attributes.map { |a| "#{a.to_s}::TEXT ILIKE '%#{keyword}%'"}.join(' OR ')
    puts query_attrs
    User.where(query_attrs)
  end

  def self.flight(attributes, keyword)
    query_attrs = attributes.map { |a| "#{a.to_s}::TEXT ILIKE '%#{keyword}%'"}.join(' OR ')
    Flight.where(query_attrs)
  end

  def self.hotel(attributes, keyword)
    query_attrs = attributes.map { |a| "#{a.to_s}::TEXT ILIKE '%#{keyword}%'"}.join(' OR ')
    Hotel.where(query_attrs)
  end

end