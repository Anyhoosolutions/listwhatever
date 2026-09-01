# Legacy bucket name
gsutil cors set tool/cors.json gs://listwhatever.appspot.com

# Or newer Firebase Storage bucket
gcloud storage buckets update gs://listwhatever.firebasestorage.app --cors-file=tool/cors.json
