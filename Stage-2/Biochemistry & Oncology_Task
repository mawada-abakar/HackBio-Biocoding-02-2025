# Load necessary libraries
library(ggplot2)
library(dplyr)
library(readr)
library(tidyr)

# Step 1: Import both datasets
sift_url <- "https://raw.githubusercontent.com/HackBio-Internship/2025_project_collection/refs/heads/main/Python/Dataset/sift.tsv"
foldx_url <- "https://raw.githubusercontent.com/HackBio-Internship/2025_project_collection/refs/heads/main/Python/Dataset/foldx.tsv"

sift_data <- read_tsv(sift_url)
foldx_data <- read_tsv(foldx_url)

# Inspect the structure of datasets
head(sift_data)
head(foldx_data)

# Step 2: Create 'specific_Protein_aa' column
sift_data <- sift_data %>%
  mutate(specific_Protein_aa = paste(Protein, Amino_acid, sep = "_"))

foldx_data <- foldx_data %>%
  mutate(specific_Protein_aa = paste(Protein, Amino_acid, sep = "_"))

# Step 3: Merge SIFT and FoldX datasets using 'specific_Protein_aa'
merged_data <- inner_join(sift_data, foldx_data, by = "specific_Protein_aa")

# Step 4: Identify deleterious mutations
deleterious_mutations <- merged_data %>%
  filter(SIFT_Score < 0.05 & FoldX_Score > 2)

# Step 5: Extract the first amino acid (original residue) from the substitution (e.g., E63D → E)
deleterious_mutations <- deleterious_mutations %>%
  mutate(Original_Amino_Acid = substr(Amino_acid.x, 1, 1))  # Extracts first character

# Step 6: Generate a frequency table for the first amino acids
amino_acid_freq <- deleterious_mutations %>%
  count(Original_Amino_Acid, name = "Frequency") %>%
  arrange(desc(Frequency))

# Step 7: Bar Plot of Amino Acid Frequency
ggplot(amino_acid_freq, aes(x = reorder(Original_Amino_Acid, -Frequency), y = Frequency, fill = Original_Amino_Acid)) +
  geom_bar(stat = "identity") +
  labs(title = "Frequency of Deleterious Amino Acid Mutations",
       x = "Amino Acid",
       y = "Frequency") +
  theme_minimal()

# Step 8: Pie Chart of Amino Acid Frequency
ggplot(amino_acid_freq, aes(x = "", y = Frequency, fill = Original_Amino_Acid)) +
  geom_bar(width = 1, stat = "identity") +
  coord_polar("y") +
  labs(title = "Proportion of Amino Acids in Deleterious Mutations") +
  theme_void()

# Step 9: Identify the amino acid with the highest impact
top_amino_acid <- amino_acid_freq %>%
  slice_max(order_by = Frequency, n = 1)  # Get the amino acid with the highest occurrence

print(top_amino_acid)

# Step 10: Analyze Amino Acids with More Than 100 Occurrences
high_impact_aa <- amino_acid_freq %>%
  filter(Frequency > 100)

print(high_impact_aa)

# Observations and Analysis:
# - The amino acid with the highest impact is stored in 'top_amino_acid'.
# - The bar plot and pie chart show the distribution of amino acid mutations.
# - Amino acids occurring >100 times indicate a trend in their structural and functional impact.
# - Hydrophobic and charged residues may show higher impact due to their role in protein stability and interactions.
