///statistical analyses career trajectories Faculty Computer Science UC Santa Barbara

///Import our final dataset
import excel "/Users/kasilvestrovich/Harvard predoc with publications.xlsx", sheet("Sheet1") firstrow clear

///ttest to compare average number of publications in years with industry job and without 
drop A
gen having_industry_job=0 if Industry_job=="" & Publication!=. & year!=2022
replace having_industry_job=1 if Industry_job!="" & year!=2022
bys Name: egen years_in_industry=total(having_industry_job) if year!=2022
ttest Publication if years_in_industry>=1, by(having_industry_job) unequal

///reg controlling for additional variables
bys Name: egen total_publ=total(Publication) 
reg Publication having_industry_job total_publ years_in_industry i.year if year!=2022 & years_in_industry>=1, robust 

esttab using "/Users/kasilvestrovich/Dropbox/regression_publications.tex", replace b(3) se(3) nomtitle label star(* 0.10 ** 0.05 *** 0.01) booktabs alignment(D{.}{.}{-1}) title(Number of publication and industry job table \label{reg1}) addnotes("Dependent variable: number of publications.")
