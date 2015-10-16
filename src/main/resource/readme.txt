-->anything need help, contact me via:
    qq:195358385
    email:collonn@126.com
=============================================================================
-->程序的生成mapper和pojo的速度还是很快的
=============================================================================
-->本程序目前支持mysql和oracle，如果要支持其它数据库，请自行实现com.collonn.mybatis.interfaces.Gen接口(这是一个抽象类)
=============================================================================
-->不管是ibatis2.x还是mybatis3.x，可以通过直接修改ftl来实现生成相应的mapper和pojo类，我们已经提供了从数据库中抽取出来的各种必要的数据。
=============================================================================
-->在本地仓库中添加oracle jdbc
    由于Oracle授权问题，Maven不提供Oracle JDBC driver，为了在Maven项目中应用Oracle JDBC driver,必须手动添加到本地仓库.
    mvn install:install-file -DgroupId=com.oracle -DartifactId=ojdbc14 -Dversion=10.2.0.4.0 -Dpackaging=jar -Dfile=./ojdbc14.jar

    <dependency>
        <groupId>com.oracle</groupId>
        <artifactId>ojdbc14</artifactId>
        <version>10.2.0.4.0</version>
    </dependency>