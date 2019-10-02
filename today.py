#!/usr/bin/env python
import os
import sys
from datetime import datetime, date, time

did_file = sys.argv[1]
modified_datetime = datetime.fromtimestamp(os.path.getmtime(did_file))
today_beginning = datetime.combine(date.today(), time())

if (modified_datetime > today_beginning):
  sys.exit()
else:
  sys.exit(1)
