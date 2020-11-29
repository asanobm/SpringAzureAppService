FROM maven:3.6.3-jdk-11 as builder
RUN mkdir -p /opt/java/src
# 必要なソースを /opt/java へコピー
COPY . /opt/java/
# mvn install によりtargetディレクトリにjarが生成される
RUN cd /opt/java && mvn install

FROM adoptopenjdk/openjdk11
RUN mkdir -p /opt/app/
# 2.builderコンテナの中にあるjarファイルを /opt/app/ にコピー
COPY --from=builder /opt/java/target/SpringAzureAppService.jar /opt/app/
# 8080ポートを開ける
EXPOSE 8080
# 3.アプリを実行
CMD  ["java","-jar","/opt/app/SpringAzureAppService-0.0.1.jar"]