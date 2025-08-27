# Clear existing data and graphics ---------------------------------------------
#graphics.off()

# Load libraries ---------------------------------------------------------------
library(Hmisc)
library(tidyverse)

# Read Data --------------------------------------------------------------------
data=read.csv(here::here("data", "HealthEquityAtDFMPra_DATA_2022-05-23_1207.csv"))

# Change the names Question 4 columns because the order goes beyond 10 and 
# causes the ordering of factors to be wonky. There's also an added underscore
q4_index <- data %>% 
  select(hi_race_q1___1:hi_race_q1____67) %>% 
  names()

q4_names <- c("hi_race_q1___01",
              "hi_race_q1___02",
              "hi_race_q1___66",
              "hi_race_q1___04",
              "hi_race_q1___05",
              "hi_race_q1___06",
              "hi_race_q1___07",
              "hi_race_q1___08",
              "hi_race_q1___09",
              "hi_race_q1___10",
              "hi_race_q1___11",
              "hi_race_q1___67")

data <- data %>%
  rename_at(all_of(q4_index), ~q4_names)

# Set Labels -------------------------------------------------------------------
label(data$record_id)="Record ID"
label(data$redcap_survey_identifier)="Survey Identifier"
label(data$health_equity_in_dfm_practices_survey_timestamp)="Survey Timestamp"
label(data$hi_problems_q1___1)="in the United States? (choice=Not a problem at all)"
label(data$hi_problems_q1___2)="in the United States? (choice=Minor problem )"
label(data$hi_problems_q1___3)="in the United States? (choice=Moderate problem )"
label(data$hi_problems_q1___4)="in the United States? (choice=Serious problem)"
label(data$hi_problems_q2___1)="in the UCHealth System? (choice=Not a problem at all)"
label(data$hi_problems_q2___2)="in the UCHealth System? (choice=Minor problem )"
label(data$hi_problems_q2___3)="in the UCHealth System? (choice=Moderate problem )"
label(data$hi_problems_q2___4)="in the UCHealth System? (choice=Serious problem)"
label(data$hi_problems_q3___1)="In your clinic? (choice=Not a problem at all)"
label(data$hi_problems_q3___2)="In your clinic? (choice=Minor problem )"
label(data$hi_problems_q3___3)="In your clinic? (choice=Moderate problem )"
label(data$hi_problems_q3___4)="In your clinic? (choice=Serious problem)"
label(data$hi_clinic_q1)="Patient attitudes and beliefs about health and healthcare"
label(data$hi_clinic_q2)="Patient health behaviors (diet, exercise, adherence to medical treatment)"
label(data$hi_clinic_q3)="Patient social and economic circumstances (transportation, availability of healthy food, economic opportunities, etc)"
label(data$hi_clinic_q4)="Biologic/genetic differences"
label(data$hi_clinic_q5)="Patient access to healthcare"
label(data$hi_clinic_q6)="Availability of healthcare providers from similar backgrounds as their patients"
label(data$hi_clinic_q7)="Provider attitudes and beliefs about patients from different backgrounds"
label(data$hi_clinic_q8)="Miscommunication between patients and healthcare providers"
label(data$patient_hi_q1)="Is there anything else that you think leads to health inequities among your patients?"
label(data$patient_hi_q2)="Please share what else you think leads to health inequities among your patients"
label(data$hi_race_q1___01)="Among patients at your clinic, do you think that any of the following groups experience worse health than that of an average Colorado resident? (Select all that apply) (choice=Black/African American)"
label(data$hi_race_q1___02)="Among patients at your clinic, do you think that any of the following groups experience worse health than that of an average Colorado resident? (Select all that apply) (choice=Hispanic/Latinx )"
label(data$hi_race_q1___66)="Among patients at your clinic, do you think that any of the following groups experience worse health than that of an average Colorado resident? (Select all that apply) (choice=Other race/ethnicity (please specify))"
label(data$hi_race_q1___04)="Among patients at your clinic, do you think that any of the following groups experience worse health than that of an average Colorado resident? (Select all that apply) (choice=Lesbian/gay, or bisexual patients)"
label(data$hi_race_q1___05)="Among patients at your clinic, do you think that any of the following groups experience worse health than that of an average Colorado resident? (Select all that apply) (choice=Transgender or gender nonconforming patients)"
label(data$hi_race_q1___06)="Among patients at your clinic, do you think that any of the following groups experience worse health than that of an average Colorado resident? (Select all that apply) (choice=Patients with a disability)"
label(data$hi_race_q1___07)="Among patients at your clinic, do you think that any of the following groups experience worse health than that of an average Colorado resident? (Select all that apply) (choice=Non-English Speaking patients)"
label(data$hi_race_q1___08)="Among patients at your clinic, do you think that any of the following groups experience worse health than that of an average Colorado resident? (Select all that apply) (choice=Patients with limited education)"
label(data$hi_race_q1___09)="Among patients at your clinic, do you think that any of the following groups experience worse health than that of an average Colorado resident? (Select all that apply) (choice=Patients with low income)"
label(data$hi_race_q1___10)="Among patients at your clinic, do you think that any of the following groups experience worse health than that of an average Colorado resident? (Select all that apply) (choice=Immigrants or other non-citizens)"
label(data$hi_race_q1___11)="Among patients at your clinic, do you think that any of the following groups experience worse health than that of an average Colorado resident? (Select all that apply) (choice=Elderly patients)"
label(data$hi_race_q1___67)="Among patients at your clinic, do you think that any of the following groups experience worse health than that of an average Colorado resident? (Select all that apply) (choice=Other)"
label(data$hi_race_fre_rspse)="Other groups (please specify) "
label(data$hi_individual_q1)="How important is it to you to address health inequities within your clinic?"
label(data$hi_individual_q2)="Why is it not important at all or slightly important to address health inequities within your clinic?"
label(data$hi_individual_q3)="Other (please specify):"
label(data$hi_clinicleaders_q1)="How important is it to clinic leadership to address health inequities at your clinic?"
label(data$personal_actions_q1___1)="Participated in professional development related to health equity (trainings, webinars, lectures, etc)"
label(data$personal_actions_q1___2)="Participated in other opportunities to learn about topics related to health equity (read books, listened to podcasts, watched a documentary, etc)"
label(data$personal_actions_q1___3)="Changed the way I provide patient care to be more equitable or inclusive"
label(data$personal_actions_q1___4)="Changed my communication with patients to be more equitable or inclusive"
label(data$personal_actions_q1___5)="Participated in a project at my practice that aimed to reduce health inequities"
label(data$personal_actions_q1___6)="Provided feedback to leadership about how the practice could be more equitable or inclusive"
label(data$personal_actions_q1___7)="Other (please specify)"
label(data$personal_actions_q2)="Please specify the other actions you have taken"
label(data$hi_strategy_q1)="Practice leaders make a clear commitment to health equity and create a team to lead the work"
label(data$hi_strategy_q2)="Provide training on topics related to health equity, diversity, and inclusion"
label(data$hi_strategy_q3)="Focus on health inequities in quality improvement projects"
label(data$hi_strategy_q4)="Conduct a formal review to look for policies and practices that may make health inequities worse"
label(data$hi_strategy_q5)="Provide data to staff and providers about health inequities among the patients at this clinic"
label(data$hi_strategy_q6)="Ask patients about social barriers to health and refer them to resources (social barriers to health include problems with transportation, housing, food access, etc)"
label(data$hi_strategy_q7)="Partner with local community organizations to improve the health of your patients"
label(data$hi_strategy_q8)="Incorporate more input from patients experiencing health inequities into clinic decisions"
label(data$hi_strategy_q9)="Promote and celebrate diversity of clinic staff, clinicians, and leadership"
label(data$hi_barriers_q1)="What else do you think would help reduce health inequities among your patients? "
label(data$hi_barriers_q2___1)="Staff and providers do not have the knowledge or skills to address health inequities."
label(data$hi_barriers_q2___2)="The culture at my clinic would not support the work"
label(data$hi_barriers_q2___3)="The culture at UCHealth would not support the work"
label(data$hi_barriers_q2___4)="Not enough resources (personnel, time, space)"
label(data$hi_barriers_q2___5)="Other priorities are more important"
label(data$hi_barriers_q2___6)="Staff and providers are not aware of the issue"
label(data$hi_barriers_q2___7)="Staff and providers are not interested in the issue"
label(data$hi_barriers_q2___8)="Lack of a leader for this work"
label(data$hi_barriers_q2___9)="Other (please specify)"
label(data$hi_barriers_q3)="Please specify any other barriers you believe exist"
label(data$hi_strengths_q1___1)="Knowledge and skills to address health inequities"
label(data$hi_strengths_q1___2)="A practice culture that is supportive of diversity and health equity efforts"
label(data$hi_strengths_q1___3)="Experience with successful quality improvement or other types of projects"
label(data$hi_strengths_q1___4)="Staff and providers who want to work on this issue"
label(data$hi_strengths_q1___5)="Financial resources that can be dedicated to this work"
label(data$hi_strengths_q1___6)="Existing meetings or committees that can be used to focus on this work"
label(data$hi_strengths_q1___7)="Other (please specify)"
label(data$hi_strengths_q2)="Other strengths and resources (please specify)"
label(data$hi_partners_q1)="Are there people or organizations in the community that could be partners to try to address health inequities among patients at your clinic?  If yes, who are they?"
label(data$demographic_1_practice)="What is your clinic location?"
label(data$demographic_2_role)="What is your role at the clinic? "
label(data$demographic_residency)=" Are you a resident/trainee or student?"
label(data$demographic_3_age)="What is your age?"
label(data$demographic_4_race___1)="American Indian or Alaskan Native"
label(data$demographic_4_race___2)="Asian"
label(data$demographic_4_race___3)="Black or African American"
label(data$demographic_4_race___4)="White"
label(data$demographic_4_race___5)="Hispanic or Latino"
label(data$demographic_4_race___6)="Another race"
label(data$demographic_4_race___8)="Prefer not to answer"
label(data$demographic_5_race_other)="Another race (please specify) "
label(data$demographic_6_gender)="What is your gender identity? "
label(data$demographic_7_gender_other)="Other (please specify) "
label(data$demographic_8_transgender)="Do you identify as transgender? "
label(data$demographic_9_disability)="Do you have a mental or physical disability?"
label(data$free_respons)="Please feel free to write any comments, concerns, or questions about the survey you may have. "
label(data$health_equity_in_dfm_practices_survey_complete)="Complete?"
label(data$admin_form_timestamp)="Survey Timestamp"
label(data$contact_info_1)="I would like to provide my contact info "
label(data$first_last)="First and Last Name "
label(data$email)="Email Address"
label(data$clinic_name)="Clinic Name"
label(data$admin_form_complete)="Complete?"
#Setting Units


# Set Factors(will create new variable for factors) ----------------------------
data$hi_problems_q1___1.factor = factor(data$hi_problems_q1___1,levels=c("0","1"))
data$hi_problems_q1___2.factor = factor(data$hi_problems_q1___2,levels=c("0","1"))
data$hi_problems_q1___3.factor = factor(data$hi_problems_q1___3,levels=c("0","1"))
data$hi_problems_q1___4.factor = factor(data$hi_problems_q1___4,levels=c("0","1"))
data$hi_problems_q2___1.factor = factor(data$hi_problems_q2___1,levels=c("0","1"))
data$hi_problems_q2___2.factor = factor(data$hi_problems_q2___2,levels=c("0","1"))
data$hi_problems_q2___3.factor = factor(data$hi_problems_q2___3,levels=c("0","1"))
data$hi_problems_q2___4.factor = factor(data$hi_problems_q2___4,levels=c("0","1"))
data$hi_problems_q3___1.factor = factor(data$hi_problems_q3___1,levels=c("0","1"))
data$hi_problems_q3___2.factor = factor(data$hi_problems_q3___2,levels=c("0","1"))
data$hi_problems_q3___3.factor = factor(data$hi_problems_q3___3,levels=c("0","1"))
data$hi_problems_q3___4.factor = factor(data$hi_problems_q3___4,levels=c("0","1"))
data$hi_clinic_q1.factor = factor(data$hi_clinic_q1,levels=c("1","2","3","4","5"))
data$hi_clinic_q2.factor = factor(data$hi_clinic_q2,levels=c("1","2","3","4","5"))
data$hi_clinic_q3.factor = factor(data$hi_clinic_q3,levels=c("1","2","3","4","5"))
data$hi_clinic_q4.factor = factor(data$hi_clinic_q4,levels=c("1","2","3","4","5"))
data$hi_clinic_q5.factor = factor(data$hi_clinic_q5,levels=c("1","2","3","4","5"))
data$hi_clinic_q6.factor = factor(data$hi_clinic_q6,levels=c("1","2","3","4","5"))
data$hi_clinic_q7.factor = factor(data$hi_clinic_q7,levels=c("1","2","3","4","5"))
data$hi_clinic_q8.factor = factor(data$hi_clinic_q8,levels=c("1","2","3","4","5"))
data$patient_hi_q1.factor = factor(data$patient_hi_q1,levels=c("1","0"))
data$hi_race_q1___01.factor = factor(data$hi_race_q1___01,levels=c("0","1"))
data$hi_race_q1___02.factor = factor(data$hi_race_q1___02,levels=c("0","1"))
data$hi_race_q1___66.factor = factor(data$hi_race_q1___66,levels=c("0","1"))
data$hi_race_q1___04.factor = factor(data$hi_race_q1___04,levels=c("0","1"))
data$hi_race_q1___05.factor = factor(data$hi_race_q1___05,levels=c("0","1"))
data$hi_race_q1___06.factor = factor(data$hi_race_q1___06,levels=c("0","1"))
data$hi_race_q1___07.factor = factor(data$hi_race_q1___07,levels=c("0","1"))
data$hi_race_q1___08.factor = factor(data$hi_race_q1___08,levels=c("0","1"))
data$hi_race_q1___09.factor = factor(data$hi_race_q1___09,levels=c("0","1"))
data$hi_race_q1___10.factor = factor(data$hi_race_q1___10,levels=c("0","1"))
data$hi_race_q1___11.factor = factor(data$hi_race_q1___11,levels=c("0","1"))
data$hi_race_q1___67.factor = factor(data$hi_race_q1___67,levels=c("0","1"))
data$hi_individual_q1.factor = factor(data$hi_individual_q1,levels=c("1","2","3","4"))
data$hi_individual_q2.factor = factor(data$hi_individual_q2,levels=c("1","2","3","-66"))
data$hi_clinicleaders_q1.factor = factor(data$hi_clinicleaders_q1,levels=c("a","b","c","d"))
data$personal_actions_q1___1.factor = factor(data$personal_actions_q1___1,levels=c("0","1"))
data$personal_actions_q1___2.factor = factor(data$personal_actions_q1___2,levels=c("0","1"))
data$personal_actions_q1___3.factor = factor(data$personal_actions_q1___3,levels=c("0","1"))
data$personal_actions_q1___4.factor = factor(data$personal_actions_q1___4,levels=c("0","1"))
data$personal_actions_q1___5.factor = factor(data$personal_actions_q1___5,levels=c("0","1"))
data$personal_actions_q1___6.factor = factor(data$personal_actions_q1___6,levels=c("0","1"))
data$personal_actions_q1___7.factor = factor(data$personal_actions_q1___7,levels=c("0","1"))
data$hi_strategy_q1.factor = factor(data$hi_strategy_q1,levels=c("1","2","3","4"))
data$hi_strategy_q2.factor = factor(data$hi_strategy_q2,levels=c("1","2","3","4"))
data$hi_strategy_q3.factor = factor(data$hi_strategy_q3,levels=c("1","2","3","4"))
data$hi_strategy_q4.factor = factor(data$hi_strategy_q4,levels=c("1","2","3","4"))
data$hi_strategy_q5.factor = factor(data$hi_strategy_q5,levels=c("1","2","3","4"))
data$hi_strategy_q6.factor = factor(data$hi_strategy_q6,levels=c("1","2","3","4"))
data$hi_strategy_q7.factor = factor(data$hi_strategy_q7,levels=c("1","2","3","4"))
data$hi_strategy_q8.factor = factor(data$hi_strategy_q8,levels=c("1","2","3","4"))
data$hi_strategy_q9.factor = factor(data$hi_strategy_q9,levels=c("1","2","3","4"))
data$hi_barriers_q2___1.factor = factor(data$hi_barriers_q2___1,levels=c("0","1"))
data$hi_barriers_q2___2.factor = factor(data$hi_barriers_q2___2,levels=c("0","1"))
data$hi_barriers_q2___3.factor = factor(data$hi_barriers_q2___3,levels=c("0","1"))
data$hi_barriers_q2___4.factor = factor(data$hi_barriers_q2___4,levels=c("0","1"))
data$hi_barriers_q2___5.factor = factor(data$hi_barriers_q2___5,levels=c("0","1"))
data$hi_barriers_q2___6.factor = factor(data$hi_barriers_q2___6,levels=c("0","1"))
data$hi_barriers_q2___7.factor = factor(data$hi_barriers_q2___7,levels=c("0","1"))
data$hi_barriers_q2___8.factor = factor(data$hi_barriers_q2___8,levels=c("0","1"))
data$hi_barriers_q2___9.factor = factor(data$hi_barriers_q2___9,levels=c("0","1"))
data$hi_strengths_q1___1.factor = factor(data$hi_strengths_q1___1,levels=c("0","1"))
data$hi_strengths_q1___2.factor = factor(data$hi_strengths_q1___2,levels=c("0","1"))
data$hi_strengths_q1___3.factor = factor(data$hi_strengths_q1___3,levels=c("0","1"))
data$hi_strengths_q1___4.factor = factor(data$hi_strengths_q1___4,levels=c("0","1"))
data$hi_strengths_q1___5.factor = factor(data$hi_strengths_q1___5,levels=c("0","1"))
data$hi_strengths_q1___6.factor = factor(data$hi_strengths_q1___6,levels=c("0","1"))
data$hi_strengths_q1___7.factor = factor(data$hi_strengths_q1___7,levels=c("0","1"))
data$demographic_1_practice.factor = factor(data$demographic_1_practice,levels=c("1","2","3","4","5"))
data$demographic_2_role.factor = factor(data$demographic_2_role,levels=c("1","2"))
data$demographic_residency.factor = factor(data$demographic_residency,levels=c("1","0"))
data$demographic_3_age.factor = factor(data$demographic_3_age,levels=c("1","2","3","4","5"))
data$demographic_4_race___1.factor = factor(data$demographic_4_race___1,levels=c("0","1"))
data$demographic_4_race___2.factor = factor(data$demographic_4_race___2,levels=c("0","1"))
data$demographic_4_race___3.factor = factor(data$demographic_4_race___3,levels=c("0","1"))
data$demographic_4_race___4.factor = factor(data$demographic_4_race___4,levels=c("0","1"))
data$demographic_4_race___5.factor = factor(data$demographic_4_race___5,levels=c("0","1"))
data$demographic_4_race___6.factor = factor(data$demographic_4_race___6,levels=c("0","1"))
data$demographic_4_race___8.factor = factor(data$demographic_4_race___8,levels=c("0","1"))
data$demographic_6_gender.factor = factor(data$demographic_6_gender,levels=c("1","2","3","4","5"))
data$demographic_8_transgender.factor = factor(data$demographic_8_transgender,levels=c("1","2","3"))
data$demographic_9_disability.factor = factor(data$demographic_9_disability,levels=c("1","2","3"))
data$health_equity_in_dfm_practices_survey_complete.factor = factor(data$health_equity_in_dfm_practices_survey_complete,levels=c("0","1","2"))
data$contact_info_1.factor = factor(data$contact_info_1,levels=c("1","0"))
data$clinic_name.factor = factor(data$clinic_name,levels=c("1","2","3","4","5"))
data$admin_form_complete.factor = factor(data$admin_form_complete,levels=c("0","1","2"))

levels(data$hi_problems_q1___1.factor)=c("Unchecked","Checked")
levels(data$hi_problems_q1___2.factor)=c("Unchecked","Checked")
levels(data$hi_problems_q1___3.factor)=c("Unchecked","Checked")
levels(data$hi_problems_q1___4.factor)=c("Unchecked","Checked")
levels(data$hi_problems_q2___1.factor)=c("Unchecked","Checked")
levels(data$hi_problems_q2___2.factor)=c("Unchecked","Checked")
levels(data$hi_problems_q2___3.factor)=c("Unchecked","Checked")
levels(data$hi_problems_q2___4.factor)=c("Unchecked","Checked")
levels(data$hi_problems_q3___1.factor)=c("Unchecked","Checked")
levels(data$hi_problems_q3___2.factor)=c("Unchecked","Checked")
levels(data$hi_problems_q3___3.factor)=c("Unchecked","Checked")
levels(data$hi_problems_q3___4.factor)=c("Unchecked","Checked")
levels(data$hi_clinic_q1.factor)=c("Not at all","Slightly","Moderately","Very much","Extremely")
levels(data$hi_clinic_q2.factor)=c("Not at all","Slightly","Moderately","Very much","Extremely")
levels(data$hi_clinic_q3.factor)=c("Not at all","Slightly","Moderately","Very much","Extremely")
levels(data$hi_clinic_q4.factor)=c("Not at all","Slightly","Moderately","Very much","Extremely")
levels(data$hi_clinic_q5.factor)=c("Not at all","Slightly","Moderately","Very much","Extremely")
levels(data$hi_clinic_q6.factor)=c("Not at all","Slightly","Moderately","Very much","Extremely")
levels(data$hi_clinic_q7.factor)=c("Not at all","Slightly","Moderately","Very much","Extremely")
levels(data$hi_clinic_q8.factor)=c("Not at all","Slightly","Moderately","Very much","Extremely")
levels(data$patient_hi_q1.factor)=c("Yes","No")
levels(data$hi_race_q1___01.factor)=c("Unchecked","Checked")
levels(data$hi_race_q1___02.factor)=c("Unchecked","Checked")
levels(data$hi_race_q1___66.factor)=c("Unchecked","Checked")
levels(data$hi_race_q1___04.factor)=c("Unchecked","Checked")
levels(data$hi_race_q1___05.factor)=c("Unchecked","Checked")
levels(data$hi_race_q1___06.factor)=c("Unchecked","Checked")
levels(data$hi_race_q1___07.factor)=c("Unchecked","Checked")
levels(data$hi_race_q1___08.factor)=c("Unchecked","Checked")
levels(data$hi_race_q1___09.factor)=c("Unchecked","Checked")
levels(data$hi_race_q1___10.factor)=c("Unchecked","Checked")
levels(data$hi_race_q1___11.factor)=c("Unchecked","Checked")
levels(data$hi_race_q1___67.factor)=c("Unchecked","Checked")
levels(data$hi_individual_q1.factor)=c("Not important at all","Slightly important","Moderately important","Extremely important")
levels(data$hi_individual_q2.factor)=c("Health inequities are not a significant issue in our practice.","Addressing health inequities is too difficult within our practice.","Other priorities are more important","Other (please specify):")
levels(data$hi_clinicleaders_q1.factor)=c("Not important at all","Slightly important","Moderately important","Extremely important")
levels(data$personal_actions_q1___1.factor)=c("Unchecked","Checked")
levels(data$personal_actions_q1___2.factor)=c("Unchecked","Checked")
levels(data$personal_actions_q1___3.factor)=c("Unchecked","Checked")
levels(data$personal_actions_q1___4.factor)=c("Unchecked","Checked")
levels(data$personal_actions_q1___5.factor)=c("Unchecked","Checked")
levels(data$personal_actions_q1___6.factor)=c("Unchecked","Checked")
levels(data$personal_actions_q1___7.factor)=c("Unchecked","Checked")
levels(data$hi_strategy_q1.factor)=c("Not effective","Somewhat effective","Very effective","Not sure")
levels(data$hi_strategy_q2.factor)=c("Not effective","Somewhat effective","Very effective","Not sure")
levels(data$hi_strategy_q3.factor)=c("Not effective","Somewhat effective","Very effective","Not sure")
levels(data$hi_strategy_q4.factor)=c("Not effective","Somewhat effective","Very effective","Not sure")
levels(data$hi_strategy_q5.factor)=c("Not effective","Somewhat effective","Very effective","Not sure")
levels(data$hi_strategy_q6.factor)=c("Not effective","Somewhat effective","Very effective","Not sure")
levels(data$hi_strategy_q7.factor)=c("Not effective","Somewhat effective","Very effective","Not sure")
levels(data$hi_strategy_q8.factor)=c("Not effective","Somewhat effective","Very effective","Not sure")
levels(data$hi_strategy_q9.factor)=c("Not effective","Somewhat effective","Very effective","Not sure")
levels(data$hi_barriers_q2___1.factor)=c("Unchecked","Checked")
levels(data$hi_barriers_q2___2.factor)=c("Unchecked","Checked")
levels(data$hi_barriers_q2___3.factor)=c("Unchecked","Checked")
levels(data$hi_barriers_q2___4.factor)=c("Unchecked","Checked")
levels(data$hi_barriers_q2___5.factor)=c("Unchecked","Checked")
levels(data$hi_barriers_q2___6.factor)=c("Unchecked","Checked")
levels(data$hi_barriers_q2___7.factor)=c("Unchecked","Checked")
levels(data$hi_barriers_q2___8.factor)=c("Unchecked","Checked")
levels(data$hi_barriers_q2___9.factor)=c("Unchecked","Checked")
levels(data$hi_strengths_q1___1.factor)=c("Unchecked","Checked")
levels(data$hi_strengths_q1___2.factor)=c("Unchecked","Checked")
levels(data$hi_strengths_q1___3.factor)=c("Unchecked","Checked")
levels(data$hi_strengths_q1___4.factor)=c("Unchecked","Checked")
levels(data$hi_strengths_q1___5.factor)=c("Unchecked","Checked")
levels(data$hi_strengths_q1___6.factor)=c("Unchecked","Checked")
levels(data$hi_strengths_q1___7.factor)=c("Unchecked","Checked")
levels(data$demographic_1_practice.factor)=c("AF Williams","Boulder","Lone Tree","Westminster","WISH")
levels(data$demographic_2_role.factor)=c("Staff","Clinician/Provider")
levels(data$demographic_residency.factor)=c("Yes ","No ")
levels(data$demographic_3_age.factor)=c("18 - 35","36 - 50","51 - 64","65+","Prefer not to answer")
levels(data$demographic_4_race___1.factor)=c("Unchecked","Checked")
levels(data$demographic_4_race___2.factor)=c("Unchecked","Checked")
levels(data$demographic_4_race___3.factor)=c("Unchecked","Checked")
levels(data$demographic_4_race___4.factor)=c("Unchecked","Checked")
levels(data$demographic_4_race___5.factor)=c("Unchecked","Checked")
levels(data$demographic_4_race___6.factor)=c("Unchecked","Checked")
levels(data$demographic_4_race___8.factor)=c("Unchecked","Checked")
levels(data$demographic_6_gender.factor)=c("Woman","Man","Nonbinary/Gender Non-Conforming","Other (please specify)","Prefer not to answer")
levels(data$demographic_8_transgender.factor)=c("Yes","No","Prefer not to answer")
levels(data$demographic_9_disability.factor)=c("Yes","No","Prefer not to answer")
levels(data$health_equity_in_dfm_practices_survey_complete.factor)=c("Incomplete","Unverified","Complete")
levels(data$contact_info_1.factor)=c("Yes","No")
levels(data$clinic_name.factor)=c("Lone Tree","WISH","Boulder","AFW","Westminster")
levels(data$admin_form_complete.factor)=c("Incomplete","Unverified","Complete")

# Prep Variables & Labels  ------------------------------------------------
# Filter data by when the survey was released
data <- data %>% 
  separate(health_equity_in_dfm_practices_survey_timestamp, 
                into = c("date", "timestamp"),
                sep = " ")

# Convert to date format
data$date <- as.Date(data$date, "%Y-%m-%d")

# Filter out data by the 1st of April 2022
data <- data %>%
  filter(date >= "2022-04-01")

# Get all of the labels for the non-factored columns 
labels <- data %>%
  select(!contains(".factor"))  %>%
  map_df(., ~attr(.x, "label"))

## Demographics Table ----------------------------------------------------------
  # Requirements:
  # 1. List of demographic variables for tbl_summary() because they are factored
  # 2. List of race variables separately for add_variable_grouping() and because
  #    they the columns used are binary variable 
  
  # Demographic Variables:
  # Use the .factored columns because the integer values have already been trans-
  # formed to something readable
  dem_vars <- names(data %>% 
                      select(starts_with("demographic") & 
                               ends_with(".factor") & 
                               !contains("race")))

  # Label the .factor columns for display in tbl_summary()
  dem_labels <- c("Practice", "Role", "Resident", "Age", "Gender", "Transgender", "Disability")
  for (i in seq_along(dem_vars)){
    label(data[[dem_vars[i]]]) <- dem_labels[i]
  }
  
  # Race & Ethnicity Variables:
  # Use the un factored columns because they are coded as 0 or 1 which makes them
  # easier to work with instead of the factored Checked/Unchecked
  race_vars <- names(data %>% 
          select(starts_with("demographic") & 
                   contains("race") & 
                   !contains(".factor") &
                   !contains("other")))


## Question 1 ------------------------------------------------------------------
  # Requirements:
  # 1. Three columns of factored responses for tbl_liker(). Can't use the 
  # .factored nor the un factored columns because each sub question is spread 
  # across 4 columns. 
  
  # Create a function that will collapse the Q1 sub question columns into new
  # columns. Each sub set of questions consist of 4 columns coded as binary values
  collapse_cols <- function(vars, name){
    # vars is a character vector naming a subset of 4 columns
    # name is a string variable of what to name the collapsed columns
    # Usage: collapse_cols(q1_vars[1:4], "in the US?")
    data <<- data %>%
      mutate("{name}" := case_when(
        .[, vars[1]] == 1 ~ "Not a problem at all",
        .[, vars[2]] == 1 ~ "Minor problem",
        .[, vars[3]] == 1 ~ "Moderate problem",
        .[, vars[4]] == 1 ~ "Serious problem")) %>%
      mutate_at(all_of(name), 
                ~factor(., levels = c("Not a problem at all",
                                      "Minor problem",
                                      "Moderate problem",
                                      "Serious problem")))
  }
  
  # Set the variable names for all of the Q1 sub questions
  q1_vars <- names(data %>% select(hi_problems_q1___1:hi_problems_q3___4))
  
  # Apply the collapse_col function 
  collapse_cols(q1_vars[1:4], "in the US?")
  collapse_cols(q1_vars[5:8], "in the UC Health System?")
  collapse_cols(q1_vars[9:12], "in your clinic?")
  
  # Remove unused columns
  data <- data %>% 
    select(-(hi_problems_q1___1:hi_problems_q3___4)) %>% 
    select(-(hi_problems_q1___1.factor:hi_problems_q3___4.factor))


## Question 2 ------------------------------------------------------------------
  # Uses the .factored columns to create table & plots, but it uses the labels 
  # from the uncfactored columns to rename the .factored columns for display
  # Requirements
  # 1. q2_vars which are the names of the columns of the .factored columns
  # 2. q2_names which are the labels of the non-factored q2 columns
  
  # Set the q2_vars variable for the factored columns
  q2_vars <- names(data %>% select(contains("hi_clinic_q") & contains(".factor")))
    
  # Set the q2_names to be used in renaming the factored columns
  q2_names <- as.character(labels %>% select(hi_clinic_q1:hi_clinic_q8))
    
  # Remove unused columns
  data <- data %>% select(-(hi_clinic_q1:hi_clinic_q8))
  
  # Collapse very much and extremely in one category very much/extremely
    data <- data %>%
      mutate_at(all_of(q2_vars), 
                ~fct_collapse(.,
                              "Not at all" =  "Not at all",
                               "Slightly" =  "Slightly",
                               "Moderately" =  "Moderately",
                               "Very much/Extremely" = c("Very much",  "Extremely")
                                               ))
      
## Question 3 -------------------------------------------------------------------
  # Set the q3_vars variable for the factored columns
  q3_vars <- names(data %>% select(patient_hi_q1.factor))
  
  # Set the q3_names to be used in renaming the factored columns
  q3_names <- as.character(labels %>% select(patient_hi_q1))


## Question 4 ------------------------------------------------------------------
  # Uses the unfactored columns for the table, and the .factored columns for the plot
  # Table Requirements:
  # 1. q4_labels for the plot from the labels df and sub stringed to get the 
  # labels to look nice
  
  # There are two "other" columns for this question. One indexes the respondents
  # that provided a free response (67) and refers to other groups. The other 
  # column references other race/ethnicity (66). This code chunk collapses 
  # across the two columns
  data$hi_race_q1___66 <- data$hi_race_q1___66 + data$hi_race_q1___67 
  data$hi_race_q1___66[data$hi_race_q1___66 >= 1] <- 1 
  data$hi_race_q1___66.factor <- factor(data$hi_race_q1___66,levels = c("0","1"))
  label(data$hi_race_q1___66) = "Among patients at your clinic, do you think that any of the following groups experience worse health than that of an average Colorado resident? (Select all that apply) (choice=Other groups (please specify))"

  levels(data$hi_race_q1___66.factor)=c("Unchecked","Checked")
  data <- data %>% select(-hi_race_q1___67, -hi_race_q1___67.factor)                                         
  
  
  # Redo the labels
  labels <- data %>%
    select(!contains(".factor"))  %>%
    map_df(., ~attr(.x, "label"))
  
  # Plot Requirements:
  # 1. q4_vars consisting of the factored columns
  q4_vars <- data %>% 
    select(hi_race_q1___01.factor:hi_race_q1___11.factor) %>%
    names() %>%
    sort()
  
  # 2. q4_labels after removing the .factor suffix
  q4_labels <- as.character(
    labels %>% select(all_of(sub("\\..*", "", q4_vars)))) %>% 
    str_sub(., 177, -2)


## Question 5 ------------------------------------------------------------------
  # Uses factored data only for both the table and the plots
  q5.1_labels <- as.character(
    labels %>% select(hi_individual_q1))
  
  q5.2_labels <- as.character(
    labels %>% select(hi_individual_q2))
  
  # Remove unused columns
  data <- data %>% select(-hi_individual_q1, -hi_individual_q2)
  
  
## Question 6 ------------------------------------------------------------------
  # Uses factored data only for both the table and the plots
  q6_labels <- as.character(
    labels %>% select(hi_clinicleaders_q1))

  # Remove unused columns
  data <- data %>% select(-hi_clinicleaders_q1)

  
## Question 7 ------------------------------------------------------------------
  # Uses the unfactored data for the table and factored data for the plots
  # Requirements
  # 1. q7_vars
  # 2. q7_labels
  q7_vars <- names (data %>% select(personal_actions_q1___1.factor:personal_actions_q1___7.factor))
  
  # Get the labels to insert into the plot
  q7_labels <- as.character(
    labels %>% select(starts_with("personal_actions_q1")))


## Question 8 ------------------------------------------------------------------
  # Uses the unfactored data for the table and factored data for the plots
  # Requirements
  # 1. q8_vars
  # 2. q7_labels
  q8_vars <- names(data %>% select(hi_strategy_q1.factor:hi_strategy_q9.factor))
  
  # Get the names to rename columns
  q8_names <- as.character(labels %>% select(hi_strategy_q1:hi_strategy_q9))
  
  # Change the order of the factor levels so they are displayed differenty in
  # plots
  data <- data %>%
    mutate_at(vars(all_of(q8_vars)), ~fct_relevel(., "Not sure") )


## Question 9 ------------------------------------------------------------------
  # Free response question only, see below.


## Question 10 -----------------------------------------------------------------
  # Uses the unfactored data for the table and factored data for the plots
  # Requirements
  # 1. q10_vars
  # 2. q10_vars
  
  # could not work with the labelled attribute in the non-factored columns
  q10_vars <- names(data %>% select(hi_barriers_q2___1.factor:hi_barriers_q2___9.factor))
  
  # Get the labels to insert into the plot
  q10_labels <- as.character(
    labels %>% select(starts_with("hi_barriers_q2")))


## Question 11 -----------------------------------------------------------------
  # Uses the unfactored data for the table and factored data for the plots
  # Requirements
  # 1. q11_vars
  # 2. q11_vars
  q11_vars <- names(data %>% select(hi_strengths_q1___1.factor:hi_strengths_q1___7.factor))
  
  # Get the labels to insert into the plot
  q11_labels <- as.character(
    labels %>% select(starts_with("hi_strengths_q1")))


## Question 12 -----------------------------------------------------------------
  # Free response question only, see below.


## Free Response Questions -----------------------------------------------------
  # Variables for the free response questions
  free_vars <- c("hi_race_fre_rspse",
                 "patient_hi_q2",
                 "hi_individual_q3", 
                 "personal_actions_q2", 
                 "hi_barriers_q1", 
                 "hi_barriers_q3",
                 "hi_strengths_q2",
                 "hi_partners_q1")
  
  # Corresponding names of the tables according to question number
  free_names <- c("q4.tab.f",
                  "q3.tab.f",
                  "q5.tab.f",
                  "q7.tab.f", 
                  "q9.tab.f", 
                  "q10.tab.f",
                  "q11.tab.f",
                  "q12.tab.f")

# Response Rates --------------------------------------------------------------
# Create a dataframe of the response rates
Clinics <- c("All Clinics", "AF Williams", "Boulder", "Lone Tree", "Westminster", "WISH")
Surveys_Sent <- c(243, 80, 38, 54, 36, 35)
Surveys_Completed <- c(nrow(data), 
              nrow(filter(data, demographic_1_practice.factor == Clinics[2])),
              nrow(filter(data, demographic_1_practice.factor == Clinics[3])),
              nrow(filter(data, demographic_1_practice.factor == Clinics[4])),
              nrow(filter(data, demographic_1_practice.factor == Clinics[5])),
              nrow(filter(data, demographic_1_practice.factor == Clinics[6])))
              
response_rates <- data.frame(Clinics, Surveys_Sent, Surveys_Completed)

response_rates <- response_rates %>%
  mutate("Response Rate (%)" = round(Surveys_Completed/Surveys_Sent * 100, 0))

# Rename response rate columns for output to table
names(response_rates) <- c("Clinics", 
                           "Surveys Sent", 
                           "Surveys Completed", 
                           "Response Rate (%)")

# Remove any remaining rows not necessary generating reports ----
# data %>%
#     filter(health_equity_in_dfm_practices_survey_timestamp != "[not complete]")
  
# Remove any remaining columns not necessary generating reports ----
data <- data %>% 
  select(-redcap_survey_identifier, 
        # -health_equity_in_dfm_practices_survey_timestamp, 
         -admin_form_timestamp, 
         -contact_info_1, 
         -contact_info_1.factor, 
         -first_last, 
         -email, 
         -clinic_name, 
         -clinic_name.factor, 
         -admin_form_complete, 
         -admin_form_complete.factor)

rm(i)

# Create a Role variable
data$Role <- data$demographic_2_role.factor
