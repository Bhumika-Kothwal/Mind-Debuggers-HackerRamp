from flask import Flask, jsonify, request
from PIL import Image
import os
from findfit import FindFit
from background_removal import Background_Removal
import pyrebase

app = Flask(__name__)

config = {
    "apiKey": "AIzaSyA0MCXAKdh4W1yVkMAtQqfm_kLV55nfblc",
    "authDomain": "myntra-482f2.firebaseapp.com",
    "databaseURL": "https://myntra-482f2-default-rtdb.firebaseio.com",
    "projectId": "myntra-482f2",
    "storageBucket": "myntra-482f2.appspot.com",
    "messagingSenderId": "860212007202",
    "appId": "1:860212007202:web:1f814b9e92fd3e5a12d57b",
    "measurementId": "G-ZV3JEL4LWF"
}

firebase = pyrebase.initialize_app(config)

storage = firebase.storage()
db = firebase.database()


@app.route('/post_image', methods = ['GET', 'POST'])
def handle_request():
    if request.method == "POST":
        # check if the post request has the file part
        if 'file' not in request.files:
            return "someting went wrong"
        
        # Image of user sized garment
        user_file = request.files['file']
        temp = request.files['file']
        if user_file.filename == '':
            return "file name not found ..." 
        
        else:
            # ID of the required garment
            ID = request.form['ID']

            usr_img_path = os.path.join(os.getcwd()+"/Images/bg_removed/user_image.jpg")
            user_file.save(usr_img_path)
            
            # background removal of user size image
            Background_Removal('Images/bg_removed/user_image.jpg').bg_removal()
            im = Image.open(usr_img_path) 
            im.show("User_size_background_removed")
            print("User size image background removed!!!")
            
            # fetching images of different sizes of given garment from firebase
            storage.child(ID + "/small_size.jpg").download("Images/fetched_from_firebase/small_size.jpg")
            storage.child(ID + "/medium_size.jpg").download("Images/fetched_from_firebase/medium_size.jpg")
            storage.child(ID + "/large_size.jpg").download("Images/fetched_from_firebase/large_size.jpg")
            print("Images of all sizes of given dress ID fetched from firebase.")

            usr_img = "Images/bg_removed/user_image.jpg"
            small_size = "Images/fetched_from_firebase/small_size.jpg"
            medium_size = "Images/fetched_from_firebase/medium_size.jpg"
            large_size = "Images/fetched_from_firebase/large_size.jpg"

            # to get perfect fit
            print("Correct is being detected....")
            ans = FindFit(usr_img, small_size, medium_size, large_size).findfit()

            if ans=="S":
                print("Correct fit is : Small size")
            elif ans=="M":
                print("Correct fit is : Medium size")
            elif ans=="L":
                print("Correct fit is : Large size")

            # returning the answer to frontend
            return ans


@app.route('/add_garment', methods = ['POST'])
def add_garment():
    if "small_size" in request.files:
        # Small sized garment images and its ID is taken from frontend and background removed
        small_size = "Images/bg_removed/small_size.jpg"

        user_file = request.files['small_size']
        usr_img_path = os.path.join(os.getcwd()+"/"+ small_size)
        user_file.save(usr_img_path)
        Background_Removal(small_size).bg_removal()

        im = Image.open(small_size)
        im.show()

        ID = request.form['ID']

        # Small sized garment images added to firebase
        storage.child(str(ID)+"/small_size.jpg").put(small_size)

        #os.remove(small_size)
        print("Small sized garment background removed and added to firebase.")

        return  'Y'

    elif "medium_size" in request.files:
        # Medium sized garment images and its ID is taken from frontend and background removed
        medium_size = "Images/bg_removed/medium_size.jpg"

        user_file = request.files['medium_size']
        usr_img_path = os.path.join(os.getcwd()+"/" + medium_size)
        user_file.save(usr_img_path)

        Background_Removal(medium_size).bg_removal()
        im = Image.open(medium_size) 
        im.show("Medium_size_background_removed")

        ID = request.form['ID']

        # Medium sized garment images added to firebase
        storage.child(str(ID)+"/medium_size.jpg").put(medium_size)

        #os.remove(medium_size)
        print("Medium sized garment background removed and added to firebase.")

        return  'Y'
        
    elif "large_size" in request.files:
        # Large sized garment images and its ID is taken from frontend and background removed
        large_size = "Images/bg_removed/large_size.jpg"

        user_file = request.files['large_size']
        usr_img_path = os.path.join(os.getcwd()+"/" + large_size)
        user_file.save(usr_img_path)

        Background_Removal(large_size).bg_removal()
        im = Image.open(large_size) 
        im.show("Large_size_background_removed")

        ID = request.form['ID']

        # Large sized garment images added to firebase
        storage.child(str(ID)+"/large_size.jpg").put(large_size)

        #os.remove(large_size)
        print("Large sized garment background removed and added to firebase.")

        return  'Y'

    else:
        return "someting went wrong"


if __name__ == "__main__":
    app.run(host="0.0.0.0",port=5000, debug=True)