import java.sql.*;

public class CheckDb {
    public static void main(String[] args) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/legal_db", "root", "root");
            DatabaseMetaData metaData = con.getMetaData();
            ResultSet rs = metaData.getColumns(null, null, "bookings", null);
            System.out.println("Columns in bookings table:");
            while (rs.next()) {
                System.out.println(rs.getString("COLUMN_NAME") + " - " + rs.getString("TYPE_NAME"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
