FROM maven:3.9.6-eclipse-temurin-17 as builder

WORKDIR /app

COPY ./Doctor-Patient-Portal/pom.xml ./

RUN mvn dependency:go-offline -B

COPY . .

RUN mvn -o clean package

FROM tomcat:9-jdk17

COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

CMD ["catalina.sh", "run"]

