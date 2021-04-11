import cv2 as cv
import numpy as np
from change_detection import ChangeDetection


class FindFit:
    def __init__(self, img, small_img, medium_img, large_img):
        self.img = cv.imread(img)
        self.small_size = cv.imread(small_img)
        self.medium_size = cv.imread(medium_img)
        self.large_size = cv.imread(large_img)
        self.findarea()

    def findarea(self):

        print("Change detection btw user size and small size.")
        self.area_small= ChangeDetection(self.small_size, self.img).change_area()
        print("Change detection btw user size and medium size.")
        self.area_medium = ChangeDetection(self.medium_size, self.img).change_area()
        print("Change detection btw user size and large size.")
        self.area_large = ChangeDetection(self.large_size, self.img).change_area()

        print("Change detection btw small size and medium size.")
        self.area_sm = ChangeDetection(self.small_size, self.medium_size).change_area()
        print("Change detection btw medium size and large size.")
        self.area_ml = ChangeDetection(self.medium_size, self.large_size).change_area()

    def findfit(self):
        # when the area difference btw small size and user size if smallest
        if(self.area_small < self.area_medium) and (self.area_small < self.area_large):
            # correct fit will be small -> if area diff btw small and user size is less than 30%
            # correct fit will be medium -> if area diff btw small and user size is greater than 30%
            
            # U....S...................M
            if(self.area_medium > self.area_sm):
                return "S"

            # S....U..............M
            elif(self.area_small * 100/self.area_sm) <= 30:
                return "S"
            
            # S......U............M
            else: return "M"

        # when the area difference btw medium size and user size if smallest
        elif(self.area_medium < self.area_small) and (self.area_medium < self.area_large):
            #S...........U....M..................L
            if(self.area_large > self.ml):
                return "M"

            #S................M....U.............L
            elif(self.area_medium * 100/self.area_ml) <=30:
                return "M"

            #S................M.......U..........L
            else: return "L"


        # when the area difference btw big size and user size if smallest
        else:
            return "L"
