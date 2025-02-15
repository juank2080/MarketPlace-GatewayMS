FROM alpine/java:21-jre

ENV JAVA_OPTS="" \
    JAVA_ARGS="" \
    LOGS_DIR="/var/log/marketplace-gateway" \
    WORKING_DIR="/opt/marketplace-gateway"

RUN mkdir -p ${WORKING_DIR} \
    && mkdir -p ${LOGS_DIR}

RUN apk add curl

WORKDIR ${WORKING_DIR}

ARG JAR_FILE
ENV JAR_FILE=${JAR_FILE}

COPY target/${JAR_FILE} ${WORKING_DIR}/${JAR_FILE}

ARG BUILD_DATE
ARG POM_VERSION
ARG PROJECT_NAME
ARG VCS_REF

LABEL org.label-schema.build-date="${BUILD_DATE}" \
      org.label-schema.name="${PROJECT_NAME}" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.vendor="Juan" \
      org.label-schema.vcs-ref="${VCS_REF}" \
      org.label-schema.vcs-url="https://github.com/juank2080/MarketPlace-GatewayMS" \
      org.label-schema.version="${POM_VERSION}"

# The EXPOSE instruction informs Docker that the container listens on the specified network ports at runtime.
# You can specify whether the port listens on TCP or UDP, and the default is TCP if the protocol is not specified.
# The EXPOSE instruction does not actually publish the port. It functions as a type of documentation between the
# person who builds the image and the person who runs the container
EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD [ "sh", "-c", "set -a && . /etc/marketplace-gateway/marketplace-gateway.properties && set +a && java ${JAVA_OPTS} -jar ${WORKING_DIR}/${JAR_FILE}"]