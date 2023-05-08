{{
  config(
    materialized='table'
  )
}}

with fact_cte fa AS (
 SELECT 
	d.ID,                  
	d.LOANNUMBER,            
	d.NAICSCODE,           
	d.LOANSTATUS,           
	d.LOANSTATUSDATE,       
	d.SBAOFFICECODE,       
	d.PROCESSINGMETHOD,     
	d.DATEAPPROVED,         
	d.TERM,                 
	d.SBAGUARANTYPERCENTAGE,
	d.INITIALAPPROVALAMOUNT,
	d.CURRENTAPPROVALAMOUNT,
	d.UNDISBURSEDAMOUNT,    
	d.RURALURBANINDICATOR,  
	d.HUBZONEINDICATOR,     
	d.LMIINDICATOR,         
	d.JOBSREPORTED,         
	d.FORGIVENESSAMOUNT,    
	d.FORGIVENESSDATE
    db.id as borrower,
    dd.id as datekey,
    df.id as LoanStatusDateKey,
    dl.id as ForgivenessDateKey,
    dn.id as naicscode,
    dor.id as originatinglender,
    dp.id as project,
    ds.id servicinglender,      
from DATA d

JOIN {{ ref('dim_borrower') }} db
    ON db.BORROWNAME = d.BORROWNAME
JOIN {{ ref('dim_date') }} dd
    ON dd.date_value = d.DateApproved
JOIN {{ ref('dim_date') }} dl
    ON dd.date_value = d.LoanStatusDate
JOIN {{ ref('dim_date') }} df
    ON dd.date_value = d.ForgivenessDate
JOIN {{ ref('dim_naics') }} dn
    ON dn.NAICSCode = d.NAICSCODE
JOIN {{ ref('dim_originatingLender') }} dor
    ON dor.ORIGINATINGLENDER = d.ORIGINATINGLENDER
JOIN {{ ref('dim_project') }} dp
    ON dp.ProjectCountyName = d.ProjectCountyName
JOIN {{ ref('dim_servicingLender') }} ds
    ON ds.SERVICINGLENDERNAME = d.SERVICINGLENDERNAME
)

 

insert into fact_ppp (id, loannumber, borrower, originatinglender, datekey, servicinglender, project, naicscode,
                      loanstatus, loanstatusdate, sbaofficecode, processingmethod, dateapproved, term,
                      sbaguarantypercentage, initialapprovalamount, currentapprovalamount, undisbursedamount,
                      ruralurbanindicator, hubzoneindicator, lmiindicator, jobsreported, forgivenessamount,
                      forgivenessdate)
select
id, loannumber, borrower, originatinglender, datekey, servicinglender, project, naicscode,
                      loanstatus, LoanStatusDateKey, sbaofficecode, processingmethod, dateapproved, term,
                      sbaguarantypercentage, initialapprovalamount, currentapprovalamount, undisbursedamount,
                      ruralurbanindicator, hubzoneindicator, lmiindicator, jobsreported, forgivenessamount,
                      ForgivenessDateKey
from fact_cte