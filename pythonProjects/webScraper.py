import re

import requests
from bs4 import BeautifulSoup


vgm_url = 'https://www.vgmusic.com/music/console/nintendo/nes/'
html_text = requests.get(vgm_url).text
soup = BeautifulSoup(html_text, 'html.parser')


if __name__ == '__main__':
    attrs = {
        'href': re.compile(r'\.mid$')
    }

    tracks = soup.find_all('a', attrs=attrs, string=re.compile(r'^((?!\().)*$'))

    count = 0
    for track in tracks:
        print(track)
        count += 1
    print(len(tracks))

