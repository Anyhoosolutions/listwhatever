/google-cloud-sdk/bin/gcloud auth activate-service-account --key-file=firebase-adminsdk-google-cloud-service-account.json
/google-cloud-sdk/bin/gcloud --quiet config set project listanything-2b9b0
/google-cloud-sdk/bin/gcloud firebase test android run \
    --type instrumentation  \
    --app app-development-debug.apk  \
    --test app-development-debug-androidTest.apk \
    --timeout 3m \
    --results-bucket=integration_results_listanything \
    --results-dir=test/firebase