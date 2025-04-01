import requests
from bs4 import BeautifulSoup

def print_secret_message(url):
    # Fetch the HTML content from the URL and gather data
    response = requests.get(url)
    soup = BeautifulSoup(response.content, 'html.parser')
    table = soup.find('table')
    rows = table.find_all('tr')
    data_rows = rows[1:]
    
    # Extract data into a list of (x, char, y) tuples
    data = []
    for row in data_rows:
        cols = row.find_all('td')
        x = int(cols[0].text.strip())  # x-coordinate
        char = cols[1].text.strip()    # character
        y = int(cols[2].text.strip())  # y-coordinate
        data.append((x, char, y))
    
    # Create a grid
    max_x = max(item[0] for item in data)
    max_y = max(item[2] for item in data)
    grid = [[' ' for _ in range(max_x + 1)] for _ in range(max_y + 1)]
    
    # Fill grid and display
    for x, char, y in data:
        grid[y][x] = char
    for row in reversed(grid):
        print(''.join(row))


print_secret_message("https://docs.google.com/document/d/e/2PACX-1vQGUck9HIFCyezsrBSnmENk5ieJuYwpt7YHYEzeNJkIb9OSDdx-ov2nRNReKQyey-cwJOoEKUhLmN9z/pub")