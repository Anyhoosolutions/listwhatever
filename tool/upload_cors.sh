# Legacy bucket name
gsutil cors set tool/cors.json gs://firebase_prod_project_id_to_replace.appspot.com

# Or newer Firebase Storage bucket
gcloud storage buckets update gs://firebase_prod_project_id_to_replace.firebasestorage.app --cors-file=tool/cors.json
