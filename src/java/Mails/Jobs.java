/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Mails;


/**
 *
 * @author nmohamed
 */
public class Jobs {
    
    private int id;
    private String name;
    private String message;
    private String messagetitle;
   private String type;//behavior,gradebook,admission
    private String runfreq;//daily,weekly,once
    private String lastrun;
    private int userid;
    private String setting;//any other setting that is specific to this type of job ex merit or demerit
    private String sender;
    private String cc;
    private String description;
    private String start;
     private String runhour;
    private String TFstart;
    private String TFfinish;
    private String status;//if it id disabled or enabled

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
   

   

    public String getSetting() {
        return setting;
    }

    public void setSetting(String setting) {
        this.setting = setting;
    }

    public String getSender() {
        return sender;
    }

    public void setSender(String sender) {
        this.sender = sender;
    }

    public String getCc() {
        return cc;
    }

    public void setCc(String cc) {
        this.cc = cc;
    }

    public String getRunhour() {
        return runhour;
    }

    public void setRunhour(String runhour) {
        this.runhour = runhour;
    }

    public String getTFstart() {
        return TFstart;
    }

    public void setTFstart(String TFstart) {
        this.TFstart = TFstart;
    }

    public String getTFfinish() {
        return TFfinish;
    }

    public void setTFfinish(String TFfinish) {
        this.TFfinish = TFfinish;
    }
 
    

    public String getLastrun() {
        return lastrun;
    }

    public void setLastrun(String lastrun) {
        this.lastrun = lastrun;
    }
    

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getStart() {
        return start;
    }

    public void setStart(String start) {
        this.start = start;
    }

    public String getFinish() {
        return finish;
    }

    public void setFinish(String finish) {
        this.finish = finish;
    }
    private String finish;
    private String date;
   
  

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }
   

   

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getMessagetitle() {
        return messagetitle;
    }

    public void setMessagetitle(String messagetitle) {
        this.messagetitle = messagetitle;
    }

    public String getRunfreq() {
        return runfreq;
    }

    public void setRunfreq(String runfreq) {
        this.runfreq = runfreq;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

}
