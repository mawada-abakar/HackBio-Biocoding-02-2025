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


# Stage-1
This repository contains solutions for Stage-1 of the HackBio Biocoding Internship. The scripts are written in R and cover different bioinformatics-related tasks.

# Project Overview
This repository contains four R scripts that perform various bioinformatics and computational tasks, including:

1-Translating DNA to protein sequences

2-Simulating and visualizing logistic growth curves

3-Determining the time to reach 80% of carrying capacity

4-Calculating Hamming distance between two strings

These scripts are designed to help with biological data analysis and computational research in genomics and population modeling.

 #Installation & Setup
 -Install R (if not already installed)
    Download and install R from CRAN.

 -Install Required R Packages
    Some scripts use additional libraries. Install them using:
    install.packages(c("ggplot2", "dplyr"))

# Scripts Overview

1-Translating DNA to protein sequences

This script converts a DNA sequence into a protein sequence using the standard genetic code.

🔹 How it Works:

-Takes a DNA sequence as input.
-Splits the sequence into codons (triplets).
-Maps each codon to an amino acid using the genetic code table.
-Returns the translated protein sequence.

🔹 Usage Example:
source("dna_to_protein.R")
dna_sequence <- "ATGGCCATTGTAATGGGCCGCTGAAAGGGTGCCCGATAG"
protein <- dna_to_protein(dna_sequence)
print(protein)  # Output: "MAMIVMGRAKGA*"

2-Logistic Growth Simulation & Growth Curves

This script simulates and visualizes logistic growth curves for 100 different populations.

🔹 How it Works:

-Uses a logistic growth model to simulate population growth.
-Randomizes lag phase and exponential phase for variation.
-Generates a dataframe with 100 different growth curves.
-Plots a subset of the growth curves.

🔹 Usage Example:
source("logistic_growth.R")
growth_data <- generate_growth_data(100)
head(growth_data)  # View first few rows

3-Determining the time to reach 80% of carrying capacity

This script determines the time when population growth reaches 80% of the carrying capacity (K) in a logistic model.

🔹 How it Works:

-Simulates logistic growth using the growth equation.
-Identifies the first time point where the population reaches 80% of K.

🔹 Usage Example:
source("time_to_80_percent.R")
time <- seq(0, 50, 1)
growth_curve <- simulate_logistic_growth(time)
time_80 <- time_to_80_percent(growth_curve)
print(paste("Time to reach 80% of K:", time_80))

4-Calculating Hamming distance between two strings

This script calculates the Hamming distance between two strings (e.g., Slack username vs Twitter handle).

🔹 How it Works:

-Pads the shorter string with spaces to make lengths equal.
-Compares characters at each position.
-Counts the number of different characters.

🔹 Usage Example:
source("hamming_distance.R")
slack_username <- "BioCoder123"
twitter_handle <- "BioDevGuy"
distance <- hamming_distance(slack_username, twitter_handle)
print(paste("Hamming Distance:", distance)) # Output : "Hamming Distance: 5"

🤝 Contributing

If you find any issues or improvements, feel free to submit a pull request or open an issue 😊.


# Stage-2
This repository contains solutions for Stage-2 of the HackBio Biocoding Internship, implemented entirely in R. Each task includes a brief explanation and the R code used to solve it.


1-Microbiology Task
This task requires analyzing a microbiology dataset containing Optical Density (OD600) measurements over Time for different bacterial strains under two conditions:

Knock-out (-): A gene is deleted/inactivated.
Knock-in (+): A gene is inserted/activated.

🔹Objective:

-Plot growth curves (OD600 vs Time) for different strains.

-Compare knock-out (-) and knock-in (+) strains.

-Determine the time to reach carrying capacity.

-Generate scatter and box plots for carrying capacity times.

-Conduct statistical analysis to compare knock-out and knock-in strains.

🔹Solution Approach:

1-Load and process the dataset.

2-Generate growth curves using ggplot2.

3-Use logistic growth modeling to determine carrying capacity times.

4-Generate scatter and box plots for comparisons.

5-Perform statistical tests (e.g., t-tests) to analyze differences.


2-Botany and Plant Science Task
This task requires analyzing a dataset describing scientists engineering mutants in a crop to improve pesticide resistance. They measured metabolic responses in both wild-type (WT) and mutants after 8 hours and 24 hours, comparing them to a DMSO (control) treatment.

🔹Objective:

-Compute the difference in metabolic response (ΔM) for wild type and mutant plants.

-Create a scatter plot for ΔM.

-Fit a reference line (y = x).

-Compute residuals and categorize metabolites.

-Highlight significant metabolites and analyze their trends.

-Plot metabolic response over time for selected metabolites.

🔹Solution Approach:

1-Load and Inspect the Data
2-Compute ΔM (Difference in Metabolic Response)
3-Create a Scatter Plot Comparing WT vs Mutant ΔM
4-Fit a reference Line with y = x
5-Compute residuals and categorize metabolites.
6-Highlight significant metabolites and analyze their trends.
7-Create a Line Plot for Selected Metabolites


3-Biochemistry and Oncology Task
This task involves analyzing the functional and structural impact of amino acid mutations on protein stability and function using two datasets:

1-SIFT Dataset (Functional Impact): Measures how amino acid substitutions affect protein function.
SIFT Score < 0.05 → Deleterious mutation.

2-FoldX Dataset (Structural Impact): Measures the effect of amino acid substitutions on protein stability (energy changes in kCal/mol).
FoldX Score > 2 kCal/mol → Deleterious mutation.

🔹Objective:

-Merge SIFT and FoldX datasets using a common identifier.

-Identify mutations affecting both structure and function.

-Determine the amino acid with the highest impact.

-Generate a frequency table and visualize amino acid impacts.

🔹Solution Approach:

1-Load and Inspect the Data
2-Create a specific Protein_ Amino Acid column
3-Merge SIFT and FoldX Datasets
4-Filter Deleterious Mutations
5-Extract First Amino Acid from Mutation
6-Generate Frequency Table
7-visualize amino acid impacts using Bar Plot and pie plot
8-Identify Amino Acid with Highest Impact
9-Analyze Amino Acids with >100 Occurrences



