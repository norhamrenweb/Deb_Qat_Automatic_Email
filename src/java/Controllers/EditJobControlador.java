/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controllers;


import atg.taglib.json.util.JSONObject;
import java.lang.ProcessBuilder.Redirect;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.*;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Mails.*;
import org.springframework.context.ApplicationContext;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.*;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.google.gson.*;
import java.io.PrintWriter;
import java.io.StringWriter;
import org.springframework.ui.ModelMap;
import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;
import org.springframework.web.bind.annotation.ResponseBody;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
/**
 *
 * @author nmohamed
 */
@Controller
public class EditJobControlador{
    
      Connection cn;
      
//      private ServletContext servlet;
    
    private Object getBean(String nombrebean, ServletContext servlet)
    {
        ApplicationContext contexto = WebApplicationContextUtils.getRequiredWebApplicationContext(servlet);
        Object beanobject = contexto.getBean(nombrebean);
        return beanobject;
    }
    @RequestMapping("/editjob/start.htm")
    public ModelAndView start(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        
        ModelAndView mv = new ModelAndView("editjob");  
        String jobid = hsr.getParameter("jobid");
         DriverManagerDataSource dataSource;
        dataSource = (DriverManagerDataSource)this.getBean("dataSource",hsr.getServletContext());
        this.cn = dataSource.getConnection();
        Statement st = this.cn.createStatement();
        String consulta= null;       
        consulta = "select * from jobs where id ="+jobid;
        ResultSet rs = st.executeQuery(consulta);
        Jobs j = new Jobs();
        while(rs.next())
        {
            j.setId(Integer.parseInt(jobid));
            j.setMessage(rs.getString("message"));
            j.setMessagetitle(rs.getString("msgtitle"));
            j.setRunfreq(rs.getString("runfreq"));
            j.setSender(rs.getString("sender"));
            j.setName(rs.getString("name"));
            j.setSetting(rs.getString("setting"));
            
        }
        mv.addObject("job",j);
        return mv;
    }
    @RequestMapping("/editjob/save.htm")
    public ModelAndView save(@RequestBody Jobs job, HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        
        ModelAndView mv = new ModelAndView("editjob");
       try {
        HttpSession sesion = hsr.getSession();
        User user = (User) sesion.getAttribute("user");
        DriverManagerDataSource dataSource;
        dataSource = (DriverManagerDataSource)this.getBean("dataSource",hsr.getServletContext());
        this.cn = dataSource.getConnection();
        Statement st = this.cn.createStatement();
        String consulta= null;     
        String jobid = hsr.getParameter("jobid");
        consulta = "update jobs set name = '"+job.getName()+"' ,message = '"+job.getMessage()+"',msgtitle = '"+job.getMessagetitle()+"',runfreq = '"+job.getRunfreq()+"',sender = '"+job.getSender()+"',setting = '"+job.getSetting()+"',type = '"+job.getType()+"' where id ="+ jobid;
        st.executeUpdate(consulta);
       }catch (SQLException ex) {
     System.out.println("Error"+ex);
        }
        
        return mv;
    }
}
