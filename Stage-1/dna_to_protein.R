# Function: DNA to Protein Translation
# This function takes a DNA sequence as input and returns the translated protein sequence.

dna_to_protein <- function(dna_seq) {
  # Define the genetic code as a named vector
  genetic_code <- c(
    "ATA" = "I", "ATC" = "I", "ATT" = "I", "ATG" = "M",
    "ACA" = "T", "ACC" = "T", "ACG" = "T", "ACT" = "T",
    "AAC" = "N", "AAT" = "N", "AAA" = "K", "AAG" = "K",
    "AGC" = "S", "AGT" = "S", "AGA" = "R", "AGG" = "R",
    "CTA" = "L", "CTC" = "L", "CTG" = "L", "CTT" = "L",
    "CCA" = "P", "CCC" = "P", "CCG" = "P", "CCT" = "P",
    "CAC" = "H", "CAT" = "H", "CAA" = "Q", "CAG" = "Q",
    "CGA" = "R", "CGC" = "R", "CGG" = "R", "CGT" = "R",
    "GTA" = "V", "GTC" = "V", "GTG" = "V", "GTT" = "V",
    "GCA" = "A", "GCC" = "A", "GCG" = "A", "GCT" = "A",
    "GAC" = "D", "GAT" = "D", "GAA" = "E", "GAG" = "E",
    "GGA" = "G", "GGC" = "G", "GGG" = "G", "GGT" = "G",
    "TCA" = "S", "TCC" = "S", "TCG" = "S", "TCT" = "S",
    "TTC" = "F", "TTT" = "F", "TTA" = "L", "TTG" = "L",
    "TAC" = "Y", "TAT" = "Y", "TAA" = "*", "TAG" = "*",
    "TGC" = "C", "TGT" = "C", "TGA" = "*", "TGG" = "W"
  )
  
  # Split DNA sequence into codons (triplets)
  codons <- substring(dna_seq, seq(1, nchar(dna_seq), 3), seq(3, nchar(dna_seq), 3))
  
  # Translate codons into amino acids
  protein_seq <- paste(genetic_code[codons], collapse = "")
  
  # Return protein sequence
  return(protein_seq)
}

# Example Usage
dna_sequence <- "ATGGCCATTGTAATGGGCCGCTGAAAGGGTGCCCGATAG"
protein_sequence <- dna_to_protein(dna_sequence)
print(protein_sequence)  
