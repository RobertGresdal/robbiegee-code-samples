require "watir"

test_site = "http://www.google.com"

ie = Watir::IE.new

puts "Beginning of test: Google search."

puts " Step 1: go to the test site: " + test_site
ie.goto test_site

puts " Step 2: enter 'pickaxe' in the search text field."
ie.text_field(:name, "q").set "pickaxe"

puts " Step 3: click the 'Google Search' button."
ie.button(:name, "btnG").click

puts " Expected Result:"
puts "  A Google page with results should be shown."

puts " Actual Result:"
if ie.text.include? "Programming Ruby"
    puts "  PASS"
else
    puts  "FAIL"
end

puts "End of test"