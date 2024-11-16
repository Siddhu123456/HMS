package DBConnect;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBconnection {
	private static Connection conn;
	public static Connection getConnection() throws Exception {
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		String jdbcurl = "jdbc:mysql://localhost:3306/project";
		String username = "root";
		String password = "Teja@2005";
		conn= DriverManager.getConnection(jdbcurl, username, password);
		return conn;
	}
}