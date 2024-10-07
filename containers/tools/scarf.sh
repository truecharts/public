PLAIN='jackett'

ajson="Accept:application/json"
credentials="Authorization: Bearer ${1}"
CT="Content-Type:application/json"

data='{"name":"truecharts/'${PLAIN}'","backendUrl":"https://ghcr.io/truecharts/'${PLAIN}'","longDescription":"","shortDescription":"example description","website":"https://truecharts.org","libraryType":"docker","publicUrl":"https://tccr.io/truecharts/'${PLAIN}'"}'
url="https://scarf.sh/api/v1/packages"

curl --header "$ajson" --header "$credentials" --data "$data" --header "$CT" "$url"

for group in apps dev mirror base; do
  for i in ${group}/*; do
    PLAIN=$( echo $i | cut -d'/' -f2 )

    data='{"name":"truecharts/'${PLAIN}'","backendUrl":"https://ghcr.io/truecharts/'${PLAIN}'","longDescription":"","shortDescription":"example description","website":"https://truecharts.org","libraryType":"docker","publicUrl":"https://tccr.io/truecharts/'${PLAIN}'"}'
    url="https://scarf.sh/api/v1/packages"

    curl --header "$ajson" --header "$credentials" --data "$data" --header "$CT" "$url"

    done
  done
