// Data source: https://github.com/CSSEGISandData/COVID-19/blob/master/csse_covid_19_data/csse_covid_19_daily_reports/03-17-2020.csv

capture cd "$GoogleDriveWork"
capture cd "$GoogleDriveLaptop"
capture cd "$Presentations"
capture cd ".\Talks\2020\Webinar_COVID19\examples\data\"


global Width4x3 = 1440*2
global Height4x3 = 1080*2

clear all


// Import a single .csv file
clear
import delimited "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/01-29-2020.csv"

describe
list in 1/5


// add the option ", encoding(utf-8)
//  Thank you Jean-Claude Arbaut!!!
clear
import delimited "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/01-29-2020.csv", encoding(utf-8)

describe
list in 1/5


// Storing things with locals
local today = "3-18-2020"
display "`today'"




// Create locals from locals
local month = "3" 
local day   = "18"
local year  = "2020"
local today = "`month'-`day'-`year'"
display "`today'"




// Add leading zeros using string()
local month = string(3, "%02.0f") 
local day   = string(19, "%02.0f") 
local year  = "2020"
local today = "`month'-`day'-`year'"
display "`today'"

// Store the URL to a local
local URL = "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/"
display "`URL'"

// Import data using the local FileName
clear
local FileName = "`URL'`today'.csv"
import delimited "`FileName'", encoding(utf-8)
describe





// Loop over months
forvalues month = 1/12 {
    display "month = `month'"
}



// Loop over months and days
forvalues month = 1/12 {
    forvalues day = 1/31 {
        display "month = `month', day = `day'"
    }
}




// Loop and create local "today"
forvalues month = 1/12 {
    forvalues day = 1/31 {
        local month = string(`month', "%02.0f") 
        local day   = string(`day', "%02.0f") 
        local year  = "2020"
        local today = "`month'-`day'-`year'"
        display "`today'"
    }
}




// Import and save each data file (time to loop = 60 seconds)
local URL = "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/"
forvalues month = 1/12 {
    forvalues day = 1/31 {
        local month = string(`month', "%02.0f") 
        local day = string(`day', "%02.0f") 
        local year = "2020"
        local today = "`month'-`day'-`year'"
        local FileName = "`URL'`today'.csv"
        clear
        capture import delimited "`FileName'", encoding(utf-8)
        capture save "`today'", replace
    }
}

// list the files
ls




// Append two data files that match
clear
append using 01-22-2020.dta
append using 01-23-2020.dta


// Some variable names changed on 3/21/2020
describe using 03-21-2020.dta
describe using 03-22-2020.dta

clear
append using 03-21-2020.dta
append using 03-22-2020.dta
describe



// Rename the variables names that changed on 3/21/2020
local URL = "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/"
forvalues month = 1/12 {
    forvalues day = 1/31 {
        local month = string(`month', "%02.0f") 
        local day   = string(`day', "%02.0f") 
        local year  = "2020"
        local today = "`month'-`day'-`year'"
        local FileName = "`URL'`today'.csv"
        clear
        capture import delimited "`FileName'", encoding(utf-8)
		capture rename province_state provincestate
		capture rename country_region countryregion
		capture rename last_update lastupdate
		capture rename lat latitude
		capture rename long longitude
        capture save "`today'", replace
    }
}


// Verify that the variable names match
describe using 03-21-2020.dta
describe using 03-22-2020.dta

// Verify that the files append correctly
clear
append using 03-21-2020.dta
append using 03-22-2020.dta
describe


// Use loops to append all data files
clear
forvalues month = 1/12 {
    forvalues day = 1/31 {
        local month = string(`month', "%02.0f") 
        local day = string(`day', "%02.0f") 
        local year = "2020"
        local today = "`month'-`day'-`year'"
        capture append using "`today'"
    }
}


describe


// List the first and last five obs of "lastupdate"
list lastupdate in 1/5
list lastupdate in -5/l


// Generate the variable "tempdate"
local URL = "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/"
forvalues month = 1/12 {
    forvalues day = 1/31 {
        local month = string(`month', "%02.0f") 
        local day = string(`day', "%02.0f") 
        local year = "2020"
        local today = "`month'-`day'-`year'"
        local FileName = "`URL'`today'.csv"
        clear
        capture import delimited "`FileName'", encoding(utf-8)
        capture rename province_state provincestate
        capture rename country_region countryregion
        capture rename last_update lastupdate
        capture rename lat latitude
        capture rename long longitude
        generate tempdate = "`today'"
        capture save "`today'", replace
    }
}
clear
forvalues month = 1/12 {
    forvalues day = 1/31 {
        local month = string(`month', "%02.0f") 
        local day = string(`day', "%02.0f") 
        local year = "2020"
        local today = "`month'-`day'-`year'"
        capture append using "`today'"
    }
}



// List the first and last 5 obs of "tempdate"
list tempdate in 1/5
list tempdate in -5/l


// Display the numeric date for "03-23-2020"
display date("03-23-2020", "MDY")


// Show that 01-01-1960 is the zero of the time line
display date("01-01-1960", "MDY")


// Change the display format for 03-23-2020
display %tdNN/DD/CCYY date("03-23-2020", "MDY")


// Use date() to generate "date" from "tempdate"
generate date = date(tempdate, "MDY")
list lastupdate tempdate date in -5/l


// Format "date"
format date %tdNN/DD/CCYY
list lastupdate tempdate date in -5/l


// Save the dataset
save covid19_date, replace



// keep the data for the United States
use covid19_date, clear
keep if countryregion=="US"

// List confirmed, deaths, and recovered on 1/26/2020
list date confirmed deaths recovered           ///
     if date==date("1/26/2020", "MDY"), abbreviate(13)

// collapse the data by(date)   
collapse (sum) confirmed deaths recovered, by(date)
list date confirmed deaths recovered           ///
     if date==date("1/26/2020", "MDY"), abbreviate(13)

     
// collapse the data for all countries by(date)
use covid19_date, clear
collapse (sum) confirmed deaths recovered, by(date)

describe 
list in 1/5, abbreviate(9)

// format with commas
format %12.0fc confirmed deaths recovered
list, abbreviate(9)  

// Declare time series
tsset date, daily

twoway (tsline confirmed) 
twoway (tsline deaths)   
twoway (tsline confirmed, recast(bar))


// Use the D. operator to calculate "newcases"
generate newcases = D.confirmed
list, abbreviate(9) 

twoway (tsline newcases) 





// Time series by country
// =====================================================================
// Start with the raw data
use covid19_date, clear
tab countryregion 

// replace "Mainland China" with "China"
replace countryregion = "China" if countryregion=="Mainland China"

// keep the data from China, Italy, and the US
keep if inlist(countryregion, "China", "Italy", "US")
tab countryregion

// collapse the data by data and country
collapse (sum) confirmed deaths recovered, by(date countryregion)
list date countryregion confirmed deaths recovered /// 
     in -9/l, sepby(date) abbreviate(13) 

// create a numeric variable for country
encode countryregion, gen(country)
list date countryregion country  /// 
     in -9/l, sepby(date) abbreviate(13) 

label list country

// tsset time series data with panels
tsset country date, daily

// Save the "long" version of the data
save covid19_long, replace



// Create a "wide" version of the data
use covid19_long, clear

describe

// Keep only the data we will reshape
keep date country confirmed deaths recovered

// reshape the data from "long" to "wide"
reshape wide confirmed deaths recovered, i(date) j(country)

describe
list date confirmed1 confirmed2 confirmed3  ///
     in -5/l, abbreviate(13)

// rename the variables     
rename confirmed1 china_c
rename deaths1    china_d
rename recovered1 china_r

rename confirmed2 italy_c
rename deaths2    italy_d
rename recovered2 italy_r 

rename confirmed3 usa_c
rename deaths3    usa_d
rename recovered3 usa_r

// label the variables
label var china_c "China cases"
label var china_d "China deaths"
label var china_r "China recovered"
label var italy_c "Italy cases"
label var italy_d "Italy deaths"
label var italy_r "Italy recovered"
label var usa_c "USA cases"
label var usa_d "USA deaths"
label var usa_r "USA recovered"

describe
list date china_c italy_c usa_c  ///
     in -5/l, abbreviate(13)

// Plot the data     
twoway (line china_c date, lwidth(thick))          ///
       (line italy_c date, lwidth(thick))          ///
       (line usa_c   date, lwidth(thick))          ///
       , legend(rows(1))                           ///
       ylabel(, angle(horizontal) format(%12.0fc))



// Generate count data per million population
generate china_ca = china_c / 1389.6
generate italy_ca = italy_c / 62.3 
generate usa_ca   = usa_c / 331.8     
label var china_ca "China cases adj."
label var italy_ca "Italy cases adj."
label var usa_ca "USA cases adj."     
format %9.0f china_ca italy_ca usa_ca

// Plot the population-adjusted cases
twoway (line china_ca date, lwidth(thick))         ///
       (line italy_ca date, lwidth(thick))         ///
       (line usa_ca   date, lwidth(thick))         ///
       , legend(rows(1))                           ///
       ylabel(, angle(horizontal) format(%12.0fc))

       
      
// Add notes
notes china_ca: china_ca = china_c / 1389.6
notes china_ca: Population data source: https://www.census.gov/popclock/
notes italy_ca: italy_ca = italy_c / 62.3
notes italy_ca: Population data source: https://www.census.gov/popclock/
notes usa_ca:   usa_ca = usa_c / 331.8
notes usa_ca:   Population data source: https://www.census.gov/popclock/    


// Label the dataset and add notes to the dataset
label data "COVID-19 Data assembled for the Stata Blog"
notes _dta: Raw data course: https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data/csse_covid_19_daily_reports
notes _dta: These data are for instructional purposes only


// Declare time series data
tsset date, daily    

// Save the "wide" data
save covid19_wide, replace    

