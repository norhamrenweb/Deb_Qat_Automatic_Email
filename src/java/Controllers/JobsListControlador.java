/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controllers;


import Mails.*;
import atg.taglib.json.util.JSONObject;
import com.google.gson.Gson;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.ApplicationContext;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author nmohamed
 */
@Controller
public class JobsListControlador{
    
      Connection cn;
      
//      private ServletContext servlet;
    
    private Object getBean(String nombrebean, ServletContext servlet)
    {
        ApplicationContext contexto = WebApplicationContextUtils.getRequiredWebApplicationContext(servlet);
        Object beanobject = contexto.getBean(nombrebean);
        return beanobject;
    }
   @RequestMapping("/homepage/loadJobs.htm")
    public ModelAndView loadLessons(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        
        ModelAndView mv = new ModelAndView("homepage");
       
        DriverManagerDataSource dataSource;
        dataSource = (DriverManagerDataSource)this.getBean("dataSource",hsr.getServletContext());
        this.cn = dataSource.getConnection();
        HttpSession sesion = hsr.getSession();
        User user = (User) sesion.getAttribute("user");
        mv.addObject("jobslist", this.getJobs(user.getId(),hsr.getServletContext()));
        mv.addObject("username",user.getName());
        
        
        return mv;
    }

    
    public ArrayList<Jobs> getJobs(int userid,ServletContext servlet) throws SQLException
    {
//        this.conectarOracle();
        ArrayList<Jobs> jobslist = new ArrayList<>();
        try {
            
             Statement st = this.cn.createStatement();
             
            String consulta = "SELECT * FROM jobs ";
            ResultSet rs = st.executeQuery(consulta);
          
            while (rs.next())
            {
                Jobs job = new Jobs();
              //  lesson.setId(rs.getString("id_lessons"));
                job.setName(rs.getString("name"));
                job.setId(rs.getInt("id"));     
                job.setLastrun(rs.getString("lastrun"));
//                SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
//                String dateStr = sdfDate.format(rs.getTimestamp("lastrun"));
//                job.setLastrun(dateStr);// when it is null at first it will give error
//                 Timestamp stamp = rs.getTimestamp("start");
//               Timestamp finish = rs.getTimestamp("finish");
//               SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
//               SimpleDateFormat sdfTime = new SimpleDateFormat("hh:mm:ss a");
//               String dateStr = sdfDate.format(stamp);
//                String timeStr = sdfTime.format(stamp);
//                 
//                String timeStr2 = sdfTime.format(finish);
//                job.setDate(""+ dateStr);
//                job.setStart(timeStr);
//                job.setFinish(timeStr2);
                jobslist.add(job);
                
            }
           
            
            this.cn.close();
            
        } catch (SQLException ex) {
            System.out.println("Error leyendo Alumnos: " + ex);
        }
       
        return jobslist;
    }

    @RequestMapping("/homepage/deleteJob.htm")
             @ResponseBody
        public String deleteJob(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
  
        JSONObject jsonObj = new JSONObject();
       String[] id = hsr.getParameterValues("JobsSelected");
       String message = null;
       try {
        DriverManagerDataSource dataSource;
        dataSource = (DriverManagerDataSource)this.getBean("dataSource",hsr.getServletContext());
        this.cn = dataSource.getConnection();
        HttpSession sesion = hsr.getSession();
        User user = (User) sesion.getAttribute("user");
         Statement st = this.cn.createStatement();
         
        String consulta = "DELETE FROM jobs WHERE id="+id[0];
           st.executeUpdate(consulta);
           message = "Job deleted successfully";
        jsonObj.put("message", message);
       }catch (SQLException ex) {
            System.out.println("Error : " + ex);
        }
       
        return jsonObj.toString();
      
    }
    @RequestMapping("/homepage/editJob.htm")
      public ModelAndView editJob(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
        
        ModelAndView mv = new ModelAndView("homepage");
       String[] id = hsr.getParameterValues("seleccion");
       try {
        DriverManagerDataSource dataSource;
        dataSource = (DriverManagerDataSource)this.getBean("dataSource",hsr.getServletContext());
        this.cn = dataSource.getConnection();
        HttpSession sesion = hsr.getSession();
        User user = (User) sesion.getAttribute("user");
         Statement st = this.cn.createStatement();
          
        String consulta = "DELETE FROM pjobs WHERE id="+id[0];
           st.executeUpdate(consulta);
        mv.addObject("lessonslist", this.getJobs(user.getId(),hsr.getServletContext()));
       }catch (SQLException ex) {
            System.out.println("Error : " + ex);
        }
       
        
        return mv;
    }

}