from change_detection import ChangeDetection
import cv2 as cv

usr_img = cv.imread("Images/user_image.jpg")
small_size = cv.imread("Images/small_size.jpg")
medium_size = cv.imread("Images/medium_size.jpg")
large_size = cv.imread("Images/large_size.jpg")

print("\nFor change detection between User size and small size : ")
change_small_size = ChangeDetection(small_size, usr_img,"small").change_area()

print("\nFor change detection between User size and medium size : ")
change_medium_size = ChangeDetection(medium_size, usr_img,"medium").change_area()

print("\nFor change detection between User size and large size : ")
change_large_size = ChangeDetection(large_size, usr_img,"large").change_area()


print("\n\nPercentage change detection between User size and small size : " + str(round(change_small_size, 3)) + "%")
print("Percentage change detection between User size and medium size : " + str(round(change_medium_size, 3)) + "%")
print("Percentage change detection between User size and large size : " + str(round(change_large_size, 3)) + "%")


print('''Now based on the area change and percentage of area change, we use some conditions to find the perfect fit.
        Conditions : 
        1. if area change btw user and smaller size > 30% of area change btw smaller consequtive larger size
                -> then the correct fit is larger size
                
        2. if area change btw user and smaller size <= 30% of area change btw smaller consequtive larger size
                -> then the correct fit is smaller size''')

print("\n\nUsing these conditions, we get to see that 'Large size' is the perfect match")