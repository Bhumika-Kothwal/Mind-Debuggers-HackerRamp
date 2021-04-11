import cv2 
import sklearn
from sklearn.cluster import KMeans
from collections import Counter
from sklearn.decomposition import PCA
import skimage.morphology
import numpy as np
import time


def find_vector_set(diff_image, new_size):
 
    i = 0
    j = 0
    vector_set = np.zeros((int(new_size[0] * new_size[1] / 16),16))
    while i < vector_set.shape[0]:
        while j < new_size[1]:
            k = 0
            while k < new_size[0]:
                block   = diff_image[j:j+4, k:k+4]
                feature = block.ravel()
                vector_set[i, :] = feature
                k = k + 4
            j = j + 4
        i = i + 1

    mean_vec   = np.mean(vector_set, axis = 0)
    # Mean normalization
    vector_set = vector_set - mean_vec   
    return vector_set, mean_vec

def find_FVS(EVS, diff_image, mean_vec, new):
 
    i = 2
    feature_vector_set = []
 
    while i < new[1] - 2:
        j = 2
        while j < new[0] - 2:
            block = diff_image[i-2:i+2, j-2:j+2]
            feature = block.flatten()
            feature_vector_set.append(feature)
            j = j+1
        i = i+1
    
    FVS = np.dot(feature_vector_set, EVS)
    FVS = FVS - mean_vec
    #print ("[INFO] Feature vector space size", FVS.shape)
    return FVS

def clustering(FVS, components, new):
    kmeans = KMeans(components, verbose = 0)
    kmeans.fit(FVS)
    output = kmeans.predict(FVS)
    count  = Counter(output)
 
    least_index = min(count, key = count.get)
    change_map  = np.reshape(output,(new[1] - 4, new[0] - 4))
    return least_index, change_map
    

class ChangeDetection:

    def __init__(self, image1, image2):
        self.image1 = image1
        self.image2 = image2

    def change_area(self):

        # Resize Images
        #print('[INFO] Resizing Images ...')
        start = time.time()
        new_size = np.asarray(self.image1.shape) /4
        new_size = new_size.astype(int) *4
        image1 = cv2.resize(self.image1, (new_size[0],new_size[1])).astype(int)
        image2 = cv2.resize(self.image2, (new_size[0],new_size[1])).astype(int)
        end = time.time()
        #print('[INFO] Resizing Images took {} seconds'.format(end-start))

        # Difference Image
        #print('[INFO] Computing Difference Image ...')
        start = time.time()
        diff_image = abs(image1 - image2)
        end = time.time()
        #print('[INFO] Computing Difference Image took {} seconds'.format(end-start))
        diff_image=diff_image[:,:,1]


        #print('[INFO] Performing PCA ...')
        start = time.time()
        pca = PCA()
        vector_set, mean_vec=find_vector_set(diff_image, new_size)
        pca.fit(vector_set)
        EVS = pca.components_
        end = time.time()
        #print('[INFO] Performing PCA took {} seconds'.format(end-start))

        #print('[INFO] Building Feature Vector Space ...')
        start = time.time()
        FVS = find_FVS(EVS, diff_image, mean_vec, new_size)
        components = 2
        end = time.time()
        #print('[INFO] Building Feature Vector Space took {} seconds'.format(end-start))

        #print('[INFO] Clustering ...')
        start = time.time()
        least_index, c_map = clustering(FVS, components, new_size)
        end = time.time()
        #print('[INFO] Clustering took {} seconds'.format(end-start))

        c_map[c_map == least_index] = 255
        c_map[c_map != 255] = 0

        total_size = c_map.shape[0] * c_map.shape[1]

        change_size = 0
        for r in range(0, c_map.shape[0]):
            for w in range(0,c_map.shape[1]):
                    if(c_map[r][w] == 255):
                        change_size += 1

        per_change = (change_size/total_size) * 100

        #print("The percentage of area changed = " + str(round(per_change, 3)) + "%")
        return change_size