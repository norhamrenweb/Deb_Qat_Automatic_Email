/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sendemailjobs;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import static sendemailjobs.SendMail.SendMail;

/**
 *
 * @author nmohamed
 */
public class SendEmailJobs {

   //need to add here the job id
    public static void sendEmails(int jobid){
        try {
            ArrayList<Msg> list = GetMsgs.getMsgs(jobid);
            ArrayList<Msg> finallist = RWEvents.getMsgs(list);
            SendMail(finallist);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(SendEmailJobs.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(SendEmailJobs.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
}
