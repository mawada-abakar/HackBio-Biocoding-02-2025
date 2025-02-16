# Function: Compute Hamming Distance
hamming_distance <- function(str1, str2) {
  len1 <- nchar(str1)
  len2 <- nchar(str2)
  
  # Pad the shorter string with spaces to match length
  if (len1 > len2) {
    str2 <- paste(str2, paste(rep(" ", len1 - len2), collapse=""), sep="")
  } else if (len2 > len1) {
    str1 <- paste(str1, paste(rep(" ", len2 - len1), collapse=""), sep="")
  }
  
  # Convert strings to character vectors
  str1_chars <- unlist(strsplit(str1, ""))
  str2_chars <- unlist(strsplit(str2, ""))
  
  # Count number of different characters
  distance <- sum(str1_chars != str2_chars)
  
  return(distance)
}

# Example Usage:
slack_username <- "BioCoder123"
twitter_handle <- "BioDevGuy"
distance <- hamming_distance(slack_username, twitter_handle)

print(paste("Hamming Distance:", distance))
