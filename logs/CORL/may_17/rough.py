import os
import numpy as np
import shutil

directory = 'real'

# iterate over files in
# that directory
for filename in os.listdir(directory):
    if "corl-mppi" in filename:
        a, b = filename.split("corl-mppi")
        shutil.copyfile(directory+'/'+filename, "real/corl-bcmppi" + b)
