#!/usr/bin/python3
import urllib.request
import json
import datetime

token = "bf50368602ef90dae4e9aa113fb31490"

url = "https://www.wanikani.com/api/user/"+token+"/study-queue"

format_date = "%B %d"

with urllib.request.urlopen(url) as response:
    resp = json.loads(response.read())
    #print(resp)

    queue_info = resp["requested_information"]

    available = queue_info["reviews_available"] + queue_info["lessons_available"]

    available_hour = queue_info["reviews_available_next_hour"]
    
    available_next_day = queue_info["reviews_available_next_day"]

    next_review_date = datetime.datetime.fromtimestamp(queue_info["next_review_date"])
    today = datetime.datetime.today()
    delta = next_review_date - today

    if available > 0:
        print(available, "available now")
    elif available_hour > 0:
        minutes = delta.seconds/60
        print(available_hour, "available in", int(minutes), "minutes")
    elif available_next_day > 0:
        hours = round(delta.seconds/60/60)
        print("Next review is in", hours, "hours" if hours > 1 else "hour")
    else:
        print("Next review is",next_review_date.strftime(format_date))
