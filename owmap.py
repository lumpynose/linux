import urllib.request, json
import datetime

class OWMap():
    def __init__(self, url):
        self.url = url

    def get_weather(self):
        with urllib.request.urlopen(self.url) as url:
            data = json.loads(url.read().decode())

            weather = {
                "temperature" : data["main"]["temp"],
                "pressure" : data["main"]["pressure"],
                "wind speed" : data["wind"]["speed"],
                "sunrise" : data["sys"]["sunrise"],
                "sunset" : data["sys"]["sunset"]
            }

        return weather

def get_passwd(ow_appid):
    file = open(ow_appid, 'r')
    line = file.readline()
    return line.strip()

if __name__ == '__main__':
    appid = get_passwd("/usr/local/etc/ow_appid")

    owurl = "http://api.openweathermap.org/data/2.5/weather?id=5339111&units=imperial&appid=" + appid

    owmap = OWMap(owurl)

    print(owmap.get_weather())
