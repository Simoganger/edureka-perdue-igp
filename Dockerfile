FROM maven:alpine as build

WORKDIR /app
COPY pom.xml /app
RUN mvn verify --fail-never
COPY . /app
RUN mvn package

FROM tomcat
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

