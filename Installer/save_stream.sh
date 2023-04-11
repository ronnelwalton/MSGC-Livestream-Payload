#!/bin/bash
gst-launch-1.0 -e rtspsrc location=rtsp://localhost:8554/payload ! rtph264depay ! h264parse ! splitmuxsink  location=/home/pi/Videos/Payload%02d%05d.mp4 max-size-time=300000000000 max-files=96
