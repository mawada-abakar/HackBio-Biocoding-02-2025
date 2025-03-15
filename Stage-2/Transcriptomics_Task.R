# Load necessary libraries
library(ggplot2)
library(dplyr)
library(readr)

# Step 1: Load the dataset
url <- "https://gist.githubusercontent.com/stephenturner/806e31fce55a8b7175af/raw/1a507c4c3f9f1baaa3a69187223ff3d3050628d4/results.txt"
data <- read_tsv(url)

# Inspect the first few rows of the dataset
head(data)

# Step 2: Generate the Volcano Plot
# Compute -log10(p-value) for visualization
data <- data %>%
  mutate(logP = -log10(P.Value))

# Create the volcano plot
volcano_plot <- ggplot(data, aes(x = logFC, y = logP)) +
  geom_point(aes(color = (logFC > 1 & P.Value < 0.01) | (logFC < -1 & P.Value < 0.01)), alpha = 0.5) +
  scale_color_manual(values = c('grey', 'red')) +
  geom_vline(xintercept = c(-1, 1), linetype = 'dashed', color = 'blue') +
  geom_hline(yintercept = -log10(0.01), linetype = 'dashed', color = 'blue') +
  labs(title = 'Volcano Plot', x = 'Log2 Fold Change', y = '-log10(p-value)') +
  theme_minimal()

# Display the plot
print(volcano_plot)

# Step 3: Identify Upregulated and Downregulated Genes
upregulated_genes <- data %>%
  filter(logFC > 1, P.Value < 0.01) %>%
  arrange(desc(logFC))

downregulated_genes <- data %>%
  filter(logFC < -1, P.Value < 0.01) %>%
  arrange(logFC)

# Display the top 5 upregulated and downregulated genes
top5_upregulated <- head(upregulated_genes, 5)
top5_downregulated <- head(downregulated_genes, 5)

print("Top 5 Upregulated Genes:")
print(top5_upregulated$Gene)

print("Top 5 Downregulated Genes:")
print(top5_downregulated$Gene)

# Step 4: Investigate Gene Functions (Using GeneCards or Ensembl)
# This step requires querying an online database

# Install and load the biomaRt package for accessing Ensembl data
if (!requireNamespace("biomaRt", quietly = TRUE)) {
  install.packages("biomaRt")
}
library(biomaRt)

# Use Ensembl as the BioMart database
ensembl <- useMart("ensembl", dataset = "hsapiens_gene_ensembl")

# Function to retrieve gene descriptions
get_gene_description <- function(gene_symbol) {
  result <- getBM(attributes = c('hgnc_symbol', 'description'),
                  filters = 'hgnc_symbol',
                  values = gene_symbol,
                  mart = ensembl)
  if (nrow(result) > 0) {
    return(result$description[1])
  } else {
    return(NA)
  }
}

# Retrieve descriptions for top 5 upregulated genes
upregulated_descriptions <- sapply(top5_upregulated$Gene, get_gene_description)
names(upregulated_descriptions) <- top5_upregulated$Gene

# Retrieve descriptions for top 5 downregulated genes
downregulated_descriptions <- sapply(top5_downregulated$Gene, get_gene_description)
names(downregulated_descriptions) <- top5_downregulated$Gene

print("Descriptions of Top 5 Upregulated Genes:")
print(upregulated_descriptions)

print("Descriptions of Top 5 Downregulated Genes:")
print(downregulated_descriptions)
