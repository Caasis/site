#|/bin/sh -eu

DIR=./dist
mkdir -p $DIR

variables=
cd fragments
for file in *; do
  name=${file%.html}
  var=$(echo $name | tr [:lower:] [:upper:])
  variables="$variables \$$var"
  export $var="$(cat $file)"
done

cd ../src
for file in *; do
  case $file in
    *.html) cat $file | envsubst "$variables" > ../$DIR/$file;;
    *)  cp $file ../dist;;
  esac
done

echo "Site built into $DIR."
