#!/bin/sh

#Update the Raspberry Pi
sudo apt-get update
sudo apt-get dist-upgrade

#Download this repository and create virtual environment
git clone https://github.com/EdjeElectronics/TensorFlow-Lite-Object-Detection-on-Android-and-Raspberry-Pi.git
mv TensorFlow-Lite-Object-Detection-on-Android-and-Raspberry-Pi tflite1
cd tflite1
sudo pip3 install virtualenv
python3 -m venv tflite1-env
source tflite1-env/bin/activate

#Install TensorFlow Lite dependencies and OpenCV
bash get_pi_requirements.sh

#Set up TensorFlow Lite detection model
wget https://storage.googleapis.com/download.tensorflow.org/models/tflite/coco_ssd_mobilenet_v1_1.0_quant_2018_06_29.zip
unzip coco_ssd_mobilenet_v1_1.0_quant_2018_06_29.zip -d Sample_TFLite_model

#ImportError: No module named 'cv2'
cd tflite1
source tflite1-env/bin/activate

#Run the TensorFlow Lite model
python3 TFLite_detection_webcam.py --modeldir=Sample_TFLite_model