import pandas as pd
import requests
from bs4 import BeautifulSoup

base_url = "https://quotes.toscrape.com/page/{}/" # URL template for multiple pages

quotes = []
authors = []
tags = []

# Loop through all 10 pages
for page in range(1, 11):
    url = base_url.format(page) # Construct URL for current page
    response = requests.get(url)
    
    # stop if page not found (failsafe)
    if response.status_code != 200:
        break
    
    soup = BeautifulSoup(response.text, "html.parser") # Parsing HTML
    quotes_site = soup.find_all("div", class_="quote") # Finding all quote blocks
    
    for quote_block in quotes_site: # Extracting quote, author, and tags
        quote = quote_block.find("span", class_="text").text # Extract quote text
        author = quote_block.find("small", class_="author").text # Extract author
        tag_list = [t.text for t in quote_block.find_all("a", class_="tag")] # Extract tags
        
        quotes.append(quote) 
        authors.append(author) 
        tags.append(", ".join(tag_list))

# Create DataFrame
df = pd.DataFrame({
    "Quote": quotes,
    "Author": authors,
    "Tags": tags
})

df.index = df.index + 1 # Start index at 1
df.to_csv("quotes.csv", index_label="ID") # Save to CSV

print("Scraping complete! Saved to quotes.csv") # Confirmation message
