# Welcome to Practical 2!
#
# This is a regular R script file containing comments and code.
# In this practical, we will continue working with phyloseq objects and explore
# the data further with interactive ordinations using the `microViz` package.
#
# **How to run code line-by-line:**
# - Place your cursor on the line you wish to run and press `Ctrl + Enter` (Windows)
#   or `Cmd + Enter` (Mac). This will execute the current line and move to the next.
# - To run multiple lines at once, highlight the desired lines and use the same shortcut.
#
# Now, let's get started by loading the necessary libraries and reading in the data.

# Load necessary libraries
library(here)         # For help constructing file paths
library(tidyverse)    # For data manipulation and visualization
library(phyloseq)     # For handling and analyzing microbiome data
library(microViz)     # For microbiome data visualization and ordination

# Read the phyloseq object created in part 1.
ps <- read_rds(file = here("data/papa2012/processed/papa12_phyloseq.rds"))

# Interactive ordination!

# The `microViz` package provides a Shiny app `ord_explore()` to interactively
# create and explore PCoA plots and other ordinations.
# Let's give it a try!

# Note: we filter out OTUs that only appear in 1 sample, to speed up the app.
# Run the following code in the Console (not in an R script or Quarto doc).

ps %>%
  tax_filter(min_prevalence = 2, verbose = FALSE) %>%
  ord_explore()

# Instructions / Suggestions:
# 1. Colour the samples using the variables in the sample data.
# 2. Select a few samples to view their composition on bar charts!
# 3. Change some ordination options:
#    - Different rank of taxonomic aggregation.
#    - Different distances we've discussed.
# 4. Copy the automatically generated code:
#    - Exit the app (click the red 🛑 button in R console!).
#    - Paste and run the code to recreate the ordination plot.
#    - Customise the plot: change colour scheme, title, etc.
# 5. Launch the app again with a different subset of the data:
#    - Practice using `ps_filter()`.
#    - e.g. use the data of only the UC patients' gut microbiota!
#    - Colour points by the dominant genus?

# For suggestion 5: try this code in your Console.
# This code filters for samples with "UC" diagnosis and calculates
# the dominant genus for each sample before launching the interactive app.

ps %>%
  tax_filter(min_prevalence = 2, verbose = FALSE) %>%
  ps_filter(diagnosis == "UC") %>%
  # Calculate dominant Genus for each sample (optional)
  ps_calc_dominant(rank = "Genus", none = "Mixed", other = "Other") %>%
  ord_explore()

# Unblock popups?!
# To allow the interactive function to open a new tab in your browser,
# you may need to unblock pop-ups for posit.cloud.
# If you don't see anything after running the `ord_explore` command,
# check for messages/notifications from your browser.

# Beware: some important notes on interactive analysis:

# There are many distances available.
# Feel free to try out distances we haven't talked about, BUT:

# 1. You should not use a distance that you don't understand in your work,
#    even if the plot looks nice! 😉
# 2. A few of the distances might not work correctly...
#    - They are mostly implemented in the package `vegan` and I haven't tested them all.
#    - Errors may appear in the RStudio Console.
#    - You can report to me any distances that don't work (if you're feeling helpful! 😇).

# There are several other ordination methods available:
# Try out PCA, principal components analysis, which does NOT use distances.

# We will not discuss "constrained" or "conditioned" ordinations today.
