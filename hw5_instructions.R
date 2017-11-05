Homework 5
Context
This assignment reinforces ideas in Data Wrangling II.

Due: November 10 at 1:00pm.

Points
Problem 0: 10 points
Problem 1: 30 points
Problem 2: 30 points
Problem 3: 30 points

Problem 0

This “problem” focuses on:
  structure of your submission, 
including the use of R Markdown to write reproducible reports, 
the use of R Projects to organize your work, 
the use of relative paths to load data, and 
the naming structure for your files.

To that end:
  
  create a directory named p8105_hw5_YOURUNI (e.g. p8105_hw5_ajg2202 for Jeff)
put an R project in the directory
create a single .Rmd file named p8105_hw5_YOURUNI.Rmd
Data used in this homework will be read from online sources.

Your solutions to Problems 1+ should be included in your .Rmd file, and 
your submission for this assignment will be a zip file of the directory named p8105_hw5_YOURUNI.

We will assess
adherence to the instructions above and 
whether we are able to knit your .Rmd 
– that is, whether your work is reproducible – in the grading of this problem. 
Adherence to appropriate styling and clarity of code will be assessed in Problems 1+. 
This homework includes figures; 
the readability of your embedded plots (e.g. font sizes, axis labels, titles) will be assessed in Problems 1+.

#################################################
Problem 1
#################################################
Subway stations in NYC have multiple entrances; 
data on this page contains information on the entrances for each station.

Using the State of New York API, 
read the complete dataset using functions in httr. 
By default, the API will return only the first 1000 entries, 
so using the GET option query = list(`$limit` = 2000) in your request will be useful.

After you’ve read the data, 
clean it up by retaining:
variables on station name, 
entrance latitude and longitude, 
East/West street, 
North/South street, and 
corner.

Make a plot showing:
  the number of entrances for each subway station. 
Restrict your plot to stations that have more than 10 entrances, and 
order stations according to the number of entrances.

Overall (not only in stations that have more than 10 entrances), 
how many subway station names contain the abbreviation “St”? 
  How many end with “St”?
  
#################################################
Problem 2
#################################################
I’m curious about how many people watched each episode of “Game of Thrones” over the past 7 seasons. 
Find these data online and import them into R using functions in rvest. 
Taking the time to find data that’s pretty close to the format you want is worth a bit of effort; 
wikipedia is a good place to start.


After you’ve found and read the data, 
make sure they’re tidy. 
In your final dataset, include variables for:
season, 
episode, and 
viewers; 
also create a unique episode ID 
of the form SX_EYY where X and Y are season or episode numbers.

Make a plot that shows the number of viewers for each episode of each season.

Make a boxplot of the number of viewers for each episode of each season.

Fit a linear model that:
  treats number of viewers in each episode as a response and 
season as a categorical predictor; 
make season 4 the reference season. 
Present and discuss the results of your modeling.


#################################################
Problem 3
#################################################
The code below will scrape the 1000 most recent reviews of the movie “Napoleon Dynamite” from Amazon.

read_page_reviews <- function(url) {
  
  h <- read_html(url)
  
  title <- h %>%
    html_nodes("#cm_cr-review_list .review-title") %>%
    html_text()
  
  stars <- h %>%
    html_nodes("#cm_cr-review_list .review-rating") %>%
    html_text() %>%
    str_extract("\\d") %>%
    as.numeric()
  
  text = h %>%
    html_nodes(".review-data:nth-child(4)") %>%
    html_text()
  
  data_frame(title, stars, text)
}

url_base <- "https://www.amazon.com/product-reviews/B00005JNBQ/ref=cm_cr_arp_d_viewopt_rvwer?ie=UTF8&reviewerType=avp_only_reviews&sortBy=recent&pageNumber="
urls <- paste0(url_base, 1:100)

dynamite_reviews <- map(urls, ~read_page_reviews(.x)) %>% 
  bind_rows

Inspect and describe the resulting dataset. 
What variables are included? 
  Has the scraping been successful?
  
Create a tidy text dataset from the above using the text in the reviews. 
Use words as the token and 
remove stop words.

What words are most frequently used in:
  five-star reviews? 
  1-star reviews?
  
Make a plot that 
shows the (approximate) log odds ratio for
word appearance comparing 1-star reviews to 5-star reviews; 
include the 10 words with the most extreme log ORs in both directions.

Conduct a sentiment analysis of the review texts; 
make a plot of your results and include the star rating in your graphic. 
What is:
  the most positive review? 
  The most negative review?
  
  