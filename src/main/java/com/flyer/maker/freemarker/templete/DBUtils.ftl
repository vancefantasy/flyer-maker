package ${projectPackage};

import ${projectPackage}.common.BeanFactoryRegister;
import org.apache.ibatis.session.defaults.DefaultSqlSessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Created by ${author} on ${.now?string('yyyy/MM/dd')}.
 */
public class DBUtils {

    protected final static Logger log = LoggerFactory.getLogger(DBUtils.class);

    private final static String TRUNCATE_TABLE_SQL_PATTERN = "TRUNCATE %s";

    /**
     * 由于每次执行完UT，都会清空库，所以需要
     * 检查当前配置的jdbc.url，连接的数据库是否以'_ut'结尾
     * 如果不是，则单元测试中断。
     * 该策略的目的是：保证单元测试每次执行幂等
     */
    public static void checkDBName() {
        DataSource dataSource = null;
        Connection connection = null;
        try {
            DefaultSqlSessionFactory sqlSession =
                (DefaultSqlSessionFactory) BeanFactoryRegister.getBean("sqlSessionFactory");
            dataSource = sqlSession.getConfiguration().getEnvironment().getDataSource();
            connection = dataSource.getConnection();
            String db = connection.getCatalog();
            if (!db.endsWith("_ut")) {
                log.error("单元测试数据库名称必须以{ _ut }结尾，当前库: {}", db);
                log.error("单元测试退出");
                System.exit(100);
            }
            log.info("unit test currnt db: {}", db);
        } catch (Exception e) {
            log.error("checkDBName error", e);
        } finally {
            try {
                connection.close();
            } catch (SQLException e) {
                log.error("db close error", e);
            }
        }
    }

    /**
     * truncate table by table name
     *
     * @param tableName
     */
    public static void truncateTable(String tableName) {
        DataSource dataSource = null;
        Connection connection = null;
        Statement statement = null;
        String sql = String.format(TRUNCATE_TABLE_SQL_PATTERN, tableName);
        try {
            DefaultSqlSessionFactory sqlSession =
                (DefaultSqlSessionFactory) BeanFactoryRegister.getBean("sqlSessionFactory");
            dataSource = sqlSession.getConfiguration().getEnvironment().getDataSource();
            connection = dataSource.getConnection();
            statement = connection.createStatement();
            statement.execute(sql);
            log.info("truncateTable  {} complete", tableName);
        } catch (Exception e) {
            log.error("truncateTable error, table: {}", tableName, e);
        } finally {
            try {
                statement.close();
                connection.close();
            } catch (SQLException e) {
                log.error("db close error", e);
            }
        }
    }
}
