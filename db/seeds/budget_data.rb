require 'csv'
source = File.join(Rails.root, 'data', 'departments.csv')
CSV.foreach(source) do |line|
  (code, name) = line
  item = Department.find_or_create_by_code(code)
  item.assign_attributes({name: name}, without_protection: true)
  item.save!
end

source = File.join(Rails.root, 'data', 'agencies.csv')
CSV.foreach(source) do |line|
  (code, agency_type, name, department) = line
  parent = Department.find_by_code(department)
  item = Owner.find_or_create_by_code(code)
  item.assign_attributes({name: name, classification: agency_type, department: parent}, without_protection: true)
  item.save!
end

source = File.join(Rails.root, 'data', 'areas.csv')
CSV.foreach(source) do |line|
  (code, name) = line
  item = Area.find_or_create_by_code(code)
  item.assign_attributes({name: name}, without_protection: true)
  item.save!
end

ActiveRecord::Base.transaction do
  source = File.join(Rails.root, 'data', '2013-appropriations.csv')
  CSV.foreach(source) do |line|
    (year, agency_code, area_code, code, description, ps, mooe, co, new_appropriation) = line
    owner = Owner.find_by_code(agency_code)
    area = Area.find_by_code(area_code)
    item = GeneralAppropriation.find_or_create_by_year_and_code(year, code)
    item.assign_attributes({
                               description: description,
                               budget_ps: ps,
                               budget_mooe: mooe,
                               budget_co: co,
                               new_appropriation: new_appropriation,
                               owner: owner,
                               area: area}, without_protection: true)
    item.save!
  end
end