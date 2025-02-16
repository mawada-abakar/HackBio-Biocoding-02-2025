# HackBio-Biocoding-02-2025

# Stage-0
This project demonstrates how to store and display personal details using R in the HackBio Stage-0 Biocoding Internship.

Steps to Follow:

  1.Set Up Your Environment
     Ensure R is installed on your system. If not, download and install it from CRAN.
     Optionally, install RStudio for an enhanced coding experience.
     
 2.Define Your Personal Information
    Store your details as variables in R
    
# Define personal details

name <- "Your Name"

slack_username <- "@YourSlackUsername"

email <- "your.email@example.com"

hobby <- "Your Hobby"

country <- "Your Country"

discipline <- "Your Discipline"

preferred_language <- "R"

# Display information
personal_info <- data.frame(
  Field = c("Name", "Slack Username", "Email", "Hobby", "Country", "Discipline", "Preferred Programming Language"),
  Value = c(name, slack_username, email, hobby, country, discipline, preferred_language)
)

print(personal_info)

