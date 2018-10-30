import os
import tarfile

tar = tarfile.open(os.path.join(os.getcwd(), 'yzahidi-datasets-heart-challenge.tar'))
tar.extractall(path=os.getcwd())
