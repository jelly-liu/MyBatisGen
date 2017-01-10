# MyBatisGen
generate mapper of mybatis, support mysql, oracle
# Contact  
qq:195358385  
email:collonn@126.com  
# Feature
fast to generate mapper and pojo  
support mysql,oracle，if you want to make it to support other database，implement com.collonn.mybatis.interfaces.Gen  
no matter ibatis2.x or mybatis3.x，you can edit xx.ftl to generate mapper and pojo
# How to add ojdbc14.jar to your local Maven repository
cause authorization of Oracle，Maven repository can not support Oracle JDBC driver  
do like the follows to add ojdbc14.jar to local maven repository  
mvn install:install-file -DgroupId=com.oracle -DartifactId=ojdbc14 -Dversion=10.2.0.4.0 -Dpackaging=jar -Dfile=./ojdbc14.jar
<dependency>  
    <groupId>com.oracle</groupId>  
    <artifactId>ojdbc14</artifactId>  
    <version>10.2.0.4.0</version>  
</dependency>  
# How to useage
just change config.properties, for an example  
<pre>
#out put dir
outDir=F:/out/
#database.type:mysql,oracle
database.type=mysql
database.name=eoss
#sqlCase:upper,lower
sqlCase=upper
#model package name
model.package=com.jelly.eoss.model
#mysql database url
mysql.url = jdbc:mysql://localhost:3306/eoss?useUnicode=true&characterEncoding=utf8&useOldAliasMetadataBehavior=true
mysql.username = root
mysql.password = sa
#databasetype-javatype
mysql.ref=TINYINT-Integer|INT-Integer|BIGINT-Long|DECIMAL-BigDecimal|CHAR-String|VARCHAR-String|TEXT-String|LONGTEXT-String|DATETIME-Date
#oracle database url
oracle.url =
oracle.username =
oracle.password =
#databasetype-javatype
oracle.ref=NUMBER-Long|DATA_SCALE-BigDecimal|NVARCHAR2-String|VARCHAR2-String|VARCHAR-String|CHAR-String|CLOB-String|DATE-Date

</pre>
