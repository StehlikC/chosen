countries = ["", "United States", "United Kingdom", "Afghanistan", "Aland Islands", "Albania", "Algeria", "American Samoa", "Andorra", "Angola", "Anguilla", "Antarctica", "Antigua and Barbuda", "Argentina", "Armenia", "Aruba", "Australia", "Austria", "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bermuda", "Bhutan", "Bolivia, Plurinational State of", "Bonaire, Sint Eustatius and Saba", "Bosnia and Herzegovina", "Botswana", "Bouvet Island", "Brazil", "British Indian Ocean Territory", "Brunei Darussalam", "Bulgaria", "Burkina Faso", "Burundi", "Cambodia", "Cameroon", "Canada", "Cape Verde", "Cayman Islands", "Central African Republic", "Chad", "Chile", "China", "Christmas Island", "Cocos (Keeling) Islands", "Colombia", "Comoros", "Congo", "Congo, The Democratic Republic of The", "Cook Islands", "Costa Rica", "Cote D'ivoire", "Croatia", "Cuba", "Curacao", "Cyprus", "Czech Republic", "Denmark", "Djibouti", "Dominica", "Dominican Republic", "Ecuador", "Egypt", "El Salvador", "Equatorial Guinea", "Eritrea", "Estonia", "Ethiopia", "Falkland Islands (Malvinas)", "Faroe Islands", "Fiji", "Finland", "France", "French Guiana", "French Polynesia", "French Southern Territories", "Gabon", "Gambia", "Georgia", "Germany", "Ghana", "Gibraltar", "Greece", "Greenland", "Grenada", "Guadeloupe", "Guam", "Guatemala", "Guernsey", "Guinea", "Guinea-bissau", "Guyana", "Haiti", "Heard Island and Mcdonald Islands", "Holy See (Vatican City State)", "Honduras", "Hong Kong", "Hungary", "Iceland", "India", "Indonesia", "Iran, Islamic Republic of", "Iraq", "Ireland", "Isle of Man", "Israel", "Italy", "Jamaica", "Japan", "Jersey", "Jordan", "Kazakhstan", "Kenya", "Kiribati", "Korea, Democratic People's Republic of", "Korea, Republic of", "Kuwait", "Kyrgyzstan", "Lao People's Democratic Republic", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libya", "Liechtenstein", "Lithuania", "Luxembourg", "Macao", "Macedonia, The Former Yugoslav Republic of", "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali", "Malta", "Marshall Islands", "Martinique", "Mauritania", "Mauritius", "Mayotte", "Mexico", "Micronesia, Federated States of", "Moldova, Republic of", "Monaco", "Mongolia", "Montenegro", "Montserrat", "Morocco", "Mozambique", "Myanmar", "Namibia", "Nauru", "Nepal", "Netherlands", "New Caledonia", "New Zealand", "Nicaragua", "Niger", "Nigeria", "Niue", "Norfolk Island", "Northern Mariana Islands", "Norway", "Oman", "Pakistan", "Palau", "Palestinian Territory, Occupied", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines", "Pitcairn", "Poland", "Portugal", "Puerto Rico", "Qatar", "Reunion", "Romania", "Russian Federation", "Rwanda", "Saint Barthelemy", "Saint Helena, Ascension and Tristan da Cunha", "Saint Kitts and Nevis", "Saint Lucia", "Saint Martin (French part)", "Saint Pierre and Miquelon", "Saint Vincent and The Grenadines", "Samoa", "San Marino", "Sao Tome and Principe", "Saudi Arabia", "Senegal", "Serbia", "Seychelles", "Sierra Leone", "Singapore", "Sint Maarten (Dutch part)", "Slovakia", "Slovenia", "Solomon Islands", "Somalia", "South Africa", "South Georgia and The South Sandwich Islands", "South Sudan", "Spain", "Sri Lanka", "Sudan", "Suriname", "Svalbard and Jan Mayen", "Swaziland", "Sweden", "Switzerland", "Syrian Arab Republic", "Taiwan, Province of China", "Tajikistan", "Tanzania, United Republic of", "Thailand", "Timor-leste", "Togo", "Tokelau", "Tonga", "Trinidad and Tobago", "Tunisia", "Turkey", "Turkmenistan", "Turks and Caicos Islands", "Tuvalu", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom", "United States", "United States Minor Outlying Islands", "Uruguay", "Uzbekistan", "Vanuatu", "Venezuela, Bolivarian Republic of", "Viet Nam", "Virgin Islands, British", "Virgin Islands, U.S.", "Wallis and Futuna", "Western Sahara", "Yemen", "Zambia", "Zimbabwe"]

sharedBehavior = (context) ->

  chosen = null

  beforeEach ->
    chosen = context.chosen

  test_search_string_match = (string, search) ->
    regex = chosen.get_search_regex(search)
    expect(chosen.search_string_match(string, regex)).toBe(true)

  test_search_string_no_match = (string, search) ->
    regex = chosen.get_search_regex(search)
    expect(chosen.search_string_match(string, regex)).toBe(undefined)

  test_highlight_string = (expected, string, search) ->
    regex = chosen.get_search_regex(search)
    zregex = new RegExp(search.replace(/[-[\]{}()*+?.,\\^$|#\s]/g, "\\$&"), 'i')
    expect(chosen.highlight_search_result(regex, zregex, string, search)).toBe(expected)

  describe "search", ->

    it "should match on different strings", ->
      start = Date.now()

      test_search_string_match('United States', 'U')
      test_search_string_match('United States', 'Un')
      test_search_string_match('United States', 'Uni')
      test_search_string_match('United States', 'Unit')
      test_search_string_match('United States', 'Unite')
      test_search_string_match('United States', 'United')
      test_search_string_match('United States', 'United S')
      test_search_string_match('United States', 'United St')
      test_search_string_match('United States', 'United Sta')
      test_search_string_match('United States', 'United Stat')
      test_search_string_match('United States', 'United State')
      test_search_string_match('United States', 'United States')
      test_search_string_no_match('United States', 'States United')
      test_search_string_no_match('United States', 'States Unite')
      test_search_string_no_match('United States', 'States Unit')
      test_search_string_no_match('United States', 'States Uni')
      test_search_string_no_match('United States', 'States Un')
      test_search_string_no_match('United States', 'States U')
      test_search_string_match('United States', 'States')
      test_search_string_match('United States', 'State')
      test_search_string_match('United States', 'Stat')
      test_search_string_match('United States', 'Sta')
      test_search_string_match('United States', 'St')
      test_search_string_match('United States', 'S')

      test_search_string_no_match('Bonaire, Sint Eustatius and Saba', 'S E and Bo')

      console.log('Time spent: ' + (Date.now() - start) + 'ms')

    it "should highlight the result", ->
      start = Date.now()

      test_highlight_string('<em>U</em>nited States', 'United States', 'U')
      test_highlight_string('Unit<em>e</em>d States', 'United States', 'e')

      console.log('Time spent: ' + (Date.now() - start) + 'ms')

sharedFuzzyBehavior = (context) ->

  chosen = null

  beforeEach ->
    chosen = context.chosen

  test_search_string_match = (string, search) ->
    regex = chosen.get_search_regex(search)
    expect(chosen.search_string_match(string, regex)).toBe(true)

  test_search_string_no_match = (string, search) ->
    regex = chosen.get_search_regex(search)
    expect(chosen.search_string_match(string, regex)).toBe(undefined)

  test_highlight_string = (expected, string, search) ->
    regex = chosen.get_search_regex(search)
    zregex = new RegExp(search.replace(/[-[\]{}()*+?.,\\^$|#\s]/g, "\\$&"), 'i')
    expect(chosen.highlight_search_result(regex, zregex, string, search)).toBe(expected)

  describe "search_fuzzy", ->

    describe "#search_string_match", ->
      it "should match on different strings", ->
        start = Date.now()

        test_search_string_match('United States', 'U')
        test_search_string_match('United States', 'Un')
        test_search_string_match('United States', 'Uni')
        test_search_string_match('United States', 'Unit')
        test_search_string_match('United States', 'Unite')
        test_search_string_match('United States', 'United')
        test_search_string_match('United States', 'United S')
        test_search_string_match('United States', 'United St')
        test_search_string_match('United States', 'United Sta')
        test_search_string_match('United States', 'United Stat')
        test_search_string_match('United States', 'United State')
        test_search_string_match('United States', 'United States')
        test_search_string_match('United States', 'States United')
        test_search_string_match('United States', 'States Unite')
        test_search_string_match('United States', 'States Unit')
        test_search_string_match('United States', 'States Uni')
        test_search_string_match('United States', 'States Un')
        test_search_string_match('United States', 'States U')
        test_search_string_match('United States', 'States')
        test_search_string_match('United States', 'State')
        test_search_string_match('United States', 'Stat')
        test_search_string_match('United States', 'Sta')
        test_search_string_match('United States', 'St')
        test_search_string_match('United States', 'S')

        test_search_string_match('Bonaire, Sint Eustatius and Saba', 'S E and Bo')

        console.log('Time spent: ' + (Date.now() - start) + 'ms')

    describe "#highlight_search_result", ->
      it "should highlight the result", ->
        start = Date.now()

        test_highlight_string('<em>U</em>nited States', 'United States', 'U')
        test_highlight_string('Unit<em>e</em>d Stat<em>e</em>s', 'United States', 'e')
        test_highlight_string('Unit<em>e</em>d Stat<em>e</em>s', 'United States', 'e e')
        test_highlight_string('<em>United</em> <em>States</em>', 'United States', 'States United')
        test_highlight_string('<em>United</em> <em>States</em>', 'United States', 'United States')
        test_highlight_string('United <em>Stat</em>es', 'United States', 'es stat')
        test_highlight_string('<em>Coco</em>s <em>(Kee</em>ling) Is<em>lands</em>', 'Cocos (Keeling) Islands', 'lands coco (kee')
        test_highlight_string('Bolivia<em>,</em> <em>Plur</em>inational State of', 'Bolivia, Plurinational State of', ', plur')

        console.log('Time spent: ' + (Date.now() - start) + 'ms')
