class CountryCodeHelper {

  static String getCode(String country) {

    final codes = {

      "Afghanistan": "AF",
      "Albania": "AL",
      "Algeria": "DZ",
      "Andorra": "AD",
      "Angola": "AO",
      "Argentina": "AR",
      "Armenia": "AM",
      "Australia": "AU",
      "Austria": "AT",
      "Azerbaijan": "AZ",

      "Bangladesh": "BD",
      "Belarus": "BY",
      "Belgium": "BE",
      "Belize": "BZ",
      "Bolivia": "BO",
      "Bosnia and Herzegovina": "BA",
      "Brazil": "BR",
      "Bulgaria": "BG",

      "Cambodia": "KH",
      "Canada": "CA",
      "Chile": "CL",
      "China": "CN",
      "Colombia": "CO",
      "Croatia": "HR",
      "Cyprus": "CY",
      "Czech Republic": "CZ",

      "Denmark": "DK",
      "Dominican Republic": "DO",

      "Ecuador": "EC",
      "Egypt": "EG",
      "Estonia": "EE",
      "Ethiopia": "ET",

      "Finland": "FI",
      "France": "FR",

      "Georgia": "GE",
      "Germany": "DE",
      "Ghana": "GH",
      "Greece": "GR",

      "Hong Kong": "HK",
      "Hungary": "HU",

      "Iceland": "IS",
      "India": "IN",
      "Indonesia": "ID",
      "Iran": "IR",
      "Iraq": "IQ",
      "Ireland": "IE",
      "Israel": "IL",
      "Italy": "IT",

      "Japan": "JP",
      "Jordan": "JO",

      "Kenya": "KE",
      "Kuwait": "KW",

      "Lebanon": "LB",
      "Luxembourg": "LU",

      "Malaysia": "MY",
      "Maldives": "MV",
      "Malta": "MT",
      "Mexico": "MX",
      "Morocco": "MA",
      "Myanmar": "MM",

      "Nepal": "NP",
      "Netherlands": "NL",
      "New Zealand": "NZ",
      "Nigeria": "NG",
      "Norway": "NO",

      "Oman": "OM",

      "Pakistan": "PK",
      "Peru": "PE",
      "Philippines": "PH",
      "Poland": "PL",
      "Portugal": "PT",

      "Qatar": "QA",

      "Romania": "RO",
      "Russia": "RU",

      "Saudi Arabia": "SA",
      "Serbia": "RS",
      "Singapore": "SG",
      "Slovakia": "SK",
      "Slovenia": "SI",
      "South Africa": "ZA",
      "South Korea": "KR",
      "Spain": "ES",
      "Sri Lanka": "LK",
      "Sweden": "SE",
      "Switzerland": "CH",

      "Taiwan": "TW",
      "Thailand": "TH",
      "Turkey": "TR",

      "Ukraine": "UA",
      "United Arab Emirates": "AE",
      "United Kingdom": "GB",
      "United States": "US",
      "Uruguay": "UY",

      "Venezuela": "VE",
      "Vietnam": "VN",

      "Yemen": "YE",

      "Zimbabwe": "ZW",

    };


    return codes[country.trim()] ?? "UN";

  }

}