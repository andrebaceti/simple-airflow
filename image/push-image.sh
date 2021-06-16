source version
git add --all
git commit -m "Building a new version for Simple Airflow ${VERSION}"
git tag -a ${VERSION} -m "Building a new version for Simple Airflow ${VERSION}"
git push
git push origin ${VERSION}

docker push andrebaceti/simple-airflow:${VERSION}
