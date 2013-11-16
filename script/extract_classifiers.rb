require 'csv'
year = 2013
gaa = CSV.read("data/#{year}-GAA.csv"); nil
gaa_columns = gaa.first; nil
gaa.delete(gaa_columns); nil
na = CSV.read("data/#{year}-NA.csv"); nil
na_columns = na.first; nil
na.delete(na_columns); nil
dpt = {}
agency = {}
area = {}
budget = []
gaa.each do |line|
  next if line.size == 0
  (dpt_cd, dpt_name, agency_type, agency_cd, agency_name, code, description, area_cd, area_name, ps, mooe, co, net, *rest) = line
  raise "Derp: #{rest.inspect}" unless rest.empty?
  dpt_cd = dpt_cd.upcase.strip
  dpt[dpt_cd] = dpt_name.strip unless dpt.has_key?(dpt_cd)
  agency_cd = agency_cd.upcase.strip
  agency[agency_cd] = [agency_type.strip, agency_name.strip, dpt_cd] unless agency.has_key?(agency_cd)
  area_cd = area_cd.strip
  if (area_cd =~ /^\d+$/)
    area_cd = area_cd.to_i
  end
  area[area_cd] = area_name unless area.has_key? area_cd
  budget << [year, agency_cd, area_cd, "#{code.strip}.".encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: ''), description.strip.encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: ''), (ps || '0').strip.to_f, (mooe || '0').strip.to_f, (co || '0').strip.to_f, false]
end; nil
na.each do |line|
  next if line.size == 0
  (dpt_cd, dpt_name, agency_type, agency_cd, agency_name, code, description, area_cd, area_name, ps, mooe, co, net, *rest) = line
  raise "Derp: #{rest.inspect}" unless rest.empty?
  dpt_cd = dpt_cd.upcase.strip
  dpt[dpt_cd] = dpt_name.strip unless dpt.has_key?(dpt_cd)
  agency_cd = agency_cd.upcase.strip
  agency[agency_cd] = [agency_type.strip, agency_name.strip, dpt_cd] unless agency.has_key?(agency_cd)
  area_cd = area_cd.strip
  if (area_cd =~ /^\d+$/)
    area_cd = area_cd.to_i
  end
  area[area_cd] = area_name unless area.has_key? area_cd
  budget << [year, agency_cd, area_cd, "#{code.strip}.".encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: ''), description.strip.encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: ''), (ps || '0').strip.to_f, (mooe || '0').strip.to_f, (co || '0').strip.to_f, true]
end; nil
CSV.open("data/departments.csv", "wb") do |csv|
  dpt.each { |k,v| csv << [k, v].flatten }
end
CSV.open("data/agencies.csv", "wb") do |csv|
  agency.each { |k,v| csv << [k, v].flatten }
end
CSV.open("data/areas.csv", "wb") do |csv|
  area.each { |k,v| csv << [k, v].flatten }
end
CSV.open("data/#{year}-appropriations.csv", "wb") do |csv|
  budget.each { |item| csv << item }
end; nil