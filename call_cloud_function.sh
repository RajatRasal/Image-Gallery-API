curl https://us-central1-my-blog-253414.cloudfunctions.net/get_image_from_bucket \
  -H "Authorization: bearer $(gcloud auth print-access-token)"
