/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sendemailjobs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Objects;
import org.joda.time.DateTime;
import org.joda.time.Days;

/**
 *
 * @author nmohamed
 */
public class GetMsgs {
    
    public static ArrayList<Msg> getMsgs (int jobid) throws ClassNotFoundException, SQLException
    {
    ArrayList<Msg> msgs = new ArrayList<>();
     
     Class.forName("org.postgresql.Driver");
           Connection cn = DriverManager.getConnection("jdbc:postgresql://192.168.1.3:5432/Maintenance_jobs?user=eduweb&password=Madrid2016");
        Statement st = cn.createStatement();
        ResultSet rs = st.executeQuery("select * from jobs where id = '"+jobid+"'");//when equal nul does not return it need to make ISNULL()
        while(rs.next())
        {
            
            Msg m = new Msg();
      
                m.setBody(rs.getString("message"));
                m.setTitle(rs.getString("msgtitle"));
                 m.setType(rs.getString("setting"));
                m.setSender(rs.getString("sender"));
                m.setJob_id(""+rs.getInt("id"));
                 msgs.add(m);
 
            }

           
        
    return msgs;
    }
}
