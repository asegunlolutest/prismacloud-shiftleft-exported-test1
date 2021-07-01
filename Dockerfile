FROM adoptopenjdk:11.0.3_7-jdk-openj9-0.14.0

USER root
LABEL project="prismacloud-shiftleft"
#Secret exposed
COPY id_rsa ~/.ssh/id_rsa
COPY evil /evil

#Expose credentials
ENV CLIENT_ID="9aadafc1-bd59-4575-847a-21f0f0a517ea"
ENV SECRET_KEY="~DUUvI~gbnZ_~~zrj3J4i83q69vuJGczn0"

#Virus included
COPY eicar ~/eicar.txt

#Install vulnerable os level packages
#Hashing out as it didn't install it originally....:  CMD apt-get install nmap nc
RUN apt-get update \
        && apt-get install -y nmap \
        && apt-get install -y netcat

#Expose vulnerable ports
EXPOSE 22
EXPOSE 80

ARG DEPENDENCY=target/dependency

COPY ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY ${DEPENDENCY}/META-INF /app/META-INF
COPY ${DEPENDENCY}/BOOT-INF/classes /app

ENTRYPOINT ["java","-cp","app:app/lib/*","org.springframework.samples.petclinic.PetClinicApplication"]
