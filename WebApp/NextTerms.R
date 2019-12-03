# Filename "NextTerms.R"
# Defines function NextTerms, which looks up most likely next words among commonStrings
# NextTerms requires unigrams, bigrams, trigrams and quadgrams to be defined in the environment


NextTerms <- function(inputText = "") {
  
  # Load libraries
  library(tidyverse)
  
  # Determine if last character in input string is a space, i.e. we have no letter from the word we are to predict
  partialWord <- (substr(inputText, nchar(inputText), nchar(inputText)) != " ")
  
  # Dictionaries
  dictionary <- c("unigrams", "bigrams", "trigrams", "quadgrams")
  
  inputText <- str_squish(inputText) # Remove excess blanks
  inputText <- str_replace_all(inputText, "[^[:alpha:] ]", "") # Remove anything not being a letter or a blank space
  inputText <- tolower(inputText)

  matchFound <- FALSE
  result <- NA

    
  if (partialWord)
    # Part of word entered, predict the rest
    {
    # Search for string, start with quadgrams, then trigrams, then bigrams lastly unigrams
    i <- 3
    while (i >= 0) {
      matchstring <- str_match(inputText, paste("([:alpha:]+ ){", i ,"}[:alpha:]+$", sep = ""))[1]
      if (!is.na(matchstring)) {
        matches <- eval(as.name(dictionary[i+1]))[which(startsWith(eval(as.name(dictionary[i+1]))$term, matchstring)),]
        if (dim(matches)[1] > 1 | (dim(matches)[1] == 1 & nchar(matchstring) < nchar(matches[1]))) matchFound <- TRUE
        # Remove potential identical match
        if (dim(matches)[1] > 0) matches <- matches[which(nchar(matches$term) > nchar(matchstring)),]
        if (dim(matches)[1] > 0){
          matchFound <- TRUE
          matches$score <- (i+1) * matches$count / dim(matches)[1]
          matches$dictionary <- dictionary[i+1]
          result <- rbind(result, matches)
        }
      }
      i <- i -1
    }
    
    
  } else
    # Last character entered was a blank, i.e. no letters known from the word to predict
    {
      # Search for string, start with quadgrams, then trigrams and lastly bigrams
      i <- 3
      while (i >= 1) {
        matchstring <- str_match(inputText, paste("([:alpha:]+ ){", i-1 ,"}[:alpha:]+$", sep = ""))[1]
        if (!is.na(matchstring)) {
          matches <- eval(as.name(dictionary[i+1]))[which(startsWith(eval(as.name(dictionary[i+1]))$term, paste(matchstring, " ", sep = ""))),]
          if (dim(matches)[1] > 0){
            matchFound <- TRUE
            matches$score <- (i+1) * matches$count / dim(matches)[1]
            matches$dictionary <- dictionary[i+1]
            result <- rbind(result, matches)
          }

        }
        i <- i -1
      }
    
    }
  
  if (matchFound)
  {
    result <- result %>%
      mutate(term = str_match(term, "[:alpha:]+$")) %>%
      group_by(term) %>%                  # Summarize scores from all n-gram dictionaries
      summarise(score = sum(score)) %>%
      arrange(desc(score))
    
    result <- as.character(result[1, 'term'])
      
  } else
  {
    result <- ""
  }

  
  result
  
}

