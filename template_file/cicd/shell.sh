pip3 install git-remote-codecommit
git clone codecommit::us-east-1://code_commit_{{apply_name}}
cd code_commit_{{apply_name}}/
cp -rvf ../app/{{apply_name}}/ .
git add -A .
git commit -m "v1"
git push -u origin master
cd ..
