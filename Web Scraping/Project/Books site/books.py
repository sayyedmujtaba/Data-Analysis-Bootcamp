import pandas
import requests
from bs4 import BeautifulSoup

url = "https://books.toscrape.com"
response = requests.get(url)
soup = BeautifulSoup(response.text, "html.parser")
articles = soup.find_all("article")

titles = []
prices = []
statuses = []

for article in articles:
  title = article.h3.a.attrs["title"]
  price = article.find("p", class_="price_color").text.strip()
  status = article.find("p", class_="instock availability").text.strip()
  
  titles.append(title)
  prices.append(price)
  statuses.append(status)

data_frame = pandas.DataFrame({"Title": titles, "Price":prices, "Status":status})
data_frame.index = data_frame.index + 1
data_frame.to_csv("books.csv", index_label="#")