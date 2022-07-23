require "csv"
require "erb"
require "time"
require "google/apis/civicinfo_v2"

def clean_phone_number(phone_number)
  phone_number = phone_number.split("")
  unwanted_chars = phone_number.reject { |char| ("0".."9").include?(char) }.uniq

  phone_number -= unwanted_chars

  phone_number.shift if phone_number[0] == "1" && phone_number.length > 10

  # stardard formatting to "(xxx) xxx-xxxx", e.g. "(123) 456-1000"
  if phone_number.length == 10
    return "(#{phone_number[0..2].join}) #{phone_number[3..5].join}-#{phone_number[6..].join}"
  end

  "bad number"
end

def clean_zipcode(zipcode)
  zipcode = zipcode.to_s

  if zipcode.length < 5
    zipcode.rjust(5, '0')
  elsif zipcode.length > 5
    zipcode[0..4]
  else
    zipcode
  end
end

def legislators_by_zipcode(zipcode, civic_info)
  civic_info.representative_info_by_address(
    address: zipcode,
    levels: "country",
    roles: %w[legislatorUpperBody legislatorLowerBody]
  ).officials
rescue StandardError
  "You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials"
end

def save_thank_you_letter(id, form_letter)
  Dir.mkdir("output") unless Dir.exist?("output")

  filename = "output/thanks_#{id}.html"

  File.open(filename, "w") do |file|
    file.puts form_letter
  end
end

def get_formatted_time(time)
  Time.strptime(time, "%m/%d/%Y %H:%M") do |year|
    if year >= 69
      year + 1900
    else
      year + 2000
    end
  end
end

def get_peak_registration_hours(registration_times)
  registration_hours = registration_times.map { |time| get_formatted_time(time).hour }
  number_of_registrations = registration_hours.to_h { |hour| [hour, registration_hours.count(hour)] }

  # Sorts the hash by the highest value to the lowest value.
  # e.g. {a: 2, b: 8, c: 1, d: 5} => {b: 8, d: 5, a: 2, c: 1}
  # Hash#sort returns an Array, to_h fixes that
  number_of_registrations.sort { |hash_a, hash_b| hash_b[1] <=> hash_a[1] }.to_h
end

def get_peak_registration_weekdays(registration_times)
  registration_weekdays = registration_times.map { |time| get_formatted_time(time).wday }
  number_of_registrations = registration_weekdays.to_h { |weekday| [weekday, registration_weekdays.count(weekday)] }

  number_of_registrations = number_of_registrations.sort { |hash_a, hash_b| hash_b[1] <=> hash_a[1] }.to_h

  weekdays = {
    0 => "sunday",
    1 => "monday",
    2 => "tuesday",
    3 => "wednesday",
    4 => "thursday",
    5 => "friday",
    6 => "saturday"
  }

  number_of_registrations.transform_keys { |key| weekdays[key] }
end

puts "Event Manager Initialized!"
puts

civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
civic_info.key = "AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw"

contents = CSV.open(
  "event_attendees.csv",
  headers: true,
  header_converters: :symbol
)

template_letter = File.read "form_letter.erb"
erb_template = ERB.new template_letter

registration_times = []

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  registration_times << row[:regdate]

  zipcode = clean_zipcode(row[:zipcode])

  phone_number = clean_phone_number(row[:homephone])

  legislators = legislators_by_zipcode(zipcode, civic_info)

  form_letter = erb_template.result(binding)

  save_thank_you_letter(id, form_letter)
end

peak_registration_hours = get_peak_registration_hours(registration_times)
peak_registration_weekdays = get_peak_registration_weekdays(registration_times)
