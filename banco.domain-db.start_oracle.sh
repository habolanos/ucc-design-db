docker run --name oracle \
        -p 1521:1521 \
        -e ORACLE_PASSWORD=oracle \
        -e APP_USER=banco \
        -e APP_USER_PASSWORD=oracle \
        -e ORACLE_DATABASE=ORCL \
        -d gvenzl/oracle-free