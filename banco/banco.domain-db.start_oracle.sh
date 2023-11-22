docker run --name oracle \
        -p 1521:1521 \
        -e ORACLE_PASSWORD=oracle \
        -e APP_USER=banco \
        -e APP_USER_PASSWORD=oracle \
        -e ORACLE_DATABASE=ORCL,AGENCIA,COLEGIO \
        -v ~/repos-ucc/ucc-design-db/Scripts:/container-entrypoint-initdb.d \
        -d gvenzl/oracle-free
sleep 30
docker exec oracle createAppUser agencia oracle AGENCIA
docker exec oracle createAppUser colegio oracle COLEGIO