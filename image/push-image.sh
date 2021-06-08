source version
git add --all
git commit -m "Building a new version for DataScience App ${VERSION}"
git tag -a app_${VERSION} -m "Building a new version for Return DataScience App ${VERSION}"
git push
git push origin app_${VERSION}

docker push andrebaceti/simple-airflow:${VERSION}
