** Are Georgian voters polarized?
** Dustin Gilbreath & Koba Turmanidze
** CRRC policy Bulletin, October, 2020
** https://crrc.ge/en/content/policy-briefs/5/

*******************************************************************************

***** recode and merge datasets
*******************************************************************************
*******************************************************************************

/// 2016 June
clear
//use "https://caucasusbarometer.org/downloads/NDI_2016_Nov_20.12.16_Public.dta"
use "NDI_2016_June_09.07.16.dta"

gen year=1
replace substratum=year*1000+substratum

/// recoding variables for standatization

** interview language
recode ethnocode(2=1 "Non-Georgian")(1=0 "Georgian"), gen(lang) // proxy for language

** survey wave
gen wave_06_16 = 1
lab var wave "survey wave"

** most important issues
recode q1_7(1=1)(-1 0=0)(else=.), gen(jobs)
recode q1_13(1=1)(-1 0=0)(else=.), gen(inflation)
recode q1_11(1=1)(-1 0=0)(else=.), gen(poverty)
recode q1_12(1=1)(-1 0=0)(else=.), gen(territory)

lab var jobs "Jobs"
lab var inflation "Inflation"
lab var poverty "Poverty"
lab var territory "Territory"

** settlement type
gen settype_1=.
replace settype_1=0 if settype==1
replace settype_1=1 if settype==2 | substratum==110
replace settype_1=2 if settype==3 | substratum==120
lab define sett 0 "Capital" 1 "Urban" 2 "Rural"
lab values settype_1 sett
lab var settype_1 "Settlement type"

** party identification
recode q18_1(-1 19=0 "No party")(8=1 "GD")(7=2 "UNM")(3 10 13 15 16=3 "Liberal")(-2=5 "Refusal")(-9/-3=.)(else=4 "Other"), gen(pid_3)
lab var pid_3 "Party closest to you"

** gender
recode sex (1=0 "Male")(2=1 "Female"), gen(gender)
lab var gender "Gender female"

** age groups
recode age (18/37=2 "18-37")(38/57=1 "38-57")(58/100=0 ">57")(else=.), gen(agegr)
lab var agegr "Age groups {0=>57}"

** education
recode q46 (1/4=0 "Below tertiary")(5/6=1 "Tertiary")(else=.), gen(edu)
lab var edu "Tertiary education"

** employment
recode q49(1=1 "Employed")(-1 0=0 "Not employed")(else=.), gen(empl_1)
lab var empl_1 "Employed"

** posessions
foreach v of varlist q51_1-q51_10  {
gen `v'r = `v'
}
recode q51_1r-q51_10r(1=1)(-1 0 =0)(else=.)
egen goods=rowtotal(q51_1r-q51_10r)
lab var goods "Posession of goods"

** EU support
recode q13(1=1 "EU")(-1 0=0 "Not EU")(else=.), gen(eu_1)
** NATO support
recode q17(1=1 "NATO")(-1 0=0 "Not NATO")(else=.), gen(nato_1)
** EU vs Russia
recode q14(1/2=1 "EU")(3/4=2 "Russia")(-1 5=3 "Neither")(else=.), gen(euvsruss_1)
lab var euvsruss_1 "Benefit of joining EU vs Russia"

** keeping needed variables
keep id lang settype_1 gender agegr edu empl_1 goods jobs poverty territory inflation eu_1 nato_1 euvsruss_1 pid_3 /// 
stratum psu substratum npsuss nhhpsu nadhh indwt hhwt wave_06_16

** order variables 
order id lang settype_1 gender agegr edu empl_1 goods jobs poverty territory inflation eu_1 nato_1 euvsruss_1 pid_3 /// 
stratum psu substratum npsuss nhhpsu nadhh indwt hhwt wave_06_16

save "ndi_2016_June.dta", replace  
*******************************************************************************

/// 2016 November
clear 
//use "https://caucasusbarometer.org/downloads/NDI_2016_Nov_20.12.16_Public.dta"
use "NDI_2016_Nov_20.12.16.dta"

gen year=2
replace substratum=year*1000+substratum

/// recoding variables for standatization

** interview language
recode ethnocode(2=1 "Non-Georgian")(1=0 "Georgian"), gen(lang) // proxy for language

** survey wave
gen wave_11_16 = 1
lab var wave "survey wave"

** most important issues
recode q1_7(1=1)(-1 0=0)(else=.), gen(jobs)
recode q1_13(1=1)(-1 0=0)(else=.), gen(inflation)
recode q1_11(1=1)(-1 0=0)(else=.), gen(poverty)
recode q1_12(1=1)(-1 0=0)(else=.), gen(territory)

lab var jobs "Jobs"
lab var inflation "Inflation"
lab var poverty "Poverty"
lab var territory "Territory"

** settlement type
gen settype_1=.
replace settype_1=0 if settype==1
replace settype_1=1 if settype==2 | substratum==42
replace settype_1=2 if settype==3 | substratum==41
lab define sett 0 "Capital" 1 "Urban" 2 "Rural"
lab values settype_1 sett
lab var settype_1 "Settlement type"

** party identification
recode q53_1(-1 23=0 "No party")(8=1 "GD")(7=2 "UNM")(3 10 13 15 16=3 "Liberal")(-2=5 "Refusal")(-9/-3=.)(else=4 "Other"), gen(pid_3)
lab var pid_3 "Party closest to you"

** gender
recode sex (1=0 "Male")(2=1 "Female"), gen(gender)
lab var gender "Gender female"

** age groups
recode age (18/37=2 "18-37")(38/57=1 "38-57")(58/100=0 ">57")(else=.), gen(agegr)
lab var agegr "Age groups {0=>57}"

** education
recode q54 (1/4=0 "Below tertiary")(5/6=1 "Tertiary")(else=.), gen(edu)
lab var edu "Tertiary education"

** employment
recode q57(1=1 "Employed")(-1 0=0 "Not employed")(else=.), gen(empl_1)
lab var empl_1 "Employed"

** posessions
foreach v of varlist q59_1-q59_10  {
gen `v'r = `v'
}
recode q59_1r-q59_10r(1=1)(-1 0 =0)(else=.)
egen goods=rowtotal(q59_1r-q59_10r)
lab var goods "Posession of goods"

** EU support
recode q10(1=1 "EU")(-1 0=0 "Not EU")(else=.), gen(eu_1)
** NATO support
recode q12(1=1 "NATO")(-1 0=0 "Not NATO")(else=.), gen(nato_1)
** EU vs Russia
recode q13(1/2=1 "EU")(3/4=2 "Russia")(-1 5=3 "Neither")(else=.), gen(euvsruss_1)
lab var euvsruss_1 "Benefit of joining EU vs Russia"

** keeping needed variables
keep id lang settype_1 gender agegr edu empl_1 goods jobs poverty territory inflation eu_1 nato_1 euvsruss_1 pid_3 /// 
stratum psu substratum npsuss nhhpsu nadhh indwt hhwt wave_11_16

** order variables 
order id lang settype_1 gender agegr edu empl_1 goods jobs poverty territory inflation eu_1 nato_1 euvsruss_1 pid_3 /// 
stratum psu substratum npsuss nhhpsu nadhh indwt hhwt wave_11_16

save "ndi_2016_Nov.dta", replace  
*******************************************************************************


/// 2017 June
clear
//use "https://caucasusbarometer.org/downloads/NDI_2017_June_12.07.17_public.dta"
use "NDI_2017_June_12.07.17.dta"

gen year=3
replace substratum=year*1000+substratum

/// recoding variables for standatization

** interview language
recode l1(1=0 "Georgian")(2 3=1 "Non-Georgian"), gen(lang)

** survey wave
gen wave_06_17 = 1
lab var wave "survey wave"

** most important issues
recode q1_7(1=1)(-1 0=0)(else=.), gen(jobs)
recode q1_13(1=1)(-1 0=0)(else=.), gen(inflation)
recode q1_11(1=1)(-1 0=0)(else=.), gen(poverty)
recode q1_12(1=1)(-1 0=0)(else=.), gen(territory)

lab var jobs "Jobs"
lab var inflation "Inflation"
lab var poverty "Poverty"
lab var territory "Territory"

** settlement type
gen settype_1=.
replace settype_1=0 if settype==1
replace settype_1=1 if settype==2 | substratum==51
replace settype_1=2 if settype==3 | substratum==52
lab define sett 0 "Capital" 1 "Urban" 2 "Rural"
lab values settype_1 sett
lab var settype_1 "Settlement type"

** party identification
recode q21_1(-1 24=0 "No party")(9=1 "GD")(7=2 "UNM")(3 8 11 14 16 17 19=3 "Liberal")(-2=5 "Refusal")(-9/-3=.)(else=4 "Other"), gen(pid_3)
lab var pid_3 "Party closest to you"

** gender
recode sex (1=0 "Male")(2=1 "Female"), gen(gender)
lab var gender "Gender female"

** age groups
recode age (18/37=2 "18-37")(38/57=1 "38-57")(58/100=0 ">57")(else=.), gen(agegr)
lab var agegr "Age groups {0=>57}"

** education
recode q63 (1/4=0 "Below tertiary")(5/6=1 "Tertiary")(else=.), gen(edu)
lab var edu "Tertiary education"

** employment
recode q66(1=1 "Employed")(-1 0=0 "Not employed")(else=.), gen(empl_1)
lab var empl_1 "Employed"

** posessions
foreach v of varlist q68_1-q68_10  {
gen `v'r = `v'
}
recode q68_1r-q68_10r(1=1)(-1 0 =0)(else=.)
egen goods=rowtotal(q68_1r-q68_10r)
lab var goods "Posession of goods"

** EU support
recode q15(1=1 "EU")(-1 0=0 "Not EU")(else=.), gen(eu_1)
** NATO support
recode q16(1=1 "NATO")(-1 0=0 "Not NATO")(else=.), gen(nato_1)
** EU vs EEU
recode q17(3/4=1 "EU")(1/2=2 "EEU")(-1 5=3 "Neither")(else=.), gen(euvsruss_2)
lab var euvsruss_2 "Benefit of joining EU vs EEU"

** keeping needed variables
keep id lang settype_1 gender agegr edu empl_1 goods jobs poverty territory inflation eu_1 nato_1 euvsruss_2 pid_3 /// 
stratum psu substratum npsuss nhhpsu nadhh indwt hhwt wave_06_17

** order variables 
order id lang settype_1 gender agegr edu empl_1 goods jobs poverty territory inflation eu_1 nato_1 euvsruss_2 pid_3 /// 
stratum psu substratum npsuss nhhpsu nadhh indwt hhwt wave_06_17

save "ndi_2017_Jun.dta", replace  
*******************************************************************************

/// 2017 December
clear all
//use "https://caucasusbarometer.org/downloads/NDI_2017_Dec_25_12_17_public.dta"
use "NDI_2017_Dec_25.12.17.dta"

gen year=4
replace substratum=year*1000+substratum

/// recoding variables for standatization

** interview language
recode l1(1=0 "Georgian")(2 3=1 "Non-Georgian"), gen(lang)

** survey wave
gen wave_12_17 = 1
lab var wave "survey wave"

** most important issues
recode q1_7(1=1)(-1 0=0)(else=.), gen(jobs)
recode q1_13(1=1)(-1 0=0)(else=.), gen(inflation)
recode q1_11(1=1)(-1 0=0)(else=.), gen(poverty)
recode q1_12(1=1)(-1 0=0)(else=.), gen(territory)

lab var jobs "Jobs"
lab var inflation "Inflation"
lab var poverty "Poverty"
lab var territory "Territory"

** settlement type
gen settype_1=.
replace settype_1=0 if settype==1
replace settype_1=1 if settype==2 | substratum==51
replace settype_1=2 if settype==3 | substratum==52
lab define sett 0 "Capital" 1 "Urban" 2 "Rural"
lab values settype_1 sett
lab var settype_1 "Settlement type"

** party identification
recode q54_1(-1 26=0 "No partye")(8=1 "GD")(6=2 "UNM")(3 7 10 13 15 17 20=3 "Liberal")(-2=5 "Refusal")(-9/-3=.)(else=4 "Other"), gen(pid_3)
lab var pid_3 "Party closest to you"

** gender
recode sex (1=0 "Male")(2=1 "Female"), gen(gender)
lab var gender "Gender female"

** age groups
recode age (18/37=2 "18-37")(38/57=1 "38-57")(58/100=0 ">57")(else=.), gen(agegr)
lab var agegr "Age groups {0=>57}"

** education
recode q63 (1/4=0 "Below tertiary")(5/6=1 "Tertiary")(else=.), gen(edu)
lab var edu "Tertiary education"

** employment
recode q66(1=1 "Employed")(-1 0=0 "Not employed")(else=.), gen(empl_1)
lab var empl_1 "Employed"

** posessions
foreach v of varlist q68_1-q68_10  {
gen `v'r = `v'
}
recode q68_1r-q68_10r(1=1)(-1 0 =0)(else=.)
egen goods=rowtotal(q68_1r-q68_10r)
lab var goods "Posession of goods"

** EU support
recode q7(1=1 "EU")(-1 0=0 "Not EU")(else=.), gen(eu_1)
** NATO support
recode q8(1=1 "NATO")(-1 0=0 "Not NATO")(else=.), gen(nato_1)
** EU vs EEU
recode q9(3/4=1 "EU")(1/2=2 "EEU")(-1 5=3 "Neither")(else=.), gen(euvsruss_2)
lab var euvsruss_2 "Benefit of joining EU vs EEU"

** keeping needed variables
keep id lang settype_1 gender agegr edu empl_1 goods jobs poverty territory inflation eu_1 nato_1 euvsruss_2 pid_3 /// 
stratum psu substratum npsuss nhhpsu nadhh indwt hhwt wave_12_17

** order variables 
order id lang settype_1 gender agegr edu empl_1 goods jobs poverty territory inflation eu_1 nato_1 euvsruss_2 pid_3 /// 
stratum psu substratum npsuss nhhpsu nadhh indwt hhwt wave_12_17

save "ndi_2017_Dec.dta", replace  
*******************************************************************************

/// 2018 June
clear all
//use "https://caucasusbarometer.org/downloads/NDI_2018_Jun_16.07.18_Public.dta"
use "NDI_2018_June_16.07.18.dta"

gen year=5
replace substratum=year*1000+substratum

/// recoding variables for standatization

** interview language
recode l1(1=0 "Georgian")(2 3=1 "Non-Georgian"), gen(lang)

** survey wave
gen wave_06_18 = 1
lab var wave "survey wave"

** most important issues
recode q1_7(1=1)(-1 0=0)(else=.), gen(jobs)
recode q1_13(1=1)(-1 0=0)(else=.), gen(inflation)
recode q1_11(1=1)(-1 0=0)(else=.), gen(poverty)
recode q1_12(1=1)(-1 0=0)(else=.), gen(territory)

lab var jobs "Jobs"
lab var inflation "Inflation"
lab var poverty "Poverty"
lab var territory "Territory"

** settlement type
gen settype_1=.
replace settype_1=0 if settype==1
replace settype_1=1 if settype==2 | substratum==51
replace settype_1=2 if settype==3 | substratum==52
lab define sett 0 "Capital" 1 "Urban" 2 "Rural"
lab values settype_1 sett
lab var settype_1 "Settlement type"

** party identification
recode q46_1(-1 25=0 "No party")(8=1 "GD")(6=2 "UNM")(3 7 10 13 15 16 17 23=3 "Liberal")(-2=5 "Refusal")(-9/-3=.)(else=4 "Other"), gen(pid_3)
lab var pid_3 "Party closest to you"

** gender
recode sex (1=0 "Male")(2=1 "Female"), gen(gender)
lab var gender "Gender female"

** age groups
recode age (18/37=2 "18-37")(38/57=1 "38-57")(58/100=0 ">57")(else=.), gen(agegr)
lab var agegr "Age groups {0=>57}"

** education
recode q62 (1/4=0 "Below tertiary")(5/6=1 "Tertiary")(else=.), gen(edu)
lab var edu "Tertiary education"

** employment
recode q64 (0=0 "Not employed")(1/31=1 "Employed")(else=.), gen(empl_1)	
lab var empl_1 "Employed"

** posessions
foreach v of varlist q66_1-q66_10  {
gen `v'r = `v'
}
recode q66_1r-q66_10r(1=1)(-1 0 =0)(else=.)
egen goods=rowtotal(q66_1r-q66_10r)
lab var goods "Posession of goods"

** EU support
recode q44(1=1 "EU")(-1 0=0 "Not EU")(else=.), gen(eu_1)
** NATO support
recode q45(1=1 "NATO")(-1 0=0 "Not NATO")(else=.), gen(nato_1)

/// recode questions on values 

** conservative values
recode q9(1/2=0 "conservative")(3/4=1 "liberal")(else=.), gen(marry)
recode q10(1/2=0 "conservative")(3/4=1 "liberal")(else=.), gen(divorce)
recode q11(1/2=0 "conservative")(3/4=1 "liberal")(else=.), gen(inherit) 
recode q12(1/2=0 "conservative")(3/4=1 "liberal")(else=.), gen(earring)

** land ownership by Georgians opnly
recode q30(3/4=1 "Anybody can own land")(1/2=0 "Only Georgians own land")(else=.), gen(landge)
//recode q30(1/2=1 "Only Georgians own land")(-1 3/5=0 "Anybody can own land")(else=.), gen(landge)

** drug policies
recode q35(1=1 "Legalization")(-1 0=0 "No legalization")(else=.), gen(drugleg)

** sexual minorities
recode q36_1(4/5=1 "Important")(-1 1/3=0 "Not important")(else=.), gen(lgbt)

** keeping needed variables
keep id lang settype_1 gender agegr edu empl_1 goods jobs poverty territory inflation eu_1 nato_1 pid_3 /// 
stratum psu substratum npsuss nhhpsu nadhh indwt hhwt wave_06_18 ///
marry divorce inherit earring landge drugleg lgbt

** order variables 
order id lang settype_1 gender agegr edu empl_1 goods jobs poverty territory inflation eu_1 nato_1 pid_3 /// 
stratum psu substratum npsuss nhhpsu nadhh indwt hhwt wave_06_18 ///
marry divorce inherit earring landge drugleg lgbt

save "ndi_2018_Jun.dta", replace  
*******************************************************************************

/// 2018 December
clear all
//use "https://caucasusbarometer.org/downloads/NDI_2018_Dec_28.12.18_Public.dta"
use "NDI_2018_Dec_28.12.18.dta"

gen year=6
replace substratum=year*1000+substratum

/// recoding variables for standatization

** interview language
recode l1(1=0 "Georgian")(2 3=1 "Non-Georgian"), gen(lang)

** survey wave
gen wave_12_18 = 1
lab var wave "survey wave"

** most important issues
recode q1_8(1=1)(-1 0=0)(else=.), gen(jobs)
recode q1_14(1=1)(-1 0=0)(else=.), gen(inflation)
recode q1_12(1=1)(-1 0=0)(else=.), gen(poverty)
recode q1_13(1=1)(-1 0=0)(else=.), gen(territory)

lab var jobs "Jobs"
lab var inflation "Inflation"
lab var poverty "Poverty"
lab var territory "Territory"

** settlement type
gen settype_1=.
replace settype_1=0 if settype==1
replace settype_1=1 if settype==2 | substratum==51
replace settype_1=2 if settype==3 | substratum==52
lab define sett 0 "Capital" 1 "Urban" 2 "Rural"
lab values settype_1 sett
lab var settype_1 "Settlement type"

** party identification
recode q38_1(-1 25=0 "No party")(8=1 "GD")(6=2 "UNM")(3 7 10 13 15 16 17 23=3 "Liberal")(-2=5 "Refusal")(-9/-3=.)(else=4 "Other"), gen(pid_3)
lab var pid_3 "Party closest to you"

** gender
recode sex (1=0 "Male")(2=1 "Female"), gen(gender)
lab var gender "Gender female"

** age groups
recode age (18/37=2 "18-37")(38/57=1 "38-57")(58/100=0 ">57")(else=.), gen(agegr)
lab var agegr "Age groups {0=>57}"

** education
recode q75 (1/4=0 "Below tertiary")(5/6=1 "Tertiary")(else=.), gen(edu)
lab var edu "Tertiary education"

** employment
recode q77 (0=0 "Not employed")(1/31=1 "Employed")(else=.), gen(empl_1)	
lab var empl_1 "Employed"

** posessions
foreach v of varlist q80_1-q80_10  {
gen `v'r = `v'
}
recode q80_1r-q80_10r(1=1)(-1 0 =0)(else=.)
egen goods=rowtotal(q80_1r-q80_10r)
lab var goods "Posession of goods"

** EU support
recode q36(1=1 "EU")(-1 0=0 "Not EU")(else=.), gen(eu_1)
** NATO support
recode q37(1=1 "NATO")(-1 0=0 "Not NATO")(else=.), gen(nato_1)

** keeping needed variables
keep id lang settype_1 gender agegr edu empl_1 goods jobs poverty territory inflation eu_1 nato_1 pid_3 /// 
stratum psu substratum npsuss nhhpsu nadhh indwt hhwt wave_12_18

** order variables 
order id lang settype_1 gender agegr edu empl_1 goods jobs poverty territory inflation eu_1 nato_1 pid_3 /// 
stratum psu substratum npsuss nhhpsu nadhh indwt hhwt wave_12_18

save "ndi_2018_Dec.dta", replace  
*******************************************************************************

/// 2019 April
clear all
//use "https://caucasusbarometer.org/downloads/NDI_2019_April_22.04.19_Public.dta"
use "NDI_2019_April_22.04.19.dta" 

gen year=7
replace substratum=year*1000+substratum

/// recoding variables for standatization

** interview language
recode l1(1=0 "Georgian")(2 3=1 "Non-Georgian"), gen(lang)

** survey wave
gen wave_04_19 = 1
lab var wave "survey wave"

** settlement type
gen settype_1=.
replace settype_1=0 if settype==1
replace settype_1=1 if settype==2 | (substratum==51|substratum==61)
replace settype_1=2 if settype==3 | (substratum==52|substratum==62)
lab define sett 0 "Capital" 1 "Urban" 2 "Rural"
lab values settype_1 sett

** party identification
recode q5_1(-1 25=0 "No party")(8=1 "GD")(6=2 "UNM")(3 7 10 13 15 16 17 23=3 "Liberal")(-2=5 "Refusal")(-9/-3=.)(else=4 "Other"), gen(pid_3)
lab var pid_3 "Party closest to you"

** gender
recode sex (1=0 "Male")(2=1 "Female"), gen(gender)
lab var gender "Gender female"

** age groups
recode age (18/37=2 "18-37")(38/57=1 "38-57")(58/100=0 ">57")(else=.), gen(agegr)
lab var agegr "Age groups {0=>57}"

** education
recode q67 (1/4=0 "Below tertiary")(5/6=1 "Tertiary")(else=.), gen(edu)
lab var edu "Tertiary education"

** employment
recode q69 (0=0 "Not employed")(1/31=1 "Employed")(else=.), gen(empl_1)	
lab var empl_1 "Employed"

** posessions
foreach v of varlist q72_1-q72_10  {
gen `v'r = `v'
}
recode q72_1r-q72_10r(1=1)(-1 0 =0)(else=.)
egen goods=rowtotal(q72_1r-q72_10r)
lab var goods "Posession of goods"

** trust TV channel
recode q56(-5=0 "None")(1=1 "Imedi")(3=2 "R2")(-3 -1=.)(else=3 "Other"), gen(tvtrust)

** USSR
recode q41(1=1 "Good")(-1 0=0 "No good")(else=.), gen(ussr)
** RR
recode q42(1=1 "Good")(-1 0=0 "No good")(else=.), gen(rrose)
** 2012
recode q43(1=1 "Good")(-1 0=0 "No good")(else=.), gen(change12)

** EU support
recode q14(1=1 "EU")(-1 0=0 "Not EU")(else=.), gen(eu_1)
** NATO support
recode q32(1=1 "NATO")(-1 0=0 "Not NATO")(else=.), gen(nato_1)
** EU vs Russia
recode q19(1/2=1 "EU")(3/4=2 "Russia")(-1 5=3 "Neither")(else=.), gen(euvsruss_1)
lab var euvsruss_1 "Benefit of joining EU vs Russia"

** Approval of individuals
foreach v of varlist q4_1-q4_37 {
    gen `v'r = `v'
}
recode q4_1r-q4_37r(-1=2)(-5=0)(-7 -3 -2=.)

egen pers_gov=rowmean(q4_1r-q4_17r)
lab var pers_gov "Approval of individuals -- government"

egen pers_opp=rowmean(q4_18r-q4_37r)
lab var pers_opp"Approval of individuals -- opposition"

** performance of institutions
foreach v of varlist q3_5-q3_12 {
    gen `v'r = `v'
}
recode q3_5r-q3_12r(-1=0)(-7 -3 -2=.)

egen perf_inst=rowmean(q3_5r-q3_12r)
lab var perf_inst "Performance of institutions -- mean score"

** keeping needed variables
keep id lang settype_1 gender agegr edu empl_1 goods eu_1 nato_1 euvsruss_1 pid_3 ///
tvtrust ussr rrose change12 pers_gov pers_opp perf_inst ///
stratum psu substratum npsuss nhhpsu nadhh indwt hhwt wave_04_19

** order variables 
order id lang settype_1 gender agegr edu empl_1 goods eu_1 nato_1 euvsruss_1 pid_3 ///
tvtrust ussr rrose change12 euvsruss_1 pers_gov pers_opp perf_inst ///
stratum psu substratum npsuss nhhpsu nadhh indwt hhwt wave_04_19

save "ndi_2019_Apr.dta", replace  
*******************************************************************************

/// 2019 July
clear all
//use "https://caucasusbarometer.org/downloads/NDI_2019_July_04.08.19_Public.dta"
use "NDI_2019_July_04.08.19.dta"

gen year=8
replace substratum=year*1000+substratum

/// recoding variables for standatization

** interview language
recode l1(1=0 "Georgian")(2 3=1 "Non-Georgian"), gen(lang)

** survey wave
gen wave_07_19 = 1
lab var wave "survey wave"

** most important issues
recode q1_8(1=1)(-1 0=0)(else=.), gen(jobs)
recode q1_14(1=1)(-1 0=0)(else=.), gen(inflation)
recode q1_12(1=1)(-1 0=0)(else=.), gen(poverty)
recode q1_13(1=1)(-1 0=0)(else=.), gen(territory)

lab var jobs "Jobs"
lab var inflation "Inflation"
lab var poverty "Poverty"
lab var territory "Territory"

** settlement type
gen settype_1=.
replace settype_1=0 if settype==1
replace settype_1=1 if settype==2 | substratum==51
replace settype_1=2 if settype==3 | substratum==52
lab define sett 0 "Capital" 1 "Urban" 2 "Rural"
lab values settype_1 sett
lab var settype_1 "Settlement type"

** party identification
recode q5_1(-1 25=0 "No party")(8=1 "GD")(6=2 "UNM")(3 7 10 13 15 16 17 21 23 26=3 "Liberal")(-2=5 "Refusal")(-9/-3=.)(else=4 "Other"), gen(pid_3)
lab var pid_3 "Party closest to you"

** gender
recode sex (1=0 "Male")(2=1 "Female"), gen(gender)
lab var gender "Gender female"

** age groups
recode age (18/37=2 "18-37")(38/57=1 "38-57")(58/100=0 ">57")(else=.), gen(agegr)
lab var agegr "Age groups {0=>57}"

** education
recode q74 (1/4=0 "Below tertiary")(5/6=1 "Tertiary")(else=.), gen(edu)
lab var edu "Tertiary education"

** employment
recode q41 (0=0 "Not employed")(1/31=1 "Employed")(else=.), gen(empl_1)	
lab var empl_1 "Employed"

** posessions
foreach v of varlist q76_1-q76_10  {
gen `v'r = `v'
}
recode q76_1r-q76_10r(1=1)(-1 0 =0)(else=.)
egen goods=rowtotal(q76_1r-q76_10r)
lab var goods "Posession of goods"

** EU support
recode q10(1=1 "EU")(-1 0=0 "Not EU")(else=.), gen(eu_1)
** NATO support
recode q11(1=1 "NATO")(-1 0=0 "Not NATO")(else=.), gen(nato_1)

** government's role in economy
recode q31 (1=1 "None")(2=2 "Some")(3/4=3 "Big")(-1=4 "DK")(else=.), gen(govrole)

** approval of regulations on loans
recode q57 (1=1 "Yes")(-1 0=0 "Otherwise")(else=.), gen(regloan)

** approval of voluntary pension contributions
recode q60 (2=1 "Yes") (-1 1 3=0 "Otherwise") (else=.), gen(volpens)


** keeping needed variables
keep id lang settype_1 gender agegr edu empl_1 goods jobs poverty territory inflation eu_1 nato_1 pid_3 /// 
stratum psu substratum npsuss nhhpsu nadhh indwt hhwt wave_07_19 ///
govrole regloan volpens

** order variables 
order id lang settype_1 gender agegr edu empl_1 goods jobs poverty territory inflation eu_1 nato_1 pid_3 /// 
stratum psu substratum npsuss nhhpsu nadhh indwt hhwt wave_07_19 ///
govrole regloan volpens

save "ndi_2019_Jul.dta", replace  
*******************************************************************************

// 2019 December
clear all
//use "https://caucasusbarometer.org/downloads/NDI_2019_Nov_16.12.19_Public.dta"
use "NDI_2019_Nov_16.12.19.dta"

gen year=9
replace substratum=year*1000+substratum

/// recoding variables for standatization

** interview language
recode l1(1=0 "Georgian")(2 3=1 "Non-Georgian"), gen(lang)

** survey wave
gen wave_12_19 = 1
lab var wave "survey wave"

** most important issues
// N/A
gen jobs=.
gen inflation=.
gen poverty=.
gen territory=.

** settlement type
gen settype_1=.
replace settype_1=0 if settype==1
replace settype_1=1 if settype==2 | substratum==51
replace settype_1=2 if settype==3 | substratum==52
lab define sett 0 "Capital" 1 "Urban" 2 "Rural"
lab values settype_1 sett
lab var settype_1 "Settlement type"

** party identification
gen pid_3=.
//recode using q7a_1 q7b_1
//lab var pid_3 "Party closest to you"

** gender
recode sex (1=0 "Male")(2=1 "Female"), gen(gender)
lab var gender "Gender female"

** age groups
recode age (18/37=2 "18-37")(38/57=1 "38-57")(58/100=0 ">57")(else=.), gen(agegr)
lab var agegr "Age groups {0=>57}"

** education
recode q55 (1/4=0 "Below tertiary")(5/6=1 "Tertiary")(else=.), gen(edu)
lab var edu "Tertiary education"

** employment
// N/A
gen empl_1=.

** posessions
foreach v of varlist q57_1-q57_10  {
gen `v'r = `v'
}
recode q57_1r-q57_10r(1=1)(-1 0 =0)(else=.)
egen goods=rowtotal(q57_1r-q57_10r)
lab var goods "Posession of goods"

** EU support
recode q33(1=1 "EU")(-1 0=0 "Not EU")(else=.), gen(eu_1)
** NATO support
recode q34(1=1 "NATO")(-1 0=0 "Not NATO")(else=.), gen(nato_1)

** keeping needed variables
keep id lang settype_1 gender agegr edu empl_1 goods jobs poverty territory inflation eu_1 nato_1 pid_3 /// 
stratum psu substratum npsuss nhhpsu nadhh indwt hhwt wave_12_19

** order variables 
order id lang settype_1 gender agegr edu empl_1 goods jobs poverty territory inflation eu_1 nato_1 pid_3 /// 
stratum psu substratum npsuss nhhpsu nadhh indwt hhwt wave_12_19

save "ndi_2019_Dec.dta", replace  
*******************************************************************************

/// Merge datasets
*******************************************************************************

use "ndi_2016_June.dta"

append using "ndi_2016_Nov.dta"
append using "ndi_2017_Jun.dta"
append using "ndi_2017_Dec.dta"
append using "ndi_2018_Jun.dta"
append using "ndi_2018_Dec.dta"
append using "ndi_2019_Apr.dta"
append using "ndi_2019_Jul.dta"
append using "ndi_2019_Dec.dta"

gen wave=.
replace wave=1 if wave_06_16 == 1
replace wave=2 if wave_11_16 == 1
replace wave=3 if wave_06_17 == 1
replace wave=4 if wave_12_17 == 1
replace wave=5 if wave_06_18 == 1
replace wave=6 if wave_12_18 == 1
replace wave=7 if wave_04_19 == 1
replace wave=8 if wave_07_19 == 1
//replace wave=9 if wave_12_19 == 1 

lab var wave "Survey wave"
lab define wave1 1 "Jun_16" 2 "Nov_16" 3 "Jun_17" 4 "Dec_17" 5 "Jun_18" 6 "Dec_18" 7 "Apr_19" 8 "Jul_19" 9 "Dec_19"
lab values wave wave1

drop wave_06_16 wave_11_16 wave_06_17 wave_12_17 wave_06_18 wave_12_18 wave_04_19 wave_07_19 wave_12_19 

order id wave lang settype_1 gender agegr edu empl_1 goods jobs poverty territory inflation eu_1 nato_1 euvsruss_1 euvsruss_2 pid_3 /// 
stratum psu substratum npsuss nhhpsu nadhh indwt hhwt ///
pers_gov pers_opp perf_inst change12 rrose ussr tvtrust ///
marry divorce inherit earring landge drugleg lgbt

svyset psu [pweight=indwt], strata(substratum) fpc(npsuss) singleunit(certainty) || id, fpc(nhhpsu) || _n, fpc(nadhh)

save "ndi_20016_2019_longi.dta", replace
*******************************************************************************

/// models and graphs
*******************************************************************************
*******************************************************************************

graph set window fontface calibri

grstyle init

grstyle set plain


/// Figure 1. Attitudes to important partisan events -- predicted probabilities

clear all
use "ndi_20016_2019_longi.dta" 

svyset psu [pweight=indwt], strata(substratum) fpc(npsuss) singleunit(certainty) || id, fpc(nhhpsu) || _n, fpc(nadhh)

fvset base 1 pid_3

local covar i.gender i.agegr i.edu i.empl_1 c.goods i.settype_1 i.lang

** Rose Revolution
qui svy: logit rrose i.pid_3 `covar' 
qui: margins pid_3, post
estimates store r1
** Government change in 2012
qui svy: logit change12 i.pid_3 `covar' 
qui: margins pid_3, post
estimates store c1

**
coefplot ///
(r1, label("") msymbol(D) pstyle(p5) ciopts(pstyle(p5))) || c1, ///
plotlabels() bylabels("Rose Revolution" "Government change in 2012") ///
name(events, replace) ///
baselevels drop(_cons) ///
xscale(r(0 1)) xlabel(0 "0" .5 ".5" 1 "1") ///
mlabel format(%9.2f) mlabposition(12) mlabsize(msmall) mlabcolor(black*.8) mlabgap(*2) ///
graphregion(color(white)) ///
order (1.pid_3 2.pid_3 3.pid_3 4.pid_3 0.pid_3 5.pid_3) ///
coeflabels(0.pid_3="No party" 1.pid_3="GD" 2.pid_3="UNM" 3.pid_3="Liberal" 4.pid_3="Other" 5.pid_3="Refusal", ///
wrap(40) notick labcolor(black*.8) labsize(small) labgap(2)) /// 
byopt(rows(1) graphregion(color(white)) ///
title("Was the following a good thing for Georgia?", color(black*.9) tstyle(size(large)) span) ///
subtitle("Predicted probabilities of logit estimates, 95% CIs", color(black*.8) tstyle(size(medium)) span) ///
note("NDI/CRRC, April 2019"))

graph export "Figure_1.png", width(4000) replace
*******************************************************************************

/// Figure 2. Attitudes to individuals and institutions -- marginal effects

clear all
use "ndi_20016_2019_longi.dta" 

svyset psu [pweight=indwt], strata(substratum) fpc(npsuss) singleunit(certainty) || id, fpc(nhhpsu) || _n, fpc(nadhh)

fvset base 1 pid_3

local covar i.gender i.agegr i.edu i.empl_1 c.goods i.settype_1 i.lang
 
** institutions
qui svy: reg perf_inst i.pid_3 `covar' 
qui: margins pid_3, post
estimates store i1
 ** Government persons
qui svy: reg pers_gov i.pid_3 `covar' 
qui: margins pid_3, post
estimates store g1
** Opposition persons
qui svy: reg pers_opp i.pid_3 `covar' 
qui: margins pid_3, post
estimates store o1

**
coefplot ///
(i1, label("") msymbol(D) pstyle(p5) ciopts(pstyle(p5))) || g1, || o1, ///
plotlabels() bylabels("institutions" "government individuals" "opposition individuals") ///
name(assessments, replace) ///
baselevels drop(_cons) ///
xscale(r(0 4)) xlabel(0 "0" 1 "1" 2 "2" 3 "3") ///
mlabel format(%9.2f) mlabposition(12) mlabsize(msmall) mlabcolor(black*.8) mlabgap(*2) ///
graphregion(color(white)) ///
order (1.pid_3 2.pid_3 3.pid_3 4.pid_3 0.pid_3 5.pid_3) ///
coeflabels(0.pid_3="No party" 1.pid_3="GD" 2.pid_3="UNM" 3.pid_3="Liberal" 4.pid_3="Other" 5.pid_3="Refusal", ///
wrap(40) notick labcolor(black*.8) labsize(small) labgap(2)) /// 
byopt(rows(1) graphregion(color(white)) ///
title("Positive assessment of ... (average score)", color(black*.9) tstyle(size(large)) span) ///
subtitle("Predicted scores of OLS estimates, 95% CIs", color(black*.8) tstyle(size(medium)) span) ///
note("NDI/CRRC, April 2019"))

graph export "Figure_2.png", width(4000) replace
********************************************************************************

//// Figure 5. Most important national issues -- predicted probabilities 
*******************************************************************************

clear all
use "ndi_20016_2019_longi.dta" 

drop if wave==7|wave==8|wave==9

svyset psu [pweight=indwt], strata(substratum) fpc(npsuss) singleunit(certainty) || id, fpc(nhhpsu) || _n, fpc(nadhh)

local covar i.gender i.agegr i.edu i.empl_1 c.goods i.settype_1 i.lang 

*** jobs

/// 2016
qui svy: logit jobs i.pid_3##i.wave `covar'
qui: margins pid_3, at (wave=(1)) post
est store j_16_pre

qui svy: logit jobs i.pid_3##i.wave `covar'
qui: margins pid_3, at (wave=(2)) post
est store j_16_post

/// 2017
qui svy: logit jobs i.pid_3##i.wave `covar'
qui: margins pid_3, at (wave=(3)) post
est store j_17_pre

qui svy: logit jobs i.pid_3##i.wave `covar'
qui: margins pid_3, at (wave=(4)) post
est store j_17_post

/// 2018
qui svy: logit jobs i.pid_3##i.wave `covar'
qui: margins pid_3, at (wave=(5)) post
est store j_18_pre

qui svy: logit jobs i.pid_3##i.wave `covar'
qui: margins pid_3, at (wave=(6)) post
est store j_18_post

///

coefplot ///
(j_16_pre, label("Pre-election") msymbol(D) pstyle(p5) ciopts(pstyle(p5))) ///
(j_16_post, label("Post-election") msymbol(O) pstyle(p13) ciopts(pstyle(p13 ))) || ///
(j_17_pre) (j_17_post) || ///
(j_18_pre) (j_18_post), ///
bylabels("2016" "2017" "2018") ///
name(jobs, replace) ///
baselevels drop(_cons) ///
xscale(r(0 1)) xlabel(0 "0" .5 ".5" 1 "1") ///
mlabel format(%9.2f) mlabposition(12) mlabsize(msmall) mlabcolor(black*.8) mlabgap(*.5) ///
graphregion(color(white)) ///
order (1.pid_3 2.pid_3 3.pid_3 4.pid_3 0.pid_3 5.pid_3) ///
coeflabels(1._at#0.pid_3="No party" 1._at#1.pid_3="GD" 1._at#2.pid_3="UNM" 1._at#3.pid_3="Liberal" 1._at#4.pid_3="Other" 1._at#5.pid_3="Refusal" ///
2._at#0.pid_3="No party" 2._at#1.pid_3="GD" 2._at#2.pid_3="UNM" 2._at#3.pid_3="Liberal" 2._at#4.pid_3="Other" 2._at#5.pid_3="Refusal", ///
wrap(40) notick labcolor(black*.8) labsize(small) labgap(2)) /// 
byopt(rows(1) graphregion(color(white)) ///
title("Jobs", color(black*.9) tstyle(size(large)) span))

*** inflation

local covar i.gender i.agegr i.edu i.empl_1 c.goods i.settype_1 i.lang

/// 2016
qui svy: logit inflation i.pid_3##i.wave `covar'
qui: margins pid_3, at (wave=(1)) post
est store i_16_pre

qui svy: logit inflation i.pid_3##i.wave `covar'
qui: margins pid_3, at (wave=(2)) post
est store i_16_post

/// 2017
qui svy: logit inflation i.pid_3##i.wave `covar'
qui: margins pid_3, at (wave=(3)) post
est store i_17_pre

qui svy: logit inflation i.pid_3##i.wave `covar'
qui: margins pid_3, at (wave=(4)) post
est store i_17_post

/// 2018
qui svy: logit inflation i.pid_3##i.wave `covar'
qui: margins pid_3, at (wave=(5)) post
est store i_18_pre

qui svy: logit inflation i.pid_3##i.wave `covar'
qui: margins pid_3, at (wave=(6)) post
est store i_18_post

///
coefplot ///
(i_16_pre, label("Pre-election") msymbol(D) pstyle(p5) ciopts(pstyle(p5))) ///
(i_16_post, label("Post-election") msymbol(O) pstyle(p13) ciopts(pstyle(p13))) || ///
i_17_pre i_17_post || i_18_pre i_18_post, ///
bylabels("2016" "2017" "2018") ///
name(inflation, replace) ///
baselevels drop(_cons) ///
xscale(r(0 1)) xlabel(0 "0" .5 ".5" 1 "1") ///
mlabel format(%9.2f) mlabposition(12) mlabsize(msmall) mlabcolor(black*.8) mlabgap(*1) ///
graphregion(color(white)) ///
order (1.pid_3 2.pid_3 3.pid_3 4.pid_3 0.pid_3 5.pid_3) ///
coeflabels(1._at#0.pid_3="No party" 1._at#1.pid_3="GD" 1._at#2.pid_3="UNM" 1._at#3.pid_3="Liberal" 1._at#4.pid_3="Other" 1._at#5.pid_3="Refusal" ///
2._at#0.pid_3="No party" 2._at#1.pid_3="GD" 2._at#2.pid_3="UNM" 2._at#3.pid_3="Liberal" 2._at#4.pid_3="Other" 2._at#5.pid_3="Refusal", ///
wrap(40) notick labcolor(black*.8) labsize(small) labgap(2)) /// 
byopt(rows(1) graphregion(color(white)) ///
title("Inflation", color(black*.9) tstyle(size(large)) span))

///
graph combine jobs inflation, ycommon xcommon rows(1) ///
graphregion(color(white)) ///
title("Most important national issues", color(black*.9) tstyle(size(large)) span) ///
subtitle("Predicted probabilities of logit estimates, 95% CIs", color(black*.8) tstyle(size(mlarge)) span) ///
note("NDI/CRRC, 2016-2018") 

graph export "Figure_5.png", width(8000) replace
*****************************************************************************

//// Figure 6. Approve governmant's stated goal to join EU and NATO -- predicted probabilities 
*******************************************************************************

clear all
use "ndi_20016_2019_longi.dta" 

drop if wave==7|wave==8|wave==9

svyset psu [pweight=indwt], strata(substratum) fpc(npsuss) singleunit(certainty) || id, fpc(nhhpsu) || _n, fpc(nadhh)

fvset base 1 pid_3

local covar i.gender i.agegr i.edu i.empl_1 c.goods i.settype_1 i.lang

*** EU

/// 2016
qui svy: logit eu_1 i.pid_3##i.wave `covar'
qui: margins pid_3, at (wave=(1)) post
est store e_16_pre

qui svy: logit eu_1 i.pid_3##i.wave `covar'
qui: margins pid_3, at (wave=(2)) post
est store e_16_post

/// 2017
qui svy: logit eu_1 i.pid_3##i.wave `covar'
qui: margins pid_3, at (wave=(3)) post
est store e_17_pre

qui svy: logit eu_1 i.pid_3##i.wave `covar'
qui: margins pid_3, at (wave=(4)) post
est store e_17_post

/// 2018
qui svy: logit eu_1 i.pid_3##i.wave `covar'
qui: margins pid_3, at (wave=(5)) post
est store e_18_pre

qui svy: logit eu_1 i.pid_3##i.wave `covar'
qui: margins pid_3, at (wave=(6)) post
est store e_18_post

///
coefplot ///
(e_16_pre, label("Pre-election") msymbol(D) pstyle(p5) ciopts(pstyle(p5))) ///
(e_16_post, label("Post-election") msymbol(O) pstyle(p13) ciopts(pstyle(p13))) || ///
e_17_pre e_17_post || e_18_pre e_18_post, ///
bylabels("2016" "2017" "2018") ///
name(eu, replace) ///
baselevels drop(_cons) ///
xscale(r(0 1)) xlabel(0 "0" .5 ".5" 1 "1") ///
mlabel format(%9.2f) mlabposition(12) mlabsize(msmall) mlabcolor(black*.8) mlabgap(*1) ///
graphregion(color(white)) ///
order (1.pid_3 2.pid_3 3.pid_3 4.pid_3 0.pid_3 5.pid_3) ///
coeflabels(1._at#0.pid_3="No party" 1._at#1.pid_3="GD" 1._at#2.pid_3="UNM" 1._at#3.pid_3="Liberal" 1._at#4.pid_3="Other" 1._at#5.pid_3="Refusal" ///
2._at#0.pid_3="No party" 2._at#1.pid_3="GD" 2._at#2.pid_3="UNM" 2._at#3.pid_3="Liberal" 2._at#4.pid_3="Other" 2._at#5.pid_3="Refusal", ///
wrap(40) notick labcolor(black*.8) labsize(small) labgap(2)) /// 
byopt(rows(1) graphregion(color(white)) ///
title("EU", color(black*.9) tstyle(size(large)) span))

*** NATO

local covar i.gender i.agegr i.edu i.empl_1 c.goods i.settype_1

/// 2016
qui svy: logit nato_1 i.pid_3##i.wave `covar'
qui: margins pid_3, at (wave=(1)) post
est store n_16_pre

qui svy: logit nato_1 i.pid_3##i.wave `covar'
qui: margins pid_3, at (wave=(2)) post
est store n_16_post

/// 2017
qui svy: logit nato_1 i.pid_3##i.wave `covar'
qui: margins pid_3, at (wave=(3)) post
est store n_17_pre

qui svy: logit nato_1 i.pid_3##i.wave `covar'
qui: margins pid_3, at (wave=(4)) post
est store n_17_post

/// 2018
qui svy: logit nato_1 i.pid_3##i.wave `covar'
qui: margins pid_3, at (wave=(5)) post
est store n_18_pre

qui svy: logit nato_1 i.pid_3##i.wave `covar'
qui: margins pid_3, at (wave=(6)) post
est store n_18_post

coefplot ///
(n_16_pre, label("Pre-election") msymbol(D) pstyle(p5) ciopts(pstyle(p5))) ///
(n_16_post, label("Post-election") msymbol(O) pstyle(p13) ciopts(pstyle(p13))) || ///
n_17_pre n_17_post || n_18_pre n_18_post, ///
bylabels("2016" "2017" "2018") ///
name(nato, replace) ///
baselevels drop(_cons) ///
xscale(r(0 1)) xlabel(0 "0" .5 ".5" 1 "1") ///
mlabel format(%9.2f) mlabposition(12) mlabsize(msmall) mlabcolor(black*.8) mlabgap(*1) ///
graphregion(color(white)) ///
order (1.pid_3 2.pid_3 3.pid_3 4.pid_3 0.pid_3 5.pid_3) ///
coeflabels(1._at#0.pid_3="No party" 1._at#1.pid_3="GD" 1._at#2.pid_3="UNM" 1._at#3.pid_3="Liberal" 1._at#4.pid_3="Other" 1._at#5.pid_3="Refusal" ///
2._at#0.pid_3="No party" 2._at#1.pid_3="GD" 2._at#2.pid_3="UNM" 2._at#3.pid_3="Liberal" 2._at#4.pid_3="Other" 2._at#5.pid_3="Refusal", ///
wrap(40) notick labcolor(black*.8) labsize(small) labgap(2)) /// 
byopt(rows(1) graphregion(color(white)) ///
title("NATO", color(black*.9) tstyle(size(large)) span))

///
graph combine eu nato, ycommon xcommon rows(1) ///
graphregion(color(white)) ///
title("Approve government's stated goal to join", color(black*.9) tstyle(size(large)) span) ///
subtitle("Predicted probabilities of logit estimates, 95% CIs", color(black*.8) tstyle(size(mlarge)) span) ///
note("NDI/CRRC, 2016-2018") 

graph export "Figure_6.png", width(8000) replace
*****************************************************************************

//// Figure 7. Government's desired involvement in economy -- predicted probabilities 
*******************************************************************************

clear all
use "ndi_20016_2019_longi.dta" 

svyset psu [pweight=indwt], strata(substratum) fpc(npsuss) singleunit(certainty) || id, fpc(nhhpsu) || _n, fpc(nadhh)

fvset base 1 pid_3

local covar i.gender i.agegr i.edu i.empl_1 c.goods i.settype_1 i.lang

///
qui svy: mlogit govrole i.pid_3 `covar' if wave==8, base (1)    
qui: margins pid_3, predict(outcome(1)) post
estimates store m1

qui svy: mlogit govrole i.pid_3 `covar' if wave==8, base (1)    
qui: margins pid_3, predict(outcome(2)) post
estimates store m2

qui svy: mlogit govrole i.pid_3 `covar' if wave==8, base (1)    
qui: margins pid_3, predict(outcome(3)) post
estimates store m3

//qui svy: mlogit govrole i.pid_3 `covar' if wave==8, base (1)    
//qui: margins pid_3, predict(outcome(4)) post
//estimates store m4

coefplot ///
(m1, label("") msymbol(D) pstyle(p5) ciopts(pstyle(p5))) || ///
m2 || m3, ///
bylabels("None" "Some" "Big" "DK") ///
name(gov, replace) ///
baselevels drop(_cons) ///
xscale(r(0 1)) xlabel(0 "0" .5 ".5" 1 "1") ///
mlabel format(%9.2f) mlabposition(12) mlabsize(msmall) mlabcolor(black*.8) mlabgap(*1) ///
graphregion(color(white)) ///
order (1.pid_3 2.pid_3 3.pid_3 4.pid_3 0.pid_3 5.pid_3) ///
coeflabels(0.pid_3="No party" 1.pid_3="GD" 2.pid_3="UNM" 3.pid_3="Liberal" 4.pid_3="Other" 5.pid_3="Refusal", ///
wrap(40) notick labcolor(black*.8) labsize(small) labgap(2)) /// 
byopt(rows(1) graphregion(color(white)) ///
title("Government's desired involvement in business and economy", color(black*.9) tstyle(size(large)) span) ///
subtitle("Predicted probabilities of multinomial logit estimates, 95% CIs", color(black*.8) tstyle(size(medium)) span) ///
note("NDI/CRRC, July 2019"))

graph export "Figure_7.png", width(4000) replace
*****************************************************************************

/// Figure 8. Attitudes to recent policy changes -- predicted probabilities

clear all
use "ndi_20016_2019_longi.dta" 

svyset psu [pweight=indwt], strata(substratum) fpc(npsuss) singleunit(certainty) || id, fpc(nhhpsu) || _n, fpc(nadhh)

fvset base 1 pid_3

local covar i.gender i.agegr i.edu i.empl_1 c.goods i.settype_1 i.lang

** bank regulations
qui svy: logit regloan i.pid_3 `covar' if wave==8  
qui: margins pid_3,  post
estimates store r1
** voluntary pension
qui svy: logit volpens i.pid_3 `covar' if wave==8  
qui: margins pid_3,  post
estimates store c1

coefplot ///
(r1, label("") msymbol(D) pstyle(p5) ciopts(pstyle(p5))) || c1, ///
plotlabels() bylabels("Bank regulations" "Voluntary pension contributions") ///
name(regulations) ///
baselevels drop(_cons) ///
xscale(r(0 1)) xlabel(0 "0" .5 ".5" 1 "1") ///
mlabel format(%9.2f) mlabposition(12) mlabsize(msmall) mlabcolor(black*.8) mlabgap(*1) ///
graphregion(color(white)) ///
order (1.pid_3 2.pid_3 3.pid_3 4.pid_3 0.pid_3 5.pid_3) ///
coeflabels(0.pid_3="No party" 1.pid_3="GD" 2.pid_3="UNM" 3.pid_3="Liberal" 4.pid_3="Other" 5.pid_3="Refusal", ///
wrap(40) notick labcolor(black*.8) labsize(small) labgap(2)) /// 
byopt(rows(1) graphregion(color(white)) ///
title("Approval of the following policies:", color(black*.9) tstyle(size(large)) span) ///
subtitle("Predicted probabilities of logit estimates, 95% CIs", color(black*.8) tstyle(size(medium)) span) ///
note("NDI/CRRC, July 2019"))

graph export "Figure_8.png", width(4000) replace
*****************************************************************************

/// Figure 9. Support to values -- predicted probabilities

clear all
use "ndi_20016_2019_longi.dta" 

svyset psu [pweight=indwt], strata(substratum) fpc(npsuss) singleunit(certainty) || id, fpc(nhhpsu) || _n, fpc(nadhh)

fvset base 1 pid_3

local covar i.gender i.agegr i.edu i.empl_1 c.goods i.settype_1

** Son/daughter to marry a person of different religion
qui svy: logit marry i.pid_3 `covar', or 
qui: margins pid_3, post
estimates store c1
** Son/daughter to divorce if not happy
qui svy: logit divorce i.pid_3 `covar', or
qui: margins pid_3, post
estimates store c2
** Inheritance should be split equally
qui svy: logit inherit i.pid_3 `covar', or
qui: margins pid_3, post
estimates store c3
** Don't mind my son to wear earrings
qui svy: logit earring i.pid_3 `covar', or
qui: margins pid_3, post
estimates store c4

**
coefplot ///
(c1, label("") msymbol(D) pstyle(p5) ciopts(pstyle(p5))) || c2 || c3 || c4, ///
plotlabels() bylabels("Marriage" "Divorce" "Inheritance" "Son wear earings") ///
name(values, replace) ///
baselevels drop(_cons) ///
xscale(r(0 1)) xlabel(0 "0" .5 ".5" 1 "1") ///
mlabel format(%9.2f) mlabposition(12) mlabsize(msmall) mlabcolor(black*.8) mlabgap(*1) ///
graphregion(color(white)) ///
order (1.pid_3 2.pid_3 3.pid_3 4.pid_3 0.pid_3 5.pid_3) ///
coeflabels(0.pid_3="No party" 1.pid_3="GD" 2.pid_3="UNM" 3.pid_3="Liberal" 4.pid_3="Other" 5.pid_3="Refusal", ///
wrap(40) notick labcolor(black*.8) labsize(small) labgap(2)) /// 
byopt(rows(1) graphregion(color(white)) ///
title("Support to values", color(black*.9) tstyle(size(large)) span) ///
subtitle("Predicted probabilities of logit estimates, 95% CIs", color(black*.8) tstyle(size(medium)) span) ///
note("NDI/CRRC, June 2018"))

graph export "Figure_9.png", width(4000) replace
*******************************************************************************

/// Figure 10. Approval of conservative policies -- predicted probabilities

clear all
use "ndi_20016_2019_longi.dta" 

svyset psu [pweight=indwt], strata(substratum) fpc(npsuss) singleunit(certainty) || id, fpc(nhhpsu) || _n, fpc(nadhh)

fvset base 1 pid_3

local covar i.gender i.agegr i.edu i.empl_1 c.goods i.settype_1

** No legalization of drugs
qui svy: logit drugleg i.pid_3 `covar' if wave==5, or 
qui: margins pid_3, post
estimates store drug
** Land ownership for Georgians only
qui svy: logit landge i.pid_3 `covar' if wave==5, or
qui: margins pid_3, post
estimates store land
** Protection of sexual minorities not important
qui svy: logit lgbt i.pid_3 `covar' if wave==5, or
qui: margins pid_3, post
estimates store minor

coefplot ///
(drug, label("") msymbol(D) pstyle(p5) ciopts(pstyle(p5))) || land || minor, ///
plotlabels() bylabels("Marijuana legalization" "Land owned by non-Georgians" "LGBT rights important") ///
name(policy, replace) ///
baselevels drop(_cons) ///
xscale(r(0 1)) xlabel(0 "0" .5 ".5" 1 "1") ///
mlabel format(%9.2f) mlabposition(12) mlabsize(msmall) mlabcolor(black*.8) mlabgap(*1) ///
graphregion(color(white)) ///
order (1.pid_3 2.pid_3 3.pid_3 4.pid_3 0.pid_3 5.pid_3) ///
coeflabels(0.pid_3="No party" 1.pid_3="GD" 2.pid_3="UNM" 3.pid_3="Liberal" 4.pid_3="Other" 5.pid_3="Refusal", ///
wrap(40) notick labcolor(black*.8) labsize(small) labgap(2)) /// 
byopt(rows(1) graphregion(color(white)) ///
title("Attitudes to the following policies:", color(black*.9) tstyle(size(large)) span) ///
subtitle("Predicted probabilities of logit estimates, 95% CIs", color(black*.8) tstyle(size(medium)) span) ///
note("NDI/CRRC, June 2018"))

graph export "Figure_10.png", width(4000) replace
*******************************************************************************


