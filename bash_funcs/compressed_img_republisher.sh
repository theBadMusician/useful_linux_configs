function compressed_img_publisher() {
  rosrun image_transport republish raw in:=$1 compressed out:=$1 &
  rosparam set $1/compressed/jpeg_quality 20
  fg
}
